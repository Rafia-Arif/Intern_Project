using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.IO;

/// <summary>
/// Summary description for clsEncryption
/// </summary>
public class clsEncryption
{
	public clsEncryption()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private static byte[] key = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24 };//, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 10 };
    private static byte[] iv = {8,7,6,5,4,3,2,1};

    public static string EncryptData(string inName)
    {
        byte[] result = null;

        TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
        UTF8Encoding m_utf8 = new UTF8Encoding();
        byte[] input = m_utf8.GetBytes(inName);

        MemoryStream memStream = new MemoryStream();

        CryptoStream cryptStream = new CryptoStream(memStream, tdes.CreateEncryptor(key, iv), CryptoStreamMode.Write);

        // transform the bytes as requested

        cryptStream.Write(input, 0, input.Length);

        cryptStream.FlushFinalBlock();

        // Read the memory stream and

        // convert it back into byte array

        memStream.Position = 0;

        //Dim result as byte() = memStream.ToArray()

        result = memStream.ToArray();

        // close and release the streams

        memStream.Close();

        cryptStream.Close();

        // hand back the encrypted buffer

        return Convert.ToBase64String(result);
    }

    //public static string DESDecrypt(string stringToDecrypt)//Decrypt the content
    //{

    //    byte[] key;
    //    byte[] IV;

    //    byte[] inputByteArray;
    //    try
    //    {

    //        key = Convert2ByteArray(DESKey);

    //        IV = Convert2ByteArray(DESIV);

    //        int len = stringToDecrypt.Length; inputByteArray = Convert.FromBase64String(stringToDecrypt);


    //        DESCryptoServiceProvider des = new DESCryptoServiceProvider();

    //        MemoryStream ms = new MemoryStream();

    //        CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(key, IV), CryptoStreamMode.Write);
    //        cs.Write(inputByteArray, 0, inputByteArray.Length);

    //        cs.FlushFinalBlock();

    //        Encoding encoding = Encoding.UTF8; return encoding.GetString(ms.ToArray());
    //    }

    //    catch (System.Exception ex)
    //    {

    //        throw ex;
    //    }



    //}

    static byte[] Convert2ByteArray(string strInput)
    {

        int intCounter; char[] arrChar;
        arrChar = strInput.ToCharArray();

        byte[] arrByte = new byte[arrChar.Length];

        for (intCounter = 0; intCounter <= arrByte.Length - 1; intCounter++)
            arrByte[intCounter] = Convert.ToByte(arrChar[intCounter]);

        return arrByte;
    }

    public static string DecryptData(string encryptedData)
    {
        if (string.IsNullOrEmpty(encryptedData))
            return "";

        TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

        UTF8Encoding m_utf8 = new UTF8Encoding();

        byte[] input = Convert.FromBase64String(encryptedData.Replace(' ', '+'));
       // byte[] input = Convert.FromBase64String(encryptedData);
          
        MemoryStream memStream = new MemoryStream();

        CryptoStream cryptStream = new CryptoStream(memStream, tdes.CreateDecryptor(key, iv), CryptoStreamMode.Write);

        // transform the bytes as requested

        cryptStream.Write(input, 0, input.Length);

        cryptStream.FlushFinalBlock();

        // Read the memory stream and

        // convert it back into byte array

        memStream.Position = 0;

        byte[] result = memStream.ToArray();

        // close and release the streams

        memStream.Close();

        cryptStream.Close();

        // hand back the encrypted buffer

        return m_utf8.GetString(result);

    }
}
