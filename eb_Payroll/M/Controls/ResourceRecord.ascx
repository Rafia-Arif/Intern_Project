
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ResourceRecord.ascx.cs" Inherits="Resource_Record" %>
<table runat="server" id="ProductWrapper" class="inner" border="0" cellpadding="2"
    cellspacing="0">
    <tr>
        <td>
            <asp:FormView ID="ResourceView" DataSourceID="ResourceDataSource" DataKeyNames="recidd"
                runat="server">
                <ItemTemplate>
                    <div class="title" style="text-align: left;width: 485px;">
                        <b>Asset Details</b><br />
                        <br />
                        <div>
                            <div style="width: 100px; float: left;">Description </div>
                            : <%# Eval("description") %></div>
                        <div style="margin-top: 5px;">
                            <div style="width: 100px; float: left;">Emails </div>
                            : <%# Eval("emails") %> </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 100px; float: left;">Owner </div>
                            :  <%# Eval("owners") %> </div>
                        <div style="margin-top: 5px;">
                            <div style="width: 100px; float: left;">Category </div>
                            : <%# Eval("category") %></div>
                        <div style="margin-top: 5px;">
                            <div style="width: 100px; float: left;">Repeating Node </div>
                            :
                            <input type="checkbox" <%#Convert.ToBoolean(Eval("repeating")) ? "checked=checked" : "" %> style="vertical-align: text-bottom;" /></div>
                        <div style="margin-top: 5px;">
                            <div style="width: 100px; float: left;">Quantity </div>
                            : <%# Eval("Quantity") %></div>
                        
                    </div>

                    <asp:Panel ID="DetailPanel" Visible='<%# string.IsNullOrEmpty(Eval("category").ToString())?false:true %>'  runat="server">
                        <div style="width: 237px; border: 1px solid lightgray; display: inline-block; margin-left: 1px;">
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_1_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_1") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_3_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_3") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_5_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_5") %></div>
                            </div>

                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("ddl_1_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("ddl_1_text") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("ddl_3_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("ddl_3_text") %></div>
                            </div>

                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Date_1_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Date_1") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Date_3_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Date_3") %></div>
                            </div>

                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Radio_button_1_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Radio_button_1") %> </div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Radio_button_3_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Radio_button_3") %> </div>
                            </div>
                        </div>

                        <div style="width: 237px;  border: 1px solid lightgray; display: inline-block; margin-left: 1px;">
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_2_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_2") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_4_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_4") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Textbox_6_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Textbox_6") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("ddl_2_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("ddl_2_text") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("ddl_4_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("ddl_4_text") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Date_2_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Date_2") %></div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Date_4_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Date_4") %></div>
                            </div>

                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Radio_button_2_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Radio_button_2") %> </div>
                            </div>
                            <div style="margin-top: 5px; float: left;">
                                <div style="width: 100px; float: left;"><%# Eval("Radio_button_4_label") %> </div>
                                <div style="width: 137px; float: left;">: <%# Eval("Radio_button_4") %> </div>
                            </div>

                        </div>

                        </asp:Panel>
                </ItemTemplate>
            </asp:FormView>
        </td>
    </tr>
</table>
<asp:SqlDataSource ID="ResourceDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:eb_payroll %>"
    ProviderName="System.Data.SqlClient" SelectCommand="select top 1 *, isnull(isRepeat,0) repeating,isnull(Quantity,0) Quantity,dbo.func_getResourceEmails(recidd) as emails
,dbo.func_getResourceOwners(recidd) as owners
  from eb_prlresmst rmst left join tbl_CategoryMaster cmst on rmst.categoryId=cmst.Id where recidd = @recidd">
    <SelectParameters>
        <asp:Parameter Name="recidd" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

