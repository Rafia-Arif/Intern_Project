using System;
using System.Collections;
using System.Linq;

public partial class Controls_ucEmployeeCard : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void LoadEmployeeCard(string employeeID)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", employeeID);
        var dsEmployee = clsDAL.GetDataSet("sp_Payroll_Get_Employee_Card_By_ID", ht);

        if (dsEmployee != null)
        {
            if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
            {
                lblEmployeeCode.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["EmployeeCode"]).Trim();
                lblEmail.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PersonalEmail"]).Trim();
                lblName.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PrintingName"]).Trim();
                lblPhone.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["MobileNumber"]).Trim();
                lblPositionCode.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PositionName"]).Trim();
                lblDepartmentCode.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["DepartmentName"]).Trim();
                lblEmail.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PersonalEmail"]).Trim();
                lblPhone.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["MobileNumber"]).Trim();

            //    lblDesignationCode.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PositionCode"]).Trim();

                // get image from database as base64 string

                   string logoAsBase64 = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LogoAsBase64"]);
                string contentType = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LogoType"]);
                string logo;
                if (logoAsBase64.Trim() != "" || !string.IsNullOrEmpty(logoAsBase64))
                {

                    logo = string.Format("data:{0};base64,{1}", contentType, logoAsBase64);
                        imgEmployee.Src = logo;
                    
                }
                else
                {
                    imgEmployee.Src = "~/Images/Emp_Card_Pic2.jpg";
                
                }
                 }
        }
    }
}