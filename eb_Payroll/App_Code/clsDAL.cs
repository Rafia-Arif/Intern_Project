using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for clsDAL
/// </summary>
public class clsDAL
{
	public clsDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    // Functions for the product database//

    public static void InsertErrorLogs(string PageTitle, string FunctionName, int LineNo, string OrignalException,
        string MsgDisplayed, string Comments, DateTime RecCreatedOn, string RecCreatedBy)
    {
        try
        {
            Hashtable ht_parameters = new Hashtable();
            ht_parameters["@PageTitle"] = PageTitle;
            ht_parameters["@FunctionName"] = FunctionName;
            if (LineNo > 0)
            {
                ht_parameters["@LineNo"] = LineNo;
            }
            ht_parameters["@OrignalException"] = OrignalException;
            ht_parameters["@MsgDisplayed"] = MsgDisplayed;
            ht_parameters["@Comments"] = Comments;
            ht_parameters["@RecCreatedOn"] = RecCreatedOn;
            ht_parameters["@RecCreatedBy"] = RecCreatedBy;
            clsDAL.ExecuteNonQuery("sp_Payroll_Insert_ErrorLog", ht_parameters);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static DataSet GetDataSet(string Select_Command)
    {
        try
        {
            SqlDataAdapter objDA = new SqlDataAdapter(Select_Command, ConfigurationManager.ConnectionStrings["connection"].ConnectionString);

            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static DataSet GetDataSet(string Command, Hashtable hsh_Parameters)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
            if (HttpContext.Current.Session["_ConStr"].ToString() != "")
            {
                constr = HttpContext.Current.Session["_ConStr"].ToString();
            }
            SqlDataAdapter objDA = new SqlDataAdapter(Command, constr);
            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objDA.SelectCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static object ExecuteScalar(string Command, Hashtable hsh_Parameters)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteScalar();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static object ExecuteScalar(string Command)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);

        try
        {
            objConnection.Open();
            return objCommand.ExecuteScalar();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static SqlDataReader ExecuteReaderWithCommand(string Command)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);

        try
        {
            objConnection.Open();
            return (objCommand.ExecuteReader(CommandBehavior.CloseConnection));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
        }
    }

    public static int ExecuteNonQuery(string Command)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);

        try
        {
            objConnection.Open();
            return objCommand.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static int ExecuteNonQuery_License(string Command, Hashtable hsh_Parameters)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["eblicenseconnectionstringname"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static int ExecuteNonQuery(string Command, Hashtable hsh_Parameters)
    {
        //SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static object ExecuteNonQuery(string Command, Hashtable hsh_Parameters, string outParamName, SqlDbType type4outParam, int size4OutParam)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objCommand.Parameters[outParamName].SqlDbType = type4outParam;
            if (size4OutParam >0)
            {
                objCommand.Parameters[outParamName].Size = 255;
                objCommand.Parameters[outParamName].Direction = ParameterDirection.Output;
            }
            objConnection.Open();
            objCommand.ExecuteNonQuery();

            return objCommand.Parameters[outParamName].Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }







// Functions for the eb_Central Databases


    public static DataSet GetDataSet_admin(string Select_Command)
    {
        try
        {

            string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
           

            SqlDataAdapter objDA = new SqlDataAdapter(Select_Command, constr);

            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static DataSet GetDataSet_admin(string Command, Hashtable hsh_Parameters)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
            if (HttpContext.Current.Session["_ConStr"].ToString() != "")
            {
                constr = HttpContext.Current.Session["_ConStr"].ToString();
            } 
            
            SqlDataAdapter objDA = new SqlDataAdapter(Command, constr);
            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objDA.SelectCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static int ExecuteNonQuery_payroll(string Command, Hashtable hsh_Parameters)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }

        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }


    public static object ExecuteNonQuery_payroll(string Command, Hashtable hsh_Parameters, string outParamName, SqlDbType type4outParam, int size4OutParam)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }

        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objCommand.Parameters[outParamName].SqlDbType = type4outParam;
            if (size4OutParam > 0)
                objCommand.Parameters[outParamName].Size = size4OutParam;
            objCommand.Parameters[outParamName].Direction = ParameterDirection.Output;

            objConnection.Open();
            objCommand.ExecuteNonQuery();

            return objCommand.Parameters[outParamName].Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static DataSet GetDataSet_Payroll(string Command, Hashtable hsh_Parameters)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
            if (HttpContext.Current.Session["_ConStr"].ToString() != "")
            {
                constr = HttpContext.Current.Session["_ConStr"].ToString();
            }

            SqlDataAdapter objDA = new SqlDataAdapter(Command, constr);
            
            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objDA.SelectCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static DataSet GetDataSet_Payroll(string Command, Hashtable hsh_Parameters, string ConnectionStr)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;

            if (ConnectionStr != "")
            {
                constr = ConnectionStr;
            }
            SqlDataAdapter objDA = new SqlDataAdapter(Command, constr);

            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objDA.SelectCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
 public static DataSet GetDataSet_License(string Command, Hashtable hsh_Parameters)
    {
        try
        {
            SqlDataAdapter objDA = new SqlDataAdapter(Command, ConfigurationManager.ConnectionStrings["eb_licenseconnectionstringname"].ConnectionString);
            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objDA.SelectCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static DataSet GetDataSet_Payroll(string Command)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
            if (HttpContext.Current.Session["_ConStr"].ToString() != "")
            {
                constr = HttpContext.Current.Session["_ConStr"].ToString();
            }
            SqlDataAdapter objDA = new SqlDataAdapter(Command, ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString);
            objDA.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
            DataSet objDS = new DataSet();
            objDA.Fill(objDS);
            return (objDS);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public static object ExecuteScalar_admin(string Command, Hashtable hsh_Parameters)
    {
        //SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString);
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteScalar();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static object ExecuteScalar_admin(string Command)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);

        try
        {
            objConnection.Open();
            return objCommand.ExecuteScalar();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }

    public static SqlDataReader ExecuteReaderWithCommand_admin(string Command)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);

        try
        {
            objConnection.Open();
            return (objCommand.ExecuteReader(CommandBehavior.CloseConnection));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
        }
    }

    public static int ExecuteNonQuery_admin(string Command)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        
        try
        {
            objConnection.Open();
            return objCommand.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }


    public static void ExecuteNonQuery_admin(string Command,string app,string fromm,int linenumber,string executemethod,string hskey,string hsvalue,string userid,string filename )
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {


            objCommand.Parameters.AddWithValue("@app", app.ToString());
            objCommand.Parameters.AddWithValue("@fromm", fromm.ToString());
            objCommand.Parameters.AddWithValue("@linenumber", linenumber.ToString());

            objCommand.Parameters.AddWithValue("@executemethod", executemethod.ToString());

            objCommand.Parameters.AddWithValue("@hashkey", hskey.ToString());
            objCommand.Parameters.AddWithValue("@hashvalue", hsvalue.ToString());
            objCommand.Parameters.AddWithValue("@userid", userid.ToString());
            objCommand.Parameters.AddWithValue("@datetime", System.DateTime.Now);
            objCommand.Parameters.AddWithValue("@filename", filename);


          

            objConnection.Open();
            objCommand.ExecuteNonQuery();


        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }



    public static int ExecuteNonQuery_admin(string Command, Hashtable hsh_Parameters)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }
    public static object ExecuteNonQuery_admin(string Command, Hashtable hsh_Parameters, string outParamName, SqlDbType type4outParam, int size4OutParam)
    {

        string constr = ConfigurationManager.ConnectionStrings["eb_central"].ConnectionString;
        if (HttpContext.Current.Session["_ConStr"].ToString() != "")
        {
            constr = HttpContext.Current.Session["_ConStr"].ToString();
        }
        SqlConnection objConnection = new SqlConnection(constr);
        
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objCommand.Parameters[outParamName].SqlDbType = type4outParam;
            if (size4OutParam > 0)
                objCommand.Parameters[outParamName].Size = size4OutParam;
            objCommand.Parameters[outParamName].Direction = ParameterDirection.Output;

            objConnection.Open();
            objCommand.ExecuteNonQuery();

            return objCommand.Parameters[outParamName].Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }


    public static int ExecuteNonQuery_payroll(string Command, Hashtable hsh_Parameters, string ConnectionStr)
    {
        //SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString);
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (ConnectionStr != "")
        {
            constr = ConnectionStr;
        }
        SqlConnection objConnection = new SqlConnection(constr);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objConnection.Open();
            return objCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }


   

   
    public static object ExecuteNonQuery_payroll(string Command, Hashtable hsh_Parameters, string outParamName, SqlDbType type4outParam, int size4OutParam, string ConnectionStr)
    {
        string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
        if (ConnectionStr != "")
        {
            constr = ConnectionStr;
        }

        SqlConnection objConnection = new SqlConnection(constr);
        //SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objCommand.Parameters[outParamName].SqlDbType = type4outParam;
            if (size4OutParam > 0)
                objCommand.Parameters[outParamName].Size = size4OutParam;
            objCommand.Parameters[outParamName].Direction = ParameterDirection.Output;

            objConnection.Open();
            objCommand.ExecuteNonQuery();

            return objCommand.Parameters[outParamName].Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }


    public static object ExecuteNonQuery_master(string Command, Hashtable hsh_Parameters, string outParamName, SqlDbType type4outParam, int size4OutParam)
    {
        SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["master"].ConnectionString);
        SqlCommand objCommand = new SqlCommand(Command, objConnection);
        objCommand.CommandType = CommandType.Text;

        try
        {
            if (hsh_Parameters != null)
            {
                IDictionaryEnumerator obj_Enm = hsh_Parameters.GetEnumerator();
                while (obj_Enm.MoveNext())
                {
                    objCommand.Parameters.AddWithValue(obj_Enm.Key.ToString(), obj_Enm.Value);
                }
            }

            objCommand.Parameters[outParamName].SqlDbType = type4outParam;
            if (size4OutParam > 0)
                objCommand.Parameters[outParamName].Size = size4OutParam;
            objCommand.Parameters[outParamName].Direction = ParameterDirection.Output;

            objConnection.Open();
            objCommand.ExecuteNonQuery();

            return objCommand.Parameters[outParamName].Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (objCommand != null)
            {
                objCommand.Dispose();
            }
            if (!(objConnection.State == ConnectionState.Closed))
            {
                objConnection.Close();
            }
        }
    }





}
