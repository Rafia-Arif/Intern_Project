using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data; 

using System.Data.SqlClient;
using Telerik.Web.UI;
using Telerik.Charting;
using System.IO;
using System.Configuration;

public partial class Statisticsappsts : BasePage
{
   
 
    protected void Page_Init(object sender, EventArgs e)
    {

        FormName = "Statisticsappsts";
        base.Page_Init(sender, e);

    }
    protected void Page_Load(object sender, EventArgs e)
    {

        DataTable dt_app_req_sts = clsDAL.GetDataSet("Sts_app_req_sts").Tables[0];
        int i, j, k, l, m, n;

        i= Convert.ToInt16(dt_app_req_sts.Rows[0][0].ToString());
        j = Convert.ToInt16(dt_app_req_sts.Rows[1][0].ToString());
        k = Convert.ToInt16(dt_app_req_sts.Rows[2][0].ToString());
        l = Convert.ToInt16(dt_app_req_sts.Rows[3][0].ToString());
        m = Convert.ToInt16(dt_app_req_sts.Rows[4][0].ToString());
        //n = Convert.ToInt16(dt_app_req_sts.Rows[5][0].ToString());



        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[0].Y = i;
        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[1].Y = j;
        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[2].Y = k;
        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[3].Y = l;
        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[4].Y = m;
        //(PieChart1.PlotArea.Series[0] as PieSeries).SeriesItems[5].Y = n;

    }
   
}
