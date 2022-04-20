-- -- Query 1


DROP VIEW IF EXISTS users; 
CREATE VIEW users AS

Select Count(Distinct Sellers.UserId) as UserCount From Sellers
Where Sellers.UserId NOT IN (Select Bid.bidder_id From Bid) 

UNION

Select Count(Distinct Bid.bidder_id) From Bid
Where Bid.bidder_id NOT IN (Select Sellers.UserId
From Sellers)

UNION

Select Count(Distinct Bid.bidder_id) From Bid
Where Bid.bidder_id IN (Select Sellers.UserId
From Sellers);


Select Sum(UserCount) from users;

-- -- Query 2

Select Count(Distinct Sellers.UserId) From Item, Sellers
Where Item.item_id = Sellers.item_id and Item.location = "New York"

-- Select Count(Distinct Bid.bidder_id) From Bid, Bidders, Item
-- Where Bid.bidder_id = Bidders.UserId and Bidders.item_id = Item.item_id and Item.location = "New York"
-- and Bidders.UserId IN (Select Sellers.UserId From Sellers);



-- -- Query 4
-- Select item_id From Item
-- Where currently = (Select Max(currently)
-- From Item );


-- -- Query 5
-- Select Count(Distinct UserId) From Sellers
-- Where Rating > 1000;


-- Query 6
-- Select Count(Distinct Sellers.UserId) From Sellers;
-- Select Count(Distinct Bid.bidder_id) From Bid
-- Where Bid.bidder_id IN (Select Sellers.UserId
-- From Sellers);

-- Select Count(Distinct Bidders.UserId) From Bidders
-- Where Bidders.UserId IN (Select Sellers.UserId
-- From Sellers);

-- Query 7

