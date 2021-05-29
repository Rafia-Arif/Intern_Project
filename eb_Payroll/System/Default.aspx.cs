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

public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        decideautologin(); 
        if (Page.User.Identity.IsAuthenticated && (null != Session["UserType"]))
        {
            Response.Redirect("Dashboard.aspx");
        }
    }

    public void decideautologin()
    {
        DataSet param;
        DataTable dt_getdomainlogin = new DataTable();
        Hashtable ht = new Hashtable();

        param = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null);
        string ans = "";
        ans = param.Tables[0].Rows[0][0].ToString();
        if (ans == "True")
        {
            WindowsPrincipal wp = new WindowsPrincipal(WindowsIdentity.GetCurrent());

            string username = null;

            username = System.Web.HttpContext.Current.User.Identity.Name.ToString();
            ht.Add("@UserName", username);
            ht.Add("@password", "");

            dt_getdomainlogin = clsDAL.GetDataSet_admin("sp_User_Login_domain", ht).Tables[0];

            if (dt_getdomainlogin.Rows.Count > 0)
            {
                Session["_UserID"] = dt_getdomainlogin.Rows[0]["ID"].ToString();
                Session["_UserAPP"] = dt_getdomainlogin.Rows[0]["Username"].ToString();

                string userType = "";
                if (Convert.ToBoolean(dt_getdomainlogin.Rows[0]["IsAdmin"].ToString()) == Convert.ToBoolean("true"))
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

                if (Convert.ToBoolean(dt_getdomainlogin.Rows[0]["IsActive"].ToString()) == Convert.ToBoolean("true"))
                {
                    if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                        Response.Redirect("~/Dashboards/Dashboard.aspx");
                    else
                        Response.Redirect(Server.UrlDecode(Request.QueryString["ReturnUrl"]));
                }
                else
                {
                    FormsAuthentication.SignOut();
                    //                    lblInActive.Text = "Your Account Is Not Active.";
                }
            }

            else
            {
                Response.Redirect("~/System/LoginPage.aspx");
            }

        }
        else
            {
            Response.Redirect("~/System/LoginPage.aspx");
            }
    }

 }
