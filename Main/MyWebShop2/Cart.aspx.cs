using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;

namespace MyWebShop2
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Cart cart = new Cart();
            decimal total = cart.GetTotal();
            if (total > 0)
            {
                // Display Total.
                TotalLabel.Text = String.Format("{0:c}", total);
            }
            else
            {
                // Display empty Shopping Cart.
                TotalLabel.Text = "";
                TotalTextLabel.Text = "";
                UpdateButton.Visible = false;
                CheckoutButton.Visible = false;
            }
        }

        protected void UpdateButton_Click(object sender, ImageClickEventArgs e)
        {
            Cart cart = new Cart();

            // Check for Updates
            CartUpdate[] cartUpdates = new CartUpdate[CartView.Rows.Count];
            for (int i = 0; i < CartView.Rows.Count; i++)
            {
                IOrderedDictionary rowValues = GetRowValues(CartView.Rows[i]);

                cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                cartUpdates[i].Quantity = Convert.ToInt32(rowValues["Quantity"]);

                CheckBox removeCheckBox = (CheckBox)CartView.Rows[i].FindControl("RemoveCheckBox");
                cartUpdates[i].IsRemove = removeCheckBox.Checked;
            }

            // Update Cart and Page
            cart.Update(cartUpdates);
            CartView.DataBind();
            TotalLabel.Text = String.Format("{0:c}", cart.GetTotal());
        }

        public static IOrderedDictionary GetRowValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }
    }
}