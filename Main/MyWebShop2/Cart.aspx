<%@ Page Title="" Language="C#" MasterPageFile="~/My.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MyWebShop2.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="ShoppingCartTitle" runat="server"><h2>Shopping Cart</h2></div>
    <asp:GridView ID="CartView" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="ProductID,UnitCost,Quantity" 
        DataSourceID="CartRecordsDataSource" CellPadding="4" ForeColor="#333333" 
        GridLines="None">
        <EmptyDataTemplate><h4>It's Empty</h4></EmptyDataTemplate>
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID"
                SortExpression="ProductID" />
            <asp:BoundField DataField="ModelName" HeaderText="Model Name" 
                SortExpression="ModelName" />
            <asp:BoundField DataField="ModelNumber" HeaderText="Model Number" 
                SortExpression="ModelNumber" />
            <asp:BoundField DataField="UnitCost" HeaderText="Unit Cost" 
                SortExpression="UnitCost" ReadOnly="True"
                DataFormatString="{0:c}" />
            <asp:TemplateField>
                <HeaderTemplate>Quantity</HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="QuantityTextBox" Width="40" runat="server"
                        Text='<%# Bind("Quantity") %>'>
                    </asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>Item&nbsp;Total</HeaderTemplate>
                <ItemTemplate>
                    <%# String.Format("{0:c}", Convert.ToDouble(Eval("Quantity")) * Convert.ToDouble(Eval("UnitCost"))) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>Remove&nbsp;Item</HeaderTemplate>
                <ItemTemplate>
                    <center>
                        <asp:CheckBox ID="RemoveCheckBox" runat="server" />
                    </center>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
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

    <div style="float: right; height: 22px; margin-left: 36px;">
        <strong>
            <asp:imagebutton id="UpdateButton" runat="server"
                            ImageURL="~/Styles/Images/update.png" 
             onclick="UpdateButton_Click" ImageAlign="Right" Height="16px">
            </asp:imagebutton>
            <asp:Label id="TotalTextLabel" runat="server" Text="Order Total : ">
            </asp:Label>
            <asp:Label CssClass="NormalBold" id="TotalLabel" runat="server" EnableViewState="false">
            </asp:Label>&nbsp;&nbsp;
        </strong> 
    </div>

    <br />
    <br />
    <br />

    <asp:imagebutton id="CheckoutButton" runat="server"
                     ImageURL="~/Styles/Images/checkout_button.png"
                     PostBackUrl="~/CheckOut.aspx" 
                     ImageAlign="Right">
    </asp:imagebutton>

    <br />

    <asp:EntityDataSource ID="CartRecordsDataSource" runat="server" 
        ConnectionString="name=EcommerceEntities" 
        DefaultContainerName="EcommerceEntities" EnableFlattening="False" 
        EntitySetName="DetailedCartRecords" AutoGenerateWhereClause="True" 
        Where="" EnableDelete="True" EnableUpdate="True">
        <WhereParameters>
            <asp:SessionParameter Name="CartID" SessionField="CartId" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
