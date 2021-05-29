using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using Telerik.Web.UI;
using System.IO;
using System.Configuration;
using Telerik.Web.Device.Detection;

public partial class Dashboard : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    public static string FormType;


    protected override void Page_Init(object sender, EventArgs e)
    {
        base.Page_Init(sender, e);
        
        DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);

        myFunction(screenDimensions);
    }
    private void myFunction(DeviceScreenDimensions screenDimensions)
    {

        if (screenDimensions.Width < 680 && screenDimensions.Width != 0)
        {
            gvNotification.PagerStyle.Mode = GridPagerMode.NextPrev;
            gvNotification.PagerStyle.PagerTextFormat = " {4} Page {0} of {1}, items {2} to {3} of {5}";

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    #region Submitted Requests

    // Submitted grid data loading and binding
    protected void gvSubmitted_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        htSearchParams = new Hashtable();
        htSearchParams.Add("@UserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_Notifications_Groups", htSearchParams).Tables[0];
        dt.TableName = "Submitted";
        Session["Rows"] = dt.Rows.Count;
        grid.DataSource = dt;
        grid.DataMember = "Submitted";
    }

    // form controls setting
    // grid exporting functions
    protected void gvSubmitted_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }

    }

    //submitted grid form controls settings for insert/udpate
    protected void gvSubmitted_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "Submitted")
            {

            }
        }

        // get count literal and assign grid list count
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            Literal ltSubmittedCount = (Literal)commandItem.FindControl("ltSubmittedCount");
            if (ltSubmittedCount != null)
            {
                Hashtable ht_user = new Hashtable();
                ht_user.Add("@UserID", Session["_UserID"].ToString());

                DataTable dt_totcount = clsDAL.GetDataSet_Payroll("sp_User_Get_SubmittedRequests_count", ht_user).Tables[0];
                dt_totcount.TableName = "Submittedcount";

                ltSubmittedCount.Text = dt_totcount.Rows[0][0].ToString();
            }
        }

    }

    //Submitted grid detail table data binding
    protected void gvSubmitted_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "SubmittedDetail":
                {
                    string ID = dataItem.GetDataKeyValue("TypeId").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@UserID", Session["_UserID"].ToString());
                    ht.Add("@TypeID", ID);
                    DataTable dtSubmitted = new DataTable();
                    dtSubmitted = clsDAL.GetDataSet_Payroll("sp_User_Get_SubmittedRequests", ht).Tables[0];
                    dtSubmitted.TableName = "SubmittedDetail";
                    e.DetailTableView.DataSource = dtSubmitted;
                    e.DetailTableView.DataMember = "SubmittedDetail";
                    break;
                }
        }
    }
    #endregion

    #region Notifications

    // Notification grid data loading and binding
    protected void gvNotification_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        htSearchParams.Add("@UserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_Notifications_Groups", htSearchParams).Tables[0];
        dt.TableName = "NotificationMaster";
        Session["Rows"] = dt.Rows.Count;
        gvNotification.DataSource = dt;
        gvNotification.DataMember = "NotificationMaster";
    }

    // form controls setting for insert/udpate
    // grid exporting functions
    protected void gvNotification_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNotification").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNotification").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
    }

    //Notification grid detail table data binding
    protected void gvNotification_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "NotificationDetail":
                {
                    string ID = dataItem.GetDataKeyValue("TypeId").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@UserID", Session["_UserID"].ToString());
                    ht.Add("@TypeID", ID);
                    DataTable dtNotification = new DataTable();
                    dtNotification = clsDAL.GetDataSet_Payroll("sp_User_Get_Notifications", ht).Tables[0];
                    dtNotification.TableName = "NotificationDetail";
                    e.DetailTableView.DataSource = dtNotification;
                    e.DetailTableView.DataMember = "NotificationDetail";
                    break;
                }
        }
    }

    // form controls settings for insert/udpate
    protected void gvNotification_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "NotificationMaster")
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
                Hashtable ht_user = new Hashtable();
                ht_user.Add("@UserID", Session["_UserID"].ToString());

                DataTable dt_totcount = clsDAL.GetDataSet_Payroll("sp_User_Get_Notification_count", ht_user).Tables[0];
                dt_totcount.TableName = "Notificationcount";

                ltNotiCount.Text = dt_totcount.Rows[0][0].ToString();
            }
        }
    }
    #endregion
   
}
