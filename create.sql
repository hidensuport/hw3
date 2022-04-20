DROP TABLE if exists Category;
DROP TABLE if exists Sellers;
DROP TABLE if exists Item;
DROP TABLE if exists Bid;
DROP TABLE if exists Bidders;

-- This is a category table including all categories presented in the 
-- given data. A category_id is associated with each category and is 
-- used to link each item with its categories in ItemCategory table.
CREATE TABLE Category
(
 
 item_id      INT          NOT NULL ,
 Category_numbers VARCHAR(255) NOT NULL ,
 PRIMARY KEY (item_id,  Category_numbers ),
 FOREIGN KEY (item_id) REFERENCES Item (item_id)
);

CREATE TABLE Sellers
(
 item_id        INT          NOT NULL UNIQUE,
 UserId     VARCHAR(255) NOT NULL ,
 Rating      INT          NOT NULL,

 PRIMARY KEY (item_id)
);
 
CREATE TABLE Item
(
 item_id        INT          NOT NULL UNIQUE,
 name           VARCHAR(255) NOT NULL,
 currently      DOUBLE,
 buy_price      DOUBLE,
 first_bid      DOUBLE,
 number_of_bids INT          NOT NULL,
 country VARCHAR(255)          NOT NULL,
 location     VARCHAR(255)           NOT NULL,
 started        datetime     NOT NULL,
 ends           datetime     NOT NULL,
 description    VARCHAR(255) NOT NULL,
 PRIMARY KEY (item_id)
);
 

CREATE TABLE Bid
(
 id INT      NOT NULL UNIQUE ,
 bidder_id VARCHAR(255)      NOT NULL,
 bid_time  datetime NOT NULL,
 amount    DOUBLE   NOT NULL,
 PRIMARY KEY (id)

);
 
CREATE TABLE Bidders
(
 item_id  INT NOT NULL UNIQUE,
 UserId  VARCHAR(255) NOT NULL,
 Rating  INT NOT NULL,
 Location INT NOT NULL,
 Country  INT NOT NULL,
 PRIMARY KEY (item_id)

);
