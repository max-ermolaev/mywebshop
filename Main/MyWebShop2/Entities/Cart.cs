using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyWebShop2.Data_Access;

namespace MyWebShop2
{
	/// <summary>
	/// Represents an update of a record in shopping cart.
	/// </summary>
	public struct CartUpdate
	{
		public int ProductId;
		public int Quantity;
		public bool IsRemove;
	}

	public partial class Cart
	{
		public void Clean()
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					String cartId = this.GetId();
					var cartRecords = (from r in db.CartRecords
									   where r.CartID == cartId
									   select r);
					foreach (CartRecord r in cartRecords)
					{
						db.CartRecords.DeleteObject(r);
					}

					db.SaveChanges();
				}
				catch (Exception)
				{

					throw new Exception("ERROR: Unable to clean user's cart.");
				}
			}
		}

		public void AddProduct(int productId, int quantity)
		{
			using(EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					string cartId = this.GetId();

					// Try to get cart record with the same product's ID
					var cartRecord =
						(from c in db.CartRecords
						 where c.CartID == cartId && c.ProductID == productId
						 select c).SingleOrDefault();

					if (cartRecord != null)
					{
						// Then just increase quantity
						cartRecord.Quantity += quantity;
					}
					else
					{
						// Create new record
						CartRecord record = new CartRecord()
						{
							CartID = cartId,
							Quantity = quantity,
							ProductID = productId
						};

						// And add it to the database
						db.CartRecords.AddObject(record);
					}

					db.SaveChanges();
				}
				catch (Exception)
				{

					throw new Exception("Error: Unable to Add Product to Cart");
				}
			}
		}

		private string GetId()
		{
			if (Session["CartId"] == null)
			{
				Session["CartId"] =
					HttpContext.Current.Request.IsAuthenticated ?
					User.Identity.Name : Guid.NewGuid().ToString();
			}
			return Session["CartId"].ToString();
		}

		public decimal GetTotal()
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				decimal total = 0;
				try
				{
					string cartId = this.GetId();
					var cartRecords = (from c in db.DetailedCartRecords
									   where c.CartID == cartId
									   select c);
					if (cartRecords.Count() > 0)
					{
						total = cartRecords.Sum(c => (decimal)(c.Quantity * c.UnitCost));
					}
				}
				catch (Exception e)
				{

					throw new Exception("ERROR. Unable to Calculate Order Total: " + e.Message, e);
				}
				return total;
			}
		}

		public void Update(CartUpdate[] updates)
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					int itemCount = updates.Count();
					string cartId = this.GetId();
					var cartRecords = (from c in db.DetailedCartRecords
									   where c.CartID == cartId
									   select c);
					foreach (var record in cartRecords)
					{
						for (int i = 0; i < itemCount; i++)
						{
							if (updates[i].ProductId == record.ProductID)
							{
								if (updates[i].Quantity < 0 || updates[i].IsRemove)
								{
									this.RemoveRecord(record.ProductID);
								}
								else
								{
									UpdateRecord(record.ProductID, updates[i].Quantity);
								}
							}
						}
					}
				}
				catch (Exception e)
				{
					throw new Exception("ERROR: Unable to Update Cart Database - " + e.Message.ToString(), e);
				}
			}
		}

		public void UpdateRecord(int productId, int quantity)
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					string cartId = (new Cart()).GetId();
					CartRecord recordToUpdate = (from c in db.CartRecords
												   where c.CartID == cartId && c.ProductID == productId
												   select c).SingleOrDefault();
					if (recordToUpdate != null)
					{
						recordToUpdate.Quantity = quantity;
						db.SaveChanges();
					}
				}
				catch (Exception e)
				{

					throw new Exception("ERROR: Unable to Update Cart Item - " + e.Message.ToString(), e);
				}
			}
		}

		public void RemoveRecord(int productId)
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					string cartId = (new Cart()).GetId();
					CartRecord recordToDelete = (from c in db.CartRecords
												   where c.CartID == cartId && c.ProductID == productId
												   select c).SingleOrDefault();
					if (recordToDelete != null)
					{
						db.CartRecords.DeleteObject(recordToDelete);
						db.SaveChanges();
					}
				}
				catch (Exception e)
				{

					throw new Exception("ERROR: Unable to Remove Cart Item - " + e.Message.ToString(), e);
				}
			}
		}

		public void Migrate(String newCartId)

		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					String oldCartId = this.GetId();
					var cartRecords = (from c in db.CartRecords
									   where c.CartID == oldCartId
									   select c);

					foreach (CartRecord c in cartRecords)
					{
						c.CartID = newCartId;
					}
					db.SaveChanges();
					Session["CartId"] = newCartId;
				}
				catch (Exception)
				{
					
					throw new Exception("ERROR: Unable to Migrate Shopping Cart");
				}
			}
		}

		public bool SubmitOrder()
		{
			using (EcommerceEntities db = new EcommerceEntities())
			{
				try
				{
					// Shopping Cart ID is the user name
					// since only authorized users are able to submit
					String userName = this.GetId();

					// Add New Order Record
					DateTime shipDate = CalculateShipDate();
					Order order = new Order()
					{
						CustomerName = userName,
						OrderDate = DateTime.Now,
						ShipDate = shipDate,
					};
					db.Orders.AddObject(order);
					db.SaveChanges();

					// Create a new OrderDetail record
					// for each item in the Shopping Cart
					var detailedCartRecords = (from r in db.DetailedCartRecords
											   where r.CartID == userName
											   select r);
					foreach (DetailedCartRecord detailedCartRecord in detailedCartRecords)
					{
						OrderDetail orderDetail = new OrderDetail()
						{
							OrderID = order.OrderID,
							ProductID = detailedCartRecord.ProductID,
							Quantity = detailedCartRecord.Quantity,
						};

						var uselessRecord = 
							(from r in db.CartRecords
							 where r.CartID == detailedCartRecord.CartID && r.ProductID == detailedCartRecord.ProductID
							 select r).SingleOrDefault();
						if (uselessRecord != null)
						{
							db.DeleteObject(uselessRecord);
						}
					}
					db.SaveChanges();
				}
				catch (Exception)
				{

					return false;
				}
			}

			return true;
		}

		private DateTime CalculateShipDate()
		{
			DateTime shipDate = DateTime.Now.AddDays(2);
			return shipDate;
		}
	}
}