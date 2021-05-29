using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Drawing;

public partial class User_ChangePassword : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (!clsCommon.ValidatePageSecurity(User.Identity.Name, "ChangePassword"))
        {
            Response.Redirect("~/System/AccessDenied.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void rBtnChangePwd_Click(object sender, EventArgs e)
    {
        lblStatus.Text = "";

        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@UserID", Session["_UserID"]);
            ht.Add("@OldPasswordHash", clsEncryption.EncryptData(rTxtOldPwd.Text));
            ht.Add("@NewPasswordHash", clsEncryption.EncryptData(rTxtNewPwd.Text));
            ht.Add("@DBMessage", "");

            string DBMessage = clsDAL.ExecuteNonQuery_admin("sp_User_Update_Password", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                lblStatus.Text = "Sorry! old password is incorrect.";
                lblStatus.ForeColor = Color.Red;
            }
            else
            {
                lblStatus.Text = "Your password has been changed successfully.";
                lblStatus.ForeColor = Color.Green;
            }
        }
        catch (Exception ex)
        {
            lblStatus.Text = ex.Message;
            lblStatus.ForeColor = Color.Red;
        }
    }
}