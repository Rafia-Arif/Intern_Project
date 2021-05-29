using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_ucEmployeeLeaveBalance : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
 
   
    public void LoadLeaveBalance(string employeeID, string leaveTypeidd, string leaveCodeidd, DateTime DateFrom, DateTime DateTo, string leaveType, string leaveCode,bool hourly, DateTime StartTime,DateTime EndTime)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", employeeID);
        ht.Add("@LeaveType", leaveTypeidd);
        ht.Add("@LeaveCode", leaveCodeidd);
        ht.Add("@DateFrom", DateFrom);
        ht.Add("@DateTo", DateTo);
        ht.Add("@hourly", hourly);
        ht.Add("@StartTime", StartTime);
        ht.Add("@EndTime", EndTime);

        ht.Add("@NoOfLeaves", "0");

        var dsEmployee = clsDAL.GetDataSet("sp_Get_User_LeaveTransaction_Balance", ht);

        if (dsEmployee != null)
        {
            if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
            {
                literalLeaveType.Text=leaveType;
                literalLeaveCode.Text = leaveCode;
                literalBroughtForward.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["BroughtForward"]);
                literalAvailableBalance.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["AvailableBalance"]);
                //literalLVBalanceAOD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LVBalanceAOD"]);
                literalUnpostedLeaves.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["UnpostedLeaves"]);
                literalCalandarDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["CalandarDays"]);
                literalWeekends.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["Weekends"]);
                //literalRestDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["RestDays"]);
                literalPublicHolidays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PublicHolidays"]);
                literalActualLeaveDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["ActualLeaveDays"]);
                literalLeaveTakenYTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenYTD"]);
                //literalLeaveTakenLTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenLTD"]);
                //literalLeaveTakenAOY.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenAOY"]);
                literalAdjustedDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["AdjustedDays"]);
                literalExcessDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["ExcessDays"]);
            }
            else 
            {
                literalBroughtForward.Text = "0";
                literalAvailableBalance.Text = "0";
                //literalLVBalanceAOD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LVBalanceAOD"]);
                literalUnpostedLeaves.Text = "0";
                literalCalandarDays.Text = "0";
                literalWeekends.Text = "0";
                //literalRestDays.Text = "0";
                literalPublicHolidays.Text = "0";
                literalActualLeaveDays.Text = "0";
                literalLeaveTakenYTD.Text = "0";
                //literalLeaveTakenLTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenLTD"]);
                //literalLeaveTakenAOY.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenAOY"]);
                literalAdjustedDays.Text = "0";
                literalExcessDays.Text = "0";
            }
        }
    }
}