using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_ucEmployeeEOBBalance : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void LoadEOSBalance(string employeeID)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", employeeID);
        var dsEmployee = clsDAL.GetDataSet("sp_Get_User_LeaveTransaction_Balance", ht);

        if (dsEmployee != null)
        {
            if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
            {
                literalBroughtForward.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["BroughtForward"]);
                literalAvailableBalance.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["AvailableBalance"]);
                literalLVBalanceAOD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LVBalanceAOD"]);
                literalUnpostedLeaves.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["UnpostedLeaves"]);
                literalLeaveTakenYTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenYTD"]);
                literalLeaveTakenLTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenLTD"]);
                literalLeaveTakenAOY.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenAOY"]);
            }
        }
    }
}