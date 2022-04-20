"""
FILE: skeleton_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Modified: 04/21/2014
Skeleton parser for CS564 programming project 1. Has useful imports and
functions for parsing, including:
1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.
Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!

"""
import sys
from json import loads
from re import sub

columnSeparator = "|"

# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
"""
def transformDttm(dttm):
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):
    with open(json_file, 'r') as f:
        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file
        for item in items:
            CategoryTable(item)
            ItemTable(item)  
            SellerTable(item)
            BidTable(item)
            BidderTable(item)
Category = []
def CategoryTable(item):
    global Category
    if item['Category'] is None: return
    k = -1
    for i in item['Category']:
      k=k+1
      element = item['ItemID']+ '|'
      element += str(item['Category'][k])
      Category.append(element + "\n")
Item = []
ItemCategory = []
ItemSeller = []
def ItemTable(item):
    global Item
    global ItemCategory
    itemid = item['ItemID']
    name = item['Name'].replace('"', '""')
    currently = transformDollar(item['Currently'])
    buy_price = transformDollar(item['Buy_Price']) if "Buy_Price" in item else 'NULL'
    first_bid = transformDollar(item['First_Bid'])
    number_of_bids = item['Number_of_Bids']
    country = item['Country'].replace('"', '""')
    location = item['Location'].replace('"', '""')
    started = transformDttm(item['Started'])
    ends = transformDttm(item['Ends'])
    description = item['Description'].replace('"', '""') if item['Description'] is not None else ""
    Item.append('"' + '"|"'.join([itemid, name, currently, buy_price, first_bid, number_of_bids,country, location, started, ends, description]) + '"\n')
    
Sellers = []
def SellerTable(item):
    global Sellers
    if item['Seller'] is None: return
    element = item['ItemID']+ '|'
    element += item['Seller']['UserID'] + '|'
    element += item['Seller']['Rating']
    Sellers.append( element + "\n")
Bidders = []
subkeys = ['UserID','Rating','Location','Country']
def BidderTable(item):
    global Bidders
    if item['Bids'] is None: return
    
    for bid in item['Bids']: 
      element = item['ItemID']+ '|'
      bidder = bid['Bid']['Bidder']
      element += bid['Bid']['Bidder']['UserID'] + '|'
      element += bid['Bid']['Bidder']['Rating'] + '|'
      if 'Location' in bid['Bid']['Bidder']: 
          element += bid['Bid']['Bidder']['Location'] + '|'
      else:
        element += "NULL|"
      if 'Country' in bid['Bid']['Bidder']: 
          element += bid['Bid']['Bidder']['Country']
      else:
        element += "NULL"
    Bidders.append( element + "\n")
Bid = []
def BidTable(item):
    global Bid
    if item['Bids'] is None: return
    for bid in item['Bids']: 
        bid_id  = str(len(Bid) + 1)+ '|'
        element = item['ItemID']+ '|'
        element += bid['Bid']['Bidder']['UserID'] + '|'
        element += transformDttm(bid['Bid']['Time']) + '|'
        element += transformDollar(bid['Bid']['Amount'])
        Bid.append(bid_id  + element + "\n")
"""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def output():
    folder = ""

    with open(folder + "Category.dat","w") as f:
        f.write("".join(Category))
    
    with open(folder + "Item.dat","w") as f: 
        f.write("".join(Item)) 
    with open(folder + "Sellers.dat","w") as f: 
        f.write("".join(Sellers))
    with open(folder + "Bidders.dat","w") as f: 
        f.write("".join(Bidders))
    with open(folder + "Bid.dat","w") as f: 
        f.write("".join(Bid))
def main(argv):
    if len(argv) < 2:
        print >> sys.stderr, 'Usage: python skeleton_json_parser.py <path to json files>'
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print "Success parsing " + f
    output()
if __name__ == '__main__':
    main(sys.argv)
