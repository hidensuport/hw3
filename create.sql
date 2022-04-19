DROP TABLE if exists Items;
DROP TABLE if exists Category;
DROP TABLE if exists Bids;
DROP TABLE if exists Bidder;
DROP TABLE if exists Seller;

CREATE TABLE Items
(
 ItemId   INT          NOT NULL UNIQUE,
 Name VARCHAR(255) NOT NULL UNIQUE,
 Buy_Price DOUBLE，
 First_Bid DOUBLE，
 Number_of_Bids INT          NOT NULL,
 Location    VARCHAR(255)          NOT NULL,
 started        datetime     NOT NULL,
 ends           datetime     NOT NULL,
 description    VARCHAR(255) NOT NULL,
 country VARCHAR(255)          NOT NULL,
 started VARCHAR(255)          NOT NULL,
 ends VARCHAR(255)          NOT NULL,
 Seller_id VARCHAR(255)          NOT NULL
 description VARCHAR(255)          NOT NULL,
 PRIMARY KEY (ItemId),
 FOREIGN KEY (Seller_Id) REFERENCES Bid (Seller_Id),
);
CREATE TABLE Category
(
 item_id      INT          NOT NULL UNIQUE,
 CategoryName VARCHAR(255) NOT NULL UNIQUE,
 PRIMARY KEY (CategoryId),
 FOREIGN KEY (ItemId) REFERENCES Bid (ItemId),
);
CREATE TABLE Bids
(
 BidsId   INT          NOT NULL UNIQUE,
 bidder_id VARCHAR(255) NOT NULL UNIQUE,
 bid_time  datetime NOT NULL,
 amount    DOUBLE   NOT NULL,
 PRIMARY KEY (CategoryId),
 FOREIGN KEY (bidder_id) REFERENCES Bid (UserId),
);
CREATE TABLE Bidder
(
 Location   INT          NOT NULL UNIQUE,
 country INT          NOT NULL UNIQUE,
 user_id     VARCHAR(255) NOT NULL UNIQUE,
 Rating    VARCHAR(255)   NOT NULL,
 PRIMARY KEY (UserID)
);
CREATE TABLE Seller
(
 item_id      INT          NOT NULL UNIQUE,
 Rating     VARCHAR(255) NOT NULL UNIQUE,
 PRIMARY KEY (UserID)
);

Items(ItemId: int, Name: string, Buy_Price: string, First_Bid: string, Number_of_Bids: int, Location: string, country: string, started: string, ends: string, Seller_id: string, description: string)
Primary Key: ItemId
Foreign Keys:Seller_Id -> Seller:Seller_Id

Category(ItemId: int, Description: string)
Primary Key: ItemId, Description
Foreign Keys: ItemId->Items:ItemId

Bids(ItemId: int, bidder_id: string, Time: string, Amount: string)
Primary Key: bidder_id, Time
Foreign Keys: ItemId -> Items:ItemId, bidder_id->Bidder:UserId

Bidder(Location: string, country: string, UserID: string, Rating: int)
Primary Key: UserID
Foreign Keys: none 

Seller(UserId: string, Rating: int)
Primary Key: UserId
Foreign Keys: none