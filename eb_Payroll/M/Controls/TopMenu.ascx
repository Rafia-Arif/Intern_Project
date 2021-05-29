<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TopMenu.ascx.cs" Inherits="Controls_TopMenu" %>
<li>
    <asp:HyperLink ID="hlProfile" runat="server" NavigateUrl="~/Profile.aspx">
        <asp:Image ID="iProfile" runat="server" ImageUrl="~/images/icons/topnav/Profile.png" />
        <span>Profile</span>
    </asp:HyperLink></li>
<li>
    <asp:HyperLink ID="hlChgPass" runat="server" NavigateUrl="~/System/ChangePassword.aspx">
        <asp:Image ID="iChgPass" runat="server" ImageUrl="~/images/icons/topnav/tasks.png" />
        <span>Change Password</span>
    </asp:HyperLink></li>
<li>
    <asp:HyperLink ID="hlSettings" runat="server" NavigateUrl="~/admin/parameters.aspx" >
        <asp:Image ID="iSetting" runat="server" ImageUrl="~/images/icons/topnav/settings.png" />
        <span>Parameters</span>
    </asp:HyperLink></li>
<li>

    <asp:HyperLink ID="lnkLogout" runat="server"
        NavigateUrl="~/System/LogoutPage.aspx"  >
        <asp:Image ID="ilogout" runat="server" ImageUrl="~/images/icons/topnav/logout.png" />
        <span>Logout</span>
    </asp:HyperLink>

