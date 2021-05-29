<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucChLevChartbyEmployee.ascx.cs" Inherits="M_Controls_ucChLevChartbyEmployee" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" Skin="Material">
                <Legend>
                    <Appearance Position="Bottom">
                    </Appearance>
                </Legend>
            </telerik:RadHtmlChart>

 

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eb_Payroll %>" SelectCommand="eb_getLeaveBalancesbyEmp" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="empcod" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
