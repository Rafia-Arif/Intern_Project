<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ResourceItem.ascx.cs" Inherits="Payroll_Setup_ResourceItem" %>

<table runat="server" id="ProductWrapper" class="inner" border="0" cellpadding="2"
    cellspacing="0">
    <tr>
        <td>
            <asp:FormView ID="ResourceView" DataSourceID="ResourceDataSource" DataKeyNames="recidd"
                runat="server">
                <ItemTemplate>
                    <div class="title" style="text-align: left;width: 450px;">
                        <b>Asset Details</b><br />
                        <br />
                        <div>
                            <div style="width: 85px; float: left;">Description </div>
                            : <%# Eval("description") %></div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Emails </div>
                            : <%# Eval("emails") %> </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Owner </div>
                            :  <%# Eval("owners") %> </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Category </div>
                            : <%# Eval("category") %></div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Repeating Node </div>
                            :
                            <input type="checkbox" <%#Convert.ToBoolean(Eval("repeating")) ? "checked=checked" : "" %> style="vertical-align: text-bottom;" /></div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </td>
    </tr>
</table>
<asp:SqlDataSource ID="ResourceDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:eb_payroll %>"
    ProviderName="System.Data.SqlClient" SelectCommand="select *, isnull(isRepeat,0) repeating,dbo.func_getResourceEmails(recidd) as emails
,dbo.func_getResourceOwners(recidd) as owners
  from eb_prlresmst where recidd = @recidd">
    <SelectParameters>
        <asp:Parameter Name="recidd" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
