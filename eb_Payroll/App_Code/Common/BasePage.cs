using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Web.Security;

    public class BasePage : System.Web.UI.Page
    {
        public BaseMasterPage MasterPage
        {
            get
            {
                return (this.Master as BaseMasterPage);
            }
        }

        public string UserName
        {
            get
            {
                return this.User.Identity.Name;
            }
        }

        public bool IsLoggedIn
        {
            get
            {
                return this.User.Identity.IsAuthenticated;
            }
        }

        public virtual string FormName
        {
            get;
            set;
        }
        
        public void ShowMessage(string Message, MessageType EnmMessageType)
        {
            
            MasterPage.ShowMessage(Message, EnmMessageType, "");
        }
        public void ShowMessage(string Message, MessageType EnmMessageType, string RedirectUrl)
        {
            MasterPage.ShowMessage(Message, EnmMessageType, RedirectUrl);
        }

        protected virtual void Page_Init(object sender, EventArgs e)
        {
            if (Page.GetType().Name.ToLower().Contains("system_loginpage"))
                return;

            if (!Page.User.Identity.IsAuthenticated
            || Session["UserType"] == null
            || Session["_UserID"] == null
            )
            {
                string returnUrl = Server.UrlEncode("~" + Request.Url.PathAndQuery.Replace("/eb_Payroll", ""));
                Response.Redirect("~/System/LoginPage.aspx?ReturnUrl=" + returnUrl);
            }


            //if (!clsCommon.ValidatePageSecurity(Session["_UserID"].ToString(), FormName))
            //{
            //    Response.Redirect("~/System/AccessDenied.aspx");
            //}
        }
    }
