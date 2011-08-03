using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyWebShop2.Data_Access;

namespace MyWebShop2
{
    public partial class My : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Migrates Shopping Cart when User logs in.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnLoggedIn(object sender, EventArgs e)
        {
            if (Session["CartId"] != null)
            {
                Login login = sender as Login;

                if (login != null)
                {
                    String userName = login.UserName;
                    (new Cart()).Migrate(userName);
                }
                else
                {
                    throw new InvalidCastException("ERROR: Unable to Cast object to Login type");
                }
            }
        }

        /// <summary>
        /// Cleans Shopping Cart when User logs out.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnLoggingOut(object sender, EventArgs e)
        {
            (new Cart()).Clean();
        }

        protected void searchbutton_Click(object sender, EventArgs e)
        {
            string keyword = searchfield.Value;
            Response.Redirect("~/ProductList.aspx?Keyword=" + keyword);
        }
    }
}