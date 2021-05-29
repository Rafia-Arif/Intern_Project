<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucEmployeeCard.ascx.cs" Inherits="Controls_ucEmployeeCard" %>

<div class="widget12">

    <div class="title"  style="background-color:#95A1C3; >
        <img src="/images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6B>Employee Card</h6B>
    </div>


    <div class="formRow">
        <div class="emp-data">
            <asp:Literal runat="server" ID="lblEmployeeCode" Text=""></asp:Literal>
            <br />
            <asp:Literal runat="server" ID="lblName"></asp:Literal>
            <br />
            <asp:Literal runat="server" ID="lblDepartmentCode"></asp:Literal>
             <br />
            <asp:Literal runat="server" ID="lblPositionCode"></asp:Literal>
            <br />
            <asp:Literal runat="server" ID="lblPhone"></asp:Literal>
            <br />
            <asp:Literal runat="server" ID="lblEmail"></asp:Literal>
        </div>
        <div class="emp-picture">
            <img alt="Employee" runat="server" id="imgEmployee" src="~/Images/Emp_Card_Pic2.jpg" height="133" />
        </div>
        <div class="clear"></div>
    </div>
</div>
