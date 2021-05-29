<%@ Page title="User Dashboard" Language="C#" AutoEventWireup="true" CodeFile="UserDashboard.aspx.cs" MasterPageFile="~/MasterPages/UserMasterPage.master"
    Inherits="UserDashboard" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dashboard</title>

    <link type="text/css" rel="Stylesheet" href="../styles/main.css" />
    <link type="text/css" rel="Stylesheet" href="../styles/Calendar.css" />
  <%--<link type="text/css" rel="Stylesheet" href="../App_Themes/Dark/Styles/rafia.css"/>--%>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <telerik:RadContentTemplateTile runat="server" ID="TotalLeaves" shape="Wide" width="326px" BackColor="#273033" style="margin-left:2px; border-radius:5px;">
        <ContentTemplate>
            <div>
                <asp:Image runat="server" ImageAlign="Middle" Height="80px" Style="padding:10px 0 5px 10px;" ImageUrl="../Images/assets/AnnualLeave.png" />
                <telerik:RadLabel runat="server" Text="50" Font-Bold="true" ForeColor="white" Font-Size="XX-Large" Style="padding:0 0 0 50px ;" />
                <div style="padding:10px 0 0 10px; text-align:center;"><telerik:RadLabel runat="server" ForeColor="white" Font-Size="large" Text="Annual Leaves"></telerik:RadLabel></div>
            </div>
        </ContentTemplate>
    </telerik:RadContentTemplateTile>
    <telerik:RadContentTemplateTile runat="server" ID="MonthlyLeaves" shape="Wide" width="326px" BackColor="#273033" style="border-radius:5px;">
        <ContentTemplate>
            <div>
                <asp:Image runat="server" ImageAlign="Middle" Height="80px" Style="padding:10px 0 5px 10px;" ImageUrl="../Images/assets/AnnualLeave.png" />
                <telerik:RadLabel runat="server" Text="5" Font-Bold="true" Font-Size="XX-Large" ForeColor="white" Style="padding:0 0 0 50px ;" />
                <div style="padding:10px 0 0 10px; text-align:center;"><telerik:RadLabel runat="server" ForeColor="white" Font-Size="large" Text="Monthly Leaves"></telerik:RadLabel></div>
            </div>
        </ContentTemplate>
    </telerik:RadContentTemplateTile>

    <div id="grpchart" class="col-6 col-m-6" style="display:block; float: right; box-sizing: border-box;">
        <div class="widget">
            <div class="title">
                <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>Consumed</h6>
                <div class="num">
                    <a class="blueNum">
                        <asp:Literal ID="Literal3" runat="server"></asp:Literal></a>
                </div>
            </div>
            <telerik:RadHtmlChart ID="HtmlDonutChart" runat="server" Width="330em" Height="330em" transition="true" style="float:left; display:inline-block;">
                <Appearance FillStyle-BackgroundColor="Transparent"></Appearance>
                <ChartTitle Text="Paid Leaves">
                    <Appearance Align="Center" Position="Top">
                        <TextStyle Bold="true" />
                    </Appearance>
                </ChartTitle>
                <Legend>
                    <Appearance Position="Bottom" Visible="true"></Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:DonutSeries HoleSize="50" StartAngle="90">
                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0}" Visible="true">
                            </LabelsAppearance>
                            <TooltipsAppearance Visible="false"></TooltipsAppearance>
                            <SeriesItems>
                                <telerik:PieSeriesItem BackgroundColor="#b9779f" Name="Alloted" Y="32" />
                                <telerik:PieSeriesItem BackgroundColor="#2B0B3F" Name="Remaining" Y="12" />
                            </SeriesItems>
                        </telerik:DonutSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
            <telerik:RadHtmlChart ID="HtmlDonutChart2" runat="server" Width="330em" Height="330em" transition="true" style=" display:inline-block;">
                <Appearance FillStyle-BackgroundColor="Transparent"></Appearance>
                <ChartTitle Text="Unpaid Leaves">
                    <Appearance Align="Center" Position="Top">
                        <TextStyle Bold="true" />
                    </Appearance>
                </ChartTitle>
                <Legend>
                    <Appearance Position="Bottom" Visible="true"></Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:DonutSeries HoleSize="50" StartAngle="90">
                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0}" Visible="true">
                            </LabelsAppearance>
                            <TooltipsAppearance Visible="false"></TooltipsAppearance>
                            <SeriesItems>
                                <telerik:PieSeriesItem BackgroundColor="#b9779f" Name="Alloted" Y="20" />
                                <telerik:PieSeriesItem  BackgroundColor="#2B0B3F" Name="Remaining" Y="2" />
                            </SeriesItems>
                        </telerik:DonutSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
            <br />
            <telerik:RadHtmlChart ID="HtmlDonutChart3" runat="server" Height="330em" transition="true" style=" display:block;">
                <Appearance FillStyle-BackgroundColor="Transparent"></Appearance>
                <ChartTitle Text="Work From Home Hrs">
                    <Appearance Align="Center" Position="Top">
                        <TextStyle Bold="true" />
                    </Appearance>
                </ChartTitle>
                <Legend>
                    <Appearance Position="Bottom" Visible="true"></Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:DonutSeries HoleSize="50" StartAngle="90">
                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0}" Visible="true">
                            </LabelsAppearance>
                            <TooltipsAppearance Visible="false"></TooltipsAppearance>
                            <SeriesItems>
                                <telerik:PieSeriesItem BackgroundColor="#b9779f" Name="Alloted" Y="20" />
                                <telerik:PieSeriesItem  BackgroundColor="#2B0B3F" Name="Remaining" Y="2" />
                            </SeriesItems>
                        </telerik:DonutSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
        </div>
    </div>

        <telerik:RadContentTemplateTile runat="server" ID="PaidAnnual" Shape="Square" BackColor="#273033" Style=" border-radius: 5px;">
            <ContentTemplate>
                <div style="text-align: center;">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/paid.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="34" Font-Size="XX-Large" ForeColor="white" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Paid Annual Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </ContentTemplate>
            <PeekTemplate>
                <div style="text-align: center; background-color: #273033">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/paid.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="5" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div style="padding-bottom:30px;">
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Paid Monthly Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </PeekTemplate>
            <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
        </telerik:RadContentTemplateTile>
        <telerik:RadContentTemplateTile runat="server" ID="UnpaidMonthly" Shape="Square" BackColor="#273033" Style=" border-radius: 5px;">
            <ContentTemplate>
                <div style="text-align: center;">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/unpaid.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="2" Font-Size="XX-Large" ForeColor="white" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Unpaid Annual Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </ContentTemplate>
            <PeekTemplate>
                <div style="text-align: center; background-color: #273033">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/unpaid.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="12" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Unpaid Monthly Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </PeekTemplate>
            <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
        </telerik:RadContentTemplateTile>
        <telerik:RadContentTemplateTile runat="server" ID="AnnualSick" Shape="Square" BackColor="#273033" Style=" border-radius: 5px;">
            <ContentTemplate>
                <div style="text-align: center;">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/sick.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="3" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Monthly Sick Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </ContentTemplate>
        </telerik:RadContentTemplateTile>
        <telerik:RadContentTemplateTile runat="server" ID="RadContentTemplateTile1" Shape="Square" BackColor="#273033" Style=" border-radius: 5px; top: 0px; left: -1px;">
            <ContentTemplate>
                <div style="text-align: center;">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/sick.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="4" Font-Size="XX-Large" ForeColor="white" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Annual Consumed Sick Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </ContentTemplate>
            <PeekTemplate>
                <div style="text-align: center; background-color: #273033">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/sick.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="1" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Monthly Consumed Sick Leaves"></telerik:RadLabel>
                    </div>
                </div>
            </PeekTemplate>
            <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
        </telerik:RadContentTemplateTile>
        <telerik:RadContentTemplateTile runat="server" ID="ExtraWork" Shape="Square" BackColor="#273033" Style=" border-radius: 5px;">
            <ContentTemplate>
                <div style="text-align: center;">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/request.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="25" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div>
                        <telerik:RadLabel runat="server" Font-Size="larger" ForeColor="white" Text="Hours Worked Extra"></telerik:RadLabel>
                    </div>
                </div>
            </ContentTemplate>
            <PeekTemplate>
                <div style="text-align: center; background-color: #273033">
                    <asp:Image runat="server" Height="40px" Style="padding-bottom: 5px;" ImageUrl="../Images/assets/request.png" />
                    <div>
                        <telerik:RadLabel runat="server" Text="1" ForeColor="white" Font-Size="XX-Large" Style="padding-bottom: 10px;" />
                    </div>
                    <div style="padding-bottom: 30px;">
                        <telerik:RadLabel runat="server" ForeColor="white" Font-Size="larger" Text="Days Worked Extra"></telerik:RadLabel>
                    </div>
                </div>
            </PeekTemplate>
            <PeekTemplateSettings Animation="Slide" HidePeekTemplateOnMouseOut="true" ShowPeekTemplateOnMouseOver="true" />
        </telerik:RadContentTemplateTile>
        
    <div id="grpchart2" class="col-6 col-m-6" style="display:block; float: left; box-sizing: border-box;">
        <div class="widget">
            <div class="title">
                <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>Calendar</h6>
                <div class="num">
                    <a class="blueNum">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal></a>
                </div>
            </div>
            <telerik:RadCalendar RenderMode="Lightweight" ID="RadCalendar1" runat="server" AutoPostBack="True" Skin="Material" style="width:100%;"
                EnableEmbeddedSkins="true" EnableEmbeddedBaseStylesheet="true" CssFile="../Styles/Calendar.css" EnableMonthYearFastNavigation="false" EnableNavigation="true"
                DayNameFormat="Short" ShowRowHeaders="false" ShowOtherMonthsDays="false" EnableWeekends="True" ClientEvents-OnDateClick="false">
                <SpecialDays>
                    <telerik:RadCalendarDay Date="2021/03/23" Repeatable="DayInMonth" TemplateID="HolidayTemplate">
                    </telerik:RadCalendarDay>
                    <telerik:RadCalendarDay Date="2021/06/19" Repeatable="DayInMonth" TemplateID="HolidayTemplate">
                    </telerik:RadCalendarDay>
                    <telerik:RadCalendarDay Date="2021/06/17" Repeatable="DayInMonth" TemplateID="WFHTemplate">
                    </telerik:RadCalendarDay>
                    <telerik:RadCalendarDay Date="2021/06/8" Repeatable="DayAndMonth" TemplateID="BirthdayTemplate">
                    </telerik:RadCalendarDay>
                    <telerik:RadCalendarDay Date="2021/08/7" Repeatable="DayAndMonth" TemplateID="BirthdayTemplate">
                    </telerik:RadCalendarDay>
                </SpecialDays>
                <WeekendDayStyle CssClass="rcWeekend" />
                <CalendarTableStyle CssClass="rcMainTable" />
                <OtherMonthDayStyle CssClass="rcOtherMonth" />
                <OutOfRangeDayStyle CssClass="rcOutOfRange" />
                <DisabledDayStyle CssClass="rcDisabled" />
                <SelectedDayStyle CssClass="rcSelected" />
                <DayOverStyle CssClass="rcHover" />
                <FastNavigationStyle CssClass="RadCalendarMonthView RadCalendarMonthView_Material"></FastNavigationStyle>
                <CalendarTableStyle Font-Size="Larger" />
                <TitleStyle Font-Size="large" />
                <CalendarDayTemplates>
                        <telerik:DayTemplate ID="HolidayTemplate" runat="server">
                            <Content>
                                <div class="rcTemplate rcDayNH">
                                    National Holiday
                                </div>
                            </Content>
                        </telerik:DayTemplate>
                        <telerik:DayTemplate ID="WFHTemplate" runat="server">
                            <Content>
                                <div class="rcTemplate rcDayWFH">
                                    Work From Home
                                </div>
                            </Content>
                        </telerik:DayTemplate>
                        <telerik:DayTemplate ID="BirthdayTemplate" runat="server">
                            <Content>
                                <div class="rcTemplate rcDayBirthday">
                                    birthday
                                </div>
                            </Content>
                        </telerik:DayTemplate>
                    </CalendarDayTemplates>
                <ViewSelectorStyle CssClass="rcViewSel" />
            </telerik:RadCalendar>
        </div>
    </div>

</asp:Content>
