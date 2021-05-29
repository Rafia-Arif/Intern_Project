<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ResourceAssignmentItem.ascx.cs" Inherits="Payroll_Setup_ResourceAssignmentItem" %>
<table runat="server" id="ProductWrapper" class="inner" border="0" cellpadding="2"
    cellspacing="0">
    <tr>
        <td>
            <asp:FormView ID="ResourceView" DataSourceID="ResourceDataSource" DataKeyNames="recidd"
                runat="server">
                <ItemTemplate>
                    <div class="title" style="text-align: left; width: 450px;">
                        <b>Asset Details</b><br />
                        <br />
                        <div>
                            <div style="width: 85px; float: left;">Description </div>
                            : <%# Eval("description") %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Emails </div>
                            : <%# Eval("emails") %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Owner </div>
                            :  <%# Eval("owners") %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Category </div>
                            : <%# Eval("category") %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Repeating Node </div>
                            :
                            <input type="checkbox" <%# string.IsNullOrEmpty(Eval("repeating").ToString()) ? "" :  (Convert.ToBoolean(Eval("repeating")) ? "checked=checked" : "") %> style="vertical-align: text-bottom;" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <br />
            <asp:FormView ID="FormView1" DataSourceID="AssignmentDataSource" DataKeyNames="recidd"
                runat="server">
                <ItemTemplate>
                    <div class="title" style="text-align: left; width: 450px;">
                        <b>Assignment Details</b><br />
                        <br />
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Requestor Date </div>
                            : <%# Eval("reqdtm").ToString() != "" ? DateTime.Parse(Eval("reqdtm").ToString()).ToShortDateString() : "" %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Requestor</div>
                            : <%# Eval("reqdsc") %>
                        </div>

                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Owner Date </div>
                            : <%# !string.IsNullOrEmpty(Eval("owndtm").ToString()) ? DateTime.Parse(Eval("owndtm").ToString()).ToShortDateString() : "" %>
                        </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 85px; float: left;">Is Provided </div>
                            :
                            <input type="checkbox" <%#Convert.ToBoolean(Eval("IsProvided")) ? "checked=checked" : "" %> style="vertical-align: text-bottom;" />
                        </div>
                        <div>
                            <div style="width: 85px; float: left;">Owner</div>
                            : <%# Eval("owndsc") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </td>
    </tr>
</table>
<asp:SqlDataSource ID="ResourceDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:eb_payroll %>"
    ProviderName="System.Data.SqlClient"
    SelectCommand="select * ,(select top 1 isnull(isRepeat,0) from eb_prlresmst where recidd = residd) repeating,
(select top 1 description from eb_prlresmst where recidd = residd) description,
    (select top 1 category from eb_prlresmst where recidd = residd) category,
dbo.func_getResourceEmails(residd) as emails
,dbo.func_getResourceOwners(residd) as owners
  from eb_prlresasm where recidd = @recidd">
    <SelectParameters>
        <asp:Parameter Name="recidd" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="AssignmentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:eb_payroll %>"
    ProviderName="System.Data.SqlClient"
    SelectCommand="select top 1 *,isnull(isprov,0) IsProvided from eb_prlresasmdtl where asmidd =  @recidd order by recidd desc">
    <SelectParameters>
        <asp:Parameter Name="recidd" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
