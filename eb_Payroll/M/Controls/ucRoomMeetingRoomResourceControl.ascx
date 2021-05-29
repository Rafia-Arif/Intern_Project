<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRoomMeetingRoomResourceControl.ascx.cs" Inherits="Controls_ucRoomMeetingRoomResourceControl" %>

<%--
	This is a custom control used for editing resources that support single values.
	
	It contains a label and DropDownList.
--%>

<asp:Label runat="server" ID="ResourceLabel" AssociatedControlID="ResourceValue" Text='<%# Label %>' CssClass="rsAdvResourceLabel" /><!--
--><telerik:RadComboBox runat="server" ID="ResourceValue" CssClass="rsAdvResourceValue" />
<asp:RequiredFieldValidator runat="server" ID="ResourceValueValidator" ControlToValidate="ResourceValue"
    EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" ValidationGroup='<%#Owner.ValidationGroup %>' ErrorMessage="Room is Required" />