<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucEmployeeLeaveChart.ascx.cs" Inherits="Controls_ucEmployeeLeaveChart" %>

<div class="widget12">

    <div class="title"  style="background-color:#95A1C3; >
        <img src="/images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6B>Absence Balance Chart</h6B>
    </div>


    <div class="formRow">
        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server">
            

        </telerik:RadHtmlChart>
        
        <%--<div class="clear"></div>--%>
    </div>
</div>
