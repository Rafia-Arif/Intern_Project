using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_UserMenu : System.Web.UI.UserControl
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
            //Announcement

            Hashtable ht1_Announcement = new Hashtable();
            ht1_Announcement.Add("@UserID", Session["_UserID"].ToString());
            ht1_Announcement.Add("@module", "Payroll");
            ht1_Announcement.Add("@submod", "Announcement");

            DataTable dt1_Announcement = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht1_Announcement).Tables[0];

            if (dt1_Announcement != null)
            {
                RptAnnounce.DataSource = dt1_Announcement;
                RptAnnounce.DataBind();

                if (dt1_Announcement.Rows.Count > 0)
                    lirptAnnounce.Visible = true;
                else
                    lirptAnnounce.Visible = false;
            }

            //Documents

            Hashtable ht1_Documents = new Hashtable();
            ht1_Documents.Add("@UserID", Session["_UserID"].ToString());
            ht1_Documents.Add("@module", "Payroll");
            ht1_Documents.Add("@submod", "Documents");

            DataTable dt1_Documents = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht1_Documents).Tables[0];

            if (dt1_Documents != null)
            {
                RpDocuments.DataSource = dt1_Documents;
                RpDocuments.DataBind();

                if (dt1_Documents.Rows.Count > 0)
                    lirptDocuments.Visible = true;
                else
                    lirptDocuments.Visible = false;
            }

            //Setup

            Hashtable ht1_Setup = new Hashtable();
            ht1_Setup.Add("@UserID", Session["_UserID"].ToString());
            ht1_Setup.Add("@module", "Payroll");
            ht1_Setup.Add("@submod", "Setup");

            DataTable dt1_Statistics = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht1_Setup).Tables[0];

            if (dt1_Statistics != null)
            {
                setup.DataSource = dt1_Statistics;
                setup.DataBind();

                if (dt1_Statistics.Rows.Count > 0)
                    lirptsetup.Visible = true;
                else
                    lirptsetup.Visible = false;
            }

            //Master

            Hashtable ht_master = new Hashtable();
            ht_master.Add("@UserID", Session["_UserID"].ToString());
            ht_master.Add("@module", "Payroll");
            ht_master.Add("@submod", "Master");

            DataTable dtmaster = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht_master).Tables[0];

            if (dtmaster != null)
            {
                Master.DataSource = dtmaster;
                Master.DataBind();

                if (dtmaster.Rows.Count > 0)
                    lirptmaster.Visible = true;
                else
                    lirptmaster.Visible = false;
            }

            //Employee

            Hashtable ht_emp = new Hashtable();
            ht_emp.Add("@UserID", Session["_UserID"].ToString());
            ht_emp.Add("@module", "Payroll");
            ht_emp.Add("@submod", "Employee");

            DataTable dtemp = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht_emp).Tables[0];

            if (dtemp != null)
            {
                Employee.DataSource = dtemp;
                Employee.DataBind();

                if (dtemp.Rows.Count > 0)
                    lirptemployee.Visible = true;
                else
                    lirptemployee.Visible = false;
            }

            // Transactions

            Hashtable ht3 = new Hashtable();
            ht3.Add("@UserID", Session["_UserID"].ToString());
            ht3.Add("@module", "Payroll");
            ht3.Add("@submod", "Transactions");

            DataTable dt3 = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht3).Tables[0];

            if (dt3 != null)
            {
                Transactions.DataSource = dt3;
                Transactions.DataBind();

                if (dt3.Rows.Count > 0)
                    lirpttransaction.Visible = true;
                else
                    lirpttransaction.Visible = false;
            }

            // // Reports

            Hashtable ht_Reports = new Hashtable();
            ht_Reports.Add("@UserID", Session["_UserID"].ToString());
            ht_Reports.Add("@module", "Payroll");
            ht_Reports.Add("@submod", "Reports");

            DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht_Reports).Tables[0];

            if (dt_Reports != null)
            {
                Reports.DataSource = dt_Reports;
                Reports.DataBind();

                if (dt_Reports.Rows.Count > 0)
                    lirptreports.Visible = true;
                else
                    lirptreports.Visible = false;
            }

            //MonthEnd Menu

            Hashtable ht_monthend = new Hashtable();
            ht_monthend.Add("@UserID", Session["_UserID"].ToString());
            ht_monthend.Add("@module", "Payroll");
            ht_monthend.Add("@submod", "Month");

            DataTable dtmonthend = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht_monthend).Tables[0];

            if (dtmonthend != null)
            {
                MonthEnd.DataSource = dtmonthend;
                MonthEnd.DataBind();

                if (dtmonthend.Rows.Count > 0)
                    lirptmonthend.Visible = true;
                else
                    lirptmonthend.Visible = false;
            }
            //Utility Menu

            Hashtable htUtilities = new Hashtable();
            htUtilities.Add("@UserID", Session["_UserID"].ToString());
            htUtilities.Add("@module", "Payroll");
            htUtilities.Add("@submod", "Utilities");

            DataTable dtutilities = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", htUtilities).Tables[0];

            if (dtutilities  != null)
            {
                MonthEnd.DataSource = dtutilities;
                MonthEnd.DataBind();

                if (dtutilities.Rows.Count > 0)
                    lirptmonthend.Visible = true;
                else
                    lirptmonthend.Visible = false;
            }

            
            //Exception Dashboard

            Hashtable ht_exc = new Hashtable();
            ht_exc.Add("@UserID", Session["_UserID"].ToString());
            ht_exc.Add("@module", "Payroll");
            ht_exc.Add("@submod", "Exception");

            DataTable dtexc = clsDAL.GetDataSet_admin("sp_User_Get_User_Payroll", ht_exc).Tables[0];

            if (dtexc != null)
            {
                rptexp.DataSource = dtexc;
                rptexp.DataBind();

                if (dtexc.Rows.Count > 0)
                    lirptexp.Visible = true;
                else
                    lirptexp.Visible = false;
            }

        }
        catch (Exception ex)
        {
        }
    }

}