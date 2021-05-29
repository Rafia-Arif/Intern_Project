using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.IO;
using System.Diagnostics;
using System.Text;
using System.Xml.Serialization;

[Serializable()]
public enum LogType
{
    Html = 0,
    Text = 1,
    EventLog = 2
};

[Serializable()]
public class Logger
{

    #region Data Members
    // variable to hold Line break charater, 
    //Its value will depend upon type of logging choosed by user 
    private static string m_lineBreak = "<br>";
    // Constant used for event logging...
    private const string EVENT_SOURCE = "NPA";
    private const string EVENT_LOG_NAME = "eBiz.NPA-Error";
    private const string ERROR_LOG_FILENAME = "Error.txt";
    private const string ARCHIEVE_FILENAME = "ErrorArchieve.txt";
    private const short FILE_SIZE = (5120); // 5 MB
    // Enum defining log Types, where message can be written



    #endregion


    public Logger()
    {

    }


    #region Error Message Construction Functions

    /// <summary>
    ///		Build string containing error details 
    /// </summary>
    /// <param name="ex">Exception from which string is to be build </param>
    /// <returns>
    ///		Last Updated : 01/07/2010
    ///		Author		 : ZA
    ///		Notes		 : 
    /// </returns>

    private static string GetErrorMessage(Exception ex)
    {

        StringBuilder errorMessage = new StringBuilder(300);

        errorMessage.Append("-------------------------------------------------------------" + m_lineBreak);
        errorMessage.Append(" Exception Occured at : " + DateTime.Now + m_lineBreak);
        errorMessage.Append("Type :" + ex.GetType() + m_lineBreak);
        errorMessage.Append("Original Message : " + ex.Message + m_lineBreak);
        errorMessage.Append("Source :" + ex.Source + m_lineBreak);
        errorMessage.Append("Stack Trace :" + ex.StackTrace + m_lineBreak);
        errorMessage.Append(GetFileDetails(ex));
        if (ex.InnerException != null)
        {
            Exception innerError = ex.InnerException;
            errorMessage.Append("Inner Exception Message is :" + innerError.Message + m_lineBreak);
            errorMessage.Append("Inner Exception Stack Trace is :" + innerError.StackTrace + m_lineBreak);
            errorMessage.Append(GetFileDetails(ex.InnerException));

        }

        errorMessage.Append("-------------------------------------------------------------" + m_lineBreak);
        return errorMessage.ToString();


    }

    /// <summary>
    ///		Get File Name, Line No on which exception occured..
    /// </summary>
    /// <param name="ex">Exception  </param>
    /// <returns>
    ///		String containg file and line info on which exception occured, if available.
    /// </returns>
    /// <remarks>
    ///		Last Updated : 01/07/2010
    ///		Author		 : IM
    /// </remarks>

    private static string GetFileDetails(Exception ex)
    {
        string lineNo = "", fileName = "", errorMessage = "";
        StackTrace stockTrace = new StackTrace(ex, true);
        for (int i = 0; i < stockTrace.FrameCount; i++)
        {
            if (stockTrace.GetFrame(i).GetFileName() != null)
            {
                lineNo = stockTrace.GetFrame(i).GetFileLineNumber().ToString();
                fileName = stockTrace.GetFrame(i).GetFileName();
                break;
            }
        }


        if (fileName != "")
        {
            errorMessage = "File Name : " + fileName + m_lineBreak;
            errorMessage += "Line No   : " + lineNo + m_lineBreak;

        }
        return errorMessage;

    }

    #endregion


    #region Log Error Functions
    /// <summary>
    ///		Log error Message
    /// </summary>
    /// <param name="errorMessage">String which is to be appended to log file</param>
    /// <remarks>
    ///		Last Updated : 01/07/2010
    ///		Author		 : IM
    ///		
    /// </remarks>

    public static void LogError(string errorMessage)
    {

        m_lineBreak = GetLineBreakCharacter();
        string message = "--------------------------------------------------------" + m_lineBreak;
        message += "Recording message at " + DateTime.Now + m_lineBreak;
        message += errorMessage;
        message += "---------------------------------------------------------------" + m_lineBreak;
        WriteMessage(message);

    }



    /// <summary>
    ///		Logs error detail 
    /// </summary>
    /// <param name="ex">Excedption which is to be logged </param>
    /// <remarks>
    ///		Last Updated : 01/07/2010
    ///		Author		: IM
    /// </remarks>
    public static void LogError(Exception ex)
    {

        try
        {
            // Get Appropriate Line Break Character according to Logging Type

            
            /*Comment the below code to upload to Azure*/

            //  m_lineBreak = GetLineBreakCharacter();
            //  WriteMessage(GetErrorMessage(ex));
        
        }
        catch (Exception)
        {

            throw;
        }

    }

    #endregion


    #region Write Message Functions
    /// <summary>
    ///		Call Appropriate method to write error message, depending upon 
    ///		log type 
    /// </summary>
    /// <param name="message">
    ///		String which is to be appended to log file..
    /// </param>
    /// <remarks>
    ///		Last Updated : 04/19/2006
    ///		Author		 : IM
    /// </remarks>
    public static void WriteMessage(string message)
    {

        LogType type = LocalLogType;
        /*Comment the below code to upload to Azure*/
/*
        switch (type)
        {
            case LogType.Html:
                WriteToFile(message);
                break;
            case LogType.EventLog:
                WriteToEventLog(message);
                break;
            default:
                WriteToFile(message);
                break;
        }
        */
    }


    /// <summary>
    ///		Append error message to file..
    /// </summary>
    /// <param name="message">error message string which is to be appended </param>
    /// <remarks>
    ///		Last Updated : 04/19/2006
    ///		Author		 : IM
    ///		Notes		 : This method is used for writing of html file as well as text file...
    /// </remarks>
    private static void WriteToFile(string message)
    {
       /*Comment the below code to upload to Azure*/
        StreamWriter writer = null;
        string filePath =   ErrorLogDirectoryPath;
        filePath = filePath   + @"\" + ERROR_LOG_FILENAME;
        // Lets find directory path..
        string dirPath = filePath.Substring(0, filePath.LastIndexOf("\\"));
        if (!Directory.Exists(dirPath))
        {
            Directory.CreateDirectory(dirPath);
        }
        try
        {
            setFileArchive(filePath);
            FileStream fileStream = new FileStream(filePath, FileMode.OpenOrCreate, FileAccess.Write);
            writer = new StreamWriter(fileStream);
            writer.BaseStream.Seek(0, SeekOrigin.End);
            // Force the write to the underlying file
            writer.WriteLine(message);
            writer.Flush();
        }
        finally
        {
            if (writer != null)
            {
                writer.Close();

            }
        }
    }
    private static void setFileArchive(string filePath)
    {
        try
        {
            //string filePath = UtilConstants.clsConstants.sErrorLogFilePath;
            string sArchivePath;
            sArchivePath = ErrorLogDirectoryPath + @"\" + ARCHIEVE_FILENAME;

            //long iFileSize = Convert.ToInt64(oCommon.GetDataFromXMLConfig("ErrorLogFileSize", UtilConstants.clsConstants.sAgentConfigFilePath));
            // Changed by Khalid: Jan-28-2008 

            if (File.ReadAllBytes(filePath).Length > FILE_SIZE * 1000)
            {
                File.Copy(filePath, sArchivePath, true);
                File.Delete(filePath);
            }
        }
        catch (Exception ex)
        {
            // Logger.WriteMessage(ex.Message); 
        }
    }

    public static void WriteObject(Object obj, Type type)
    {


        TextWriter writer = null;
        string dirPath = ErrorLogDirectoryPath;
        try
        {

            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }

            try
            {
                XmlSerializer serializer = new XmlSerializer(type);
                //string filePath=dirPath+"\\"+type.Name+".xml" ;
                string filePath = dirPath + "\\" + DateTime.Now.Hour + "-" + type.Name + ".xml";
                writer = new StreamWriter(filePath);
                //writer.BaseStream.Seek(0, SeekOrigin.End); 
                serializer.Serialize(writer, obj);
            }
            finally
            {
                if (writer != null)
                {
                    writer.Close();
                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }






    /// <summary>
    ///		Log Error message in event log
    /// </summary>
    /// <param name="message">error message string which is to be written </param>
    /// <remarks>
    ///		Last Updated : 04/19/2006
    ///		Author		 : IM
    ///		Notes		 : By default, asp.net worker process dont have premissions to write to event log
    ///					 To solve this problem: 
    ///					  1) Open regedit32 
    ///					  2) Move To HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\EventLog
    ///					  3) Click on "Security-->Permissions..." in the menu. and give Full Control 
    ///					     to aps.net worker process
    ///		
    ///		
    /// </remarks>
    public static void WriteToEventLog(string message)
    {

        if (!EventLog.SourceExists(EVENT_SOURCE))
        {
            EventLog.CreateEventSource(EVENT_SOURCE, EVENT_LOG_NAME);
        }
        EventLog log = new EventLog();
        log.Source = EVENT_LOG_NAME;
        log.WriteEntry(message, EventLogEntryType.Error);

    }

    #endregion

    #region Get LineBreak Character
    /// <summary>
    ///		Get line break chacters depending upon logging type
    /// </summary>
    /// <returns>
    ///		Line Break Character
    /// </returns>
    /// <remarks>
    ///		Last Updated : 04/19/2006
    ///		Author		 : IM
    /// </remarks>
    private static string GetLineBreakCharacter()
    {
        string lineBreak = "";
        LogType type = LocalLogType;
        switch (type)
        {
            case LogType.Html:
                lineBreak = "<br>";
                break;
            case LogType.EventLog:
                lineBreak = "";
                break;
            default:
                lineBreak = "\n";
                break;
        }
        return lineBreak;

    }

    #endregion

    #region Logging Common Utils
    private static string locallogtype = System.Configuration.ConfigurationManager.AppSettings["LocalLogType"].ToString();
    private static LogType LocalLogType
    {
        get
        {
            if (locallogtype == null)
            {
                return LogType.EventLog;
            }
            return (LogType)System.Enum.Parse(typeof(LogType), locallogtype);
        }
    }

    public static string GetExecutingDirectory()
    {
        return HttpRuntime.AppDomainAppPath;
    }

    private static string errorlogdirectorypath = GetExecutingDirectory();

    //private static string errorlogdirectorypath = System.Configuration.ConfigurationManager.AppSettings["ErrorLogDirectoryPath"].ToString();
    public static string ErrorLogDirectoryPath
    {
        get
        {
            if (!Directory.Exists(errorlogdirectorypath))
            {
                Directory.CreateDirectory(errorlogdirectorypath);
            }
            return errorlogdirectorypath;
        }
    }
    #endregion

}