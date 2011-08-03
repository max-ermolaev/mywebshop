using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyWebShop2
{
    public partial class CheckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (OrderView.Rows.Count == 0)
            {
                OrderMessageLabel.Text = "Your Shopping Cart is Empty";
                SubmitButton.Visible = false;
            }
            else if (!User.Identity.IsAuthenticated)
            {
                OrderMessageLabel.Text = "You have to log in to submit your order.";
                SubmitButton.Visible = false;
                OrderView.Style.Value = "display: none";
            }
        }

        protected void SubmitButton_Click(object sender, ImageClickEventArgs e)
        {
            Cart cart = new Cart();
            if (cart.SubmitOrder())
            {
                OrderMessageLabel.Text = "Thank You - Your Order is Complete.";
                SubmitButton.Visible = false;
            }
            else
            {
                OrderMessageLabel.Text = "Order Submission Failed - Please try again.";
            }

            OrderView.Style.Value = "display: none";
        }
    }
}