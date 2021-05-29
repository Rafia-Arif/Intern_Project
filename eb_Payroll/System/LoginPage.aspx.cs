using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Collections;
using System.Security.Principal;
using System.Data.SqlClient;
using System.IO;

public partial class System_LoginPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MasterPage.BodyClass = "class='nobg loginPage'";
        if (Page.User.Identity.IsAuthenticated && (null != Session["UserType"]))
        {
            Response.Redirect("Dashboard.aspx");
        }

        // get logo from database
        string logo = clsCommon.GetLogoAsBase64();
        if (!string.IsNullOrEmpty(logo)) imgLogo.Src = logo;

        if (!IsPostBack)
        {

            if (Request.Cookies["UserName"] != null)

                UserName.Text = Request.Cookies["UserName"].Value;

            if(Request.Cookies["password"] != null)

            Password.Attributes.Add("value", Request.Cookies["password"].Value);
            if (Request.Cookies["UserName"] != null && Request.Cookies["password"] != null)
                rememberme.Checked = true;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "getTimeZoneOffset", "getTimeZoneOffset();", true);
        } 
    }


    public void writelogs(string message)
    {

        string path = HttpRuntime.AppDomainAppPath + "Logs\\";
        path = path + "logging.txt";

        //if (!File.Exists(path))
        //{
        // 
  
        TextWriter tw = new StreamWriter(path, true);
        
        //}
        
        tw.WriteLine(message);
        tw.Close();

    }
 	
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        try
        {
            Session["TimeOffset"] = hfTimeOffset.Value;

            writelogs("Login Button Clicked on " + System.DateTime.Now);
            FailureText.Text = "";

            Session["_ConStr"] = "";

            string username = null;
            string password = null;

            username = UserName.Text;
            password = Password.Text;

            if (username.Trim() == "" || password == "")
            {
                ShowClientMessage("Username or Password fields cannot left blank.", MessageType.Error);
                //FailureText.Text = "Username or Password fields cannot left blank.";
                return;
            }

            DataTable dt = new DataTable(); 
            if (rememberme.Checked == true)
            {
                Response.Cookies["UserName"].Value = username;
                Response.Cookies["password"].Value = password;
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["password"].Expires = DateTime.Now.AddDays(15);
            }

            else
            {

                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);

                Response.Cookies["password"].Expires = DateTime.Now.AddDays(-1);

            }

            Hashtable ht = new Hashtable();
            ht.Add("@UserName", username);
            ht.Add("@password", clsEncryption.EncryptData(password));

            dt = clsDAL.GetDataSet_admin("sp_User_Login", ht).Tables[0];
            if (dt.Rows.Count > 0)
           {
                Session["_UserID"] = dt.Rows[0]["ID"].ToString();
                Session["_UserAPP"] = dt.Rows[0]["username"].ToString();

                if (string.IsNullOrEmpty(dt.Rows[0]["constr"].ToString()))
                {
                    Session["_ConStr"] = "";
                }
                else
                {
                    Session["_ConStr"] = dt.Rows[0]["constr"].ToString();
                }

                string userType = "";
                if (Convert.ToBoolean(dt.Rows[0]["IsAdmin"].ToString()) == Convert.ToBoolean("true"))
                {
                    userType = "A";
                    Session["UserType"] = "Admin";
                }
                else
                {
                    userType = "U";
                    Session["UserType"] = "User";

                }

                FormsAuthenticationTicket k = new FormsAuthenticationTicket(1, username, DateTime.Now, DateTime.Now.AddMinutes(60), false, userType, FormsAuthentication.FormsCookiePath);

                string st = null;
                st = FormsAuthentication.Encrypt(k);
                HttpCookie ck = new HttpCookie(FormsAuthentication.FormsCookieName, st);
                Response.Cookies.Add(ck);

                if (Convert.ToBoolean(dt.Rows[0]["IsActive"].ToString()) == Convert.ToBoolean("true"))
                {
                    if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    {
                        //Response.Redirect("~/" + (userType == "A" ? "Admin" : "Dashboards") + "/Dashboard.aspx");
                        Response.Redirect("~/" + "Dashboards" + "/Dashboard.aspx");
                    }
                    else
                        Response.Redirect(Server.UrlDecode(Request.QueryString["ReturnUrl"]));
                }
                else
                {
                    FormsAuthentication.SignOut();

                    ShowClientMessage("Your Account Is Not Active.", MessageType.Error);
                    //FailureText.Text = "";
                    LoginButton.Enabled = true;
                }
            }
            else
            {
                writelogs("Wrong user name nad password on " + System.DateTime.Now);
                ShowClientMessage("Invalid User Name or Password.", MessageType.Error);
                //FailureText.Text = "";
                LoginButton.Enabled = true;
            }
        }
        catch (SqlException exp)
        {
            writelogs(exp.ToString() + "on " + System.DateTime.Now);
           
            ShowClientMessage("Login Fail due to Database.",MessageType.Error);
        }
        catch (Exception ex)
        {
            writelogs(ex.ToString() + "on " + System.DateTime.Now);

            ShowClientMessage("Login Fail, Reason : "+ex.Message, MessageType.Error);
        }
    }
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
}

