-- -- Query 3

Select Count(*) From (Select Category.item_id, Count(*) as numCategories
						From Category 
						Group By Category.item_id)
						Where numCategories = 4;



