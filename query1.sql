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










