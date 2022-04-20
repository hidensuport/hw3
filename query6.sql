-- Query 6
Select Count(Distinct Bid.bidder_id) From Bid
Where Bid.bidder_id IN (Select Sellers.UserId
From Sellers);