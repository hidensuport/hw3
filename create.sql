DROP TABLE if exists Category;
DROP TABLE if exists Sellers;
DROP TABLE if exists Item;
DROP TABLE if exists Bid;
DROP TABLE if exists Bidders;


CREATE TABLE Category
(
 item_id      INT          NOT NULL UNIQUE,
 Description VARCHAR(255) NOT NULL UNIQUE,
 PRIMARY KEY (item_id),
 FOREIGN KEY (item_id) REFERENCES Bid (item_id)
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
 item_id    INT      NOT NULL ,
 bidder_id VARCHAR(255)      NOT NULL,
 bid_time  datetime NOT NULL,
 amount    DOUBLE   NOT NULL,
 PRIMARY KEY (bid_time),
 FOREIGN KEY (item_id) REFERENCES USER (user_id)
);
 
CREATE TABLE Bidders
(
 UserId  VARCHAR(255) NOT NULL UNIQUE,
 Rating  INT NOT NULL,
 Location INT NOT NULL,
 Country  INT NOT NULL,
 PRIMARY KEY (UserId)

);