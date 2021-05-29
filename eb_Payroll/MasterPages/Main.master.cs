using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class MasterPages_Main : BaseMasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Session.Timeout = 60;

            if (Page.GetType().Name.ToLower().Contains("system_loginpage"))
                RadNotification1.Enabled = false;

            //the below line is to set the time after to show the popup 
            RadNotification1.ShowInterval = Convert.ToInt32((((decimal)Session.Timeout) / 2) * 60000);

            //to set the time to show ON the popup is at the javascript "function pageLoad()" and the variable is seconds.



            //set the redirect url as a value for an easier and faster extraction in on the client
            RadNotification1.Value = Page.ResolveClientUrl("~/system/LogoutPage.aspx");
        }
    }

    protected void OnCallbackUpdate(object sender, RadNotificationEventArgs e)
    {

    }


}
