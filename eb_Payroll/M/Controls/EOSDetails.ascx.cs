using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections;

public partial class Controls_EOSDetails : System.Web.UI.UserControl
{
    public int EmployeeID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.EmployeeID = 14;
            LoadData();
        }
    }
    public void LoadData()
    {
        if (EmployeeID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@EmployeeID", EmployeeID);

            var dsEOS = clsDAL.GetDataSet("sp_Payroll_Get_EndOfService_Details", ht);

            gridGratuityDetail.DataSource = dsEOS.Tables[0];
            gridGratuityDetail.DataBind();

            gridLeaveDetail.DataSource = dsEOS.Tables[1];
            gridLeaveDetail.DataBind();

            gridSalaryDetail.DataSource = dsEOS.Tables[2];
            gridSalaryDetail.DataBind();

            gridLoanDetail.DataSource = dsEOS.Tables[3];
            gridLoanDetail.DataBind();
        }
    }
}