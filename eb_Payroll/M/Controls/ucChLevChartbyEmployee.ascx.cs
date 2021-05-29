using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Charting;
using Telerik.Web.UI;

public partial class M_Controls_ucChLevChartbyEmployee : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = loadData("005");
        int numSeries = dt.Rows.Count - 1;

        for (int i = 0; i <= numSeries; i++)
        {
            PieSeries currLineSeries = new PieSeries();
            currLineSeries.DataFieldY = dt.Columns[0 + i].Caption;
            currLineSeries.NameField = "Balance";

            RadHtmlChart1.PlotArea.Series.Add(currLineSeries);

        }

        RadHtmlChart1.DataSource = dt;
    }
    public DataTable loadData(string empcod)
    {
        DataTable table = new DataTable();
        using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["eb_Payroll"].ConnectionString))
        using (var cmd = new SqlCommand("eb_getLeaveBalancesbyEmp", con))
        using (var da = new SqlDataAdapter(cmd))
        {
            con.Open();
            cmd.Parameters.Add(
               new SqlParameter("@empcod", empcod));

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.ExecuteNonQuery();
            da.Fill(table);
        }

        return table;
    }
}