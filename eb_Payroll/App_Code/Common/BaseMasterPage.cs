using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web;

    public enum MessageType { Error, Success, Warning, Info };
    public class BaseMasterPage : MasterPage
    {
        public virtual string BodyClass
        {
            get;
            set;
        }
        public virtual string PageTitle
        {
            get { return Page.Title; }
        }
        public virtual string PageDesc
        {
            get { return Page.MetaDescription; }
        }
        public BaseMasterPage MasterPage
        {
            get
            {
                return (this.Master as BaseMasterPage);
            }
        }
        public virtual void ShowMessage(string Message, MessageType EnmMessageType, string RedirectUrl)
        {

        }
        public virtual void UpdateHeader()
        {
        }

    }
