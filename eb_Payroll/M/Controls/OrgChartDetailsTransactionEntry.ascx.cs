using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using Telerik.Web.UI;
using System.Collections;

public partial class Controls_OrgChartDetailsTransactionEntry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private int transactionEntryID;

    public int TransactionEntryID
    {
        get { return this.transactionEntryID; }
        set { this.transactionEntryID = value; }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        //literalWorkflowID.Text = Convert.ToString(this.applicantID);

        Hashtable ht = new Hashtable();
        ht.Add("@TransactionEntryID", this.transactionEntryID);

        DataTable dt = clsDAL.GetDataSet("sp_User_Get_TransactionEntry_Statuses_OrgChart", ht).Tables[0];

        this.BindWorkFlowchart(dt, RadAjaxPanelChart);
    }

    private void BindWorkFlowchart(DataTable links, RadAjaxPanel radPanel)
    {
        if (radPanel == null || links == null)
            return;

        //var RadAjaxPanelChart = new RadOrgChart();
        radPanel.Controls.Clear();

        DataView view = new DataView(links);
        view.Sort = "UserLevel";
        DataTable distinctValues = view.ToTable(true, "UserLevel");

        //DataView dv = distinctValues.DefaultView;
        //dv.Sort = "UserLevel";
        //DataTable sortedDT = dv.ToTable();

        // for groups
        var teams = new DataTable();
        teams.Columns.Add("TeamID");
        teams.Columns.Add("ReportsTo");
        teams.Columns.Add("Team");

        var employees = new DataTable();
        employees.Columns.Add("EmployeeID");
        employees.Columns.Add("TeamID");
        employees.Columns.Add("Name");
        employees.Columns.Add("ImageUrl");

        for (int level = 0; level < distinctValues.Rows.Count; level++)
        {
            if (level == 0)
                teams.Rows.Add(new string[] { (level + 1).ToString(), null, "" });
            else
                teams.Rows.Add(new string[] { (level + 1).ToString(), (level).ToString(), "Level " + level.ToString() });

            string dbLevelValue = Convert.ToString(distinctValues.Rows[level][0]);
            //if (!string.IsNullOrEmpty(dbLevelValue))
            {
                var usersAtLevel = links.Select("UserLevel=" + dbLevelValue + "");

                for (int i = 0; i < usersAtLevel.Count(); i++)
                {
                    DataRow row = usersAtLevel[i];

                    string workflowDetails = "";
                    workflowDetails += "<div>";
                    workflowDetails += Convert.ToString(row["MainApproverFullName"]);
                    workflowDetails += Convert.ToString(row["RequestStatus"]);

                    //if (Convert.ToString(row["ColumnName"]) != "" && Convert.ToString(row["Condition"]) != "")
                    //{
                    //    workflowDetails += "<br /><br />" + Convert.ToString(row["ColumnName"]) + " " + Convert.ToString(row["Condition"]) + " " + Convert.ToString(row["ConditionVal"]);
                    //}
                    workflowDetails += "</div>";

                    string dataToDisplay = "";
                    DateTime? processedDate = row["ProcessedDate"] as DateTime?;

                    if (dbLevelValue == "0")
                    {
                        dataToDisplay = "Initiated By: <br />" + Convert.ToString(row["MainApproverFullName"]);
                        dataToDisplay += processedDate.HasValue ? "<br />Processed Date: " + processedDate.Value.ToString("MM/dd/yyyy hh:mm tt") : "";
                        dataToDisplay += "<br />Status: " + Convert.ToString(row["RequestStatus"]);

                        employees.Rows.Add(new string[] { Convert.ToString(row["ID"]), (level + 1).ToString(), dataToDisplay, "~/Img/Northwind/Customers/LONEP.jpg" });
                    }
                    else
                    {
                        dataToDisplay = Convert.ToString(row["MainApproverFullName"]);
                        dataToDisplay += processedDate.HasValue ? "<br />Processed Date: " + processedDate.Value.ToString("MM/dd/yyyy hh:mm tt") : "";
                        dataToDisplay += "<br />Status: " + Convert.ToString(row["RequestStatus"]);
                        dataToDisplay += "<br />Approved By: " + Convert.ToString(row["ApprovedByFullName"]);

                        employees.Rows.Add(new string[] { Convert.ToString(row["ID"]), (level + 1).ToString(), dataToDisplay, "~/Img/Northwind/Customers/LONEP.jpg" });
                    }
                }
            }
            //else
            //{
            //    employees.Rows.Add(new string[] { "-1", (level + 1).ToString(), "Initiated By: <br />" + Convert.ToString(row["MainApproverFullName"]), "~/Img/Northwind/Customers/LONEP.jpg" });
            //}
        }

        ////////////////////////////////////////
        RadOrgChart myChart;

        myChart = new RadOrgChart();

        myChart.GroupEnabledBinding.NodeBindingSettings.DataFieldID = "TeamID";
        myChart.GroupEnabledBinding.NodeBindingSettings.DataFieldParentID = "ReportsTo";
        myChart.RenderedFields.NodeFields.Add(new Telerik.Web.UI.OrgChartRenderedField() { DataField = "Team" });
        myChart.GroupEnabledBinding.NodeBindingSettings.DataSource = teams;

        myChart.GroupEnabledBinding.GroupItemBindingSettings.DataFieldID = "EmployeeID";
        myChart.GroupEnabledBinding.GroupItemBindingSettings.DataFieldNodeID = "TeamID";
        myChart.GroupEnabledBinding.GroupItemBindingSettings.DataTextField = "Name";
        //myChart.GroupEnabledBinding.GroupItemBindingSettings.DataImageUrlField = "ImageUrl";
        myChart.GroupEnabledBinding.GroupItemBindingSettings.DataSource = employees;

        myChart.DataBind();
        radPanel.Controls.Add(myChart);
    }
}