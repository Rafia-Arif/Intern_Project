using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Constants
/// </summary>
public static class Constraints
{
    #region DBConstants
    public const string SP_DDLVALUES_GETBYDDLNAMEVALUE = "DDLValues_GetByDDLNameValue";

    public const string sp_User_Insert_LoanAdjustment = "sp_User_Insert_LoanAdjustment";
    public const string sp_User_Get_Position = "sp_User_Get_Position";
    public const string sp_User_Get_Religion = "sp_User_Get_Religion";
    public const string sp_User_Get_Nationality = "sp_User_Get_Nationality";
    public const string sp_User_Get_Department = "sp_User_Get_Department";
    public const string sp_User_Get_Budget_Code = "sp_User_Get_Budget_Code";
    public const string sp_User_Get_GradeRequested = "sp_User_Get_GradeRequested";
    public const string sp_User_Insert_Loan_Installment = "sp_User_Insert_Loan_Installment";
    public const string sp_User_Update_Loan_Installment = "sp_User_Update_Loan_Installment";

    public const string sp_User_Insert_Applicant = "sp_User_Insert_Applicant";
    public const string sp_User_Get_User_Info_4_Email = "sp_User_Get_User_Info_4_Email";
    public const string sp_User_Insert_Requisition = "sp_User_Insert_Requisition";
    public const string sp_User_Get_Requisition_Info_4_Email = "sp_User_Get_Requisition_Info_4_Email";

    public const string sp_User_Get_CheckList = "sp_User_Get_CheckList";
    public const string sp_User_Get_CheckList_Details = "sp_User_Get_CheckList_Details";
    public const string sp_User_Get_CheckList_Details_4_MAF = "sp_User_Get_CheckList_Details_4_MAF";

    public const string sp_User_Get_AppDetails_4_MAF = "sp_User_Get_AppDetails_4_MAF";
    public const string sp_User_Get_AppDetails_4_Prehiring = "sp_User_Get_AppDetails_4_Prehiring";

    public const string sp_User_Get_MAF_CheckList_Detail = "sp_User_Get_MAF_CheckList_Detail";

    public const string sp_User_Get_PRE_CheckList_Detail = "sp_User_Get_PRE_CheckList_Detail";

    public const string sp_User_Get_Employees = "sp_User_Get_Employees";
    public const string sp_User_Get_RequisitionType = "sp_User_Get_RequisitionTypes_4_DDL";
    public const string sp_Admin_Get_Replacment_Employees_4_DDL = "sp_Admin_Get_Replacment_Employees_4_DDL";

    public const string sp_admin_Get_Email_configuration = "sp_Admin_Get_Admin_Parameters";

    public const string sp_User_Insert_TransactionEntry = "sp_User_Insert_TransactionEntry";
    public const string sp_User_Insert_LeaveTransaction = "sp_User_Insert_LeaveTransaction";
    public const string sp_User_Update_LeaveRecord = "sp_User_Update_LeaveRecord";
    
    public const string sp_User_Insert_Reimbursment = "sp_User_Insert_Reimbursment";
    public const string sp_User_Insert_MonthEndProcessing = "sp_User_Insert_MonthEndProcessing";
    public const string sp_User_Get_Next_Number = "sp_User_Get_Next_Number";
    public const string sp_User_Insert_IncidentRecord = "sp_User_Insert_IncidentRecord";
    public const string sp_User_Update_IncidentRecord = "sp_User_Update_IncidentRecord";

    public const string sp_User_Insert_Attachment = "sp_User_Insert_Attachment";

    
    public const string sp_User_Insert_Complain = "sp_User_Insert_Complain";
    public const string get_WorkFlowID = "get_WorkFlowID";
    public const string sp_User_Insert_Suggestion = "sp_User_Insert_Suggestion";
    public const string sp_User_Insert_LoanTransaction = "sp_User_Insert_LoanTransaction";
    public const string sp_User_Insert_Loan = "sp_User_Insert_Loan";
    public const string sp_User_Insert_TicketTransaction = "sp_User_Insert_TicketTransaction";
    public const string sp_User_Insert_TicketTransaction_Detail = "sp_User_Insert_TicketTransaction_Detail";
    public const string sp_User_Insert_EOSTransaction = "sp_User_Insert_EOSTransaction";
    public const string sp_User_Insert_LeaveResumption = "sp_User_Insert_LeaveResumption";

    #endregion

    #region DropDownLists
    public static class DropDownLists
    {
        public const string Status = "Status";
        public const string JobType = "JobType";
        public const string Gender = "Gender";
        public const string Department = "Department";
        public const string Grade = "Grade";
        public const string ReqExperienceStatus = "ReqExperienceStatus";
        public const string ReqSkillStatus = "ReqSkillStatus";
        public const string Expertise = "Expertise";
        public const string ReqQualificationStatus = "ReqQualificationStatus";

        public const string LeaveBased = "LeaveBased";
        public const string SalaryBased = "SalaryBased";
        public const string LeaveFrequency = "LeaveFrequency";
        public const string LeaveProvision = "LeaveProvision";
        public const string NewEmployeeAnnualLeave = "NewEmployeeAnnualLeave";
        public const string PayCode = "PayCode";
        public const string DeductionCode = "DeductionCode";
        public const string BenefitCode = "BenefitCode";

        public const string NegativeBalance = "NegativeBalance";
        public const string FallBelowZero = "FallBelowZero";
		public const string LeaveEncashment = "LeaveEncashment";
        public const string LeaveBalanceCalculationNoofDaysYear = "LeaveBalanceCalculationNoofDaysYear";
        public const string PensionCode = "PensionCode";
        public const string PremiumType = "PremiumType";
        public const string UnitOfPayment = "UnitOfPayment";
        public const string PreminumType = "PreminumType";
        public const string MeasurmentType = "MeasurmentType";
        public const string DefaultPayrollType = "DefaultPayrollType";
        public const string EmployeeSalaryCalculation = "EmployeeSalaryCalculation";
        public const string OvertimeDataEntry = "OvertimeDataEntry";
        public const string DefaultRolldownSetting = "DefaultRolldownSetting";

        public const string DeductionType = "DeductionType";
        //public const string GarnishmentCategory = "GarnishmentCategory";
        public const string DeductionMethod = "DeductionMethod";
        public const string DeductionFrequency = "DeductionFrequency";

        public const string BenefitType = "BenefitType";
        public const string BenefitMethod = "BenefitMethod";
        public const string BenefitFrequency = "BenefitFrequency";

        public const string PayCodeType = "PayCodeType";
        public const string PayCodePeriod = "PayCodePeriod";

        public const string ECEmploymentType = "ECEmploymentType";
        public const string ECTicketClass = "ECTicketClass";
        public const string ECTicketPeriod = "ECTicketPeriod";

        public const string CallStatus = "CallStatus";
        public const string CallValidation = "CallValidation";
        public const string Checklist = "Checklist";
        public const string TransactionType = "TransactionType";
        public const string OtherCodes = "OtherCodes";

        public const string DaysRounding = "DaysRounding";
        public const string GrtBasedOn = "GrtBasedOn";
        public const string GrtSalaryOptions = "GrtSalaryOptions";
        public const string AttFileType = "AttFileType";
        public const string AttFileName = "AttFileName";
 
        public const string AttDateFormat = "AttDateFormat";

        public const string MaritalStatus = "MaritalStatus";
        public const string BloodGroup = "BloodGroup";
        public const string Location = "Location";
        public const string VisaType = "VisaType";
        public const string VisaProfession = "VisaProfession";
        public const string CountryCategory = "CountryCategory";
        public const string CountryGroup = "CountryGroup";
        public const string EmployeeStatus = "EmployeeStatus";
        public const string EmployeeAddress = "EmployeeAddress";
        public const string DataEntryStyle = "DataEntryStyle";

        public const string CalenderShift = "CalenderShift";
        public const string BatchFrequency = "BatchFrequency";
        public const string BatchOrigin = "BatchOrigin";
        public const string LeaveEntryType = "LeaveEntryType";
        public const string Priority = "Priority";
        public const string IncidentStatus = "IncidentStatus";
        public const string TicketClass = "TicketClass";
        public const string LoanType = "LoanType";
        public const string RoundingInstallment = "RoundingInstallment";
        public const string ContributionType = "ContributionType";
public const string ColumnType = "ColumnType";
        public const string RolePermission = "RolePermission";
        public const string KeyModules = "KeyModules";

        public const string sp_User_Insert_LeaveResumption = "sp_User_Insert_LeaveResumption";
    }
    #endregion

    #region DDL
    public static class DDL
    {
        public const string Code = "Code";
        public const string BudgetCode = "BudgetCode";
        public const string Description = "Description";
        public const string Text = "Text";
        public const string Test_WithCount = "Test_WithCount";
        public const string Value = "Value";
        public const string SalesRegionID = "SalesRegionID";
        public const string ID = "ID";
        public const string firstname= "frstname";
        public const string Fname = "Fname";
        public const string requisitiontype = "requisitiontype";
        public const string EmployeeID = "EmployeeID";
        public const string FullName= "FullName";

    }
    #endregion

    #region Numbers
    public static class Numbers
    {
        public const sbyte MINUS_ONE = -1;
        public const byte ZERO = 0;
        public const byte ONE = 1;
        public const byte TWO = 2;
        public const byte THREE = 3;
        public const byte FOUR = 4;
        public const byte FIVE = 5;
        public const byte SIX = 6;
        public const byte SEVEN = 7;
        public const byte EIGHT = 8;
        public const byte NINE = 9;
        public const byte TEN = 10;
        public const byte ELEVEN = 11;
        public const byte TWELVE = 12;
        public const byte THIRTEEN = 13;
        public const byte FOURTEN = 14;
        public const byte FIFTEEN = 15;
        public const byte SIXTEN = 16;
        public const byte SEVENTEN = 17;
        public const byte EIGHTEEN = 18;
        public const byte NINTEEN = 19;
        public const byte TWENTY = 20;
        public const byte TWENTYONE = 21;
        public const byte TWENTYTWO = 22;
        public const byte TWENTYTHREE = 23;
        public const byte TWENTYFOUR = 24;
        public const byte TWENTYFIVE = 25;
        public const byte TWENTYSEVEN = 27;
        public const byte TWENTYEIGHT = 28;
        public const byte TWENTYNINE = 29;
        public const byte THIRTY = 30;
    }
    #endregion

    #region General
    public static class General
    {
        //Date String Format
        public const string DateTime_AMPM = "MM/dd/yyyy h:m:s tt";

        //Common Table Columns
        public const string EmptyString = "";
        public const string EmptyReadOnlyLabel = "          -          ";
        public const string Space = " ";
        public const string Dash = "-";
        public const string BR = "<br \\>";
        public const char UNDER_SCORE = '_';
        private static DateTime minDateField = new DateTime(1900, 1, 1);
        public static DateTime MIN_DATE
        {
            get { return minDateField; }
        }
        public static string Please_Choose = "Please Choose";
        public static string ALL = "ALL";
        public static string AboveNet = "AboveNet";
        //public static string MYSELF = "[MYSELF]";

        public const string TBA = "To Be Assigned";
        public const string NA = "Not Available";
        public const string INTERNAL = "Internal";

        public static string True = "True";
        public static string False = "False";

        public static string Yes = "Yes";
        public static string No = "No";

        public static string Y = "Y";
        public static string N = "N";

        public static string Existing = "Existing";
        public static int MaximumFileSizeLimit = 4194304;
        public static string Admin_LogInID = "9999";
        public static int Total_KB_In_MB = 1024;

        public static string NetworkConfiguration_ID = "PointToPoint";
        public static string NetworkConfiguration_Desc = "Point To Point";

        public static string READONLY = "readonly";
        public static string LINE_BREAK = "<br>";
        public static string SERVICESTATUS = "Service Status";
    }
    #endregion

    #region Dates
    public static class Dates
    {
        public static DateTime NULL_DATE = Convert.ToDateTime("1900-01-01");
        public static DateTime NULL_DATETime = Convert.ToDateTime("1900-01-01 12:00");
    }
    #endregion

    #region Constants
    public static class Constants
    {
        public const string MarkAsFinal = "Marked as Final";
        public const string PreHiring = "Pre Hiring";
        public const string PostHiring = "Post Hiring";
        public const string Database = "Database";
        public const string GoogleDrive = "Google Drive";
        public const string OneDrive = "One Drive";
    }
    #endregion

}