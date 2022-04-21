-- -- Query 7

Select Count(Distinct Category.Category_numbers) From Category, Item, Bid
Where Category.item_id = Item.item_id and Item.item_id = Bid.item_id and Bid.amount > 100; 

