using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using Telerik.Charting;
using System.IO;
using System.Configuration;

public partial class Statisticsapp : BasePage
{
   
 
    protected void Page_Init(object sender, EventArgs e)
    {

        FormName = "Statisticsapp";
        base.Page_Init(sender, e);

    }
    protected void Page_Load(object sender, EventArgs e)
    {
    }
   
}
