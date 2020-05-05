CREATE TABLE Users
(
	id SERIAL UNIQUE PRIMARY KEY,
	name varchar(255) not null,
	email varchar(255) unique not null,
	password varchar(30) not null,
	date_signup DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Managers (
	mid integer primary key,
	foreign key (mid) references Users(id)
	on delete cascade
);
--INSERT into Users(Customer);

CREATE TABLE Customers
(
	cid integer,
	points integer default 0,
	creditCard integer,
	primary key (cid),
	foreign key (cid) references Users(id)
	on delete cascade
);

CREATE TABLE Riders
(
	rid integer,
	totalOrders integer default 0,
	-- trigger case fulltime reset to 0 every end of month, PT end week
	primary key (rid),
	foreign key (rid) references Users(id)
	on delete cascade
);
/*rider availability => create view when needed*/

CREATE TABLE Restaurants
(
	minOrder integer,
	-- use trigger to check in order??
	rname varchar(255) unique not null,
	descript varchar(255),
	primary key (rname)
);

CREATE TABLE Orders
(
	orid SERIAL UNIQUE PRIMARY KEY,
	cid integer,
	rname varchar(255),
	cartCost integer,
	--generate in query
	location varchar(50),
	ostatus o_status DEFAULT 'Ongoing',
	foreign key (rname) references Restaurants(rname)
	on delete cascade
);
--check min order from restaurants


CREATE TABLE Deliver
(
	orid integer unique,
	rid integer,
	fee integer,
	--based on time criteria
	dstatus d_status DEFAULT 'Rider is departing for restaurant',
	--use trigger function to update status based on deliveryTime
	primary key (orid),
	foreign key (orid) references Orders(orid) on delete cascade,
	foreign key (rid) references Riders(rid) on delete cascade
);
--transaction with completedOrders by rider on status is complete

CREATE TABLE DeliveryTime
(
	orid integer unique,
	departForR timestamp,
	arriveForR timestamp,
	departFromR timestamp,
	deliveredTime timestamp,
	primary key (orid),
	foreign key (orid) references Orders(orid) 
    on update cascade
	on delete cascade
);

CREATE TABLE Sells
(
	rname varchar not null,
	fname varchar unique not null,
	sold integer default 0,
	--trigger based on time reset daily
	flimit integer,
	avail bool,
	--use trigger here based on limit-sold
	category e_category not null,
	price integer,
	primary key (rname, fname),
	foreign key (rname) references Restaurants (rname)
);

CREATE TABLE OrderItems
(
	-- for restaurant staffs to refer to 
	orid integer,
	fname varchar,
	quantity integer not null,
	primary key(fname, orid),
	foreign key (orid) references Orders (orid)
	on delete cascade,
	foreign key (fname) references Sells (fname)
	on delete cascade
);

--CREATE TABLE OrdersDeliveredBy (
--	orid integer,
--    rid integer,
--    deliveredTime timestamp,
--    primary key (orid),
--    foreign key (orid) references Deliver(orid),
--    foreign key (rid) references Deliver(rid),
--    foreign key (deliveredTime) references DeliveryTime(deliveredTime)
--); --getting updates from deliver and deliverytime

CREATE TABLE Staffs
(
	rname varchar(255),
	stid integer,
	foreign key (stid) references Users(id) on delete cascade,
	foreign key (rname) references Restaurants(rname) on delete cascade
);

CREATE TABLE Reviews
(
	orid integer,
	foodReview text,
	deliveryRating integer,
	primary key (orid),
	foreign key (orid) references Orders
	on delete cascade
);

CREATE TABLE FTRiders
(
	rid integer,
	foreign key (rid) references Riders(rid) on delete cascade
);
--for monthly fees, count delivery + fixed monthly pay

CREATE TABLE PTRiders
(
	rid integer,
	foreign key (rid) references Riders(rid) on delete cascade
);

--standardise the way we count the week and days?
--stores all working times of each rider
--create view (rid, hours, month, day)=>full schedule to check current available riders
CREATE TABLE WWS
(
	rid integer,
	wDay text,
	--mon/tues/wed/thur
	whichMonth integer,
	Week integer,
	startT TIME,
	endT TIME,
	foreign key (rid) references Riders(rid)
	on delete cascade
);--trigger to check work >= 10hours per week

--just to store the fixed shifts, must make sure shift duration dont exceed 4 hrs
CREATE TABLE templateShift
(
	Shift integer,
	Start1 TIME,
	End1 TIME,
	Start2 TIME,
	End2 TIME,
	primary key (Shift)
);

CREATE TABLE MWS
(
	--Will update schedule based on the shift 
	rid integer,
	whichMonth integer,
	startDay text,
	--mon
	startDate DATE not null,
	Day1Shift integer references templateShift (shift) not null,
	--which shift
	Day2Shift integer references templateShift (shift) not null,
	Day3Shift integer references templateShift (shift) not null,
	Day4Shift integer references templateShift (shift) not null,
	Day5Shift integer references templateShift (shift) not null,
	foreign key (rid) references Riders on delete cascade,
	primary key (rid, startDate)
);

CREATE TABLE Salary
(
	rid integer primary key,
	deliveryFees integer,--counted weekly for PT and monthly for FT
	basePay integer,
	foreign key (rid) references Riders on delete cascade
);

CREATE TABLE allPromotions
(
	pid SERIAL UNIQUE primary key,
	startD DATE,
	endD DATE
);

CREATE TABLE RPromotions
(
	--restaurants may offer promotional prices for menu items
	pid integer primary key,
	discount integer,
	rname varchar(30),
	fname varchar(30),
	startD DATE,
	endD DATE,
	foreign key (pid) references allPromotions on delete cascade,
	foreign key (rname) references Restaurants on delete cascade,
	foreign key (fname) references Sells (fname) on delete cascade
);

CREATE TABLE FDPromotions
(
	pid integer primary key,
	discount integer,
	startD DATE,
	endD DATE,
	foreign key (pid) references allPromotions on delete cascade
);

-- insert test data into users

