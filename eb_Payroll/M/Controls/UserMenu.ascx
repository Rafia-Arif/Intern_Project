<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserMenu.ascx.cs" Inherits="Controls_UserMenu" %>
<li class="dash">
    <asp:HyperLink ID="lkDash" runat="server" NavigateUrl="~/Dashboards/Dashboard.aspx">
        <span>Dashboard</span>
    </asp:HyperLink>
</li>
<li class="forms" id="lirptAnnounce" runat="server"><a href="#" title="" class="exp"><span>Announcements</span></a>
    <ul class="sub">
        <asp:Repeater ID="RptAnnounce" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkAnnounce" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptDocuments" runat="server"><a href="#" title="" class="exp"><span>Documents</span></a>
    <ul class="sub">
        <asp:Repeater ID="RpDocuments" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkDocuments" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptmaster" runat="server"><a href="#" title="" class="exp"><span>Master</span></a>
    <ul class="sub">
        <asp:Repeater ID="Master" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkTra" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptsetup" runat="server" ><a href="#" title="" class="exp"><span>Setup</span></a>
    <ul class="sub">
        <asp:Repeater ID="setup" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkTra" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptemployee" runat="server"><a href="#" title="" class="exp"><span>Employee</span></a>
    <ul class="sub">
        <asp:Repeater ID="Employee" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkemp" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirpttransaction" runat="server"><a href="#" title="" class="exp"><span>Transactions</span></a>
    <ul class="sub">
        <asp:Repeater ID="Transactions" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkTra" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptreports" runat="server"><a href="#" title="" class="exp"><span>Reports</span></a>
    <ul class="sub">
        <asp:Repeater ID="Reports" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkTra" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptmonthend" runat="server"><a href="#" title="" class="exp"><span>Month End</span></a>
    <ul class="sub">
        <asp:Repeater ID="MonthEnd" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkmend" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="forms" id="lirptUtilities" runat="server"><a href="#" title="" class="exp"><span>Utilities</span></a>
    <ul class="sub">
        <asp:Repeater ID="Utilities" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkUtilities" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>
<li class="charts" id="lirptexp" runat="server"><a href="#" title="" class="exp"><span>Exceptions & KPIs</span></a>
    <ul class="sub">
        <asp:Repeater ID="rptexp" runat="server">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="lkexp" runat="server" NavigateUrl='<%# string.Format(Eval("URL").ToString(),Eval("ID")) %>' Text='<%# Eval("Name") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</li>


