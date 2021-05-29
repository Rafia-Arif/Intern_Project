using System;
using System.Security.Principal;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
using System.Collections.Generic;

public partial class MasterPages_UserMasterPage : BaseMasterPage
{
    protected override void OnInit(EventArgs e)
    {
        //DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);
        //myFunction(screenDimensions);
    }

    //private void myFunction(DeviceScreenDimensions screenDimensions)
    //{
        
        //if (screenDimensions.Width < 500 && screenDimensions.Width != 0)
        //{
        //    //Make repeat columns = 1
        //    SiteMapLevelSetting setting = transactionRadSiteMap.LevelSettings[0];
        //    setting.ListLayout.RepeatColumns = 1;

        //}
    //}
    public override void ShowMessage(string Message, MessageType EnmMessageType, string RedirectUrl)
    {
        hdntype.Value = EnmMessageType.ToString().ToLower();
        hdnval.Value = Message;

        if (!string.IsNullOrEmpty(RedirectUrl))
            hdnRedirectUrl.Value = RedirectUrl;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);
        //if (screenDimensions.Width < 600)
        //{
        //    SiteMapLevelSetting setting = transactionRadSiteMap.LevelSettings[0];

        //    setting.ListLayout.RepeatColumns = 1;
        //}

        if (!IsPostBack)
        {
            

            LoadMenu();
        }
        ltPageTitle.Text = PageTitle;
        ltPageDesc.Text = PageDesc;
        if (Page.User.Identity.IsAuthenticated && Session["UserType"] != null && Session["_UserID"] != null)
        {
            WindowsPrincipal wp = new WindowsPrincipal(WindowsIdentity.GetCurrent());
            string username = null;
            username = wp.Identity.Name;



            //            string opl = HttpContext.Current.User.Identity.Name.ToString();
            //            Label2.Text = opl.Substring(opl.IndexOf(@"\") + 1);


            //            string s = Request.ServerVariables["AUTH_USER"];
            //            Label3.Text = s;


            string userid = Session["_UserID"].ToString();
            string appuser = Session["_UserAPP"].ToString();
            //lblLoggedInAs.Text = appuser + "(" + Page.User.Identity.Name + ")";
            lblLoggedInAs.Text = appuser;
            DataTable dt_cmpname = new DataTable();
            Hashtable ht_cmpname = new Hashtable();
            
            dt_cmpname = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", ht_cmpname).Tables[0];
            if (dt_cmpname.Rows.Count > 0)
            { lblCompanyName.Text = dt_cmpname.Rows[0]["company"].ToString(); }
            else
            { lblCompanyName.Text = "CompanyNameNotFound"; }

            // Retrieve the ConnectionString from App.config 
            string connectString = ConfigurationManager.ConnectionStrings["eb_payroll"].ToString();
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(connectString);
            // Retrieve the DataSource property.    

            string IPAddress = builder.DataSource;
            string databasename = builder.InitialCatalog;

           // lblDatabase.Text = "[" + databasename.ToString() + "]";
           // lblCompanyName.Text = "[" + IPAddress.ToString() + "]";

            iUserImage.ImageUrl = "~/images/userPic.png";
            imgServer.ImageUrl = "~/images/Settings.png";
          //  imgDb.ImageUrl = "~/images/Settings.png";

        }
        else
        {
            string returnUrl = Server.UrlEncode("~" + Request.Url.PathAndQuery.Replace("/HRMS", ""));
            if (!Page.IsCallback)
                Response.Redirect("~/System/LoginPage.aspx?ReturnUrl=" + returnUrl);
        }

        if (!IsPostBack)
        {
            //retrieve culture information from session
            string culture = Convert.ToString(Session["MyCulture"]);

            //check whether a culture is stored in the session
            if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
            {
                // lnkBtnArabic1.CssClass = "nav-active";
                // lnkBtnEnglish1.CssClass = "";

            }
            else
            {
                // lnkBtnArabic1.CssClass = "";
                //lnkBtnEnglish1.CssClass = "nav-active";
            }

            // get logo from database
            string logo = clsCommon.GetLogoAsBase64();
            if (!string.IsNullOrEmpty(logo)) 
            {
//              imgLogo.Src = logo;
            }
          

        }
    }

    protected void RequestLanguageChange_Click(object sender, EventArgs e)
    {
        LinkButton senderLink = sender as LinkButton;

        //store requested language as new culture in the session
        Session["MyCulture"] = senderLink.CommandArgument;

        //reload last requested page with new culture
        Server.Transfer(Request.Path);
    }

    public void LoadMenu()
    {
        #region Master

        RadSiteMap masterRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Master").ContentTemplateContainer.FindControl("masterRadSiteMap");
        if (masterRadSiteMap != null)
        {
            //Master
            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Self Service");
            ht_master.Add("@submod", "Master");

            List<string> headerlist = new List<string>();
            DataTable dtmaster = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", ht_master).Tables[0];
            foreach (DataRow row in dtmaster.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dtmaster.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add header 
                        masterRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

        #region Setup

        RadSiteMap setupRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Setup").ContentTemplateContainer.FindControl("setupRadSiteMap");
        if (setupRadSiteMap != null)
        {
            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Self Service");
            ht_master.Add("@submod", "Setup");

            DataTable dtsetup = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", ht_master).Tables[0];
            List<string> headerlist = new List<string>();
            foreach (DataRow row in dtsetup.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dtsetup.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add transaction
                        setupRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

        #region Graph

        RadSiteMap graphRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Graphs").ContentTemplateContainer.FindControl("graphRadSiteMap");
        if (graphRadSiteMap != null)
        {
            //Graph
            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Self Service");
            ht_master.Add("@submod", "Graph");

            DataTable dtgraph = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", ht_master).Tables[0];
            List<string> headerlist = new List<string>();
            foreach (DataRow row in dtgraph.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dtgraph.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add header
                        graphRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

        #region Transactions

        RadSiteMap transactionRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Transactions").ContentTemplateContainer.FindControl("transactionRadSiteMap");
        if (transactionRadSiteMap != null)
        {
            //Transactions
            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Self Service");
            ht_master.Add("@submod", "Transactions");

            DataTable dttransaction = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", ht_master).Tables[0];
            List<string> headerlist = new List<string>();
            foreach (DataRow row in dttransaction.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dttransaction.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add header
                        transactionRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

        #region Reports

        RadSiteMap reportsRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Reports").ContentTemplateContainer.FindControl("reportsRadSiteMap");
        if (reportsRadSiteMap != null)
        {
            //reports
            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Self Service");
            ht_master.Add("@submod", "Reports");

            DataTable dtreports = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", ht_master).Tables[0];
            List<string> headerlist = new List<string>();
            foreach (DataRow row in dtreports.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dtreports.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add header
                        reportsRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

        #region Utilities

        RadSiteMap utilitiesRadSiteMap = (RadSiteMap)topRadMenu.FindItemByText("Utilities").ContentTemplateContainer.FindControl("UtilitiesRadSiteMap");
        if (utilitiesRadSiteMap != null)
        {
            //Graph
            Hashtable htUtilities = new Hashtable();
            htUtilities.Add("@UserID", Session["_UserID"].ToString());
            htUtilities.Add("@module", "Self Service");
            htUtilities.Add("@submod", "Utilities");

            DataTable dtutilities = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll_Menu", htUtilities).Tables[0];
            List<string> headerlist = new List<string>();
            foreach (DataRow row in dtutilities.Rows)
            {
                // if new submenu then add it 
                if (!string.IsNullOrEmpty(row["subMenu"].ToString()))
                {
                    if (!headerlist.Contains(row["subMenu"].ToString().Trim().ToLower()))
                    {
                        headerlist.Add(row["subMenu"].ToString().Trim().ToLower());
                        // make new header node 
                        RadSiteMapNode siteMapNode = new RadSiteMapNode(row["subMenu"].ToString(), string.Format(row["URL"].ToString(), row["ID"].ToString()));

                        // add child nodes to header node
                        foreach (DataRow childrow in dtutilities.Rows)
                        {
                            if (childrow["subMenu"].ToString().Trim().ToLower() == row["subMenu"].ToString().Trim().ToLower())
                            {
                                RadSiteMapNode sitesubMapNode = new RadSiteMapNode(childrow["Name"].ToString(), string.Format(childrow["URL"].ToString(), childrow["ID"].ToString()));
                                siteMapNode.Nodes.Add(sitesubMapNode);
                            }
                        }
                        // add header
                        utilitiesRadSiteMap.Nodes.Add(siteMapNode);
                    }
                }
            }
        }

        #endregion

    }
}
