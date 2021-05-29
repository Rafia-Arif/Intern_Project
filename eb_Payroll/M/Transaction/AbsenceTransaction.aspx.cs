using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;
using System.Data.SqlClient;
using System.Configuration;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Download;
using Google.Apis.Drive.v3;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.IO;
using System.Threading;

public partial class AbsenceTransaction : BasePage
{

    #region Startup

    //public static string AttachmentStorage = "Database";
    public static string AttachmentStorage = "";

    //Name of folder on google drive to save attachments
    public static string StorageFolder = "PayrollLeave";

    //shift total hours 
    //public static double TotalHours = 8.0;
    public static double TotalHours;

    public bool exporting = false;
    public static string FormType;

    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "LeaveTransaction";
        base.Page_Init(sender, e);
        FormType = "3132";//clsCommon.FormType(Request.QueryString["FormType"].ToString());


        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        Response.Cache.SetNoStore();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["AppRequestID"] = null;
            Session["LevRequestStatusID"] = null;

            //txtOffHours.Format = DateTimePickerFormat.Time;

            Session["mode"] = "New";
            //to get the storage location for attachments from configuration 
            Hashtable htnew = new Hashtable();
            htnew["@UserId"] = HttpContext.Current.Session["_UserID"].ToString();
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_AttachmentStorage", htnew).Tables[0];

            if (dt.Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(dt.Rows[0]["attachmentstorage"].ToString()))
                {
                    AttachmentStorage = dt.Rows[0]["attachmentstorage"].ToString();
                }
                else
                {
                    AttachmentStorage = "Database";
                }
            }
            else
            {
                AttachmentStorage = "Database";
            }

            Session["AttachmentStorage"] = AttachmentStorage;

            Hashtable htt = new Hashtable();
            DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_LeaveParameters", htt).Tables[0];
            if (dtConfigs.Rows.Count > 0)
            {
                if (dtConfigs.Rows[0]["disFrmToTimeCtrls"].ToString() == "True")
                {
                    hfdisFrmToTimeCtrls.Value = "true";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideMinutesDiv", "hideMinutesDiv();", true);
                    txtOffHours.NumberFormat.DecimalDigits = 2;
                    txtOffHours.ShowSpinButtons = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMinutesDiv", "showMinutesDiv();", true);
                    txtOffHours.NumberFormat.DecimalDigits = 0;
                    txtOffHours.ShowSpinButtons = true;
                }
            }

        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        RadGrid rGrdEmployees4DDL = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, ucEmployeeCard);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbEntryType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbLeaveType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbLeaveCode);

        RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;

        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rGrdEntryTypes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rCmbLeaveType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rCmbLeaveCode);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtFromDate);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtToDate);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtNumberOfDays);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRemarks1);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRemarks2);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRejoiningDate);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, checkAirTicket);

        RadGrid rGrdLeaveTypes4DDL = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;

        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rGrdLeaveTypes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rCmbLeaveCode);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rGrdLeaveCodes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rCmbEntryType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rGrdEntryTypes4DDL);

        //RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveCodes4DDL, rGrdLeaveCodes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveCodes4DDL, ucEmployeeLeaveBalance);

        /*
         * <telerik:AjaxUpdatedControl ControlID="rCmbEntryType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode"   />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket"   />
         */

    }

    #endregion

    #region  Misc. Functions

    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000)", true);
        }
    }

    protected string getImagePathForTrue(string status)
    {
        if (status == "In Process")
            return "~/Images/16x16_process.png";
        if (status == "Sucessfull")
            return "~/Images/16x16_approved.png";
        if (status == "Rejected")
            return "~/Images/16x16_rejected.png";
        else
            return "";
    }

    protected string GetUserFullName(int EmployeeUserID, string EmployeeFullName)
    {
        if (EmployeeUserID == int.Parse(Session["_UserID"].ToString()))
            return "Self";
        else
            return EmployeeFullName;
    }

    protected bool isCompletedVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Completed:
                return true;

            default:
                return false;
        }
    }

    protected bool isEditVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }

        }
        else
            return false;
    }

    protected bool isInProcessVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRecallVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                case clsCommon.RequestStatus.Approved:
                    return true;

                case clsCommon.RequestStatus.Canceled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRejectedVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Rejected:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isSubmitVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {

            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    private void ClearEntryType()
    {
        RadGrid grid_EntryType = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        if (grid_EntryType != null)
        {
            grid_EntryType.SelectedIndexes.Clear();
            rCmbEntryType.Text = "";
            rCmbEntryType.Items[0].Value = "";
            rCmbEntryType.ClearSelection();
        }
        //rCmbLeaveCode.Enabled = false;
    }

    private void clearForm()
    {
        lbltab1.Text = "New Request";
        Session["mode"] = "New";
        //ClearEmployees();
        ClearEntryType();
        ClearLeaveType();
        ClearLeaveCode();
        txtCashAmount.Text = "";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashAmountDiv", "hideCashAmountDiv();", true);
        txtNumberOfDays.Text = "";
        txtRejoiningDate.Clear();
        txtFromDate.Clear();
        txtToDate.Clear();
        checkAirTicket.Checked = false;
        cbxPerDiem.Checked = false;
        cbxLeaveSalary.Checked = false;
        cbxCashcheck.Checked = false;
        txtCashAmount.Text = "";
        txtRemarks1.Text = "";
        txtRemarks2.Text = "";
        cbxPerDiem.Checked = false;
        cbxLeaveSalary.Checked = false;
        cbxCashcheck.Checked = false;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "DeleteFiles", "DeleteFiles();", true);
        gvAttachments.Visible = false;
        ltrNoResults.Visible = false;
        ruDocument.Visible = true;
        ruDocument.Enabled = true;

        tpFromTime.Clear();
        tpToTime.Clear();
        cbxhourly.Checked = false;
        txtDayPercentage.Text = "";
        txtNumberOfDays.Text = "";
        cbxhourly.Enabled = true;
        txtOffHours.Text = "";

        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);

        txtOffHours.Enabled = false;
        txtDayPercentage.Enabled = false;
        txtNumberOfDays.Enabled = true;

        txtFromDate.Enabled = true;
        txtToDate.Enabled = true;
        refreshGrids();

        ApprovalPanel.Visible = false;
        txtremarks.Text = "";

        ddlMinutes.SelectedText = "0";
        ddlMinutes.Enabled = false;

        txtRemarks1.Enabled = true;
        txtRemarks2.Enabled = true;
        cbxhourly.Enabled = true;
        checkAirTicket.Enabled = true;
        cbxPerDiem.Enabled = true;
        cbxCashcheck.Enabled = true;
        cbxLeaveSalary.Enabled = true;

        txtFromDate.Enabled = true;
        rCmbEmployee.Enabled = true;
        rCmbLeaveType.Enabled = true;
        rCmbLeaveCode.Enabled = true;
        rCmbEntryType.Enabled = true;
        txtCashAmount.Enabled = true;

        rBtnSave.Visible = true;
        rBtnSaveAndSubmit.Visible = true;
    }

    private void ClearEmployees()
    {
        RadGrid grid_Employees = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        if (grid_Employees != null)
        {
            grid_Employees.SelectedIndexes.Clear();
            rCmbEmployee.Text = "";
            rCmbEmployee.Items[0].Text = "";
            rCmbEmployee.Items[0].Value = "";
            rCmbEmployee.ClearSelection();
        }
    }

    private void ClearLeaveCode()
    {
        RadGrid grid_LeaveCode = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        if (grid_LeaveCode != null)
        {
            grid_LeaveCode.SelectedIndexes.Clear();
            rCmbLeaveCode.Text = "";
            rCmbLeaveCode.Items[0].Text = "";
            rCmbLeaveCode.Items[0].Value = "";
            rCmbLeaveCode.ClearSelection();
        }
    }

    private void ClearLeaveType()
    {
        RadGrid grid_LeaveType = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        if (grid_LeaveType != null)
        {
            grid_LeaveType.SelectedIndexes.Clear();
            rCmbLeaveType.Text = "";
            rCmbLeaveType.Items[0].Text = "";
            rCmbLeaveType.Items[0].Value = "";
            rCmbLeaveType.ClearSelection();
            //rCmbLeaveCode.Enabled = false;
        }
    }

    public string GetDate()
    {
        return System.DateTime.Now.ToString();
    }

    protected void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        refreshGrids();
    }

    public void refreshGrids()
    {
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }

    #endregion

    #region Tab1 - New Requests

    protected void LoadEmpcard(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
    }

    protected void LoadLeavecard(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null && rCmbLeaveType.Items[0].Value != null && rCmbLeaveCode.Items[0].Value != null)
        {
            DateTime StartTime, EndTime;
            List<DateTime> Times = new List<DateTime>();
            Times = getStartEndTime();

            ucEmployeeLeaveBalance.LoadLeaveBalance(rCmbEmployee.Items[0].Value, rCmbLeaveType.Items[0].Value, rCmbLeaveCode.Items[0].Value, txtFromDate.SelectedDate ?? DateTime.Now, txtToDate.SelectedDate ?? DateTime.Now, rCmbLeaveType.Items[0].Text, rCmbLeaveCode.Items[0].Text, Convert.ToBoolean(cbxhourly.Checked), Times[0], Times[1]);

        }
    }

    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string NumberOfDays;
            NumberOfDays = txtNumberOfDays.Text;
            if (NumberOfDays == "0" && cbxhourly.Checked == false)
            {
                ShowClientMessage("Number of days must be greater than zero", MessageType.Warning);

            }
            else
            {
                string EmpCalID = GetCalendarID(rCmbEmployee.Items[0].Value);
                if (string.IsNullOrEmpty(EmpCalID))
                {
                    ShowClientMessage("Calendar configuration missing for selected employee", MessageType.Warning);
                }
                else
                {
                    bool proceed = true;

                    //Check for New Joiner
                    Hashtable ht1 = new Hashtable();
                    ht1.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                    ht1.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                    ht1.Add("@Action", "");

                    string action = "";
                    string Warning = "";

                    action = clsDAL.ExecuteNonQuery("sp_User_CheckIfEmployeeIsNewJoiner", ht1, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                    //action can be "No Leave", "Period Allowed" or "Current Balance" 
                    if (action == "No Leave")
                    {
                        ShowClientMessage("No Leave for new joiner", MessageType.Warning);
                        proceed = false;
                    }


                    //Check if number of leaves are more than max leaves allowed under zero balance
                    Hashtable ht2 = new Hashtable();
                    ht2.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                    ht2.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                    ht2.Add("@NumberOfDays", txtNumberOfDays.Text);
                    ht2.Add("@Action", "");

                    action = "";

                    action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeavesMoreThanAllowedBelowZero", ht2, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                    //action can be "Warn User"
                    if (action == "Warn User")
                    {
                        ShowClientMessage("Leave balance falls below zero", MessageType.Warning);
                    }



                    if (proceed == true)
                    {
                        save(1);
                    }
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                    //refreshGrids();
                    //gvSavedRequests.Rebind();
                }
            }
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
        }
    }

    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        string NumberOfDays;
        NumberOfDays = txtNumberOfDays.Text;
        if (NumberOfDays == "0" && cbxhourly.Checked == false)
        {
            ShowClientMessage("Number of days must be greater than zero", MessageType.Warning);

        }
        else
        {
            string EmpCalID = GetCalendarID(rCmbEmployee.Items[0].Value);
            if (string.IsNullOrEmpty(EmpCalID))
            {
                ShowClientMessage("Calendar configuration missing for selected employee", MessageType.Warning);
            }
            else
            {
                bool proceed = true;

                //Check for New Joiner
                Hashtable ht1 = new Hashtable();
                ht1.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht1.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                ht1.Add("@Action", "");

                string action = "";
                string Warning = "";

                action = clsDAL.ExecuteNonQuery("sp_User_CheckIfEmployeeIsNewJoiner", ht1, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                //action can be "No Leave", "Period Allowed" or "Current Balance" 
                if (action == "No Leave")
                {
                    ShowClientMessage("No Leave for new joiner", MessageType.Warning);
                    proceed = false;
                }


                //Check if number of leaves are more than max leaves allowed under zero balance
                Hashtable ht2 = new Hashtable();
                ht2.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht2.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                ht2.Add("@NumberOfDays", txtNumberOfDays.Text);
                ht2.Add("@Action", "");

                action = "";

                action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeavesMoreThanAllowedBelowZero", ht2, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                //action can be "Warn User"
                if (action == "Warn User")
                {
                    ShowClientMessage("Leave balance falls below zero", MessageType.Warning);
                }


                //Check for Same Department in given dates
                Hashtable ht3 = new Hashtable();
                ht3.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht3.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                ht3.Add("@fromDate", txtFromDate.SelectedDate);
                ht3.Add("@toDate", txtToDate.SelectedDate);
                ht3.Add("@Action", "");

                action = "";

                action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeaveInSameDepartmentInDates", ht3, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                //action can be "No Action", "Warn User" or "Stop Entry" 
                if (action == "Warn User")
                {
                    ShowClientMessage("Leave in same department exists on current dates", MessageType.Warning);
                }
                else if (action == "Stop Entry")
                {
                    ShowClientMessage("Leave in same department exists on current dates", MessageType.Warning);
                    proceed = false;
                }

                //Check for Same Position in given dates
                Hashtable ht4 = new Hashtable();
                ht4.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht4.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                ht4.Add("@fromDate", txtFromDate.SelectedDate);
                ht4.Add("@toDate", txtToDate.SelectedDate);
                ht4.Add("@Action", "");

                action = "";

                action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeaveInSamePositionInDates", ht4, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
                //action can be "No Action", "Warn User" or "Stop Entry" 
                if (action == "Warn User")
                {
                    ShowClientMessage("Leave in same position exists on current dates", MessageType.Warning);
                }
                else if (action == "Stop Entry")
                {
                    ShowClientMessage("Leave in same position exists on current dates", MessageType.Warning);
                    proceed = false;
                }


                if (proceed == true)
                {
                    save(2);
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                //refreshGrids();
                //gvSubmittedRequests.Rebind();
            }
        }
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //clearForm();
        //if (rCmbEmployee.Items[0].Value != null)
        //{
        //    ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        //}
    }



    protected void rGrdEmployees4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        rCmbEmployee.ClearSelection();

        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", FormType);

        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        DataTable dt = new DataTable();
        dt = clsDAL.GetDataSet_admin("LK_Get_EmpByUserID", ht).Tables[0];
        grid.DataSource = dt;
        if (dt.Rows.Count > 5)
        {
            grid.AllowFilteringByColumn = true;
        }
        else
        {
            grid.AllowFilteringByColumn = false;
        }

        if (dt != null)
        {
            foreach (DataRow row in dt.Rows)
            {
                if (row["recidd"].ToString() == Session["_UserID"].ToString())
                {
                    rCmbEmployee.Items[0].Value = row["empidd"].ToString();
                    rCmbEmployee.Items[0].Text = row["empcod"].ToString();
                    rCmbEmployee.Text = row["empcod"].ToString();
                }
            }
        }



        if (!string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
          //  ucEmployeeLeaveChart.LoadEmployeeLeaveChart(rCmbEmployee.Items[0].Value);
            //  LoadLeavecard(null, null);

            string EmpCalID = GetCalendarID(rCmbEmployee.Items[0].Value);
            if (string.IsNullOrEmpty(EmpCalID))
            {
                warningMsg.Value = "Calendar configuration missing for selected employee";
                //ShowClientMessage("Calendar configuration missing for selected employee", MessageType.Warning);
            }
            //to set tpFromTime and tpToTime from employee shift timings
            if (!string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
            {
                Hashtable htt = new Hashtable();
                htt.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                DataTable dtt = new DataTable();
                dtt = clsDAL.GetDataSet("sp_Payroll_Get_ShiftInfo_By_Employee", htt).Tables[0];
                if (dtt != null)
                {
                    if (dtt.Rows.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(dtt.Rows[0]["sftStartTime"].ToString()))
                        {
                            tpFromTime.TimeView.StartTime = TimeSpan.Parse(dtt.Rows[0]["sftStartTime"].ToString());
                            tpFromTime.SelectedTime = TimeSpan.Parse(dtt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.TimeView.StartTime = TimeSpan.Parse(dtt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.SelectedTime = TimeSpan.Parse(dtt.Rows[0]["sftStartTime"].ToString());
                        }

                        if (!string.IsNullOrEmpty(dtt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan endTime = TimeSpan.Parse(dtt.Rows[0]["sftEndTime"].ToString());
                            TimeSpan endTimePlus = endTime + TimeSpan.Parse("00:01");
                            tpFromTime.TimeView.EndTime = endTimePlus;
                            tpToTime.TimeView.EndTime = endTimePlus;
                        }

                        if (!string.IsNullOrEmpty(dtt.Rows[0]["sftStartTime"].ToString()) && !string.IsNullOrEmpty(dtt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan TimeDiff = TimeSpan.Parse(dtt.Rows[0]["sftEndTime"].ToString()) - TimeSpan.Parse(dtt.Rows[0]["sftStartTime"].ToString());
                            TotalHours = TimeDiff.TotalHours;
                        }
                    }
                }
            }
            RadGrid rGrdLeaveTypes4DDL = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
            rGrdLeaveTypes4DDL.Rebind();
        }


        //  clearForm();
    }

    protected void rGrdEmployees4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {

        //clearForm();
        //ClearLeaveCode();

        //RadCheckBox cbxhourly = sender as RadCheckBox;
        if (cbxhourly.Checked == true)
        {
            txtToDate.SelectedDate = txtFromDate.SelectedDate;
            txtRejoiningDate.SelectedDate = txtFromDate.SelectedDate;
            txtToDate.Enabled = false;

            if (hfdisFrmToTimeCtrls.Value == "true")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showTimepicker", "showTimepicker();", true);
                txtOffHours.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                txtOffHours.Enabled = true;
            }
            txtNumberOfDays.Enabled = false;

            txtNumberOfDays.Text = "";

            //to set tpFromTime and tpToTime from employee shift timings
            if (!string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
            {
                Hashtable ht = new Hashtable();
                ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                DataTable dt = new DataTable();
                dt = clsDAL.GetDataSet("sp_Payroll_Get_ShiftInfo_By_Employee", ht).Tables[0];
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftStartTime"].ToString()))
                        {
                            tpFromTime.TimeView.StartTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpFromTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.TimeView.StartTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                        }

                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan endTime = TimeSpan.Parse(dt.Rows[0]["sftEndTime"].ToString());
                            TimeSpan endTimePlus = endTime + TimeSpan.Parse("00:01");
                            tpFromTime.TimeView.EndTime = endTimePlus;
                            tpToTime.TimeView.EndTime = endTimePlus;
                        }

                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftStartTime"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan TimeDiff = TimeSpan.Parse(dt.Rows[0]["sftEndTime"].ToString()) - TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            TotalHours = TimeDiff.TotalHours;
                        }
                    }
                }
            }

            calculateHrsDaysPer();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "enableDisableValidatorsOnHourly", "enableDisableValidatorsOnHourly();", true);
        }

        //txtDayPercentage.Text = "";
        ClearLeaveType();
        ClearLeaveCode();
        ClearEntryType();
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
          //  ucEmployeeLeaveChart.LoadEmployeeLeaveChart(rCmbEmployee.Items[0].Value);
        }

        string EmpCalID = GetCalendarID(rCmbEmployee.Items[0].Value);
        if (string.IsNullOrEmpty(EmpCalID))
        {
            ShowClientMessage("Calendar configuration missing for selected employee", MessageType.Warning);
        }

        RadGrid rGrdLeaveTypes4DDL = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        rGrdLeaveTypes4DDL.Rebind();
        RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        rGrdLeaveCodes4DDL.Rebind();
        RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        rGrdEntryTypes4DDL.Rebind();
    }

    protected void rGrdEmployees4DDL_DataBound(object sender, EventArgs e)
    {
        var grid = sender as RadGrid;

        foreach (GridItem item in grid.MasterTableView.Items)
        {
            if (item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)item;
                if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == Session["_UserID"].ToString())
                {
                    dataItem.Selected = true;
                    break;
                }
            }
        }
    }

    protected void rGrdEmployees4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //var editItem = ((sender as RadGrid).NamingContainer.NamingContainer.NamingContainer);// as GridEditFormInsertItem);
        //var ddlSubModule = editItem.FindControl("ddlSubModule") as RadComboBox;
        //var module = ((sender as RadGrid).SelectedValues as Telerik.Web.UI.DataKey)["id"];
        //BindSubModule(ddlSubModule, int.Parse(Convert.ToString(module)), "");
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenEmployeeddl", "OpenEmployeeddl();", true);
        }

        //      LoadLeavecard(null, null);
        //clearForm();
    }

    protected void rGrdEntryTypes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenEntryTypeddl", "OpenEntryTypeddl();", true);
        }

        //if entry is selected then enable from date, to date, ticket requested 
        //If entry is selected then disable rejoining date, number of days 
        //If encashment is selected then disable from date, to date, rejoining date. 
        //If encashment is selected then enable number of days, ticket requested 
        //If adjustment is selected then disable from date, to date, rejoining date, ticket requested 
        //If adjustment is selected then enable number of days
        if (e.CommandName.ToLower() == "sort")
            return;
    }

    protected void rGrdEntryTypes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
        {
            var leaveTypeID = rCmbLeaveType.Items[0].Value;
            RadGrid grid = sender as RadGrid;
            Hashtable ht = new Hashtable();
            ht.Add("@LeaveType", leaveTypeID);
            //grid.DataSource = clsCommon.DDLValueSet_GetByDDLID(Constraints.DropDownLists.LeaveEntryType, -1, 1).Tables[0];
            grid.DataSource = clsDAL.GetDataSet_admin("GetEntyTypeDDLValues", ht).Tables[0];
            grid.AllowFilteringByColumn = false;
        }
    }

    protected void rGrdLeaveCodes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenLeaveCodeddl", "OpenLeaveCodeddl();", true);
        }
        //LoadLeavecard(null, null);
    }

    protected void rGrdLeaveCodes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            var leaveTypeID = rCmbLeaveType.Items[0].Value;

            DataTable dt = new DataTable();
            Hashtable ht = new Hashtable();
            ht.Add("@LeaveType", leaveTypeID);
            ht.Add("@empidd", rCmbEmployee.Items[0].Value);

            RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
            dt = clsDAL.GetDataSet("sp_Payroll_Get_LeaveCodesbyLeaveType", ht).Tables[0];
            grid.DataSource = dt;
            if (dt.Rows.Count > 5)
            {
                grid.AllowFilteringByColumn = true;
            }
            else
            {
                grid.AllowFilteringByColumn = false;
            }
            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["levdft"].ToString() == "True")
                    {
                        rCmbLeaveCode.Items[0].Value = row["lvcidd"].ToString(); ;
                        rCmbLeaveCode.Items[0].Text = row["lvccod"].ToString();
                        rCmbLeaveCode.Text = row["lvccod"].ToString();
                    }
                }
            }
        }
        //   LoadLeavecard(null, null);
    }

    protected void rGrdLeaveCodes4DDL_DataBound(object sender, EventArgs e)
    {
        var grid = sender as RadGrid;
        foreach (GridItem item in grid.MasterTableView.Items)
        {
            if (item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)item;
                if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levdft"].ToString() == "True")
                {
                    dataItem.Selected = true;
                    break;
                }
            }
        }
    }

    protected void rGrdLeaveTypes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName) //FilterCommandName is raised when filtered
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenLeaveTypeddl", "OpenLeaveTypeddl();", true);
        }

        if (e.CommandName.ToLower() == "sort")
            return;

        //RadGrid grid = (sender as RadGrid);
        //if (grid != null)
        //{
        //    if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
        //    {
        //        var leveTypeID = Convert.ToInt32(rCmbLeaveType.Items[0].Value);
        //        this.GetLeaveCodes((int)leveTypeID);
        //        ClearLeaveCode();
        //        rCmbLeaveCode.Enabled = true;
        //    }
        //}
    }

    protected void rGrdLeaveTypes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            RadGrid grid = sender as RadGrid;

            DataTable dt = new DataTable();
            Hashtable ht = new Hashtable();
            ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
            dt = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveTypes", ht).Tables[0];
            grid.DataSource = dt;
            if (dt.Rows.Count > 5)
            {
                grid.AllowFilteringByColumn = true;
            }
            else
            {
                grid.AllowFilteringByColumn = false;
            }
            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["levdft"].ToString() == "True")
                    {
                        rCmbLeaveType.Items[0].Value = row["recidd"].ToString(); ;
                        rCmbLeaveType.Items[0].Text = row["levtypcod"].ToString();
                        rCmbLeaveType.Text = row["levtypcod"].ToString();

                        if (row["TrvTktAll"].ToString().ToLower() == "true" || row["levperdiem"].ToString().ToLower() == "true" || row["levsal"].ToString().ToLower() == "true" || row["levadvcash"].ToString().ToLower() == "true")
                        {

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showCheckboxesRowdiv", "showCheckboxesRowdiv();", true);

                        }
                        else if (row["TrvTktAll"].ToString().ToLower() == "false" && row["levperdiem"].ToString().ToLower() == "false" && row["levsal"].ToString().ToLower() == "false" && row["levadvcash"].ToString().ToLower() == "false")
                        {
                            cbxPerDiem.Checked = false;
                            cbxCashcheck.Checked = false;
                            cbxLeaveSalary.Checked = false;
                            checkAirTicket.Checked = false;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCheckboxesRowdiv", "hideCheckboxesRowdiv();", true);
                        }

                        
                        if (row["levperdiem"].ToString().ToLower() == "true")
                        {
                            //cbxPerDiem.Checked = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
                        }
                        else
                        {
                            cbxPerDiem.Checked = false;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hidePerDiemdiv", "hidePerDiemdiv();", true);
                        }

                        if (row["TrvTktAll"].ToString().ToLower() == "true")
                        {
                            //checkAirTicket.Checked = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showTicketdiv", "showTicketdiv();", true);
                        }
                        else
                        {
                            checkAirTicket.Checked = false;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTicketdiv", "hideTicketdiv();", true);
                        }
                        
                        if (row["levsal"].ToString().ToLower() == "true")
                        {//cbxLeaveSalary.Checked = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
                        }
                        else
                        {
                            cbxLeaveSalary.Checked = false;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideVacationSalarydiv", "hideVacationSalarydiv();", true);
                        }
                        if (row["levadvcash"].ToString().ToLower() == "true")
                        {
                            //cbxCashcheck.Checked = true;
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashAmountDiv", "showCashAmountDiv();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
                        }
                        else
                        {
                            cbxCashcheck.Checked = false;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashCheckdiv", "hideCashCheckdiv();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashAmountDiv", "hideCashAmountDiv();", true);
                        }
                        if (!string.IsNullOrEmpty(row["levmaxcash"].ToString()))
                        {
                            hfMaxCash.Value = row["levmaxcash"].ToString();
                        }
                    }
                }
            }

            if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
            {
                RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
                rGrdLeaveCodes4DDL.Rebind();
            }

            if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
            {
                RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
                rGrdEntryTypes4DDL.Rebind();
            }

        }


        //RadGrid grid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveTypes").Tables[0];
    }

    protected void rGrdLeaveTypes4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (grid != null)
        {
            if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
            {
                ClearLeaveCode();
                ClearEntryType();
                //var leveTypeID = Convert.ToInt32(rCmbLeaveType.Items[0].Value);

                //this.GetLeaveCodes((int)leveTypeID);
                rCmbLeaveCode.Enabled = true;

                //cbxPerDiem.Checked = false;
                //cbxLeaveSalary.Checked = false;
                //cbxCashcheck.Checked = false;
                hfMaxCash.Value = "";
                txtCashAmount.Text = "";

                GridDataItem item = (GridDataItem)grid.SelectedItems[0];
                if (item != null)
                {
                    if (item.GetDataKeyValue("levperdiem").ToString().ToLower() == "true")
                    {
                        //cbxPerDiem.Checked = true;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
                    }
                    else
                    {
                        cbxPerDiem.Checked = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hidePerDiemdiv", "hidePerDiemdiv();", true);


                    }
                    if (item.GetDataKeyValue("levsal").ToString().ToLower() == "true")
                    {
                        //cbxLeaveSalary.Checked = true;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);

                    }
                    else
                    {
                        cbxLeaveSalary.Checked = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideVacationSalarydiv", "hideVacationSalarydiv();", true);

                    }
                    if (item.GetDataKeyValue("levadvcash").ToString().ToLower() == "true")
                    {
                        //cbxCashcheck.Checked = true;
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashAmountDiv", "showCashAmountDiv();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);

                    }
                    else
                    {
                        cbxCashcheck.Checked = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashCheckdiv", "hideCashCheckdiv();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashAmountDiv", "hideCashAmountDiv();", true);
                    }
                    if (!string.IsNullOrEmpty(item.GetDataKeyValue("levmaxcash").ToString()))
                    {
                        hfMaxCash.Value = item.GetDataKeyValue("levmaxcash").ToString();
                    }
                }

                RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
                rGrdLeaveCodes4DDL.Rebind();
                RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
                rGrdEntryTypes4DDL.Rebind();
            }
        }

    }

    protected void rGrdLeaveTypes4DDL_DataBound(object sender, EventArgs e)
    {
        var grid = sender as RadGrid;
        foreach (GridItem item in grid.MasterTableView.Items)
        {
            if (item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)item;
                if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levdft"].ToString() == "True")
                {
                    dataItem.Selected = true;
                    break;
                }
            }
        }
    }

    protected List<DateTime> getStartEndTime()
    {

        List<DateTime> Times = new List<DateTime>();

        DateTime StartTime, EndTime;


        if (!Convert.ToBoolean(cbxhourly.Checked))
        {
            StartTime = (DateTime)txtToDate.SelectedDate;
            EndTime = (DateTime)txtToDate.SelectedDate;

        }
        else
        {

            StartTime = (DateTime)txtFromDate.SelectedDate;
            StartTime = DateTime.Parse(StartTime.ToShortDateString() + " " + tpFromTime.SelectedTime);
            //                StartTime = StartTime.Date.Add(Convert.ToDateTime(tpFromTime.SelectedTime).TimeOfDay);

            EndTime = (DateTime)txtToDate.SelectedDate;
            EndTime = DateTime.Parse(EndTime.ToShortDateString() + " " + tpToTime.SelectedTime);


        }
        Times.Clear();
        Times.Add(StartTime);
        Times.Add(EndTime);
        return Times;

    }
    protected DateTime getRejoiningDate()
    {
        DateTime RejoingDate = ((DateTime)txtToDate.SelectedDate).AddDays(1);

        int i = 1;
        do
        {
            DateTime StartTime, EndTime;
            List<DateTime> Times = new List<DateTime>();
            Times = getStartEndTime();
    
     
            Hashtable ht = new Hashtable();
            ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
            ht.Add("@LeaveType", rCmbLeaveType.Items[0].Value);
            ht.Add("@LeaveCode", rCmbLeaveCode.Items[0].Value);
            ht.Add("@DateFrom", ((DateTime)txtToDate.SelectedDate).AddDays(i));
            ht.Add("@DateTo", ((DateTime)txtToDate.SelectedDate).AddDays(i));

            ht.Add("@hourly", Convert.ToBoolean(cbxhourly.Checked));

            ht.Add("@StartTime",Times[0]);
            ht.Add("@EndTime", Times[1]);
            
            ht.Add("@NoOfLeaves", "0");

            var dsEmployee = clsDAL.GetDataSet("sp_Get_User_LeaveTransaction_Balance", ht);
            if (dsEmployee != null)
            {
                if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
                {
                    if (Int32.Parse(dsEmployee.Tables[0].Rows[0]["Weekends"].ToString()) > 0 || Int32.Parse(dsEmployee.Tables[0].Rows[0]["PublicHolidays"].ToString()) > 0)
                    {
                        i = i + 1;
                        RejoingDate = ((DateTime)txtToDate.SelectedDate).AddDays(i);
                    }
                    else
                    {
                        i = 31;
                    }
                }
                else
                {
                    i = 31;
                }
            }
            else
            {
                i = 31;
            }
        }
        while (i <= 30);
        return RejoingDate;
    }
    protected void txtFromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if (cbxhourly.Checked == true)
        {
            if (txtFromDate.SelectedDate != null)
            {
                txtToDate.MinDate = (DateTime)txtFromDate.SelectedDate;
                txtToDate.SelectedDate = txtFromDate.SelectedDate;
                txtRejoiningDate.SelectedDate = txtFromDate.SelectedDate;
            }
        }
        else
        {

            if (txtFromDate.SelectedDate != null)
            {
                if (txtToDate.SelectedDate == null || txtToDate.SelectedDate < txtFromDate.SelectedDate)
                {
                    txtToDate.MinDate = (DateTime)txtFromDate.SelectedDate;
                    txtToDate.SelectedDate = (DateTime)txtFromDate.SelectedDate;



                    txtRejoiningDate.SelectedDate = getRejoiningDate();


                }
                else
                {
                    txtToDate.MinDate = (DateTime)txtFromDate.SelectedDate;
                }

                if (txtToDate.SelectedDate != null && !string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                    ht.Add("@LeaveStartDate", txtFromDate.SelectedDate);
                    ht.Add("@LeaveEndDate", txtToDate.SelectedDate);
                    ht.Add("@NoOfLeaves", "0");
                    string NoOfLeaves = clsDAL.ExecuteNonQuery("sp_Payroll_Get_NoOfLeaves", ht, "@NoOfLeaves", System.Data.SqlDbType.NVarChar, 255) as string;

                    txtNumberOfDays.Text = NoOfLeaves;
                }
                LoadLeavecard(null, null);
            }
        }
    }

    protected void txtToDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if (txtToDate.SelectedDate != null)
        {
            txtRejoiningDate.SelectedDate = getRejoiningDate();


            if (txtFromDate.SelectedDate != null && !string.IsNullOrEmpty(rCmbEmployee.Items[0].Value) && rCmbLeaveType.Items[0].Value != null && rCmbLeaveCode.Items[0].Value != null)
            {
                DateTime StartTime, EndTime;
                List<DateTime> Times = new List<DateTime>();
                Times = getStartEndTime();

                Hashtable ht = new Hashtable();
                ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                ht.Add("@LeaveType", rCmbLeaveType.Items[0].Value);
                ht.Add("@LeaveCode", rCmbLeaveCode.Items[0].Value);
                ht.Add("@DateFrom", txtFromDate.SelectedDate);
                ht.Add("@DateTo", txtToDate.SelectedDate);

                ht.Add("@hourly", Convert.ToBoolean(cbxhourly.Checked));
                ht.Add("@StartTime", Times[0]);
                ht.Add("@EndTime", Times[1]);

                ht.Add("@NoOfLeaves", "0");

                var dsEmployee = clsDAL.GetDataSet("sp_Get_User_LeaveTransaction_Balance", ht);

                if (dsEmployee != null)
                {
                    if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
                    {

                        //    string NoOfLeaves = clsDAL.ExecuteNonQuery("sp_Payroll_Get_NoOfLeaves", ht, "@NoOfLeaves", System.Data.SqlDbType.NVarChar, 255) as string;

                        txtNumberOfDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["ActualLeaveDays"]);
                    }
                    LoadLeavecard(null, null);
                }
            }
        }
    }

    private string GetCalendarID(string empID)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        DataTable dt = new DataTable();
        string empcalendarID = "";
        dt = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                empcalendarID = dt.Rows[0][0].ToString();
            }
        }

        return empcalendarID;
    }

    private string GetCalendarCode(string empID)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarCode;
        empcalendarCode = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][1].ToString();
        return empcalendarCode;
    }

    private void GetLeaveCodes(int leaveTypeID = 2)
    {
        #region Leave Code

        rCmbLeaveCode.ClearSelection();

        Hashtable ht = new Hashtable();
        ht.Add("@LeaveType", leaveTypeID);

        RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_LeaveCodesbyLeaveType", ht).Tables[0];
        grid.Rebind();

        #endregion Leave Code
    }

    private void save(int saveStatus)
    {
        try
        {
            Hashtable ht = new Hashtable();
            if (Session["mode"].ToString() != "New")
            {
                ht.Add("@recordIDD", int.Parse(Session["RequestID"].ToString()));
            }
            else
            {
                ht.Add("@DBMessage", "");
                ht.Add("@DBOperation", saveStatus);
                ht.Add("@TransRemarks", "");
                ht.Add("@requestdate", DateTime.Now);
                ht.Add("@userid", Session["_UserID"].ToString());
            }

            ht.Add("@FormTypeID", FormType);
            //ht.Add("@EmployeeUserID", rCmbEmployee.Items[0].Value);

            ht.Add("@entryType", rCmbEntryType.Items[0].Value);
            ht.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
            //ht.Add("@employeeCode", rCmbEmployee.Items[0].Text);
            ht.Add("@entryDate", DateTime.Now);
            ht.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
            ht.Add("@leaveTypeCode", rCmbLeaveType.Items[0].Text);
            ht.Add("@LeaveCodeIDD", rCmbLeaveCode.Items[0].Value);
            ht.Add("@LeaveCode", rCmbLeaveCode.Items[0].Text);
            //ht.Add("@calendarIDD", rCmbCalander.Items[0].Value);
            //ht.Add("@calendarIDD", "");

            //            ht.Add("@calendarCode", rCmbCalander.Items[0].Text);

            //ht.Add("@calendarCode", "");

            ht.Add("@fromDate", txtFromDate.SelectedDate);
            ht.Add("@toDate", txtToDate.SelectedDate);
            ht.Add("@rejoiningDate", txtRejoiningDate.SelectedDate);
            ht.Add("@calendarDays", 0);
            ht.Add("@weekendDays", 0);
            ht.Add("@holidays", 0);
            ht.Add("@leavedays", 0);
            ht.Add("@remarks1", txtRemarks1.Text);
            ht.Add("@remarks2", txtRemarks2.Text);
            ht.Add("@airTicket", checkAirTicket.Checked);

            ht.Add("@NumberOfDays", txtNumberOfDays.Text);

            ht.Add("@hourly", cbxhourly.Checked);

            if (cbxhourly.Checked == true)
            {
                if (hfdisFrmToTimeCtrls.Value == "true")
                {
                    ht.Add("@fromTime", tpFromTime.SelectedTime);
                    ht.Add("@toTime", tpToTime.SelectedTime);
                }
                else
                {
                    ht.Add("@OffMints", Convert.ToInt32(ddlMinutes.SelectedText));
                }
                ht.Add("@offHours", txtOffHours.Text);
                ht.Add("@dayPercentage", txtDayPercentage.Text);
            }

            //ht.Add("@SaveStatus", saveStatus);
            ht.Add("@SubmittedByUserID", (string)Session["_UserID"]);

            ht.Add("@LeaveTransactionID", 0);

            ht.Add("@perDiem", cbxPerDiem.Checked);
            ht.Add("@leaveSalary", cbxLeaveSalary.Checked);
            ht.Add("@cashCheck", cbxCashcheck.Checked);

            if (txtCashAmount.Text != "")
            {
                ht.Add("@cashAmount", txtCashAmount.Text);
            }

            string nextnumber;
            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "LEAVEENTRY");
            ht_nextnumber.Add("@TRX_ID", null);

            nextnumber = clsDAL.ExecuteNonQuery(Constraints.sp_User_Get_Next_Number, ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;

            ht.Add("@TRX_ID", nextnumber);
            //string DBMessage = "";
            int Recidd = 0;
            if (Session["mode"].ToString() != "New")
            {
                Recidd = Convert.ToInt32(clsDAL.ExecuteNonQuery(Constraints.sp_User_Update_LeaveRecord, ht, "@LeaveTransactionID", System.Data.SqlDbType.NVarChar, 255) as string);
            }
            else
            {
            //    clsCommon.ExportHash(ht);
                string value = clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_LeaveTransaction, ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                bool checkresult = Int32.TryParse(value, out Recidd);


                if (checkresult)
                {

                    if (Recidd > 0)
                    {

                        #region Add attachments
                        bool attachmentError = false;
                        Hashtable ht_attachments = new Hashtable();

                        if (ruDocument.UploadedFiles.Count > 0)
                        {
                            for (int l = 0; l <= ruDocument.UploadedFiles.Count - 1; l++)
                            {
                                ht_attachments = new Hashtable();
                                var currentFile = ruDocument.UploadedFiles[l];
                                var filedsc = currentFile.GetFieldValue("TextBox").ToString();
                                var filename = currentFile.FileName;
                                var fileType = currentFile.ContentType;
                                if (string.IsNullOrEmpty(currentFile.ContentType))
                                {
                                    fileType = "Unknown";
                                }

                                ht_attachments.Add("@transactionname", "PayrollLeave");
                                ht_attachments.Add("@transactionidd", Recidd);
                                ht_attachments.Add("@transactioncode", nextnumber);
                                ht_attachments.Add("@description", filedsc);
                                ht_attachments["@Filetype"] = fileType;
                                ht_attachments["@Filename"] = filename;

                                ht_attachments["@attachedBy"] = Convert.ToInt32(Session["_UserId"].ToString());

                                if (AttachmentStorage == Constraints.Constants.GoogleDrive)
                                {
                                    string onlineId = clsGoogleDriveFilesRepository.FileUpload(currentFile, StorageFolder);
                                    if (!string.IsNullOrEmpty(onlineId))
                                    {
                                        ht_attachments["@OnlineId"] = onlineId;
                                        clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                                    }
                                    else
                                    {
                                        attachmentError = true;
                                    }
                                }
                                else if (AttachmentStorage == Constraints.Constants.Database)
                                {
                                    var imgStream = currentFile.InputStream;
                                    int imgLen = int.Parse(currentFile.ContentLength.ToString());

                                    byte[] imgBinaryData = new byte[imgLen];
                                    int n = imgStream.Read(imgBinaryData, 0, imgLen - 1);
                                    imgStream.Close();

                                    // Image to Base64 string and save in database
                                    // Convert byte[] to Base64 String

                                    string base64String = Convert.ToBase64String(imgBinaryData);
                                    ht_attachments["@File"] = imgBinaryData;
                                    clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                                }
                            }
                        }

                        #endregion

                        int wfid;
                        Hashtable ht_message = new Hashtable();
                        ht_message.Add("@FormTypeID",FormType);
                        ht_message.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                        ht_message.Add("@WorkFlowMasterID", "0");

                        wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

                        if (saveStatus == 2 && wfid > 0)
                        {
                            ht = null;
                            ht = new Hashtable();
                            ht.Add("@SuggestionID", Recidd);
                            ht.Add("@RedirectURL", Request.Url.AbsoluteUri);
                            clsCommon.SendMail(3, ht);
                        }

                        if (Session["AppRequestID"] == null)
                        {
                            clearForm();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);

                            if (wfid == 0)
                            {
                                ShowClientMessage("New clscommTransaction ID: " + Recidd.ToString() + " is Saved but cannot be Sumbitted due to missing workflow.", MessageType.Warning);
                            }
                            else if (wfid > 0 && saveStatus == 2)
                            {
                                ShowClientMessage("New Transaction ID: " + Recidd.ToString() + " is Saved and submitted.", MessageType.Success);
                            }
                            else if (wfid > 0 && saveStatus == 1)
                            {
                                ShowClientMessage("New Transaction ID: " + Recidd.ToString() + " is Saved and can be submitted from tab.", MessageType.Info);
                            }
                            refreshGrids();
                        }
                        else
                        {
                            ShowClientMessage("Record Saved Successfully.", MessageType.Success);
                        }


                    }
                }
                else
                {
                    if (Recidd == 0)
                    {
                        ShowClientMessage(value, MessageType.Error);
                    }
                    else if (Recidd == -1)
                        ShowClientMessage("Leave request already exist in selected dates.", MessageType.Error);
                    else if (Recidd == -2)
                        ShowClientMessage("Employee from same department and same position has already requested in selected dates.", MessageType.Error);
                    else
                        ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Sorry! some error has occurred. Please try again later.<br/>" + ex.Message, MessageType.Error);
            Logger.LogError(ex);
        }
    }
    
    #endregion

    #region Tab2 - Saved Requests

    //protected void gvSavedRequests_SortCommand(object sender, GridSortCommandEventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
    //}

    protected void rBtnnewrequest_Click(object sender, EventArgs e)
    {
        clearForm();
        //ClearEmployees();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
        lbltab1.Text = "New Request";
    }


    protected void gvSavedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(FormType))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            //ht.Add("@FormTypeID", FormType);

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_All_LeaveTransaction", ht).Tables[0];
            dt.TableName = "eb_prllevtrx";
            gvSavedRequests.DataSource = dt;
            gvSavedRequests.DataMember = "eb_prllevtrx";
        }
    }

    protected void gvAttachments_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        if (Session["RequestID"] != null)
        {
            Hashtable ht_attach = new Hashtable();
            ht_attach.Add("@ID", int.Parse(Session["RequestID"].ToString()));
            DataTable dt_attach = clsDAL.GetDataSet("[sp_User_Get_Leave_RequestAttachmentsById]", ht_attach).Tables[0];
            if (dt_attach != null && dt_attach.Rows.Count > 0)
            {
                grid.DataSource = dt_attach;
                grid.Visible = true;
                ltrNoResults.Visible = false;
            }
            else
            {
                ltrNoResults.Visible = true;
                grid.Visible = false;
            }
        }
    }

    protected void gvAttachments_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        GridDataItem item = (GridDataItem)e.Item;

        // to delete file from gdrive
        string onlineId = item.GetDataKeyValue("OnlineId").ToString();
        if (!string.IsNullOrEmpty(onlineId))
        {
            string fileId = clsGoogleDriveFilesRepository.DeleteFile(onlineId, StorageFolder);
            if (!string.IsNullOrEmpty(fileId))
            {
                // to delete file info from database
                Hashtable newValues = new Hashtable();
                newValues["@RecordId"] = Int32.Parse(item.GetDataKeyValue("RecordId").ToString());

                newValues["@DBMessage"] = "";

                string DBMessage = "";
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_leave_delete_AttachmentById", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            }
            else
            {
                ShowClientMessage("Error: Could not connect to GDrive", MessageType.Error);
            }
        }

        else
        {
            // to delete file info from database
            Hashtable newValues = new Hashtable();
            newValues["@RecordId"] = Int32.Parse(item.GetDataKeyValue("RecordId").ToString());

            newValues["@DBMessage"] = "";

            string DBMessage = "";
            DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_leave_delete_AttachmentById", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
        }

        //if (DBMessage != "" && DBMessage.Contains("Unable to delete"))
        //{
        //    ShowClientMessage(DBMessage, MessageType.Error);
        //}
        //else if (DBMessage != "" && DBMessage.Contains("Success"))
        //{
        //    ShowClientMessage("Attachment deleted successfully.", MessageType.Success);
        //}

        gvAttachments.Rebind();
        ShowClientMessage("Attachment deleted successfully.", MessageType.Success);
    }

    protected void gvAttachments_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (e.CommandName == "Download")
        {
            GridDataItem item = e.Item as GridDataItem;

            // to download from gdrive
            string onlineId = item.GetDataKeyValue("OnlineId").ToString();
            if (!string.IsNullOrEmpty(onlineId))
            {
                //to make the folder empty
                string FolderPath = System.Web.HttpContext.Current.Server.MapPath("~/GoogleDriveFiles");
                System.IO.DirectoryInfo di = new DirectoryInfo(FolderPath);
                foreach (FileInfo file in di.GetFiles())
                {
                    file.Delete();
                }
                string FilePath = clsGoogleDriveFilesRepository.DownloadGoogleFile(onlineId, StorageFolder);
                if (!string.IsNullOrEmpty(FilePath))
                {
                    Response.ContentType = "application/zip";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(FilePath));
                    Response.WriteFile(System.Web.HttpContext.Current.Server.MapPath("~/GoogleDriveFiles/" + Path.GetFileName(FilePath)));
                    Response.End();
                    Response.Flush();

                    if (System.IO.File.Exists(FilePath))
                    {
                        System.IO.File.Delete(FilePath);
                    }

                }
                else
                {
                    //ShowClientMessage("Error: GDrive credentials or file missing", MessageType.Error);
                    warningMsg.Value = "Error: Could not connect to GDrive";
                }
            }

            else
            {
                //to download from database
                int id = Convert.ToInt32(item.GetDataKeyValue("RecordId").ToString());
                try
                {
                    byte[] bytes;
                    string fileName, contentType;
                    string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandText = "select document,documenttype,documentname from eb_prlattach where idd=@ID";
                            cmd.Parameters.AddWithValue("@Id", id);
                            cmd.Connection = con;
                            con.Open();
                            using (SqlDataReader sdr = cmd.ExecuteReader())
                            {
                                sdr.Read();
                                bytes = (byte[])sdr["document"];
                                contentType = sdr["documenttype"].ToString();
                                fileName = sdr["documentname"].ToString();
                            }
                            con.Close();
                        }
                    }
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.ContentType = contentType;
                    Response.AppendHeader("Content-Disposition", "attachment; Filename=" + fileName);
                    //Response.AddHeader("Content-Length", bytes.Length.ToString());
                    Response.BinaryWrite(bytes);
                    Response.Flush();
                    Response.End();
                    //HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
            }
        }

    }

    protected void gvSavedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                    break;
                }
        }
    }


    private void SetrCmbEmployee(string strID)
    {
        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbEmployee.Items[0].Value = strID;
                        rCmbEmployee.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
                        rCmbEmployee.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
                        rCmbEmployee.SelectedValue = strID;
                        break;
                    }
                }
            }
        rCmbEmployee.Enabled = true;
        RadGrid SubGrid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        SubGrid.Rebind();
    }
    private void SetrCmbLeaveType(string strID)
    {
        RadGrid grid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbLeaveType.Items[0].Value = strID;
                        rCmbLeaveType.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levtypcod"].ToString();
                        rCmbLeaveType.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levtypcod"].ToString();
                        rCmbLeaveType.SelectedValue = strID;
                        break;
                    }
                }
            }
        rCmbLeaveType.Enabled = true;
        RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        rGrdLeaveCodes4DDL.Rebind();

        RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        rGrdEntryTypes4DDL.Rebind();
    }

    private void SetrCmbLeaveCode(string strID)
    {
        RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["lvcidd"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbLeaveCode.Items[0].Value = strID;
                        rCmbLeaveCode.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["lvccod"].ToString();
                        rCmbLeaveCode.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["lvccod"].ToString();
                        rCmbLeaveCode.SelectedValue = strID;
                        break;
                    }
                }
            }
        rCmbLeaveCode.Enabled = true;

    }

    private void SetrCmbEntryType(string strID)
    {
        RadGrid grid = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Value"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbEntryType.Items[0].Value = strID;
                        rCmbEntryType.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Text"].ToString();
                        rCmbEntryType.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Text"].ToString();
                        rCmbEntryType.SelectedValue = strID;
                        break;
                    }
                }
            }
        rCmbEntryType.Enabled = true;

    }

    private void LoadMasterInViewEdit(string RequestID)
    {
        //ClearEmployees();

        Hashtable ht = new Hashtable();
        ht.Add("@recordIDD", RequestID);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_VicationinfoByID", ht).Tables[0];

        if (dt.Rows.Count > 0)
        {
            Session["RequestID"] = dt.Rows[0]["RequestID"].ToString();
            SetrCmbEmployee(dt.Rows[0]["employeeIDD"].ToString());
            SetrCmbLeaveType(dt.Rows[0]["leaveTypeIDD"].ToString());
            SetrCmbLeaveCode(dt.Rows[0]["LeaveCodeIDD"].ToString());
            SetrCmbEntryType(dt.Rows[0]["entryType"].ToString());


            if (dt.Rows[0]["hourly"].ToString() == "True")
            {
                cbxhourly.Checked = true;
                txtToDate.Enabled = false;


                if (hfdisFrmToTimeCtrls.Value == "true")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showTimepicker", "showTimepicker();", true);
                    txtOffHours.Enabled = false;
                    ddlMinutes.Enabled = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                    txtOffHours.Enabled = true;
                    ddlMinutes.Enabled = true;

                    if (!String.IsNullOrEmpty(dt.Rows[0]["OffMints"].ToString()))
                    {
                        ddlMinutes.SelectedText = (dt.Rows[0]["OffMints"].ToString());
                    }

                }


                //txtNumberOfDays.Text = "";

                //to set tpFromTime and tpToTime from employee shift timings
                if (!string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
                {
                    Hashtable ht1 = new Hashtable();
                    ht1.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                    DataTable dt1 = new DataTable();
                    dt1 = clsDAL.GetDataSet("sp_Payroll_Get_ShiftInfo_By_Employee", ht1).Tables[0];
                    if (dt1 != null)
                    {
                        if (dt1.Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(dt1.Rows[0]["sftStartTime"].ToString()))
                            {
                                tpFromTime.TimeView.StartTime = TimeSpan.Parse(dt1.Rows[0]["sftStartTime"].ToString());
                                tpToTime.TimeView.StartTime = TimeSpan.Parse(dt1.Rows[0]["sftStartTime"].ToString());
                            }

                            if (!string.IsNullOrEmpty(dt1.Rows[0]["sftEndTime"].ToString()))
                            {
                                TimeSpan endTime = TimeSpan.Parse(dt1.Rows[0]["sftEndTime"].ToString());
                                TimeSpan endTimePlus = endTime + TimeSpan.Parse("00:01");
                                tpFromTime.TimeView.EndTime = endTimePlus;
                                tpToTime.TimeView.EndTime = endTimePlus;
                            }

                            if (!string.IsNullOrEmpty(dt1.Rows[0]["sftStartTime"].ToString()) && !string.IsNullOrEmpty(dt1.Rows[0]["sftEndTime"].ToString()))
                            {
                                TimeSpan TimeDiff = TimeSpan.Parse(dt1.Rows[0]["sftEndTime"].ToString()) - TimeSpan.Parse(dt1.Rows[0]["sftStartTime"].ToString());
                                TotalHours = TimeDiff.TotalHours;
                            }
                        }
                    }
                }
            }

            else
            {
                txtToDate.Enabled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                ddlMinutes.Enabled = false;

                txtNumberOfDays.Enabled = false;
                txtToDate.Enabled = true;
                cbxhourly.Checked = false;
            }

            if (!String.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()))
            {
                txtFromDate.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["fromDate"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                txtToDate.MinDate = (DateTime)txtFromDate.SelectedDate;
            }

            if (!String.IsNullOrEmpty(dt.Rows[0]["fromTime"].ToString()))
            {
                tpFromTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["fromTime"].ToString());
            }

            if (!String.IsNullOrEmpty(dt.Rows[0]["toDate"].ToString()))
            {
                txtToDate.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["toDate"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
            }

            if (!String.IsNullOrEmpty(dt.Rows[0]["toTime"].ToString()))
            {
                tpToTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["toTime"].ToString());
            }

            if (!String.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()))
            {
                txtRejoiningDate.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["rejoiningDate"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
            }

            txtNumberOfDays.Text = dt.Rows[0]["NumberOfDays"].ToString();

            txtOffHours.Text = dt.Rows[0]["offHours"].ToString();

            txtDayPercentage.Text = dt.Rows[0]["dayPercentage"].ToString();

            if (dt.Rows[0]["airTicket"].ToString() == "True")
            {
                checkAirTicket.Checked = true;
            }

            if (dt.Rows[0]["perDiem"].ToString() == "True")
            {
                cbxPerDiem.Checked = true;
            }
            if (dt.Rows[0]["leaveSalary"].ToString() == "True")
            {
                cbxLeaveSalary.Checked = true;
            }
            if (dt.Rows[0]["cashCheck"].ToString() == "True")
            {
                cbxCashcheck.Checked = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashAmountDiv", "showCashAmountDiv();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashAmountDiv", "hideCashAmountDiv();", true);
                cbxCashcheck.Checked = false;
            }

            txtCashAmount.Text = dt.Rows[0]["cashAmount"].ToString();

            txtRemarks1.Text = dt.Rows[0]["remarks1"].ToString();

            txtRemarks2.Text = dt.Rows[0]["remarks2"].ToString();

            if (dt.Rows[0]["levperdiem"].ToString().ToLower() == "true")
            {
                //cbxPerDiem.Checked = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
            }
            else
            {
                cbxPerDiem.Checked = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hidePerDiemdiv", "hidePerDiemdiv();", true);
            }
            if (dt.Rows[0]["levsal"].ToString().ToLower() == "true")
            {//cbxLeaveSalary.Checked = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
            }
            else
            {
                cbxLeaveSalary.Checked = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideVacationSalarydiv", "hideVacationSalarydiv();", true);
            }
            if (dt.Rows[0]["levadvcash"].ToString().ToLower() == "true")
            {
                //cbxCashcheck.Checked = true;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashAmountDiv", "showCashAmountDiv();", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
            }
            else
            {
                cbxCashcheck.Checked = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashCheckdiv", "hideCashCheckdiv();", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCashAmountDiv", "hideCashAmountDiv();", true);
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["levmaxcash"].ToString()))
            {
                hfMaxCash.Value = dt.Rows[0]["levmaxcash"].ToString();
            }
            ruDocument.Visible = true;
            gvAttachments.Rebind();

            if (ltrNoResults.Visible == false)
                gvAttachments.Visible = true;


            if (rCmbEntryType.Items[0].Text == "Encashment" || rCmbEntryType.Items[0].Text == "Adjustment")
            {
                txtNumberOfDays.Enabled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                txtFromDate.Enabled = false;
                txtToDate.Enabled = false;
                cbxhourly.Enabled = false;
                txtOffHours.Enabled = false;
                //txtDayPercentage.Enabled = false;
            }
            else
            {
                cbxhourly.Enabled = true;
                txtNumberOfDays.Enabled = false;
            }


        }

        lbltab1.Text = "Edit Request";

        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
        if (rCmbEmployee.Items[0].Value != null && rCmbLeaveType.Items[0].Value != null && rCmbLeaveCode.Items[0].Value != null)
        {
            DateTime StartTime, EndTime;
            List<DateTime> Times = new List<DateTime>();
            Times = getStartEndTime();

            ucEmployeeLeaveBalance.LoadLeaveBalance(rCmbEmployee.Items[0].Value, rCmbLeaveType.Items[0].Value, rCmbLeaveCode.Items[0].Value, txtFromDate.SelectedDate ?? DateTime.Now, txtToDate.SelectedDate ?? DateTime.Now, rCmbLeaveType.Items[0].Text, rCmbLeaveCode.Items[0].Text, Convert.ToBoolean(cbxhourly.Checked), Times[0], Times[1]);
        }
        if (rCmbEmployee.Items[0].Value != null && rCmbLeaveType.Items[0].Value != null && rCmbLeaveCode.Items[0].Value != null)
        {
          //  ucEmployeeLeaveChart.LoadEmployeeLeaveChart(rCmbEmployee.Items[0].Value);
        }

        //ScriptManager.RegisterStartupScript(this, this.GetType(), "enableDisableValidatorsOnEditAndNew", "enableDisableValidatorsOnEditAndNew();", true);
    }
    protected void gvSavedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("LeaveTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }
        if (e.CommandName == "ViewEdit")
        {
            clearForm();
            Session["mode"] = "ViewEdit";
            LoadMasterInViewEdit(e.CommandArgument.ToString());

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        }

        if (e.CommandName == "View")
        {
            clearForm();
            Session["mode"] = "View";
            LoadMasterInViewEdit(e.CommandArgument.ToString());

            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            cbxhourly.Enabled = false;
            checkAirTicket.Enabled = false;
            cbxPerDiem.Enabled = false;
            cbxCashcheck.Enabled = false;
            cbxLeaveSalary.Enabled = false;
            txtNumberOfDays.Enabled = false;
            txtCashAmount.Enabled = false;
            txtRemarks1.Enabled = false;
            txtRemarks2.Enabled = false;
            ruDocument.Enabled = false;
            rCmbEmployee.Enabled = false;
            rCmbLeaveType.Enabled = false;
            rCmbLeaveCode.Enabled = false;
            rCmbEntryType.Enabled = false;
            ddlMinutes.Enabled = false;
            txtOffHours.Enabled = false;
            txtFromDate.Enabled = false;
            //gvAttachments.Enabled = false;
            lbltab1.Text = "View Request";
        }



        if (e.CommandName == "Delete")
        {
            Hashtable ht_delete = new Hashtable();
            ht_delete.Add("@requestid", e.CommandArgument.ToString());
            clsDAL.ExecuteNonQuery("sp_User_Delete_Leave", ht_delete);
            ShowClientMessage("Transaction ID:" + e.CommandArgument.ToString() + "  is Deleted.", MessageType.Success);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }

        if (e.CommandName == "Submit")
        {
            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", FormType);
            ht_message.Add("@SubmittedbyUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", 0);

            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

            if (wfid == 0)
            {
                ShowClientMessage("Transaction cannot be submitted due to missing workflow", MessageType.Error);
            }
            else if (wfid > 0)
            {
                Hashtable ht_submit = new Hashtable();

                ht_submit.Add("@FormTypeID", FormType);
                ht_submit.Add("@TransactionID", e.CommandArgument.ToString());
                ht_submit.Add("@SubmittedByUserID", (string)Session["_UserID"]);

                clsDAL.ExecuteNonQuery("sp_User_Submit_LeaveTransaction", ht_submit);

                gvSavedRequests.Rebind();

                Hashtable ht_email = new Hashtable();
                ht_email.Add("LeaveTransactionID", e.CommandArgument.ToString());

                DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht_email).Tables[0];

                if ((null != dt) && dt.Rows.Count > 0)
                {
                    string sBody = "";
                    string htmlEmailFormat = Server.MapPath("~/EmailTemplates/NotifyApplicantApproverEmail.htm");

                    //sBody = File.ReadAllText(htmlEmailFormat);
                    //sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                    //sBody = sBody.Replace("<%ID%>", Request.QueryString["LeaveTransactionID"]);
                    ////sBody = sBody.Replace("<%FullName%>", txtFirstName.Text + txtMiddleName.Text + txtLastName.Text);
                    ////sBody = sBody.Replace("<%Position%>", rCmbPosition.SelectedValue.ToString());
                    ////sBody = sBody.Replace("<%Remarks%>", rTxtRemarks.Text);
                    //sBody = sBody.Replace("<%RedirectURL%>", Request.Url.AbsoluteUri);
                    //clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), ConfigurationManager.AppSettings["EMAIL_ACC"], "A request is pending for your approval.");
                }

                ShowClientMessage("New Transaction ID: is submitted for approval.", MessageType.Success);
                clearForm();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            }
        }
    }

    protected void gvSavedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prllevtrx")
        {
            //ImageButton imgBtnEdit = (ImageButton)e.Item.FindControl("imgBtnEdit");
            //imgBtnEdit.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], false);

            //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //if (imgBtnView != null)
            //    imgBtnView.Attributes["onclick"] = String.Format("return ShowSavedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            //ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            //imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
        }
    }

    protected void gvSavedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }

    #endregion

    #region Tab3 - Submitted Requests

    protected void gvSubmittedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);

                    break;
                }
        }
    }

    protected void gvSubmittedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {


    }

    protected void gvSubmittedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            ImageButton imgBtnRecall = (ImageButton)e.Item.FindControl("imgBtnRecall");
            if (imgBtnRecall != null)
                imgBtnRecall.Attributes["onclick"] = String.Format("return ShowRecallForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, FormType, true);

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowSubmittedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, FormType, true);

        }
    }

    protected void gvSubmittedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvSubmittedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", FormType);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_submitted_LeaveTransaction", ht).Tables[0];
        gvSubmittedRequests.DataSource = dt;
    }

    #endregion

    #region Tab4 - Pending Approval

    protected void gvPendingAppRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab4');", true);

                    break;
                }
        }
    }









    protected void gvPendingAppRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            clearForm();
            Session["mode"] = "View";
            LoadMasterInViewEdit(e.CommandArgument.ToString());
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            cbxhourly.Enabled = false;
            checkAirTicket.Enabled = false;
            cbxPerDiem.Enabled = false;
            cbxCashcheck.Enabled = false;
            cbxLeaveSalary.Enabled = false;
            txtNumberOfDays.Enabled = false;
            txtCashAmount.Enabled = false;
            txtRemarks1.Enabled = false;
            txtRemarks2.Enabled = false;
            ruDocument.Enabled = false;
            rCmbEmployee.Enabled = false;
            rCmbLeaveType.Enabled = false;
            rCmbLeaveCode.Enabled = false;
            rCmbEntryType.Enabled = false;
            ddlMinutes.Enabled = false;
            txtOffHours.Enabled = false;
            txtFromDate.Enabled = false;
            //gvAttachments.Enabled = false;
            lbltab1.Text = "View Request";
        }
        if (e.CommandName == "Approve")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            int RequestID = Int32.Parse(arg[0]);
            int requestStatusid = Int32.Parse(arg[1]);
            Session["AppRequestID"] = RequestID.ToString();
            Session["LevRequestStatusID"] = requestStatusid;
            clearForm();
            Session["mode"] = "ViewEdit";
            LoadMasterInViewEdit(RequestID.ToString());

            //TopPanel.Visible = false;
            ApprovalPanel.Visible = true;
            bindCombos();
            gvHistory.Rebind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
    }

    protected void gvPendingAppRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //ImageButton imgBtnApprove = (ImageButton)e.Item.FindControl("imgBtnApprove");
            //if (imgBtnApprove != null)
            //{
            //    imgBtnApprove.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
            //        e.Item.ItemIndex,
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
            //        FormType);
            //}

            //    ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //    if (imgBtnView != null)
            //        imgBtnView.Attributes["onclick"] = String.Format("return ShowPendingViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        }
    }

    protected void gvPendingAppRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(FormType))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_For_Approval", ht).Tables[0];
            //ht.Add("@UserID", Session["_UserID"].ToString());
            //DataTable dt = clsDAL.GetDataSet("sp_User_Get_All_LeaveTransaction", ht).Tables[0];
            gvPendingAppRequests.DataSource = dt;
        }
    }

    protected void gvPendingAppRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }

    }

    #endregion

    #region Tab5 - Approval Requests

    protected void gvApprovedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab5');", true);

                    break;
                }
        }
    }

    protected void gvApprovedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void gvApprovedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        if (imgBtnView != null)
        {
            imgBtnView.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
                               e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
                               e.Item.ItemIndex,
                               e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
                               FormType);
        }
    }

    protected void gvApprovedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvApprovedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(FormType))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", FormType);
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_approved_LeaveTransaction", ht).Tables[0];
            gvApprovedRequests.DataSource = dt;
        }
    }

    #endregion


    protected void rGrdEntryTypes4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (grid != null)
        {
            if (grid.SelectedValues != null)
            {

                string entryType = Convert.ToString((grid.SelectedValues as Telerik.Web.UI.DataKey)["Text"]);
                //ClearLeaveType();
                //ClearLeaveCode();
                switch (entryType)
                {
                    case "Entry":
                        txtFromDate.Enabled = true;
                        if (cbxhourly.Checked != true)
                        {
                            txtToDate.Enabled = true;
                        }
                        checkAirTicket.Enabled = true;
                        cbxhourly.Enabled = true;
                        if (txtToDate.IsEmpty == true && txtOffHours.Text == "")
                        {
                            txtNumberOfDays.Text = "";
                        }
                        //txtRejoiningDate.Enabled = false;
                        txtNumberOfDays.Enabled = false;
                        break;
                    case "Encashment":
                        txtFromDate.Enabled = false;
                        txtToDate.Enabled = false;
                        //txtRejoiningDate.Enabled = false;
                        checkAirTicket.Enabled = true;
                        txtNumberOfDays.Enabled = true;
                        cbxhourly.Checked = false;
                        cbxhourly.Enabled = false;
                        //tpFromTime.Enabled = false;
                        //tpToTime.Enabled = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                        txtOffHours.Enabled = false;
                        txtFromDate.Clear();
                        txtToDate.Clear();
                        txtRejoiningDate.Clear();
                        tpFromTime.Clear();
                        tpToTime.Clear();
                        txtOffHours.Text = "";
                        ddlMinutes.SelectedText = "0";
                        ddlMinutes.Enabled = false;
                        txtDayPercentage.Text = "";
                        if (txtFromDate.Enabled == true)
                        {
                            txtNumberOfDays.Text = "";
                        }

                        break;
                    case "Adjustment":
                        txtFromDate.Enabled = false;
                        txtToDate.Enabled = false;
                        //txtRejoiningDate.Enabled = false;
                        checkAirTicket.Enabled = false;

                        txtNumberOfDays.Enabled = true;
                        cbxhourly.Checked = false;
                        cbxhourly.Enabled = false;
                        //tpFromTime.Enabled = false;
                        //tpToTime.Enabled = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);
                        txtOffHours.Enabled = false;
                        txtFromDate.Clear();
                        txtToDate.Clear();
                        txtRejoiningDate.Clear();
                        tpFromTime.Clear();
                        tpToTime.Clear();
                        txtOffHours.Text = "";
                        ddlMinutes.SelectedText = "0";
                        ddlMinutes.Enabled = false;
                        txtDayPercentage.Text = "";
                        if (txtFromDate.Enabled == true)
                        {
                            txtNumberOfDays.Text = "";
                        }
                        break;
                    case "Planning":
                        txtFromDate.Enabled = true;
                        if (cbxhourly.Checked != true)
                        {
                            txtToDate.Enabled = true;
                        }
                        checkAirTicket.Enabled = true;
                        cbxhourly.Enabled = true;
                        //txtRejoiningDate.Enabled = false;
                        txtNumberOfDays.Enabled = false;
                        if (txtToDate.IsEmpty == true && txtOffHours.Text == "")
                        {
                            txtNumberOfDays.Text = "";
                        }

                        break;
                }
            }
        }
    }

    protected void rGrdLeaveCodes4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        //   LoadLeavecard(null, null);
    }



    protected void cbxhourly_CheckedChanged(object sender, EventArgs e)
    {
        //RadCheckBox cbxhourly = sender as RadCheckBox;
        if (cbxhourly.Checked == true)
        {
            txtToDate.SelectedDate = txtFromDate.SelectedDate;
            txtRejoiningDate.SelectedDate = txtFromDate.SelectedDate;
            //txtRejoiningDate.Enabled = false;
            txtToDate.Enabled = false;

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "showTimepicker", "showTimepicker();", true);

            //tpFromTime.Enabled = true;
            //tpToTime.Enabled = true;

            //lblNoOfDays.Visible = false;
            //lblOffHours.Visible = true;
            //lblDayPercentage.Visible = true;

            txtNumberOfDays.Enabled = false;

            if (hfdisFrmToTimeCtrls.Value != "true")
            {
                txtOffHours.Enabled = true;
                ddlMinutes.Enabled = true;
            }
            else
            {
                txtOffHours.Enabled = false;
                ddlMinutes.Enabled = false;
            }

            //txtDayPercentage.Enabled = true;

            txtNumberOfDays.Text = "";

            //to set tpFromTime and tpToTime from employee shift timings
            if (!string.IsNullOrEmpty(rCmbEmployee.Items[0].Value))
            {
                Hashtable ht = new Hashtable();
                ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
                DataTable dt = new DataTable();
                dt = clsDAL.GetDataSet("sp_Payroll_Get_ShiftInfo_By_Employee", ht).Tables[0];
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftStartTime"].ToString()))
                        {
                            tpFromTime.TimeView.StartTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpFromTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.TimeView.StartTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            tpToTime.SelectedTime = TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                        }

                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan endTime = TimeSpan.Parse(dt.Rows[0]["sftEndTime"].ToString());
                            TimeSpan endTimePlus = endTime + TimeSpan.Parse("00:01");
                            tpFromTime.TimeView.EndTime = endTimePlus;
                            tpToTime.TimeView.EndTime = endTimePlus;
                        }

                        if (!string.IsNullOrEmpty(dt.Rows[0]["sftStartTime"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["sftEndTime"].ToString()))
                        {
                            TimeSpan TimeDiff = TimeSpan.Parse(dt.Rows[0]["sftEndTime"].ToString()) - TimeSpan.Parse(dt.Rows[0]["sftStartTime"].ToString());
                            TotalHours = TimeDiff.TotalHours;
                        }
                    }
                }
            }

            calculateHrsDaysPer();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "enableDisableValidatorsOnHourly", "enableDisableValidatorsOnHourly();", true);

        }
        else
        {
            txtToDate.Enabled = true;

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTimePicker", "hideTimePicker();", true);

            //tpFromTime.Enabled = false;
            //tpToTime.Enabled = false;

            //lblNoOfDays.Visible = true;
            //lblOffHours.Visible = false;
            //lblDayPercentage.Visible = false;

            txtNumberOfDays.Enabled = true;
            txtOffHours.Enabled = false;
            //txtDayPercentage.Enabled = false;

            txtOffHours.Text = "";
            txtDayPercentage.Text = "";
            ddlMinutes.Enabled = false;
            txtRejoiningDate.Clear();
            txtFromDate.Clear();
            txtToDate.Clear();

            tpFromTime.Clear();
            tpToTime.Clear();
            //txtRejoiningDate.Enabled = true;
            txtToDate.Enabled = true;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "enableDisableValidators", "enableDisableValidators();", true);
        }
    }

    protected void tpFromTime_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        calculateHrsDaysPer();
        LoadLeavecard(null, null);
    
    }
    protected void tpToTime_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        calculateHrsDaysPer();
        LoadLeavecard(null, null);

    }

    private void calculateHrsDaysPer()
    {
        if (hfdisFrmToTimeCtrls.Value == "true")
        {
            if (tpFromTime.SelectedTime != null && tpToTime.SelectedTime != null)
            {

                TimeSpan TimeDiff = (TimeSpan)tpToTime.SelectedTime - (TimeSpan)tpFromTime.SelectedTime;
                var OffHours = TimeDiff.TotalHours;
                txtOffHours.Text = OffHours.ToString();

                if (OffHours > 0)
                {
                    var DayPercentage = (OffHours / TotalHours) * 100;
                    txtDayPercentage.Text = DayPercentage.ToString();

                    var NoOfDays = OffHours / TotalHours;
                    txtNumberOfDays.Text = NoOfDays.ToString();
                }
                else
                {
                    txtNumberOfDays.Text = "";
                    txtDayPercentage.Text = "";
                }

            }
            else
            {
                txtNumberOfDays.Text = "";
                txtOffHours.Text = "";
                txtDayPercentage.Text = "";
            }
        }
        else
        {
            if (txtOffHours.Text != "")
            {
                var OffHours = Convert.ToDouble(txtOffHours.Text);

                var hoursOfMints = Convert.ToDouble(ddlMinutes.SelectedText) / 60.0;

                OffHours = OffHours + hoursOfMints;

                if (OffHours > 0)
                {
                    var DayPercentage = (OffHours / TotalHours) * 100;
                    txtDayPercentage.Text = DayPercentage.ToString();

                    var NoOfDays = OffHours / TotalHours;
                    txtNumberOfDays.Text = NoOfDays.ToString();
                }
                else
                {
                    txtNumberOfDays.Text = "";
                    txtDayPercentage.Text = "";
                }
            }
        }
    }



    #region Approve

    private void bindCombos()
    {
        if (Session["AppRequestID"] != null)
        {
            RadGrid grid;

            #region Fill users and level

            rCmbLevels.ClearSelection();
            Hashtable ht_transactionentryid = new Hashtable();
            ht_transactionentryid.Add("@Leaveid", Session["AppRequestID"].ToString());
            grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Get_Revise_Users_Of_Leave", ht_transactionentryid).Tables[0];
            grid.Rebind();

            #endregion Fill Batch
        }
    }


    protected void rBtnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            bool proceed = true;
            string action = "";

            //Check for Same Department in given dates
            Hashtable ht3 = new Hashtable();
            ht3.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
            ht3.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
            ht3.Add("@fromDate", txtFromDate.SelectedDate);
            ht3.Add("@toDate", txtToDate.SelectedDate);
            ht3.Add("@Action", "");

            action = "";

            action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeaveInSameDepartmentInDates", ht3, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
            //action can be "No Action", "Warn User" or "Stop Entry" 
            if (action == "Warn User")
            {
                ShowClientMessage("Leave in same department exists on current dates", MessageType.Warning);
            }
            else if (action == "Stop Entry")
            {
                ShowClientMessage("Leave in same department exists on current dates", MessageType.Warning);
                proceed = false;
            }

            //Check for Same Position in given dates
            Hashtable ht4 = new Hashtable();
            ht4.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
            ht4.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
            ht4.Add("@fromDate", txtFromDate.SelectedDate);
            ht4.Add("@toDate", txtToDate.SelectedDate);
            ht4.Add("@Action", "");

            action = "";

            action = clsDAL.ExecuteNonQuery("sp_User_CheckIfLeaveInSamePositionInDates", ht4, "@Action", System.Data.SqlDbType.NVarChar, 255) as string;
            //action can be "No Action", "Warn User" or "Stop Entry" 
            if (action == "Warn User")
            {
                ShowClientMessage("Leave in same position exists on current dates", MessageType.Warning);
            }
            else if (action == "Stop Entry")
            {
                ShowClientMessage("Leave in same position exists on current dates", MessageType.Warning);
                proceed = false;
            }


            if (proceed == true)
            {
                Hashtable ht = new Hashtable();
                ht.Add("@TransactionID", Session["AppRequestID"].ToString());
                ht.Add("@StatusID", Session["LevRequestStatusID"].ToString());
                ht.Add("@ApproverUserID", Session["_UserID"].ToString());
                ht.Add("@TransRemarks", txtremarks.Text);
                ht.Add("@mobid", "Web");
                ht.Add("@DBMessage", "");
                clsCommon.ExportHash(ht);
                string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Approve_LeaveTransaction", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                ht = null;
                ht = new Hashtable();
                ht.Add("@LeaveTransactionID", Session["AppRequestID"].ToString());

                DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht).Tables[0];

                if ((null != dt) && dt.Rows.Count > 0)
                {
                    //ht = null;
                    //ht = new Hashtable();
                    //ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
                    //ht.Add("@RedirectURL", Request.Url.AbsoluteUri);

                    //clsCommon.SendMail(3, ht);
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    refreshGrids();
                    ApprovalPanel.Visible = false;

                    Session["AppRequestID"] = null;
                    Session["LevRequestStatusID"] = null;

                    clearForm();
                    //ClearEmployees();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
                    lbltab1.Text = "New Request";

                    //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                    ShowClientMessage("Processed successfully.", MessageType.Success);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnReject_Click(object sender, EventArgs e)
    {
        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@LeaveTransactionID", Session["AppRequestID"].ToString());
            ht.Add("@LeaveTransactionStatusID", Session["LevRequestStatusID"].ToString());
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@transremarks", txtremarks.Text);
            ht.Add("@mobid", "Web");

            ht.Add("@DBMessage", "");

            string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Reject_LeaveTransaction", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                ApprovalPanel.Visible = false;

                Session["AppRequestID"] = null;
                Session["LevRequestStatusID"] = null;

                clearForm();
                //ClearEmployees();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
                lbltab1.Text = "New Request";

                refreshGrids();

                ShowClientMessage("Processed successfully.", MessageType.Success);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnRevise_Click(object sender, EventArgs e)
    {
        //MultiView1.ActiveViewIndex = 1;
        try
        {
            RadGrid grid;
            grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;

            if (grid.SelectedValue != null)
            {
                int transactionstatusid;
                transactionstatusid = Int32.Parse(grid.SelectedValue.ToString());
                Hashtable ht = new Hashtable();
                ht.Add("@TransactionEntryRequestID", Session["AppRequestID"].ToString());
                ht.Add("@TransactionEntryStatusID", Session["LevRequestStatusID"].ToString());
                ht.Add("@ApproverUserID", Session["_UserID"].ToString());
                ht.Add("@transRemarks", txtremarks.Text);
                ht.Add("@revisetostatusid", transactionstatusid);
                ht.Add("@mobileid", "Web");

                ht.Add("@DBMessage", "");
                string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Revise_Leave_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                    Session["AppRequestID"] = null;
                    Session["LevRequestStatusID"] = null;

                    clearForm();
                    //ClearEmployees();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showCashCheckdiv", "showCashCheckdiv();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showVacationSalarydiv", "showVacationSalarydiv();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showPerDiemdiv", "showPerDiemdiv();", true);
                    lbltab1.Text = "New Request";

                    ApprovalPanel.Visible = false;
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "GoToNewEntriesState", "GoToNewEntriesState();", true);
                }
            }
            else
                ShowClientMessage("User Required", MessageType.Error);
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }


    }

    // History grid data loading and binding
    protected void gvHistory_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (Session["AppRequestID"] != null)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@recordId", Session["AppRequestID"].ToString());
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_LeaveTransaction_History", ht).Tables[0];
            dt.TableName = "HistoryMaster";
            Session["Rows"] = dt.Rows.Count;
            gvHistory.DataSource = dt;
            gvHistory.DataMember = "HistoryMaster";
        }
    }

    // grid exporting functions
    protected void gvHistory_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();
        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;
        }
        if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;

            //if (htSearchParams != null)
            //    htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
    }

    // form controls settings for insert/udpate
    protected void gvHistory_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "HistoryMaster")
            {

            }
        }

        // get count literal and assign grid list count
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            Literal ltNotiCount = (Literal)commandItem.FindControl("ltNotiCount");
            if (ltNotiCount != null)
            {
                ltNotiCount.Text = Session["Rows"] != null ? Session["Rows"].ToString() : "0";
            }
        }
    }

    #endregion

    protected void txtOffHours_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void txtOffHours_TextChanged(object sender, EventArgs e)
    {
        calculateHrsDaysPer();

    }
    protected void ddlMinutes_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        calculateHrsDaysPer();
    }
    protected void gvAttachments_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridTableView table = (GridTableView)e.Item.OwnerTableView;
            if (Session["mode"] == "View")
            {
                table.GetColumn("DeleteAttachment").Display = false;

            }
            else
            {
                table.GetColumn("DeleteAttachment").Display = true;
            }
        }

    }
}

