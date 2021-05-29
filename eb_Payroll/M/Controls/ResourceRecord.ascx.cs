using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Resource_Record : System.Web.UI.UserControl
{
    public string recidd
    {
        get
        {
            if (ViewState["recidd"] == null)
            {
                return "";
            }
            return (string)ViewState["recidd"];
        }
        set
        {
            ViewState["recidd"] = value;
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        this.ResourceDataSource.SelectParameters["recidd"].DefaultValue = this.recidd;
        this.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}