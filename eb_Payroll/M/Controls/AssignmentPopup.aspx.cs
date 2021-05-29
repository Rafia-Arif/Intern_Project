using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_Setup_AssignmentPopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblDate.Text = DateTime.Now.ToShortDateString();
            dtpApproverDate.SelectedDate = DateTime.Now;
            dtpdate.SelectedDate = DateTime.Now;
            LoadRecord();
            CheckUser();

            if (!string.IsNullOrEmpty(Request.QueryString["recordidd"]))
            {
                // assingment id 
                int Recordidd = Convert.ToInt32(Request.QueryString["recordidd"]);
                Hashtable htt = new Hashtable();
                htt.Add("@Recordidd", Recordidd);
                DataTable dtt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Resource_Detail_ByAssignmentId", htt).Tables[0];
                if (dtt.Rows.Count > 0)
                {
                    hdnRecordIdd.Value = Recordidd.ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@Recordidd", dtt.Rows[0]["residd"].ToString());
                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Resource_Detail", ht).Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        //txtCategory.Value = dt.Rows[0]["category"].ToString();
                        txtDescription.Value = dt.Rows[0]["description"].ToString();
                        //chkRepeatingNode.Checked = Convert.ToBoolean(dt.Rows[0]["repeating"]);
                        //txtEmail.Value = dt.Rows[0]["emails"].ToString();
                        if (!String.IsNullOrEmpty(dt.Rows[0]["category"].ToString()))
                        {
                            ddlCategory.Text = dt.Rows[0]["category"].ToString();
                            ddlCategory.SelectedValue = dt.Rows[0]["categoryId"].ToString();
                            ControlsPanel.Visible = true;

                            LoadLabels(dt.Rows[0]["categoryId"].ToString());

                            txt1.Value = dt.Rows[0]["Textbox_1"].ToString();
                            txt2.Value = dt.Rows[0]["Textbox_2"].ToString();
                            txt3.Value = dt.Rows[0]["Textbox_3"].ToString();
                            txt4.Value = dt.Rows[0]["Textbox_4"].ToString();
                            txt5.Value = dt.Rows[0]["Textbox_5"].ToString();
                            txt6.Value = dt.Rows[0]["Textbox_6"].ToString();

                            if (!String.IsNullOrEmpty(dt.Rows[0]["ddl_1_text"].ToString()))
                            {
                                ddl1.Text = dt.Rows[0]["ddl_1_text"].ToString();
                                ddl1.SelectedValue = dt.Rows[0]["ddl_1_value"].ToString();
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["ddl_2_text"].ToString()))
                            {
                                ddl2.Text = dt.Rows[0]["ddl_2_text"].ToString();
                                ddl2.SelectedValue = dt.Rows[0]["ddl_2_value"].ToString();
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["ddl_3_text"].ToString()))
                            {
                                ddl3.Text = dt.Rows[0]["ddl_3_text"].ToString();
                                ddl3.SelectedValue = dt.Rows[0]["ddl_3_value"].ToString();
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["ddl_4_text"].ToString()))
                            {
                                ddl4.Text = dt.Rows[0]["ddl_4_text"].ToString();
                                ddl4.SelectedValue = dt.Rows[0]["ddl_4_value"].ToString();
                            }


                            if (!String.IsNullOrEmpty(dt.Rows[0]["Date_1"].ToString()))
                            {
                                dp1.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["Date_1"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["Date_2"].ToString()))
                            {
                                dp2.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["Date_2"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["Date_3"].ToString()))
                            {
                                dp3.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["Date_3"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                            }
                            if (!String.IsNullOrEmpty(dt.Rows[0]["Date_4"].ToString()))
                            {
                                dp4.SelectedDate = DateTime.Parse(DateTime.Parse((dt.Rows[0]["Date_4"].ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                            }

                            rbl1.SelectedValue = dt.Rows[0]["Radio_button_1"].ToString();
                            rbl2.SelectedValue = dt.Rows[0]["Radio_button_2"].ToString();
                            rbl3.SelectedValue = dt.Rows[0]["Radio_button_3"].ToString();
                            rbl4.SelectedValue = dt.Rows[0]["Radio_button_4"].ToString();

                            if (dt.Rows[0]["Textbox_1_Allow_Override"].ToString() == "True")
                            {
                                cbx1.Checked = true;
                            }
                            if (dt.Rows[0]["Textbox_2_Allow_Override"].ToString() == "True")
                            {
                                cbx2.Checked = true;
                            }
                            if (dt.Rows[0]["Textbox_3_Allow_Override"].ToString() == "True")
                            {
                                cbx3.Checked = true;
                            }
                            if (dt.Rows[0]["Textbox_4_Allow_Override"].ToString() == "True")
                            {
                                cbx4.Checked = true;
                            }
                            if (dt.Rows[0]["Textbox_5_Allow_Override"].ToString() == "True")
                            {
                                cbx5.Checked = true;
                            }
                            if (dt.Rows[0]["Textbox_6_Allow_Override"].ToString() == "True")
                            {
                                cbx6.Checked = true;
                            }

                            if (dt.Rows[0]["ddl_1_Allow_Override"].ToString() == "True")
                            {
                                cbxddl1.Checked = true;
                            }
                            if (dt.Rows[0]["ddl_2_Allow_Override"].ToString() == "True")
                            {
                                cbxddl2.Checked = true;
                            }
                            if (dt.Rows[0]["ddl_3_Allow_Override"].ToString() == "True")
                            {
                                cbxddl3.Checked = true;
                            }
                            if (dt.Rows[0]["ddl_4_Allow_Override"].ToString() == "True")
                            {
                                cbxddl4.Checked = true;
                            }


                            if (dt.Rows[0]["Date_1_Allow_Override"].ToString() == "True")
                            {
                                cbxdp1.Checked = true;
                            }
                            if (dt.Rows[0]["Date_2_Allow_Override"].ToString() == "True")
                            {
                                cbxdp2.Checked = true;
                            }
                            if (dt.Rows[0]["Date_3_Allow_Override"].ToString() == "True")
                            {
                                cbxdp3.Checked = true;
                            }
                            if (dt.Rows[0]["Date_4_Allow_Override"].ToString() == "True")
                            {
                                cbxdp4.Checked = true;
                            }

                            if (dt.Rows[0]["Radio_button_1_Allow_Override"].ToString() == "True")
                            {
                                cbxrb1.Checked = true;
                            }
                            if (dt.Rows[0]["Radio_button_2_Allow_Override"].ToString() == "True")
                            {
                                cbxrb2.Checked = true;
                            }
                            if (dt.Rows[0]["Radio_button_3_Allow_Override"].ToString() == "True")
                            {
                                cbxrb3.Checked = true;
                            }
                            if (dt.Rows[0]["Radio_button_4_Allow_Override"].ToString() == "True")
                            {
                                cbxrb4.Checked = true;
                            }
                        }
                    }
                }
            }
        }
    }


    private void LoadLabels(string CategoryId)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@Id", CategoryId);
        DataTable dtCategory = new DataTable();
        dtCategory = clsDAL.GetDataSet_admin("sp_User_Get_CategoryRecord_ById", ht).Tables[0];
        if (dtCategory.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_1_label"].ToString()))
            {
                Label1.Text = dtCategory.Rows[0]["Textbox_1_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_2_label"].ToString()))
            {
                Label2.Text = dtCategory.Rows[0]["Textbox_2_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_3_label"].ToString()))
            {
                Label3.Text = dtCategory.Rows[0]["Textbox_3_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_4_label"].ToString()))
            {
                Label4.Text = dtCategory.Rows[0]["Textbox_4_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_5_label"].ToString()))
            {
                Label5.Text = dtCategory.Rows[0]["Textbox_5_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Textbox_6_label"].ToString()))
            {
                Label6.Text = dtCategory.Rows[0]["Textbox_6_label"].ToString();
            }

            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["ddl_1_label"].ToString()))
            {
                lblddl1.Text = dtCategory.Rows[0]["ddl_1_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["ddl_2_label"].ToString()))
            {
                lblddl2.Text = dtCategory.Rows[0]["ddl_2_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["ddl_3_label"].ToString()))
            {
                lblddl3.Text = dtCategory.Rows[0]["ddl_3_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["ddl_4_label"].ToString()))
            {
                lblddl4.Text = dtCategory.Rows[0]["ddl_4_label"].ToString();
            }


            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Date_1_label"].ToString()))
            {
                dplbl1.Text = dtCategory.Rows[0]["Date_1_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Date_2_label"].ToString()))
            {
                dplbl2.Text = dtCategory.Rows[0]["Date_2_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Date_3_label"].ToString()))
            {
                dplbl3.Text = dtCategory.Rows[0]["Date_3_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Date_4_label"].ToString()))
            {
                dplbl4.Text = dtCategory.Rows[0]["Date_4_label"].ToString();
            }

            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_1_label"].ToString()))
            {
                rblbl1.Text = dtCategory.Rows[0]["Radio_button_1_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_2_label"].ToString()))
            {
                rblbl2.Text = dtCategory.Rows[0]["Radio_button_2_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_3_label"].ToString()))
            {
                rblbl3.Text = dtCategory.Rows[0]["Radio_button_3_label"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_4_label"].ToString()))
            {
                rblbl4.Text = dtCategory.Rows[0]["Radio_button_4_label"].ToString();
            }


            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_1_Value1"].ToString()))
            {
                rbl1.Items[0].Text = dtCategory.Rows[0]["Radio_button_1_Value1"].ToString();
                rbl1.Items[0].Value = dtCategory.Rows[0]["Radio_button_1_Value1"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_1_Value2"].ToString()))
            {
                rbl1.Items[1].Text = dtCategory.Rows[0]["Radio_button_1_Value2"].ToString();
                rbl1.Items[1].Value = dtCategory.Rows[0]["Radio_button_1_Value2"].ToString();
            }

            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_2_Value1"].ToString()))
            {
                rbl2.Items[0].Text = dtCategory.Rows[0]["Radio_button_2_Value1"].ToString();
                rbl2.Items[0].Value = dtCategory.Rows[0]["Radio_button_2_Value1"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_2_Value2"].ToString()))
            {
                rbl2.Items[1].Text = dtCategory.Rows[0]["Radio_button_2_Value2"].ToString();
                rbl2.Items[1].Value = dtCategory.Rows[0]["Radio_button_2_Value2"].ToString();
            }

            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_3_Value1"].ToString()))
            {
                rbl3.Items[0].Text = dtCategory.Rows[0]["Radio_button_3_Value1"].ToString();
                rbl3.Items[0].Value = dtCategory.Rows[0]["Radio_button_3_Value1"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_3_Value2"].ToString()))
            {
                rbl3.Items[1].Text = dtCategory.Rows[0]["Radio_button_3_Value2"].ToString();
                rbl3.Items[1].Value = dtCategory.Rows[0]["Radio_button_3_Value2"].ToString();
            }

            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_4_Value1"].ToString()))
            {
                rbl4.Items[0].Text = dtCategory.Rows[0]["Radio_button_4_Value1"].ToString();
                rbl4.Items[0].Value = dtCategory.Rows[0]["Radio_button_4_Value1"].ToString();
            }
            if (!string.IsNullOrEmpty(dtCategory.Rows[0]["Radio_button_4_Value2"].ToString()))
            {
                rbl4.Items[1].Text = dtCategory.Rows[0]["Radio_button_4_Value2"].ToString();
                rbl4.Items[1].Value = dtCategory.Rows[0]["Radio_button_4_Value2"].ToString();
            }
        }
    }

    public void CheckUser()
    {
        if (Session["_UserID"] != null)
        {
            string userId = Session["_UserID"].ToString();
            
            // check resource requester
            if (!string.IsNullOrEmpty(Request.QueryString["recordidd"]))
            {
                int asmidd = Convert.ToInt32(Request.QueryString["recordidd"]);
                Hashtable ht = new Hashtable();
                ht.Add("@asmidd", asmidd);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Resource_Requester", ht).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    if (userId == dt.Rows[0]["ID"].ToString())
                    {
                        // logged in user is requester of resource
                        txtRequester.Enabled = true;
                        closeRequester.Visible = true;
                    }
                }
            }

            // check resource approver
            if (!string.IsNullOrEmpty(Request.QueryString["recordidd"]))
            {
                int asmidd = Convert.ToInt32(Request.QueryString["recordidd"]);
                Hashtable ht = new Hashtable();
                ht.Add("@asmidd", asmidd);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Resource_Approver", ht).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (userId == row["usridd"].ToString())
                        {
                            // logged in user is requester of resource
                            dtpApproverDate.Enabled = true;
                            radioApprove.Enabled = true;
                            radioReject.Enabled = true;
                            txtbxApprover.Enabled = true;
                            closeApprover.Visible = true;
                        }
                    }
                }
            }

            // check resource owner
            if (!string.IsNullOrEmpty(Request.QueryString["recordidd"]))
            {
                int asmidd = Convert.ToInt32(Request.QueryString["recordidd"]);
                Hashtable ht = new Hashtable();
                ht.Add("@recidd", asmidd);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_AssignmentResourceOwner", ht).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["owners"].ToString().Contains(userId))
                    { 
                        // logged in user is owner of resource
                        dtpdate.Enabled = true;
                        chkIsProvided.Enabled = true;
                        txtOwner.Enabled = true;
                        closeOwner.Visible = true;
                    }
                }
            }
        }
    }

    public void LoadRecord()
    {
        if (!string.IsNullOrEmpty(Request.QueryString["recordidd"]))
        {
            int Recordidd = Convert.ToInt32(Request.QueryString["recordidd"]);
            hdnRecordIdd.Value = Recordidd.ToString();
            Hashtable ht = new Hashtable();
            ht.Add("@Recordidd", Recordidd);
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Assignment_Detail", ht).Tables[0];
            if (dt.Rows.Count > 0)
            {
                txtOwner.Text = dt.Rows[0]["owndsc"].ToString();
                txtRequester.Text = dt.Rows[0]["reqdsc"].ToString();
                chkIsProvided.Checked = Convert.ToBoolean(dt.Rows[0]["IsProvided"]);
                //dtpdate.SelectedDate = DateTime.Parse(dt.Rows[0]["owndtm"].ToString());
            }
        }
    }

}