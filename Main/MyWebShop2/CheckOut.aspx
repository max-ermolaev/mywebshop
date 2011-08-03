<%@ Page Title="" Language="C#" MasterPageFile="~/My.Master" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="MyWebShop2.CheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Order Submission</h2>
    <span runat="server">
        <asp:Label id="OrderMessageLabel" runat="server" Text="Please check all the information below to be sure it&#39;s correct."></asp:Label>
    </span><br /><br /> 

    <asp:GridView ID="OrderView" runat="server" CellPadding="4" 
        DataSourceID="OrderDataSource" ForeColor="#333333" GridLines="None" 
        AutoGenerateColumns="False" DataKeyNames="ProductID,UnitCost,Quantity" 
        Width="100%">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" SortExpression="ProductID"  />
            <asp:BoundField DataField="ModelNumber" HeaderText="Model Number" SortExpression="ModelNumber" />
            <asp:BoundField DataField="ModelName" HeaderText="Model Name" SortExpression="ModelName" />
            <asp:BoundField DataField="UnitCost" HeaderText="Unit Cost" ReadOnly="True" SortExpression="UnitCost" DataFormatString="{0:c}" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" SortExpression="Quantity" />
            <asp:TemplateField> 
                <HeaderTemplate>Item&nbsp;Total</HeaderTemplate>
                <ItemTemplate>
                     <%# (Convert.ToDouble(Eval("Quantity")) *  Convert.ToDouble(Eval("UnitCost")))%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    <br />
    <br />

    <asp:ImageButton ID="SubmitButton" runat="server" ImageUrl="~/Styles/images/submit.png" 
        ImageAlign="Right" onclick="SubmitButton_Click" />

    <br />

    <asp:EntityDataSource ID="OrderDataSource" runat="server" 
        ConnectionString="name=EcommerceEntities" 
        DefaultContainerName="EcommerceEntities" EnableFlattening="False" 
        EntitySetName="DetailedCartRecords" Where="" 
        AutoGenerateWhereClause="True">
        <WhereParameters>
            <asp:SessionParameter Name="CartID" SessionField="CartId" DefaultValue="0" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
