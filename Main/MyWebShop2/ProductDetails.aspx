<%@ Page Title="" Language="C#" MasterPageFile="~/My.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="MyWebShop2.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="ProductDetailsView" runat="server" 
        DataSourceID="ProductDataSource">
        <ItemTemplate>
            <div>
                <h2><%# Eval("ModelName") %></h2>
            </div>
            <br />
            <table>
                <tr>
                    <td style="vertical-align: top">
                        <img src='~/Styles/Images/image_02.jpg' alt='<%# Eval("ModelName") %>' runat="server" />
                    </td>
                    <td style="vertical-align: top">
                        <h3>Description:</h3><br />
                        <%# Eval("Description") %><br /><br /><br />
                        <span><b>Your Price:</b>&nbsp;<%# Eval("UnitCost", "{0:c}")%></span><br /><a href='AddToCart.aspx?ProductId=<%# Eval("ProductID") %>'><b>Add To Cart</b>
                        </a>
                        <br />
                        <br />
                    </td>
                </tr>
            </table>

        </ItemTemplate>
    </asp:FormView>
    <asp:EntityDataSource ID="ProductDataSource" runat="server" 
        AutoGenerateWhereClause="True" ConnectionString="name=EcommerceEntities" 
        DefaultContainerName="EcommerceEntities" EnableFlattening="False" 
        EntitySetName="Products" Where="">
        <WhereParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductId" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>