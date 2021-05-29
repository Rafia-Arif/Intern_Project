using System;
using System.Web.UI;
using System.Linq;
using System.Web;
using System.Collections;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.ComponentModel;
using System.Data;
//using Microsoft.Office.Interop.Outlook;
using System.Collections.Generic;
using System.IO;

/// <summary>
/// Summary description for clsCommon
/// </summary>
public class clsCommon : BasePage
{
    public clsCommon()
    {
        //
        // TODO: Add constructor logic here
        //--
    }
    public static void ExportHash(Hashtable hsh_Parameters)
    {
        try
        {
            StreamWriter writer = null;

            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    string filePath = "c:\\test";

                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    try
                    {

                        File.AppendAllText(@"c:\test\test.txt", obj_Enm.Key.ToString() +"='"+ obj_Enm.Value+"'," + Environment.NewLine);

                      /*  FileStream fileStream = new FileStream(filePath + "test.txt", FileMode.OpenOrCreate, FileAccess.ReadWrite);
                        writer = new StreamWriter(fileStream);
                        writer.BaseStream.Seek(0, SeekOrigin.End);
                        // Force the write to the underlying file
                        writer.WriteLine(obj_Enm.Key.ToString(), obj_Enm.Value);
                        writer.Flush();
                    */}
                    catch (Exception ex) { }
                }
                File.AppendAllText(@"c:\test\test.txt", "----------------End----------------------" + Environment.NewLine);

            }
        }
        catch (Exception exp)
        { }
    }
 
    public static bool ValidatePageSecurity(string UserName, string ActionKeyWord)
    {
        if (UserName.ToLower() == "administrator" || UserName == "")
            return true;
        else
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserName", UserName);
            ht.Add("@ActionKeyWord", ActionKeyWord);
            return bool.Parse(clsDAL.ExecuteScalar_admin("sp_Admin_get_ACL_IsAllowed", ht).ToString());
        }
    }

    public enum RequestStatus
    {
        Initiated = 1,
        Edited = 2,
        Pending = 3,
        InProcess = 4,
        Approved = 5,
        Rejected = 6,
        Canceled = 7,
        Completed = 8,
        Revised = 9,
        Recalled = 10
    }

    public static string FormType (string FormTypeE)
    {
        string hdID = FormTypeE;
        string IDName = clsEncryption.DecryptData(hdID);
        int IDindx = IDName.IndexOf("------------------------------");
        string FormTypeD = IDName.Substring(0, IDindx);
        return FormTypeD;
    }

    public static void SendCompletedCallback(object sender, AsyncCompletedEventArgs e)
    {
    }

    public static string RefineMessage(string strToReplace, DataTable dt )
    {

        //replace commands from string

        strToReplace = strToReplace.Replace("<++Empcode++>", dt.Rows[0]["Empcode"].ToString());
        strToReplace = strToReplace.Replace("<++RequestorFullName++>", dt.Rows[0]["RequestorFullName"].ToString());
        strToReplace = strToReplace.Replace("<++ApproverFullName++>", dt.Rows[0]["ApproverFullName"].ToString());
        strToReplace = strToReplace.Replace("<++RequestorEmpCode++>", dt.Rows[0]["RequestorEmpCode"].ToString());
        strToReplace = strToReplace.Replace("<++EmployeeEmpCode++>", dt.Rows[0]["EmployeeEmpCode"].ToString());
        strToReplace = strToReplace.Replace("<++TransactionNumber++>", dt.Rows[0]["TransactionNumber"].ToString());
        strToReplace = strToReplace.Replace("<++RequestType++>", dt.Rows[0]["RequestType"].ToString());

        strToReplace = strToReplace.Replace("&lt;++Empcode++&gt;", dt.Rows[0]["Empcode"].ToString());
        strToReplace = strToReplace.Replace("&lt;++RequestorFullName++&gt;", dt.Rows[0]["RequestorFullName"].ToString());
        strToReplace = strToReplace.Replace("&lt;++ApproverFullName++&gt;", dt.Rows[0]["ApproverFullName"].ToString());
        strToReplace = strToReplace.Replace("&lt;++RequestorEmpCode++&gt;", dt.Rows[0]["RequestorEmpCode"].ToString());
        strToReplace = strToReplace.Replace("&lt;++EmployeeEmpCode++&gt;", dt.Rows[0]["EmployeeEmpCode"].ToString());
        strToReplace = strToReplace.Replace("&lt;++TransactionNumber++&gt;", dt.Rows[0]["TransactionNumber"].ToString());
        strToReplace = strToReplace.Replace("&lt;++RequestType++&gt;", dt.Rows[0]["RequestType"].ToString());



        return strToReplace;

    }


    public void SendEmail(int trxId)
    {
        // get email info
        // load email keys columns in email info sp
        Hashtable ht_email = new Hashtable();
        ht_email.Add("@ReimbursmentID", trxId);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbursmentT2_Info_4_Email", ht_email).Tables[0];
        if (dt.Rows.Count > 0)
        {
            string sSubject = string.Empty;
            string sBody = String.Empty;

            // load email template , subject , body with templateid

            Hashtable ht_template = new Hashtable();
            ht_template.Add("@emailtypeId", 1);
            DataTable dtTemplate = clsDAL.GetDataSet("sp_payroll_Get_EmailTemplate", ht_template).Tables[0];
            if (dtTemplate.Rows.Count > 0)
            {
                sSubject = dtTemplate.Rows[0]["subject"].ToString();
                sBody = dtTemplate.Rows[0]["body"].ToString();
                if (!string.IsNullOrEmpty(sBody))
                {
                    sSubject = clsCommon.RefineMessage(sSubject, dt);
                    sBody = clsCommon.RefineMessage(sBody, dt);


                    //call email function SendMail(mailbody,emailto, emailfrom,mailsubject) 
                    clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), string.Empty, sSubject);
                }
            }
        }
    }

    public static bool SendMail(string MailBody, string EmailTo, string MailFrom="", string Subject="")
    {
        try
        {
        
            bool windowsAuth;
            DataTable param;
            param = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null).Tables[0];
            if (param.Rows.Count > 0)
            {
                windowsAuth = Convert.ToBoolean(param.Rows[0]["windowsauthentication"]);
                // Email To
                MailMessage msg = new MailMessage();

                EmailTo = EmailTo.Trim();
                if (EmailTo.Contains(";") | EmailTo.Contains(","))
                {
                    char[] deli = new char[2];
                    deli[0] = ';';
                    deli[1] = ',';
                    string[] emails = EmailTo.Split(deli);
                    foreach (string toEmail in emails)
                    {
                        msg.To.Add(toEmail);
                    }
                }
                else
                {
                    msg.To.Add(EmailTo);
                }
                 

                // From Email
                if (string.IsNullOrEmpty(MailFrom))
                {
                   MailFrom = param.Rows[0]["HRemail"].ToString();
                }
                msg.From = new MailAddress(MailFrom);

                msg.Subject = Subject;
                msg.Body = MailBody;
                msg.IsBodyHtml = true;
               
                // Smtp settings
                SmtpClient smtp = new SmtpClient(param.Rows[0]["smtphost"].ToString(), int.Parse(param.Rows[0]["smtpport"].ToString()));
                ICredentials credentials;

                if (windowsAuth)
                {
                    smtp.UseDefaultCredentials = true;
                    smtp.Credentials = new NetworkCredential(param.Rows[0]["emailaccount"].ToString(), param.Rows[0]["emailpassword"].ToString());

                }
                else
                {
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential(param.Rows[0]["emailaccount"].ToString(), param.Rows[0]["emailpassword"].ToString());
                }
             //   SmtpClient smtp = new SmtpClient(param.Tables[0].Rows[0]["smtphost"].ToString(),int.Parse(param.Tables[0].Rows[0]["smtpport"].ToString()));
                smtp.EnableSsl = bool.Parse(param.Rows[0]["smtpssl"].ToString());

                //List<string> emails = new List<string>();

                //for (int to = 0; to <= 0; to++)
                //{
                //    msg.To.Add(EmailTo.Rows[to]["Email"].ToString());
                // //   smtp.Send(msg);


                //}
                

                
                // send email
                smtp.Send(msg);
                
                msg.Dispose();
                return true;
            }
            else
                return false;
        }
        catch (System.Exception ex)
        {

        }
        return false;
    }


    public static bool SendMail(string MailBody, DataTable EmailTo, string MailFrom = "", string Subject = "")
    {
        try
        {

            bool windowsAuth;
            DataTable param;
            param = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null).Tables[0];
            if (param.Rows.Count > 0)
            {
                windowsAuth = Convert.ToBoolean(param.Rows[0]["windowsauthentication"]);
                // Email To
                MailMessage msg = new MailMessage();

             

                // From Email
                if (string.IsNullOrEmpty(MailFrom))
                {
                    MailFrom = param.Rows[0]["HRemail"].ToString();
                }
                msg.From = new MailAddress(MailFrom);

                msg.Subject = Subject;
                msg.Body = MailBody;
                msg.IsBodyHtml = true;

                // Smtp settings
                SmtpClient smtp = new SmtpClient(param.Rows[0]["smtphost"].ToString(), int.Parse(param.Rows[0]["smtpport"].ToString()));
                ICredentials credentials;

                if (windowsAuth)
                {
                    smtp.UseDefaultCredentials = true;
                    smtp.Credentials = new NetworkCredential(param.Rows[0]["emailaccount"].ToString(), param.Rows[0]["emailpassword"].ToString());

                }
                else
                {
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential(param.Rows[0]["emailaccount"].ToString(), param.Rows[0]["emailpassword"].ToString());
                }
                //   SmtpClient smtp = new SmtpClient(param.Tables[0].Rows[0]["smtphost"].ToString(),int.Parse(param.Tables[0].Rows[0]["smtpport"].ToString()));
                smtp.EnableSsl = bool.Parse(param.Rows[0]["smtpssl"].ToString());

                List<string> emails = new List<string>();

                for (int to = 0; to <= EmailTo.Rows.Count-1; to++)
                {
                    msg.To.Clear();
                    msg.To.Add(EmailTo.Rows[to]["Email"].ToString());
                    smtp.Send(msg);
                }
                                 
                msg.Dispose();
                return true;
            }
            else
                return false;
        }
        catch (System.Exception ex)
        {

        }
        return false;
    }
/*
    public static bool SendExchangeMail(string MailBody, string EmailTo, string MailFrom = "", string Subject = "")
    {
        try
        {
            DataTable param;
            param = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null).Tables[0];
            if (param.Rows.Count > 0)
            {

                Application app = new Application();
                NameSpace ns = app.GetNamespace("mapi");
                ns.Logon("payroll@neelands.com", "P@yroll2017", false, true);
                MailItem msg = (MailItem)app.CreateItem(OlItemType.olMailItem);


                // Email To
                 EmailTo = EmailTo.Trim();
                if (EmailTo.Contains(";") | EmailTo.Contains(","))
                {
                    char[] deli = new char[2];
                    deli[0] = ';';
                    deli[1] = ',';
                    string[] emails = EmailTo.Split(deli);
                    foreach (string toEmail in emails)
                    {
                        msg.To = toEmail;
                    }
                }
                else
                {
                    msg.To=EmailTo;
                }

                // From Email
                if (string.IsNullOrEmpty(MailFrom))
                {
                    MailFrom = param.Rows[0]["HRemail"].ToString();
                }
//                msg.From = new MailAddress(MailFrom);

                msg.Subject = Subject;
                msg.Body = MailBody;
                msg.HTMLBody = MailBody;
                msg.Send();
                ns.Logoff();

                /*
                // Smtp settings
                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP_HOST"], int.Parse(ConfigurationManager.AppSettings["SMTP_PORT"]));
                //SmtpClient smtp = new SmtpClient(param.Tables[0].Rows[0]["smtphost"].ToString(),int.Parse(param.Tables[0].Rows[0]["smtpport"].ToString()));
                smtp.EnableSsl = bool.Parse(param.Rows[0]["smtpssl"].ToString());
                smtp.Credentials = new NetworkCredential(param.Rows[0]["emailaccount"].ToString(), param.Rows[0]["emailpassword"].ToString());

                // send email
                smtp.Send(msg);
             
                msg.Dispose();   */
   /*             return true;
            }
            else
                return false;
        }
        catch (System.Exception ex)
        {

        }
        return false;
    }

*/
    public static bool SendMail(string MailBody, string EmailTo, string MailFrom, string Subject, System.Net.Mail.Attachment[] attachments)
    {
        try
        {
            DataSet param;
            param = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null);
            MailMessage msg = new MailMessage();

            if (EmailTo.Contains(";") | EmailTo.Contains(","))
            {
                char[] deli = new char[2];
                deli[0] = ';';
                deli[1] = ',';

                string[] emails = EmailTo.Split(deli);

                foreach (string toEmail in emails)
                {
                    msg.To.Add(toEmail);
                }
            }
            else
            {
                msg.To.Add(EmailTo);
            }

            msg.From = new MailAddress(MailFrom);
            msg.Subject = Subject;
            msg.Body = MailBody;
            msg.IsBodyHtml = true;

            foreach (System.Net.Mail.Attachment attchmnts in attachments)
            {
                msg.Attachments.Add(attchmnts);
            }



            SmtpClient smtp = new SmtpClient(param.Tables[0].Rows[0]["smtphost"].ToString(), int.Parse(param.Tables[0].Rows[0]["smtpport"].ToString()));

            smtp.EnableSsl = bool.Parse(param.Tables[0].Rows[0]["smtpssl"].ToString());
            smtp.Credentials = new NetworkCredential(param.Tables[0].Rows[0]["emailaccount"].ToString(), param.Tables[0].Rows[0]["emailpassword"].ToString());



            smtp.Send(msg);
            msg.To.Clear();
            return true;
        }
        catch (System.Exception ex)
        {

        }
        return false;
    }

    public static string GetPostedFieldText(DateTime dt)
    {
        TimeSpan ts = DateTime.Now.Subtract(dt);

        if (ts.Days == 1)
            return string.Format("{0} {1}", ts.Days, "day ago.");
        else if (ts.Days > 1)
            return string.Format("{0} {1}", ts.Days, "days ago.");
        else if (ts.Hours == 1)
            return string.Format("{0} {1}", ts.Hours, "hour ago.");
        else if (ts.Hours > 1)
            return string.Format("{0} {1}", ts.Hours, "hours ago.");
        else if (ts.Minutes > 1)
            return string.Format("{0} {1}", ts.Minutes, "minutes ago.");
        else
            return string.Format("{0} {1}", ts.Minutes, "minute ago.");

    }

    public static DataSet DDLValueSet_GetByDDLID(string strDDLName, int iValue = -1, int iSortOnTextField = 1)
    {
        try
        {
            DataSet dsObj = new DataSet();

            Hashtable htPara = new Hashtable();

            htPara.Add("@DDLName", strDDLName);
            htPara.Add("@Value", iValue);

            if (iSortOnTextField == 0)
            {
                htPara.Add("@SortOnTextField", iSortOnTextField);
            }

            dsObj = clsDAL.GetDataSet(Constraints.SP_DDLVALUES_GETBYDDLNAMEVALUE, htPara);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet DDLValueSet_GetByDDLID_FromPayroll(string strDDLName, int iValue = -1, int iSortOnTextField = 1)
    {
        try
        {
            DataSet dsObj = new DataSet();

            Hashtable htPara = new Hashtable();

            htPara.Add("@DDLName", strDDLName);
            htPara.Add("@Value", iValue);

            if (iSortOnTextField == 0)
            {
                htPara.Add("@SortOnTextField", iSortOnTextField);
            }

            dsObj = clsDAL.GetDataSet(Constraints.SP_DDLVALUES_GETBYDDLNAMEVALUE, htPara);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet DDLValueSet_GetByDDLID_FromCentralDb(string strDDLName, int iValue = -1, int iSortOnTextField = 1)
    {
        try
        {
            DataSet dsObj = new DataSet();

            Hashtable htPara = new Hashtable();

            htPara.Add("@DDLName", strDDLName);
            htPara.Add("@Value", iValue);

            if (iSortOnTextField == 0)
            {
                htPara.Add("@SortOnTextField", iSortOnTextField);
            }

            dsObj = clsDAL.GetDataSet_admin(Constraints.SP_DDLVALUES_GETBYDDLNAMEVALUE, htPara);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_Position()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Position);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }
    public static DataSet Get_Requisition_Type()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_RequisitionType);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }
    public static DataSet Get_Nationality()
    {
        try
        {
            DataSet dsObj = new DataSet();

            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Nationality);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_Religion()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Religion);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_Department()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Department);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }


    public static DataSet Get_Employees()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Employees);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }
    public static DataSet Get_replacement_employees()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_Admin_Get_Replacment_Employees_4_DDL);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_GradeRequested()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_GradeRequested);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_Checklist(string PreOrPost)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@PreOrPost", PreOrPost);

            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_CheckList, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_ChecklistDetails(int Parent_ID, int Interview_ID)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@Parent_ID", Parent_ID);
            htPara.Add("@Interview_ID", Interview_ID);

            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_CheckList_Details, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }
    public static DataSet Get_ChecklistDetails_4_MAF()
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            //      htPara.Add("@Parent_ID",Parent_ID);
            //      htPara.Add("@Interview_ID",Interview_ID);

            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_CheckList_Details_4_MAF);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }


    public static DataSet Get_AppDetails_4_MAF(int reqidd, int appidd)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@reqidd", reqidd);
            htPara.Add("@appidd", appidd);


            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_AppDetails_4_MAF, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    public static DataSet Get_AppDetails_4_Prehiring(int reqidd, int appidd)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@reqidd", reqidd);
            htPara.Add("@appidd", appidd);


            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_AppDetails_4_Prehiring, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }





    public static DataSet Get_Budget_Codes()
    {
        try
        {
            DataSet dsObj = new DataSet();


            dsObj = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_Budget_Code);
            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }

    /*
    public static string GenerateReportHTML(string ReportDisplayName, string ReportPath, string prmRequestID, string CurrentUserID)
    {
        try
        {
            // Prepare Render arguments
            string historyID = null;
            string deviceInfo = null;
            //string format = "HTML4.0";
            string format = "IMAGE";
            Byte[] results;
            string encoding = String.Empty;
            string mimeType = String.Empty;
            string extension = String.Empty;
            Rse2005.Warning[] warnings = null;
            string[] streamIDs = null;


            Rse2005.ReportExecutionServiceSoapClient rsExec = new Rse2005.ReportExecutionServiceSoapClient();


            System.Net.NetworkCredential clientCredentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["NetworkUsername"], ConfigurationManager.AppSettings["NetworkPassword"]);
            rsExec.ClientCredentials.Windows.AllowedImpersonationLevel = System.Security.Principal.TokenImpersonationLevel.Impersonation;
            rsExec.ClientCredentials.Windows.ClientCredential = clientCredentials;

            rsExec.ClientCredentials.SupportInteractive = true;

            Rse2005.TrustedUserHeader tuh = new Rse2005.TrustedUserHeader();
            Rse2005.ServerInfoHeader sih = new Rse2005.ServerInfoHeader();
            Rse2005.ExecutionInfo ei = new Rse2005.ExecutionInfo();

            rsExec.LoadReport(tuh, ReportPath, historyID, out sih, out ei);

            Rse2005.ParameterValue[] rptParameters = new Rse2005.ParameterValue[3];

            rptParameters[0] = new Rse2005.ParameterValue();
            rptParameters[0].Name = "RequestID";
            rptParameters[0].Value = prmRequestID;

            //render the PDF
            Rse2005.ExecutionHeader eh = new Rse2005.ExecutionHeader();
            eh.ExecutionID = ei.ExecutionID;
            rsExec.SetExecutionParameters(eh, tuh, rptParameters, "en-us", out ei);

            //Rse2005.DataSourceCredentials[] dsc = new Rse2005.DataSourceCredentials[1];

            //dsc[0] = new Rse2005.DataSourceCredentials();
            //dsc[0].DataSourceName = "DataSource1";
            //dsc[0].UserName = ConfigurationManager.AppSettings["DBUsername"];
            //dsc[0].Password = ConfigurationManager.AppSettings["DBPassword"];

            //rsExec.SetExecutionCredentials(eh, tuh, dsc, out ei);


            rsExec.Render(eh, tuh, format, deviceInfo, out results, out extension, out mimeType, out encoding, out warnings, out streamIDs);

            try
            {
                if (!Directory.Exists(HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["TempReportFolder"] + "/" + CurrentUserID)))
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["TempReportFolder"] + "/" + CurrentUserID));

                //         string _ReportPath = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["TempReportFolder"] + "/" + CurrentUserID + "/" + ReportDisplayName + "_" + prmRequestID + ".jpg");

                string _ReportPath = ConfigurationManager.AppSettings["TempReportFolder"] + "/" + CurrentUserID + "/" + ReportDisplayName.Replace(" ", "_") + "_" + prmRequestID + ".jpg";

                FileStream stream = File.Create(HttpContext.Current.Server.MapPath(_ReportPath), results.Length);



                //         FileStream stream = File.Create(_ReportPath, results.Length);
                stream.Write(results, 0, results.Length);
                stream.Close();

                rsExec.Close();

                return _ReportPath;
            }
            catch (Exception ex)
            {
                Console.Write("Exception:" + ex.Message + "\n" + ex.StackTrace);
            }
        }
        catch (Exception ex)
        {
            Console.Write("Exception:" + ex.Message + "\n" + ex.StackTrace);
        }

        return "";

    }
    */
    public static string getDirection(string culture)
    {
        //check whether a culture is stored in the session
        if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
        {
            return "rtl";
        }
        else
        {
            return "ltr";
        }
    }

    public static string FloatRightIfRTL(string culture)
    {
        //check whether a culture is stored in the session
        if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
        {
            return "f-right";
        }
        else
        {
            return "";
        }
    }

    public static string FloatLeftIfRTL(string culture)
    {
        //check whether a culture is stored in the session
        if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
        {
            return "f-left";
        }
        else
        {
            return "";
        }
    }

    public static string TextLeftIfRTL(string culture)
    {
        //check whether a culture is stored in the session
        if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
        {
            return "t-left";
        }
        else
        {
            return "";
        }
    }

    public static string TextRightIfRTL(string culture)
    {
        //check whether a culture is stored in the session
        if (!string.IsNullOrEmpty(culture) && culture == "ar-AE")
        {
            return "t-right";
        }
        else
        {
            return "";
        }
    }

    public static void RecordException(string errorDetail)
    {
        int id = 0;
        Hashtable ht = new Hashtable();
        ht.Add("@Description", errorDetail);
        ht.Add("@UserHostAddress", HttpContext.Current.Request.UserHostAddress);
        ht.Add("@ID", 0);

        int.TryParse(clsDAL.ExecuteNonQuery("sp_App_Insert_Failure", ht, "@ID", System.Data.SqlDbType.Int, 0).ToString(), out id);

        HttpContext.Current.Response.Redirect("~/Error.aspx", true);
    }




    public static DataSet Get_MAF_CheckList_Detail(int reqidd, int appidd, int checklistidd)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@reqidd", reqidd);
            htPara.Add("@appidd", appidd);
            htPara.Add("@checklistidd", checklistidd);

            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_MAF_CheckList_Detail, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }



    public static DataSet Get_PRE_CheckList_Detail(int reqidd, int appidd, int checklistidd)
    {
        try
        {
            DataSet dsObj = new DataSet();
            Hashtable htPara = new Hashtable();

            htPara.Add("@reqidd", reqidd);
            htPara.Add("@appidd", appidd);
            htPara.Add("@checklistidd", checklistidd);

            dsObj = clsDAL.GetDataSet(Constraints.sp_User_Get_PRE_CheckList_Detail, htPara);

            return dsObj;
        }
        catch (System.Exception ex)
        {
            Logger.LogError(ex);
            throw;
        }
    }
    // functions to send emails
    public static bool SendMail(int typee, Hashtable ht)
    {
        return false;
    }

    public static bool SendMail(int typee, Hashtable ht,Hashtable ht_redirect)
    {
        try
        {
            MailMessage msg = new MailMessage();


            Hashtable parameters = new Hashtable();
            parameters = getfromaddress();

            string fromaddress = parameters["fromaddress"].ToString();
            string smtphost = parameters["smtphost"].ToString();
            int smtpport = Convert.ToInt32(parameters["smtpport"].ToString());
            string fromemail = parameters["fromemail"].ToString();
            string fromemailpassword = parameters["fromemailpassword"].ToString();


            msg.From = new MailAddress(fromaddress);



            msg.Subject = getsubject(typee);
            msg.Body = getbody(typee);
            msg.IsBodyHtml = true;
            msg.To.Add("salmanfazal@gmail.com");

            {

                string sBody;
                sBody = getbody(typee);

                DataTable dt = clsDAL.GetDataSet_admin(Constraints.sp_User_Get_User_Info_4_Email, ht).Tables[0];

                sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                sBody = sBody.Replace("<%ID%>", dt.Rows[0]["EmployeeEmpCode"].ToString());
                sBody = sBody.Replace("<%FullName%>", dt.Rows[0]["RequestorFullName"].ToString());
                sBody = sBody.Replace("<%FirstName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                //sBody = sBody.Replace("<%LastName%>", dt.Rows[0]["LASTNAME"].ToString());

                sBody = sBody.Replace("<%RedirectURL%>", ht_redirect["@RedirectURL"].ToString());



            }



            SmtpClient smtp = new SmtpClient(smtphost, smtpport);

            smtp.EnableSsl = Convert.ToBoolean(parameters["enablessl"].ToString());


            smtp.Credentials = new NetworkCredential(fromemail, fromemailpassword);
            smtp.Send(msg);

            msg.Dispose();
            return true;
        }
        catch (System.Exception ex)
        {

        }
        return false;
    }

    public static Hashtable getfromaddress()
    {


        DataTable dtfromaddress = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters", null).Tables[0];
        Hashtable parameters = new Hashtable();


        parameters.Add("fromaddress", dtfromaddress.Rows[0][13].ToString());
        parameters.Add("enablessl", dtfromaddress.Rows[0][10].ToString());
        parameters.Add("smtphost", dtfromaddress.Rows[0][8].ToString());
        parameters.Add("smtpport", dtfromaddress.Rows[0][9].ToString());
        parameters.Add("fromemail", dtfromaddress.Rows[0][11].ToString());
        parameters.Add("fromemailpassword", dtfromaddress.Rows[0][12].ToString());



        return parameters;


    }

    public static string getbody(int i)
    {


        Hashtable param = new Hashtable();
        param.Add("@typee", i);


        DataTable dtTemp = clsDAL.GetDataSet_admin("sp_admin_get_email_template", param).Tables[0];
        string body;
        body = dtTemp.Rows[0][4].ToString();
        return body;


    }

    public static string getsubject(int i)
    {




        Hashtable param = new Hashtable();
        param.Add("@typee", i);


        DataTable dtsubject = clsDAL.GetDataSet_admin("sp_admin_get_email_template", param).Tables[0];
        string subject;
        subject = dtsubject.Rows[0][3].ToString();
        return subject;


    }

    /// <summary>
    /// Get logo from database and display where required
    /// </summary>
    /// <returns></returns>
    public static string GetLogoAsBase64() {
        try
        {
            var dsLogoInfo = clsDAL.GetDataSet_admin("sp_Admin_Get_Admin_Parameters");
            if (dsLogoInfo.Tables.Count > 0)
            {
                if (dsLogoInfo.Tables[0].Rows.Count > 0)
                {
                    string logoAsBase64 = Convert.ToString(dsLogoInfo.Tables[0].Rows[0]["LogoAsBase64"]);
                    string contentType = Convert.ToString(dsLogoInfo.Tables[0].Rows[0]["LogoType"]);

                    if (logoAsBase64.Trim() != "") return string.Format("data:{0};base64,{1}", contentType, logoAsBase64);
                }
            }
        }
        catch { }

        return "";
    }


    public static void opendocument(string ID,string transactionname)
    {
         
        Hashtable ht_attach = new Hashtable();
        ht_attach.Add("@transid", ID);
        ht_attach.Add("@transname", transactionname);

        DataTable dt_attach = clsDAL.GetDataSet("sp_User_Get_Transactionattach_ByID", ht_attach).Tables[0];

                if (dt_attach != null && dt_attach.Rows.Count > 0)
        {
            string filename = dt_attach.Rows[0]["documentname"].ToString();
            string fileContentType = dt_attach.Rows[0]["documenttype"].ToString();
            byte[] file = (byte[])dt_attach.Rows[0]["document"];

            System.Web.HttpContext.Current.Response.Clear();
            System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + filename);
            System.Web.HttpContext.Current.Response.ContentType = Convert.ToString(fileContentType);
            System.Web.HttpContext.Current.Response.BinaryWrite(file);
            System.Web.HttpContext.Current.Response.Flush();
            System.Web.HttpContext.Current.Response.Close();
            System.Web.HttpContext.Current.Response.End();
        }
    }


public static void writelogs(string app,string fromm,int linenumber,string executemethod,Hashtable htt,string userid,string filename)
{
    
  
foreach (DictionaryEntry entry in htt)
{
    string s= entry.Key.ToString();
    string t= entry.Value.ToString();
    
    clsDAL.ExecuteNonQuery_admin("sp_admin_insert_detection", app,fromm,linenumber,executemethod,s,t,userid,filename);


}
}


public static void writelogs(string app, string fromm, int linenumber, string executemethod,string filename)
{


  
        clsDAL.ExecuteNonQuery_admin("sp_admin_insert_detection", app, fromm, linenumber, executemethod, "", "", "",filename);


    
}


}



