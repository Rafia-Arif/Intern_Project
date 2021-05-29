using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI;

/// <summary>
/// Summary description for Util
/// </summary>
[Serializable()]
public static class Util
{
    /// <summary>
    /// This function loops through all rows in each table of provided dataset
    /// If dataset is null, or dataset does not has any table, or any table of dataset does not has atleast one row then
    /// function will return false.
    /// else function will return true.
    /// </summary>
    /// <param name="ds"></param>
    /// <returns></returns>
    public static bool ParseDataSet(DataSet ds)
    {
        if (ds == null || ds.Tables.Count < Constraints.Numbers.ONE)
        {
            return false;
        }

        for (int i = Constraints.Numbers.ZERO; i < ds.Tables.Count; i++)
        {
            if (ds.Tables[i].Rows.Count < Constraints.Numbers.ONE)
            {
                return false;
            }
        }
        return true;
    }

    public static bool ParseDataTable(DataTable dt)
    {
        if (dt == null)
        {
            if (dt.Rows.Count > 0)
            {
                return true;
            }
        }

        return false;
    }

    #region NullSafeFunction
    //****************************************************************
    // NullSafeString
    //****************************************************************
    public static string NullSafeString(this object arg, string returnIfEmpty = Constraints.General.EmptyString)
    {
        string returnValue = null;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = returnIfEmpty;
        }
        else
        {
            try
            {
                returnValue = Convert.ToString(arg).Trim();
            }
            catch
            {
                returnValue = returnIfEmpty;
            }

        }

        return returnValue;
    }

    //****************************************************************
    // NullSafeInteger
    //****************************************************************
    public static int NullSafeInteger(this object arg, int returnIfEmpty = Constraints.Numbers.ZERO)
    {
        int returnValue = 0;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = returnIfEmpty;
        }
        else
        {
            try
            {
                returnValue = Convert.ToInt32(arg);
            }
            catch
            {
                returnValue = returnIfEmpty;
            }
        }

        return returnValue;
    }

    //****************************************************************
    //   NullSafeDouble
    //****************************************************************
    public static double NullSafeDouble(this object arg, int returnIfEmpty = Constraints.Numbers.ZERO)
    {
        double returnValue = 0;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = returnIfEmpty;
        }
        else
        {
            try
            {
                returnValue = Convert.ToDouble(arg);
                if (returnValue.ToString() == System.Double.NaN.ToString())
                {
                    returnValue = returnIfEmpty;
                }
            }
            catch
            {
                returnValue = returnIfEmpty;
            }
        }

        return returnValue;
    }


    //****************************************************************
    //   NullSafeDecimal
    //****************************************************************
    public static decimal NullSafeDecimal(this object arg, int returnIfEmpty = Constraints.Numbers.ZERO)
    {
        decimal returnValue = 0;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = returnIfEmpty;
        }
        else
        {
            try
            {
                returnValue = Convert.ToDecimal(arg);
            }
            catch
            {
                returnValue = returnIfEmpty;
            }
        }

        return returnValue;
    }

    //****************************************************************
    //   NullSafeLong
    //****************************************************************
    public static long NullSafeLong(this object arg, long returnIfEmpty = Constraints.Numbers.ZERO)
    {
        long returnValue = 0;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = returnIfEmpty;
        }
        else
        {
            try
            {
                returnValue = Convert.ToInt64(arg);
            }
            catch
            {
                returnValue = returnIfEmpty;
            }
        }

        return returnValue;
    }


    //****************************************************************
    // NullSafeBoolean
    //****************************************************************
    public static bool NullSafeBoolean(this object arg)
    {
        bool returnValue = false;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = false;
        }
        else
        {
            try
            {
                returnValue = Convert.ToBoolean(arg);
            }
            catch
            {
                returnValue = false;
            }
        }

        return returnValue;

    }

    //****************************************************************
    // NullSafeDate
    //****************************************************************
    public static int getDateDiffByBuisnessDays(DateTime inDate, DateTime toDate)
    {
        int diffDays = toDate.Subtract(inDate).Days;
        int weekCount = diffDays / 7;
        int totalDiff = diffDays - (weekCount * 2); // subtract 2 days from every full week cycle 

        int remainder = diffDays % 7;
        int dayOfWeek = (int)inDate.DayOfWeek;
        if ((dayOfWeek + remainder) == 6)
            totalDiff -= 1;
        else if ((dayOfWeek + remainder) >= 7)
            totalDiff -= 2;

        return totalDiff;
    }
    public static DateTime NullSafeDate(this object arg)
    {
        DateTime returnValue = Constraints.Dates.NULL_DATE;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = Constraints.Dates.NULL_DATE;
        }
        else
        {
            try
            {
                returnValue = Convert.ToDateTime(arg);
                if (returnValue < Constraints.Dates.NULL_DATE)
                {
                    returnValue = Constraints.Dates.NULL_DATE;
                }
            }
            catch
            {
                returnValue = Constraints.Dates.NULL_DATE;
            }
        }

        return returnValue;
    }

    public static DateTime NullSafeDateTime(this object arg)
    {
        DateTime returnValue = Constraints.Dates.NULL_DATETime;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = Constraints.Dates.NULL_DATETime;
        }
        else
        {
            try
            {
                returnValue = Convert.ToDateTime(arg);
                if (returnValue < Constraints.Dates.NULL_DATETime)
                {
                    returnValue = Constraints.Dates.NULL_DATETime;
                }
            }
            catch
            {
                returnValue = Constraints.Dates.NULL_DATETime;
            }
        }

        return returnValue;
    }

    #endregion

    public static bool NotBoolean(this object arg)
    {
        bool returnValue = false;

        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            returnValue = false;
        }
        else
        {
            try
            {
                returnValue = Convert.ToBoolean(arg);
                returnValue = true;
            }
            catch
            {
                returnValue = false;
            }
        }

        return returnValue;

    }

    public static bool NotInteger(this object arg)
    {
        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            return true;
        }
        else
        {
            try
            {
                Int32 returnValue = Convert.ToInt32(arg);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }

    public static bool Yes_No_TO_Bool(this string arg)
    {
        try
        {
            if (arg.ToLower() == Constraints.General.Yes.ToLower() || arg.ToLower() == Constraints.General.Y.ToLower())
            {
                return true;
            }
            else if (arg.ToLower() == Constraints.General.No.ToLower() || arg.ToLower() == Constraints.General.N.ToLower())
            {
                return false;
            }
            else
            {
                return false;
            }
        }
        catch (Exception)
        {
            return false;
        }
    }

    public static bool Not_Yes_No(this string arg)
    {
        try
        {
            if (arg.ToLower() == Constraints.General.Yes.ToLower() || arg.ToLower() == Constraints.General.Y.ToLower())
            {
                return true;
            }
            else if (arg.ToLower() == Constraints.General.No.ToLower() || arg.ToLower() == Constraints.General.N.ToLower())
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception)
        {
            return false;
        }
    }


    public static bool NotFloat(this object arg)
    {
        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            return true;
        }
        else
        {
            try
            {
                float returnValue = float.Parse(arg.NullSafeString());

                return true;
            }
            catch
            {
                return false;
            }
        }
    }

    public static bool NotDateTime(this object arg)
    {
        if ((object.ReferenceEquals(arg, DBNull.Value)) || (arg == null) || (object.ReferenceEquals(arg, string.Empty)))
        {
            return true;
        }
        else
        {
            try
            {
                DateTime returnValue = Convert.ToDateTime(arg);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }

    public static DateTime CurrentTime
    {
        get { return DateTime.Now; }
    }

    public static DateTime CurrentDate
    {
        get { return DateTime.Now.Date; }
    }

    public static int GetRandomNumber()
    {
        try
        {
            Random objRandom = new Random();
            int num = objRandom.Next();
            return num;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public static string FormatNumericValue(object objValue)
    {
        try
        {
            return String.Format("{0:#,###.##}", String.Format("{0:#,###.##}", Util.NullSafeDecimal(objValue.ToString())));
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public static bool IsNumeric(this object value)
    {
        try
        {
            int i = Convert.ToInt32(value.ToString());
            return true;
        }
        catch (FormatException)
        {
            return false;
        }
    }

    public static object ReturnNullIfDateISNull(DateTime dt)
    {
        try
        {
            if (dt == Constraints.Dates.NULL_DATE)
            {
                return null;
            }

            return dt.ToShortDateString();
        }
        catch (Exception)
        {

            throw;
        }
    }

    /// <summary>
    /// Method to make sure that user's inputs are not malicious
    /// </summary>
    /// <param name="text">User's Input</param>
    /// <param name="maxLength">Maximum length of input</param>
    /// <returns>The cleaned up version of the input</returns>
    public static string InputText(string text, int maxLength)
    {
        text = text.Trim();
        if (string.IsNullOrEmpty(text))
            return string.Empty;
        if (text.Length > maxLength)
            text = text.Substring(0, maxLength);
        text = Regex.Replace(text, "[\\s]{2,}", " ");	//two or more spaces
        text = Regex.Replace(text, "(<[b|B][r|R]/*>)+|(<[p|P](.|\\n)*?>)", "\n");	//<br>
        text = Regex.Replace(text, "(\\s*&[n|N][b|B][s|S][p|P];\\s*)+", " ");	//&nbsp;
        text = Regex.Replace(text, "<(.|\\n)*?>", string.Empty);	//any other tags
        text = text.Replace("'", "''");
        return text;
    }


    public static void CopyFilesRecursively(DirectoryInfo source, DirectoryInfo target)
    {
        if (source.Exists)
        {
            foreach (DirectoryInfo dir in source.GetDirectories())
                CopyFilesRecursively(dir, target.CreateSubdirectory(dir.Name));
            foreach (FileInfo file in source.GetFiles())
                file.CopyTo(Path.Combine(target.FullName, file.Name));
        }
    }


    public static Control FindControlRecursive(this Control root, string id)
    {
        if (root.ID == id)
        {
            return root;
        }

        foreach (Control c in root.Controls)
        {
            Control t = FindControlRecursive(c, id);
            if (t != null)
            {
                return t;
            }
        }

        return null;
    }

    public static void ApplyToolTipsToControls(Control objObject)
    {
        try
        {
            foreach (Control ctrl in objObject.Controls)
            {
                if (ctrl.HasControls())
                {
                    ApplyToolTipsToControls(ctrl);
                }
                else if (ctrl is System.Web.UI.WebControls.TextBox)
                {
                    System.Web.UI.WebControls.TextBox oTextBox = ((System.Web.UI.WebControls.TextBox)ctrl);
                    if (oTextBox != null && oTextBox.Text.Length > Constraints.Numbers.ZERO && oTextBox.Visible && (!oTextBox.Enabled))
                        oTextBox.ToolTip = oTextBox.Text;
                    else
                        oTextBox.ToolTip = string.Empty;
                }
                else if (ctrl is System.Web.UI.WebControls.DropDownList)
                {
                    System.Web.UI.WebControls.DropDownList oDDL = ((System.Web.UI.WebControls.DropDownList)ctrl);
                    if (oDDL.DataSource != null && oDDL.SelectedItem.Text.Length > Constraints.Numbers.ZERO && oDDL.Visible && (!oDDL.Enabled))
                        oDDL.ToolTip = oDDL.SelectedItem.Text;
                    else
                        oDDL.ToolTip = string.Empty;
                }
                else if (ctrl is System.Web.UI.WebControls.Label)
                {
                    System.Web.UI.WebControls.Label oLabel = ((System.Web.UI.WebControls.Label)ctrl);
                    if (oLabel != null && oLabel.Text.Length > Constraints.Numbers.ZERO && oLabel.CssClass == Constraints.General.READONLY)
                        oLabel.ToolTip = oLabel.Text;
                    else
                        oLabel.ToolTip = string.Empty;
                }
            }


        }
        catch (Exception e)
        {
            throw e;
        }
    }


    public static bool ISBlankRow(DataRow dr)
    {
        try
        {
            foreach (object item in dr.ItemArray)
            {
                if (item.NullSafeString().Length > Constraints.Numbers.ZERO)
                {
                    return true;
                }
            }

            return false;
        }
        catch (Exception)
        {

            throw;
        }
    }

    public static bool IsRecorsModified(int iPairID, DataTable dt)
    {
        try
        {
            bool blnResult = false;

            foreach (DataRow item in dt.Rows)
            {
                if (item.RowState != DataRowState.Unchanged && item.RowState != DataRowState.Deleted && item["PairID"].NullSafeInteger() == iPairID)
                {
                    blnResult = true;
                    break;
                }
                else if (item.RowState == DataRowState.Deleted && item["PairID", DataRowVersion.Original].NullSafeInteger() == iPairID)
                {
                    blnResult = true;
                    break;
                }
            }

            return blnResult;
        }
        catch (Exception)
        {

            throw;
        }
    }

    public static bool RenameFile(string OldPath, string NewPath, bool DeleteOldFile = false)
    {
        try
        {
            //File.Move(OldPath, NewPath);
            File.Copy(OldPath, NewPath, true);
            if (DeleteOldFile)
            {
                File.Delete(OldPath);
            }

            return true;
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            return false;
        }
    }
}