<%@ Page Title="Dashboard"  Language="C#"  AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" MasterPageFile="~/MasterPages/UserMasterPage.master"
    Inherits="AdminDashboard" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dashboard</title>
  <%--<link type="text/css" rel="Stylesheet" href="../App_Themes/Default/Styles/main.css"/>--%>
  <link type="text/css" rel="Stylesheet" href="../App_Themes/Dark/Styles/rafia.css"/>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <telerik:RadContentTemplateTile runat="server" ID="PendingLeavesTile" Height="130px" Width="308px" CssClass="col-3 col-m-3 " Shape="Wide" BackColor="#e6ab0b" >
        <ContentTemplate>
            <asp:Image runat="server" ImageUrl="../Images/assets/User.png" Height="65px" ImageAlign="AbsMiddle" Style="padding: 20px 0px 0px 20px;" />
            <telerik:RadLabel runat="server" ID="PendingLeave" Font-Size="30px" OnLoad="PendingLeaveCount" Style="padding: 25px 0 0 50px; color: white;"></telerik:RadLabel>
            <br />
            <telerik:RadLabel runat="server" Font-Size="18px" Style="padding-left: 20px; padding-top: 5px; color: white;">Company Total Assets </telerik:RadLabel>
        </ContentTemplate>
    </telerik:RadContentTemplateTile>

    <telerik:RadContentTemplateTile runat="server" ID="RequestMonthly" Height="130px" Width="227px" CssClass="col-2 col-m-2" Shape="wide" BackColor="#7bb524">
        <ContentTemplate>
            <div style="text-align: center;">
                <asp:Image runat="server" Height="40px" Style="padding-top: 10px;" ImageUrl="../Images/assets/Assignment.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="MonthlyRequests" OnLoad="MonthlyRequestsCount" Font-Size="XX-Large" Style="color: white; padding-bottom: 3px;" />
                </div>
                <div>
                    <label style="color: white; font-size: larger;">Total Assign Asset </label></div>
            </div>
        </ContentTemplate>
        <PeekTemplate>
            <div style="text-align: center; background-color: #7bb524;">
                <asp:Image runat="server" Height="40px" Style="padding-top: 5px;" ImageUrl="../Images/assets/Assignment.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="AnnualRequests" OnLoad="AnnualRequestsCount" Font-Size="XX-Large" Style="color: white; padding-bottom: 3px;" />
                </div>
                <div style="padding-bottom: 10px;">
                    <label style="color: white; font-size: larger;">Annual Assignment</label></div>
            </div>
        </PeekTemplate>
        <PeekTemplateSettings Animation="slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
    </telerik:RadContentTemplateTile>

    <telerik:RadContentTemplateTile runat="server" ID="ApprovedMonthly" Height="130px" Width="227px" CssClass="col-2 col-m-2" Shape="wide" BackColor="#cf306a">
        <ContentTemplate>
            <div style="text-align: center;">
                <asp:Image runat="server" Height="40px" Style="padding-top: 5px;" ImageUrl="../Images/assets/thumbs-up.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="MonthlyApproved" Font-Size="XX-Large" OnLoad="MonthlyApprovedCount" Style="color: white; padding-bottom: 10px;" />
                </div>
                <div>
                    <label style="font-size: larger; color: white;">Total Approved Assets</label></div>
            </div>
        </ContentTemplate>
        <PeekTemplate>
            <div style="text-align: center; background-color: #cf306a;">
                <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/thumbs-up.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="AnnualApproved" Font-Size="XX-Large" OnLoad="AnnualApprovedCount" Style="color: white; padding-bottom: 10px;" />
                </div>
                <div style="padding-bottom: 10px;">
                    <label style="font-size: larger; color: white;">Annual Approved</label></div>
            </div>
        </PeekTemplate>
        <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
    </telerik:RadContentTemplateTile>

    <telerik:RadContentTemplateTile runat="server" ID="RejectedMonthly" Height="130px" Width="227px" CssClass="col-2 col-m-2" Shape="wide" BackColor="#46a5db">
        <ContentTemplate>
            <div style="text-align: center;">
                <asp:Image runat="server" Height="40px" Style="padding-top: 5px;" ImageUrl="../Images/assets/thumbs-down.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="MonthlyRejected" Font-Size="XX-Large" OnLoad="MonthlyRejectedCount" Style="padding-bottom: 10px; color: white;" />
                </div>
                <div>
                    <label style="font-size: larger; color: white;">Total Rejected Assets</label></div>
            </div>
        </ContentTemplate>
        <PeekTemplate>
            <div style="text-align: center; background-color: #46a5db;">
                <asp:Image runat="server" Height="40px" Style="padding-top: 5px;" ImageUrl="../Images/assets/thumbs-down.png" />
                <div>
                    <telerik:RadLabel runat="server" ID="AnnualRejected" OnLoad="AnnualRejectedCount" Font-Size="XX-Large" Style="padding-bottom: 10px; color: white;" />
                </div>
                <div style="padding-bottom: 10px;">
                    <label style="font-size: larger; color: white;">Annual Rejected</label></div>
            </div>
        </PeekTemplate>
        <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
    </telerik:RadContentTemplateTile>

    <telerik:RadContentTemplateTile runat="server" ID="TotalEmployee" Shape="Wide" Height="130" Width="308px" CssClass="col-3 col-m-3" BackColor="#d4d466">
        <ContentTemplate>
            <asp:Image runat="server" ImageUrl="../Images/assets/provide.png" ImageAlign="AbsMiddle" Height="70px" Style="padding: 20px 0px 0px 20px;" />
            <telerik:RadLabel runat="server" ID="EmployeeCount" Font-Bold="false" Font-Size="30px" OnLoad="EmployCount" ForeColor="white" Style="padding: 25px 0 0 50px;"></telerik:RadLabel>
            <telerik:RadLabel runat="server" Font-Bold="false" Font-Size="18px" Text="Provided Assets" ForeColor="white" Style="padding: 5px 50px 20px 20px;"></telerik:RadLabel>
        </ContentTemplate>
    </telerik:RadContentTemplateTile>
    <!------------------------------->
    <div id="grpchart1" class="col-6 col-m-6" style="display: block; float: left; box-sizing: border-box;">
        <div class="widget">

            <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" Height="350em" Skin="Sunset" OnLoad="MonthlyPiechart">
                <Legend>
                    <Appearance Visible="true" Position="right">
                        <TextStyle Color="black" />
                    </Appearance>
                </Legend>

                <PlotArea>
                    <Series>
                        <telerik:PieSeries StartAngle="90" DataFieldY="leaves" NameField="dptds1">
                            <LabelsAppearance Visible="true" Position="OutsideEnd" Color="black" />
                            <TooltipsAppearance Visible="true" />
                            <SeriesItems>
                            </SeriesItems>
                        </telerik:PieSeries>
                    </Series>
                </PlotArea>

                <ChartTitle Text="Monthly Leaves">
                    <Appearance Visible="True">
                        <TextStyle Bold="true" Color="Black" />
                    </Appearance>
                </ChartTitle>

            </telerik:RadHtmlChart>

            <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" Height="350em" OnLoad="AnnualPiechart" Skin="Sunset">
                <Legend>
                    <Appearance Visible="True" Position="right">
                        <TextStyle Color="black" />
                    </Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:PieSeries StartAngle="90" DataFieldY="leaves" NameField="dptds1">
                            <LabelsAppearance Position="OutsideEnd" Color="black" />
                            <TooltipsAppearance Visible="true" />
                        </telerik:PieSeries>
                    </Series>
                </PlotArea>
                <ChartTitle Text="Yearly Leaves">
                    <Appearance Visible="True">
                        <TextStyle Bold="true" Color="black" />
                    </Appearance>
                </ChartTitle>
            </telerik:RadHtmlChart>
        </div>
    </div>-->

   <!-- <div id="grpchart2" class="col-6 col-m-6" style="display: block; float: left; box-sizing: border-box;">
        <div class="widget">
            <telerik:RadHtmlChart ID="AbsenceRatioGraph" runat="server" Height="250px">
                <Appearance FillStyle-BackgroundColor="transparent"></Appearance>
                <ChartTitle Text="Absence Ratio">
                    <Appearance Visible="True" Align="Center" Position="top" BackgroundColor="Transparent">
                        <TextStyle Bold="true" Color="black" />
                    </Appearance>
                </ChartTitle>
                <Legend>
                    <Appearance BackgroundColor="Transparent" Position="Bottom" Visible="false">
                        <TextStyle Color="black" />
                    </Appearance>
                </Legend>
                <PlotArea>
                    <Appearance FillStyle-BackgroundColor="Transparent">
                    </Appearance>
                    <XAxis Visible="true" AxisCrossingValue="0" DataLabelsField="Month" Step="1" Color="black" MajorTickType="None" MinorTickType="None" Reversed="false">
                        <MajorGridLines Color="transparent" />
                        <MinorGridLines Color="Transparent" />
                        <LabelsAppearance DataFormatString="{0}" RotationAngle="0"></LabelsAppearance>
                        <TitleAppearance Position="Center" Text="Years" Visible="true"></TitleAppearance>
                    </XAxis>
                    <YAxis AxisCrossingValue="0" MinValue="0" Step="10" Color="black" MajorTickType="none" MinorTickType="none" Visible="True" Reversed="false">
                        <MajorGridLines Color="transparent" />
                        <MinorGridLines Color="Transparent" />
                        <LabelsAppearance DataFormatString="{0}" Skip="0" Step="1" Visible="false" />
                        <TitleAppearance Position="Center" Text="Absences" Visible="true" />
                    </YAxis>
                    <Series>
                        <telerik:LineSeries MissingValues="Interpolate" DataFieldY="Absence" Name="ratio">
                            <Appearance FillStyle-BackgroundColor="#33ccff"></Appearance>
                            <LabelsAppearance Position="Above" DataFormatString="{0}">
                                <TextStyle Color="black" />
                            </LabelsAppearance>
                            <LineAppearance LineStyle="Smooth" Width="1" />
                            <MarkersAppearance MarkersType="Circle" BackgroundColor="#33ccff" Size="8" />
                        </telerik:LineSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        </div>
    </div>
    <!------------------------------------------------------->
    <div id="grpchart" class="col-6 col-m-6" style="display: block; float: left; box-sizing: border-box;">
        <div class="widget">
            <div class="title">
                <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>Employee Details</h6>
                <div class="num">
                    <a class="blueNum">
                        <asp:Literal ID="Literal3" runat="server"></asp:Literal></a>
                </div>
            </div>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="true" AllowFilteringByColumn="false" AllowSorting="true"  OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCommand="RadGrid1_ItemCommand" Style="margin-right: 0">
                <ClientSettings EnablePostBackOnRowClick="true">
                    <selecting AllowRowSelect="true" />
                </ClientSettings>
                <MasterTableView AutoGenerateColumns="false" DataKeyNames="empcod">
                    <Columns>
                        <telerik:GridBoundColumn AllowFiltering="true" DataField="empcod" DataType="System.Int32" HeaderText="Employee Code" ReadOnly="true" UniqueName="ID" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="empprn" DataType="System.String" HeaderText="Name" SortExpression="Name" ReadOnly="true" UniqueName="Name" FilterControlAltText="Filter Name column" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="poscod" DataType="System.String" HeaderText="Position Code" ReadOnly="true" SortExpression="Position Code" UniqueName="Position" FilterControlAltText="Filter Department column" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center"></telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

        </div>
    </div>

    <!----------------------------->
    


</asp:Content>

