using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_TopMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            loadMenu();
    }

    private void loadMenu()
    {
        try
        {
            hlSettings.Visible = Session["UserType"].ToString() == "Admin";
           
        }
        catch (Exception ex)
        {
        }
    }
    

   
}