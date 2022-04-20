-- -- Query 4
Select item_id From Item
Where currently = (Select Max(currently)
From Item );