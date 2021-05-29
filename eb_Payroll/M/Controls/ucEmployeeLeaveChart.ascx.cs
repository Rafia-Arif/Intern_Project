using System;
using System.Collections;
using System.Data;
using System.Linq;
using Telerik.Web.UI;

public partial class Controls_ucEmployeeLeaveChart : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void LoadEmployeeLeaveChart(string employeeID)
    {
        DataTable dt = new DataTable();
        Hashtable ht = new Hashtable();
        //ht.Add("@empidd", employeeID);
        ht.Add("@empidd", employeeID);
        dt = clsDAL.GetDataSet("eb_getLeaveBalances4AllEmp", ht).Tables[0];

        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                int numSeries = dt.Rows.Count;
                //RadHtmlChart1.Width = 400;
                RadHtmlChart1.Height = 280;
                ColumnSeries colSeries = new ColumnSeries();
                for (int i = 0; i < numSeries; i++)
                {

                    //  Color color = Color.DarkGreen;
                    //if (dt.Rows[i][1].ToString() == "Annual")
                    //{
                    //    color = Color.DarkGreen;
                    //}
                    //if (dt.Rows[i][1].ToString() == "CL Leave")
                    //{
                    //    color = Color.Red;
                    //}
                    colSeries.Gap = 1.5;
                    colSeries.Spacing = 1.5;
                    colSeries.Name = dt.Rows[i]["LeaveCode"].ToString();
                    colSeries.SeriesItems.Add(new CategorySeriesItem
                    {
                        //  BackgroundColor = color,
                        Y = Convert.ToDecimal(dt.Rows[i][9].ToString())


                    });


                }



                RadHtmlChart1.Skin = "Silk";
                RadHtmlChart1.PlotArea.Series.Add(colSeries);
                RadHtmlChart1.PlotArea.XAxis.DataLabelsField = "LeaveCode";
                RadHtmlChart1.PlotArea.XAxis.TitleAppearance.Text = "Absence Code";

                RadHtmlChart1.ChartTitle.Text = "Absence";
                RadHtmlChart1.DataSource = dt;
                RadHtmlChart1.DataBind();     

            }
        }
    }
}