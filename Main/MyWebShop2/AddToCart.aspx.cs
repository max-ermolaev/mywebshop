using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyWebShop2
{
    public partial class AddToCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Add to Cart
            int productId;
            if (Int32.TryParse(Request.QueryString["ProductID"], out productId))
            {
                (new Cart()).AddProduct(productId, 1);
            }

            // Redirect to Cart Page
            Response.Redirect("Cart.aspx");
        }
    }
}