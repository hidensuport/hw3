-- -- Query 2

Select Count(Distinct Sellers.UserId) From Item, Sellers
Where Item.item_id = Sellers.item_id and Item.location = "New York"