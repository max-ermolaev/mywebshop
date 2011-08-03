<%@ Page Title="Log In" Language="C#" MasterPageFile="~/My.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="MyWebShop2.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Log In
    </h2>
    <p>
        You can do it using login form on the left panel.
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">Register</asp:HyperLink> if you don't have an account.
    </p>
    
</asp:Content>
