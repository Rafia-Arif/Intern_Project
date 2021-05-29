using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Download;
using Google.Apis.Drive.v3;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.IO;
using System.Threading;
using Google.Apis.Auth.OAuth2.Flows;
using Google.Apis.Auth.OAuth2.Responses;
using System.Security.Cryptography.X509Certificates;
using System.Collections;
using System.Data;
using System.Diagnostics;

/// <summary>
/// Summary description for clsGoogleDriveFiles
/// </summary>
public class clsGoogleDriveFiles
{
    public string Id { get; set; }
    public string Name { get; set; }
    public long? Size { get; set; }
    public long? Version { get; set; }
    public DateTime? CreatedTime { get; set; }
    public IList<string> Parents { get; set; }

    public clsGoogleDriveFiles()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}

/// <summary>
/// Summary description for clsGoogleDriveFilesRepository
/// </summary>
public class clsGoogleDriveFilesRepository
{
	public clsGoogleDriveFilesRepository()
	{
		//
		// TODO: Add constructor logic here
		//
	}
   
    public static string RootFolderId = "";
    public static string FolderId = "";

    //create Drive API service.
    public static DriveService GetService(string FolderName)
    {
        byte[] keyp12;

        Hashtable htnew = new Hashtable();
        htnew["@UserName"] = HttpContext.Current.Session["_UserAPP"].ToString();
        htnew["@FolderName"] = FolderName;
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_GDriveConnectionParameters", htnew).Tables[0];
        
        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dt.Rows[0]["keyp12"].ToString()) &&
                !string.IsNullOrEmpty(dt.Rows[0]["gdrootfolderid"].ToString())
                )
            {
                keyp12 = (byte[])dt.Rows[0]["keyp12"];// .p12 file
                RootFolderId = dt.Rows[0]["gdrootfolderid"].ToString();//drive starting folder 
            }
            else
            {
                //Console.WriteLine("An Error occurred - Key file does not exist");
                clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService", 0, null,
                            null, "ERROR: Key file, service account or root folder id missing in data base", DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
                return null;
            }
        }
        else
        {
            //Console.WriteLine("An Error occurred - Key file does not exist");
            clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService", 0, null,
                            null, "ERROR: Company record missing in data base", DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
            return null;
        }

        string[] scopes = new string[] { DriveService.Scope.Drive };     // View analytics data            

        try
         {
            var stream = new MemoryStream(keyp12);

            var credential = GoogleCredential.FromStream(stream);
            credential = credential.CreateScoped(scopes);

            // Create the service.
            DriveService service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "GoogleDriveRestAPI-v3",
            });
            return service;
        }
        catch (Exception ex)
        {
            //Console.WriteLine(ex.InnerException);
            // Get stack trace for the exception with source file information
            var st = new StackTrace(ex, true);
            // Get the top stack frame
            var frame = st.GetFrame(st.FrameCount - 1);
            // Get the line number from the stack frame
            var ErrorlineNo = frame.GetFileLineNumber();
            clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService", ErrorlineNo, ex.Message,
                            null, null, DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
            return null;
        }
    }



    //create Drive API service with the credentials saved with the file.
    public static DriveService GetService4ExistingFiles(string FileId, string FolderName)
    {
        byte[] keyp12;

        Hashtable htnew = new Hashtable();
        htnew["@FileId"] = FileId;
        htnew["@FolderName"] = FolderName;
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_GDriveCredentialsFromAttachments", htnew).Tables[0];

        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dt.Rows[0]["keyp12"].ToString()))
            {
                keyp12 = (byte[])dt.Rows[0]["keyp12"];
            }
            else
            {
                //Console.WriteLine("An Error occurred - Key file does not exist");
                clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService4ExistingFiles", 0, null,
                            null, "ERROR: Key file or service account missing in data base", DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
                return null;
            }
        }
        else
        {
            //Console.WriteLine("An Error occurred - Key file does not exist");
            clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService4ExistingFiles", 0, null,
                            null, "ERROR: File record missing in data base", DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
            return null;
        }

        string[] scopes = new string[] { DriveService.Scope.Drive };     // View analytics data            

        
        try
        {
            var stream = new MemoryStream(keyp12);

            var credential = GoogleCredential.FromStream(stream);
            credential = credential.CreateScoped(scopes);

            // Create the service.
            DriveService service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "GoogleDriveRestAPI-v3",
            });
            return service;
        }
        catch (Exception ex)
        {
            //Console.WriteLine(ex.InnerException);
            // Get stack trace for the exception with source file information
            var st = new StackTrace(ex, true);
            // Get the top stack frame
            var frame = st.GetFrame(st.FrameCount - 1);
            // Get the line number from the stack frame
            var ErrorlineNo = frame.GetFileLineNumber();
            clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "GetService4ExistingFiles", ErrorlineNo, ex.Message,
                            null, null, DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
            return null;
        }
    }

    //get all files from Google Drive.
    public static List<clsGoogleDriveFiles> GetDriveFiles(string FolderName)
    {
        DriveService service = GetService(FolderName);
        List<clsGoogleDriveFiles> FileList = new List<clsGoogleDriveFiles>();

        if (service != null)
        {
            // define parameters of request.
            FilesResource.ListRequest FileListRequest = service.Files.List();

            //listRequest.PageSize = 10;
            //listRequest.PageToken = 10;
            FileListRequest.Fields = "nextPageToken, files(id, name, size, version, createdTime, parents)";

            //get file list.
            IList<Google.Apis.Drive.v3.Data.File> files = FileListRequest.Execute().Files;

            if (files != null && files.Count > 0)
            {
                foreach (var file in files)
                {
                    if (file.Parents != null)
                    {
                        if (file.Parents[0].ToString() == FolderId)
                        {
                            clsGoogleDriveFiles File = new clsGoogleDriveFiles
                            {
                                Id = file.Id,
                                Name = file.Name,
                                Size = file.Size,
                                Version = file.Version,
                                CreatedTime = file.CreatedTime,
                                Parents = file.Parents
                            };
                            FileList.Add(File);
                        }
                    }
                }
            }
        }
        return FileList;
    }

    //get folder Id from Google Drive.
    public static void GetFolderId(string FolderName, DriveService service)
    {
        List<clsGoogleDriveFiles> FileList = new List<clsGoogleDriveFiles>();

        if (service != null)
        {
            // define parameters of request.
            FilesResource.ListRequest FileListRequest = service.Files.List();

            //listRequest.PageSize = 10;
            //listRequest.PageToken = 10;
            FileListRequest.Fields = "nextPageToken, files(id, name, size, version, createdTime, parents, mimeType)";
            FileListRequest.Q = "mimeType = 'application/vnd.google-apps.folder'";

            //get file list.
            IList<Google.Apis.Drive.v3.Data.File> files = FileListRequest.Execute().Files;

            if (files != null && files.Count > 0)
            {
                foreach (var file in files)
                {
                    string mim = file.MimeType;
                    if (file.Parents != null)
                    {
                        if (file.Parents[0].ToString() == RootFolderId && file.MimeType == "application/vnd.google-apps.folder" && file.Name == FolderName)
                        {
                            FolderId = file.Id;
                            break;
                        }
                    }
                }
            }
        }
        //return FileList;
    }

    // to create new folder 
    public static string CreateFolder(DriveService service, string FolderName)
    {
        Google.Apis.Drive.v3.Data.File FileMetaData = new Google.Apis.Drive.v3.Data.File();
        FileMetaData.Name = FolderName;
        FileMetaData.MimeType = "application/vnd.google-apps.folder";
        FileMetaData.Parents = new List<string>
                    {
                        RootFolderId
                    };
        Google.Apis.Drive.v3.FilesResource.CreateRequest request;

        request = service.Files.Create(FileMetaData);
        request.Fields = "id";
        var file = request.Execute();
        //var ufile = request.ResponseBody;
        string id = file.Id;

        //Hashtable ht1 = new Hashtable();
        //ht1["@UserName"] = HttpContext.Current.Session["_UserAPP"].ToString();
        //ht1["@FolderId"] = id;
        //ht1["@FolderName"] = FolderName;
        //clsDAL.ExecuteNonQuery("sp_User_Insert_FolderId", ht1);

        return id;
    }

    //file Upload to the Google Drive.
    public static string FileUpload(Telerik.Web.UI.UploadedFile file, string FolderName)
    {
        string UploadedFileId = "";
        //if (file != null && file.ContentLength > 0)
        if (file != null)
        {
            DriveService service = GetService(FolderName);

            if (service != null)
            {
                try
                {
                    GetFolderId(FolderName, service);
                    if (string.IsNullOrEmpty(FolderId))
                    {
                        FolderId = CreateFolder(service, FolderName);
                    }
                    string path = Path.Combine(HttpContext.Current.Server.MapPath("~/GoogleDriveFiles"),
                    Path.GetFileName(file.FileName));
                    file.SaveAs(path);

                    var FileMetaData = new Google.Apis.Drive.v3.Data.File();
                    FileMetaData.Name = Path.GetFileName(file.FileName);
                    FileMetaData.MimeType = MimeMapping.GetMimeMapping(path);
                    FileMetaData.Parents = new List<string>
                    {
                        FolderId
                    };
                    FilesResource.CreateMediaUpload request;

                    using (var stream = new System.IO.FileStream(path, System.IO.FileMode.Open))
                    {
                        request = service.Files.Create(FileMetaData, stream, FileMetaData.MimeType);
                        request.Fields = "id";
                        request.Upload();
                    }
                    var ufile = request.ResponseBody;
                    if (ufile != null)
                    {
                        UploadedFileId = ufile.Id;
                    }
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                    }

                }
                catch (Exception ex)
                {
                    //Console.WriteLine(ex.InnerException);
                    // Get stack trace for the exception with source file information
                    var st = new StackTrace(ex, true);
                    // Get the top stack frame
                    var frame = st.GetFrame(st.FrameCount - 1);
                    // Get the line number from the stack frame
                    var ErrorlineNo = frame.GetFileLineNumber();


                    clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "FileUpload", ErrorlineNo, ex.Message,
                                    null, null, DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
                    
                    return UploadedFileId;
                }
            }
        }
        return UploadedFileId;
    }

    //Download file from Google Drive by fileId.
    public static string DownloadGoogleFile(string fileId, string FolderName)
    {
        string FilePath = "";
        DriveService service = GetService4ExistingFiles(fileId, FolderName);
        if (service != null)
        {
            try
            {
                string FolderPath = System.Web.HttpContext.Current.Server.MapPath("~/GoogleDriveFiles/");
                FilesResource.GetRequest request = service.Files.Get(fileId);

                string FileName = request.Execute().Name;
                FilePath = System.IO.Path.Combine(FolderPath, FileName);

                MemoryStream stream1 = new MemoryStream();

                // Add a handler which will be notified on progress changes.
                // It will notify on each chunk download and when the
                // download is completed or failed.
                request.MediaDownloader.ProgressChanged += (Google.Apis.Download.IDownloadProgress progress) =>
                {
                    switch (progress.Status)
                    {
                        case DownloadStatus.Downloading:
                            {
                                //Console.WriteLine(progress.BytesDownloaded);
                                break;
                            }
                        case DownloadStatus.Completed:
                            {
                                //Console.WriteLine("Download complete.");
                                SaveStream(stream1, FilePath);
                                break;
                            }
                        case DownloadStatus.Failed:
                            {
                                //Console.WriteLine("Download failed.");
                                break;
                            }
                    }
                };
                request.Download(stream1);
            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.InnerException);
                // Get stack trace for the exception with source file information
                var st = new StackTrace(ex, true);
                // Get the top stack frame
                var frame = st.GetFrame(st.FrameCount - 1);
                // Get the line number from the stack frame
                var ErrorlineNo = frame.GetFileLineNumber();
                clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "DownloadGoogleFile", ErrorlineNo, ex.Message,
                                null, null, DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
                    
                return FilePath;
            }
        }
        return FilePath;
    }

    // file save to server path
    private static void SaveStream(MemoryStream stream, string FilePath)
    {
        using (System.IO.FileStream file = new FileStream(FilePath, FileMode.Create, FileAccess.ReadWrite))
        {
            stream.WriteTo(file);
        }
    }

    //Delete file from the Google drive
    public static string DeleteFile(String fileId, string FolderName)
    {
        DriveService service = GetService4ExistingFiles(fileId, FolderName);
        if (service != null)
        {
            try
            {
                // Initial validation.
                if (service == null)
                    throw new ArgumentNullException("service");

                // Make the request.
                service.Files.Delete(fileId).Execute();
            }
            catch (Exception ex)
            {
                //throw new Exception("Request Files.Delete failed.", ex);
                // Get stack trace for the exception with source file information
                var st = new StackTrace(ex, true);
                // Get the top stack frame
                var frame = st.GetFrame(st.FrameCount - 1);
                // Get the line number from the stack frame
                var ErrorlineNo = frame.GetFileLineNumber();
                clsDAL.InsertErrorLogs("clsGoogleDriveFilesRepository", "DeleteFile", ErrorlineNo, ex.Message,
                                null, null, DateTime.Now, HttpContext.Current.Session["_UserAPP"].ToString());
                    
                return null;
            }
        }
        else
        {
            return null;
        }
        return fileId;
    }
}