<%@ Page Title="" Language="C#" MasterPageFile="~/My.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="MyWebShop2.ProductList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="ProductsView" runat="server" 
        DataSourceID="ProductsDataSource" GroupItemCount="3">
        <EmptyDataTemplate>No Results.</EmptyDataTemplate>
        <GroupTemplate>
            <tr>
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <ItemTemplate>
            <td runat="server">
                <div class="product_box margin_r35">
                    <h3><%# Eval("ModelName") %></h3>
                    <div class="image_wrapper"> <a href="#"><img src="Styles/images/image_02.jpg" alt="" /></a> </div>
                    <p class="price">Price: <%# Eval("UnitCost", "{0:c}") %></p>
                    <a href='ProductDetails.aspx?ProductId=<%# Eval("ProductID") %>'>Detail</a> | <a href='AddToCart.aspx?productId=<%# Eval("ProductID") %>'>To Cart</a>
                </div>
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table>
                <tr>
                    <td>
                        <table>
                            <tr id="groupPlaceholder" runat="server"></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>

    <asp:EntityDataSource ID="ProductsDataSource" runat="server" ConnectionString="name=EcommerceEntities" 
        DefaultContainerName="EcommerceEntities" EnableFlattening="False" 
        EntitySetName="Products"
        Where="it.CategoryID = @CategoryID OR CONTAINS(it.ModelName, @Keyword) OR (@Keyword IS NULL AND @CategoryId IS NULL)"
        EntityTypeFilter="Product" Select="">
        <WhereParameters>
            <asp:QueryStringParameter Name="CategoryID" QueryStringField="CategoryId" Type="Int32" />
            <asp:QueryStringParameter Name="Keyword" QueryStringField="Keyword" Type="String" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
