using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using Telerik.Web.UI;

public partial class Admin_ManageACL : System.Web.UI.Page
{






    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindCombos();
            gvACL2.DataBind();
        }
    }

    private void bindCombos()
    {
        //ddlURoles.DataSource = clsDAL.GetDataSet_admin("sp_Admin_get_User_Roles_4_DDL", null);
        //ddlURoles.DataTextField = "Name";
        //ddlURoles.DataValueField = "UserRoleID";
        //ddlURoles.DataBind();

        //ddlURoles.SelectedIndex = 0;

        var rGrdRoles4DDL = (ddlURolesNew.Items[0].FindControl("rGrdRoles4DDL") as RadGrid);
        rGrdRoles4DDL.DataSource = clsDAL.GetDataSet_admin("sp_Admin_get_User_Roles_4_DDL", null);
        rGrdRoles4DDL.DataBind();
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        //if (!clsCommon.ValidatePageSecurity(User.Identity.Name, "ManageACL"))
        //{
        //    //Response.Redirect("AccessDenied.aspx");
        //    Response.Redirect("~/" + "System/AccessDenied.aspx");
        //}

    }

    // function for displaying client side messages
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

    protected void gvACL2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_admin("sp_Admin_Get_FormType_Modules", null).Tables[0];

        var results = from myRow in dt.AsEnumerable()
                      orderby myRow.Field<int>("seq")
                      select new
                      {
                          MainModule = myRow.Field<string>("module")
                      };

        gvACL2.DataSource = results.Distinct();
    }

    protected void gvACL2_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "SubModules":
                {
                    
                    string mainModule = dataItem.GetDataKeyValue("MainModule").ToString();

                    DataTable dt = clsDAL.GetDataSet_admin("sp_Admin_Get_FormType_Modules", null).Tables[0];
                    var results = from myRow in dt.AsEnumerable()
                                  where myRow.Field<string>("module") == mainModule
                                  orderby myRow.Field<int>("seq")
                                  select new
                                  {
                                      SubModule = myRow.Field<string>("submod")
                                  };
                    e.DetailTableView.DataSource = results.Distinct();
                    

                    break;
                }
            case "ACL":
                {
                    string mainModule = dataItem.OwnerTableView.ParentItem.GetDataKeyValue("MainModule").ToString();
                    string subModule = dataItem.GetDataKeyValue("SubModule").ToString();

                    try
                    {

                        Hashtable ht = new Hashtable();
                        ht.Add("@UserRoleID", ddlURolesNew.Items[0].Value); //ddlURoles.SelectedValue);
                        DataTable dt = clsDAL.GetDataSet_admin("sp_Admin_Get_ACL2", ht).Tables[0];

                        e.DetailTableView.DataSource = dt.Select(string.Format("module = '{0}' and submod = '{1}'", mainModule, subModule), "seq");

                    }
                    catch(Exception exp) { }

                    break;
                }
            case "ReportRole":
                {
                    string mainModule = dataItem.GetDataKeyValue("MainModule").ToString();

                    var ddlRole = ddlURolesNew.Text.Trim();
                    DataTable dt = clsDAL.GetDataSet_admin("sp_Admin_Get_Report_Role", null).Tables[0];
                    var results = from myRow in dt.AsEnumerable()
                                  where myRow.Field<string>("modulename") == mainModule
                                  &&    myRow.Field<string>("rolename") == ddlRole
                                  select new
                                  {
                                      idd = myRow.Field<int>("idd"),
                                      modulename = myRow.Field<string>("modulename"),
                                      formname = myRow.Field<string>("formname"),
                                      reportid = myRow.Field<int>("reportid"),
                                      AllowUserAction = myRow.Field<bool>("AllowUserAction")
                                  };
                    e.DetailTableView.DataSource = results.Distinct();
                    break;
                }
        }
       
    }

    protected DataTable GetDataAccessDataSource()
    {
        return clsDAL.GetDataSet_admin("sp_Admin_Get_All_DataAccessTypes_4_DDL", null).Tables[0];
    }

    protected void gvACL2_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.ExpandCollapseCommandName)
        {

            foreach (GridItem item in e.Item.OwnerTableView.Items)
            {
                if (item.Expanded && item != e.Item)
                {
                    item.Expanded = false;
                }
            }
        }
    }

    //protected void ddlURoles_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    gvACL2.Rebind();
    //}
    protected void rGrdRoles4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvACL2.MasterTableView.HierarchyDefaultExpanded = false;
        gvACL2.Rebind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveACL();
    }


    
    protected void btnSaveNew_Click(object sender, EventArgs e)
    {
        string ddlRole = ddlURolesNew.Text.Trim();
        if(string.IsNullOrEmpty(ddlRole) || ddlRole == "")
        {
            ShowClientMessage("User Role is Required.",MessageType.Error);
            RequiredFieldValidator1.Enabled = true;
            return;
        }
        SaveACL();
        gvACL2.MasterTableView.HierarchyDefaultExpanded = false;
        gvACL2.Rebind();

    }

    private void SaveACL() {
        try
        {
            foreach (GridDataItem itm in gvACL2.Items)
            {
                CheckBox chkAllow = itm.FindControl("chkAllow") as CheckBox;
                CheckBox chkAllowWorkflow = itm.FindControl("chkAllowWorkflow") as CheckBox;
                RadComboBox ddlAccessType = itm.FindControl("ddlDataAccess") as RadComboBox;

                if (chkAllow != null || ddlAccessType != null)
                {
                    bool allow = chkAllow.Checked;
                    bool allowWorkflow = chkAllowWorkflow.Checked;
                    int userActionID = int.Parse(itm.GetDataKeyValue("UserActionID").ToString());
                    int dataAccessTypeID = int.Parse(ddlAccessType.SelectedValue);

                    Hashtable ht = new Hashtable();
                     var rGrdRoles4DDL = (ddlURolesNew.Items[0].FindControl("rGrdRoles4DDL") as RadGrid);
                    ht.Add("@UserRoleID", int.Parse(rGrdRoles4DDL.SelectedValue.ToString()));  //int.Parse(ddlURoles.SelectedValue));
                    ht.Add("@UserActionID", userActionID);
                    DataTable dtACLs = clsDAL.GetDataSet_admin("sp_Admin_Get_ACL", ht).Tables[0];

                    if (dtACLs.Rows.Count > 0)
                    {
                        ht.Clear();
                        ht.Add("@ACLID", dtACLs.Rows[0]["ACLID"]);
                        ht.Add("@AllowUserAction", allow);
                        ht.Add("@AllowWorkflow", allowWorkflow);
                        ht.Add("@DataAccessTypeID", dataAccessTypeID);
                        clsDAL.ExecuteNonQuery_admin("sp_Admin_Update_ACL", ht);
                    }
                    else
                    {
                        ht.Clear();
                      //  ht.Add("@UserRoleID", int.Parse(ddlURolesNew.Items[0].Value)); //int.Parse(ddlURoles.SelectedValue));
                        ht.Add("@UserRoleID", int.Parse(rGrdRoles4DDL.SelectedValue.ToString())); //int.Parse(ddlURoles.SelectedValue));
                       
                        ht.Add("@UserActionID", userActionID);
                        ht.Add("@AllowUserAction", allow);
                        ht.Add("@AllowWorkflow", allowWorkflow);
                        ht.Add("@DataAccessTypeID", dataAccessTypeID);
                        clsDAL.ExecuteNonQuery_admin("sp_Admin_Insert_ACL", ht);
                    }
                }

                ////////////////////////////////////////////////////////////////////
                // for saving ACL Report record

                CheckBox chkAllowRpt = itm.FindControl("chkAllowRptRole") as CheckBox;

                if (chkAllowRpt != null)
                {
                    bool allow = chkAllowRpt.Checked;
                    int rptRoleId = Convert.ToInt32(itm.GetDataKeyValue("idd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@rptroleid", rptRoleId);
                    DataTable dtACLs = clsDAL.GetDataSet_admin("sp_Admin_Get_ACL_report", ht).Tables[0];

                    if (dtACLs.Rows.Count > 0)
                    {
                        ht.Clear();
                        ht.Add("@aclrptid", dtACLs.Rows[0]["aclrptid"]);
                        ht.Add("@AllowUserAction", allow);
                        clsDAL.ExecuteNonQuery_admin("sp_Admin_Update_ACL_report", ht);
                    }
                    else
                    {
                        ht.Clear();
                        ht.Add("@rptroleid", rptRoleId);
                        ht.Add("@AllowUserAction", allow);
                        clsDAL.ExecuteNonQuery_admin("sp_Admin_Insert_ACL_report", ht);
                    }
                }
            }
            ShowClientMessage("Access Control List updated successfully.", MessageType.Success);
            
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update Access Control List. Reason: " + ex.Message, MessageType.Error);
        }
    }

    protected void ddlURolesNew_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //gvACL2.MasterTableView.HierarchyDefaultExpanded = false;
        //gvACL2.Rebind();
    }
    protected void ddlURolesNew_PreRender(object sender, EventArgs e)
    {
        RadComboBox ddlURolesNew = sender as RadComboBox;
        RadGrid rGrdRoles4DDL = ddlURolesNew.Items[0].FindControl("rGrdRoles4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdRoles4DDL, rGrdRoles4DDL);
    }
}
