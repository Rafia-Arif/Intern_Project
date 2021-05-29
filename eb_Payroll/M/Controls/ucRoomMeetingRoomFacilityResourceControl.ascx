<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRoomMeetingRoomFacilityResourceControl.ascx.cs" Inherits="Controls_ucRoomMeetingRoomFacilityResourceControl" %>

<%--
	This is a custom control used for editing resources that support multiple values.
	
	It contains a label and a slightly modified CheckBoxList control (added at runtime).
	
	The modification only serves to change the markup of the CheckBoxList, so it renders
	an unordered list, instead of a table.
--%>


<asp:Label runat="server" ID="ResourceLabel" AssociatedControlID="ResourcesValue" Text='<%# Label %>' CssClass="rsAdvResourceLabel" /><!--
--><telerik:RadComboBox runat="server" ID="ResourcesValue" CssClass="rsAdvResourceValue" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" />