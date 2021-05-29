using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.ComponentModel.DataAnnotations;
using Telerik.Web.Device.Detection;

public partial class AdminDashboard : BasePage
{
    protected override void Page_Init(object sender, EventArgs e)
    {
        base.Page_Init(sender, e);

        DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);

        myFunction(screenDimensions);
    }
    private void myFunction(DeviceScreenDimensions screenDimensions)
    {

        if (screenDimensions.Width < 680 && screenDimensions.Width != 0)
        {
            RadGrid1.PagerStyle.Mode = GridPagerMode.NextPrev;
            RadGrid1.PagerStyle.PagerTextFormat = " {4} Page {0} of {1}, items {2} to {3} of {5}";

        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        AbsenceRatioGraph.DataSource = clsDAL.GetDataSet_admin("EB_DashoardLineGraph").Tables[0];
        
       
        
    }
    protected void MonthlyPiechart(object sender, EventArgs e)
    {

        RadHtmlChart2.DataSource = clsDAL.GetDataSet_admin("EB_PiechartMonthly").Tables[0];
        
        
    }
    protected void AnnualPiechart(object sender, EventArgs e)
    {
        RadHtmlChart3.DataSource = clsDAL.GetDataSet_admin("EB_YearlyLeavePiechart").Tables[0];
    }
    protected void EmployCount(Object sender, EventArgs e)
    {
        DataSet dt = new DataSet();
        dt = clsCommon.Get_Employees();
        EmployeeCount.Text = dt.Tables[0].Rows.Count.ToString();
    }
    protected void PendingLeaveCount(Object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_PendingLeaveRequests").Tables[0];
        PendingLeave.Text = dt.Rows.Count.ToString();
    }

    protected void RadGrid1_NeedDataSource(Object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_AdmnDashboardEmployGrid").Tables[0];
        (sender as RadGrid).DataSource = dt;
    }       
    protected void AnnualRequestsCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisYearLeaves").Tables[0];
        AnnualRequests.Text = dt.Rows.Count.ToString();
    }

    protected void MonthlyRequestsCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisMonthLeaves").Tables[0];
        MonthlyRequests.Text = dt.Rows.Count.ToString();
    }
    protected void MonthlyApprovedCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisMonthApproved").Tables[0];
        MonthlyApproved.Text = dt.Rows[0][0].ToString();
    }
    protected void AnnualApprovedCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisYearApproved").Tables[0];
        AnnualApproved.Text = dt.Rows[0][0].ToString();
    }
    protected void MonthlyRejectedCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisMonthRejected").Tables[0];
        MonthlyRejected.Text = dt.Rows[0][0].ToString();
    }
    protected void AnnualRejectedCount(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("EB_ThisYearRejected").Tables[0];
        AnnualRejected.Text = dt.Rows[0][0].ToString();
    }
    protected void RadGrid1_ItemCommand(object source, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "RowClick":
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("~/Dashboards/UserDashboard.aspx?id=" + item["ID"].Text);
                break;
            default:
                break;
        }
    }
}
