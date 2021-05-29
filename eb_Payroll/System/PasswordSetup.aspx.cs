using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payroll_PasswordSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    
    // base page initalization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Password Setup Form";
        base.Page_Init(sender, e);
    }
    
    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
            LoadPrintOptions();
        }
    }

    // function for load print option
    public void LoadPrintOptions()
    {
        Hashtable ht_Reports = new Hashtable();
        ht_Reports.Add("@userid", Session["_UserID"].ToString());
        ht_Reports.Add("@formtypeid", 3094); // password setup form type = 3094
        DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];

        if (dt_Reports != null)
        {
            ddlPrintOptions.DataSource = dt_Reports;
            ddlPrintOptions.DataTextField = "reportname";
            ddlPrintOptions.DataValueField = "idd";
            ddlPrintOptions.DataBind();
            ddlPrintOptions.SelectedIndex = 0;
        }
    }

    // function to load form data
    public void LoadData()
    {
        //if (hfPostBack.Value.ToString() == "0")
        //{
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Password", htSearchParams).Tables[0];
            if (dt.Rows.Count > 0)
            {
                txtbxEmployeeEdit.Attributes.Add("value", dt.Rows[0]["psweme"].ToString());
                txtbxActionSheet.Attributes.Add("value", dt.Rows[0]["pswact"].ToString());
                txtbxEndofServiceApproval.Attributes.Add("value", dt.Rows[0]["psweos"].ToString());
                txtbxLeaveEncashment.Attributes.Add("value", dt.Rows[0]["pswenc"].ToString());
                txtbxGridRolldown.Attributes.Add("value", dt.Rows[0]["pswgrd"].ToString());
                txtbxPositionRolldown.Attributes.Add("value", dt.Rows[0]["pswpos"].ToString());
                txtbxEmployeeClassRolldown.Attributes.Add("value", dt.Rows[0]["pswcls"].ToString());

                // data already loaded
                //hfPostBack.Value = "1";
            }
        //}
    }

    // form update event
    protected void rbutUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            Hashtable newValues = new Hashtable();
            if (!string.IsNullOrEmpty(txtbxEmployeeEdit.Text) && !string.IsNullOrEmpty(txtbxActionSheet.Text) &&
               !string.IsNullOrEmpty(txtbxEndofServiceApproval.Text) && !string.IsNullOrEmpty(txtbxLeaveEncashment.Text) &&
               !string.IsNullOrEmpty(txtbxGridRolldown.Text) && !string.IsNullOrEmpty(txtbxPositionRolldown.Text) &&
               !string.IsNullOrEmpty(txtbxEmployeeClassRolldown.Text))
            {
                newValues["@psweme"] = txtbxEmployeeEdit.Text;
                newValues["@pswact"] = txtbxActionSheet.Text;
                newValues["@psweos"] = txtbxEndofServiceApproval.Text;
                newValues["@pswenc"] = txtbxLeaveEncashment.Text;
                newValues["@pswgrd"] = txtbxGridRolldown.Text;
                newValues["@pswpos"] = txtbxPositionRolldown.Text;
                newValues["@pswcls"] = txtbxEmployeeClassRolldown.Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Password", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                }
                ShowClientMessage("Password saved successfully.", MessageType.Success);
                //hfPostBack.Value = "0";
                LoadData();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update Password. Reason: " + ex.Message, MessageType.Error);
        }
    }

    // function to display client side messages
    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000);", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000);", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000);", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000);", true);
        }
    }
    
    // print command
    protected void btnNationalityPrint_Click(object sender, EventArgs e)
    {

    }
}