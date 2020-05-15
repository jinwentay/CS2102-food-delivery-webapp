-- fake data for schema.sql for everyone to have a commmon database

INSERT INTO Users
    (name, email, password, date_signup)
VALUES
    ('Athene Stuffins', 'customer@gmail.com', 'abcde', '2020-02-01'),
    ('Darbee Hadwick', 'dhadwick1@amazon.de', 'T3BAJF8', '2020-02-01'),
    ('Hollyanne Shelton', 'hshelton2@behance.net', '2PrXOPzOClr', '2020-02-01'),
    ('Angele Oxborough', 'aoxborough3@netlog.com', '66EsfeREPmJk', '2020-02-01'),
    ('Franciskus Moffatt', 'sawadeekap@gmail.com', 'thaimilktea', '2020-01-01'),
    ('Ruthie Nears', 'rnears5@fc2.com', 'ea7YdlIzyr', '2020-01-01'),
    ('Cart Esp', 'cesp6@wordpress.org', '7eZfcPkBu3T', '2020-01-01'),
    ('Mar Fincher', 'songfeng@songfengco.com', 'asdfg', '2020-01-01'),
    ('Devondra Haresnape', 'yumyum@google.it', '12345', '2020-01-01'),
    ('Wash Fish', 'wfish1@freewebs.com', 'P5Nt5P', '2020-04-01'),
    ('Bucky Maple', 'kfcftw@hotmail.com', 'P@ssw0rd', '2020-04-01'),
    ('Nerea Rosa', 'magna@fringillaestMauris.edu', 'NXN89PWN5IY', '2020-04-01'),
    ('Dahlia Dodson', 'In.ornare.sagittis@semper.co.uk', 'DTC15WZS8SM', '2020-04-01'),
    ('Ulric Casey', 'Nam@temporestac.com', 'UHY04ZIA0BL', '2020-03-01'),
    ('Julie Ballard', 'fringilla@eumetus.org', 'BKJ77ION4WC', '2020-03-01'),
    ('Fiona Cooley', 'hendrerit.Donec@metuseuerat.co.uk', 'TDM29COZ8CX', '2020-03-01'),
    ('Ashton Carter', 'mollis.vitae@ac.net', 'LAS40RWN5UJ', '2020-03-05'),
    ('Levi Barber', 'massa.non@Curabiturdictum.edu', 'ATO66CZL6EN', '2020-04-01'),
    ('Caleb Brooks', 'iaculis@Donecfelisorci.com', 'JLT05ILN4MB', '2020-05-01'),
    ('Mark Perez', 'nibh.enim.gravida@velarcu.ca', 'NQR04WUD1HJ', '2020-05-01'),
    ('Jade Myers', 'velit@mollis.edu', 'abcde', '2020-05-01'),
    ('Jin Wen', 'jinwenntay@gmail.com', 'abcde', '2020-01-01'),
    ('Jin Wen Tay', 'jinwen.tay@u.nus.edu', 'abcde', '2020-05-06'),
    ('Speedy Rider', 'speedyzoom@gmail.com', 'abcde', '2020-05-06'),
    ('Tan Ji Gen', 'customertest@gmail.com', 'abcde', '2020-04-07'),
    ('Manager Test', 'managertest@gmail.com', 'abcde', '2020-05-07'),
    ('Chew Yixin', 'ptridertest@gmail.com', 'abcde', '2020-01-07'),
    ('Mary Trout', 'ftridertest@gmail.com', 'abcde', '2020-01-07'),
    ('Staff Test', 'stafftest@gmail.com', 'abcde', '2020-05-07'),
    ('Amy Tan', 'callmeamy@gmail.com', 'password', '2020-05-01'),
    ('Umi San', 'ilovejapan@gmail.com', 'abcde', '2020-01-01')

;

INSERT INTO Managers
    (mid)
VALUES
    (22),
    (26);

-- 4 customers: 1,4,6,7,12,13,14,15, 25
INSERT INTO Customers
    (cid, points, creditcard)
VALUES
    (1, 2, 303179),
    (4, 3, 401795),
    (6, 2, 354067),
    (7, 3, 355605),
    (12, 1, 352205),
    (13, 1, 310605),
    (14, 2, 489005),
    (15, 3, 235601),
    (23, 0, 123456),
    (25, 4, 133557),
    (30, 0, 221220);

-- 2 riders: 2,3,16,17,18
INSERT INTO Riders
    (rid, totalOrders)
VALUES
    (2, 2),
    (3, 3),
    (16, 4),
    (17, 3),
    (18, 5),
    (24, 0),
    (27, 3),
    (28, 1);

INSERT INTO Restaurants
    (minOrder, rname, descript, address)
VALUES
    (20, 'Chinese Kitchen', 'Huangyingguangling', 'Changi Village'),
    (7, 'Song Feng Chicken', 'Lai Girl what you want', 'Jurong East'),
    (15, 'Naknoh Thai', 'sawaddekap', 'Supper Stretch'),
    (5, 'Nippi Place', 'ONE PLAIN PRATAAAA', 'Serangoon'),
    (10, 'Sayonara', 'Irasshaimase!', 'Yishun'),
    (5, 'McD', 'Finger Lickin Good', 'Changi'),
    (3, 'King Fried Chicken', 'Finger Licking Great', 'Home');

--as of 21 March
INSERT INTO Sells
    (rname, fname, sold, flimit, avail, category, price, fdescript)
VALUES
    ('Chinese Kitchen', 'Beef Horfun', 2, 10, true, 'Chinese', 6, 'Horfun with beef fried to perfection'),
    ('Chinese Kitchen', 'Seafood Horfun', 2, 10, true, 'Chinese', 6, '3 types of fish and squid horfun'),
    ('Chinese Kitchen', 'Tomato Noodle Soup', 0, 10, true, 'Chinese', 6, 'Tomatoes and QQ noodles'),
    ('Chinese Kitchen', 'Fried Rice', 0, 10, true, 'Chinese', 6, 'Yangzhou style fried rice with sausage'),
    ('Chinese Kitchen', 'Sweet and Sour Pork Rice', 0, 10, true, 'Chinese', 6, 'Sweetest and sourest pork around'),
    ('Chinese Kitchen', 'Salted Egg Rice', 1, 10, true, 'Chinese', 6, 'Smells like salted eggs'),
    ('Chinese Kitchen', 'Century Egg Porridge', 3, 10, true, 'Chinese', 6, 'Yummm'),

    ('Song Feng Chicken', 'Set A Chicken Wing', 0, 20, true, 'Malay', 3, 'Value for money, Chicken wing and Egg on the side'),
    ('Song Feng Chicken', 'Set B Fish', 0, 20, true, 'Malay', 3, 'Fried fish and hashbrowns on the side'),
    ('Song Feng Chicken', 'Set C Vege', 0, 20, true, 'Malay', 3, 'Vegetarian option'),
    ('Song Feng Chicken', 'Set D Mixed', 0, 20, true, 'Malay', 6, 'A bit of everything'),

    ('Nippi Place', 'Plain Prata', 0, 5, true, 'Indian', 2, 'Plainest prata around'),
    ('Nippi Place', 'Egg Prata', 0, 5, true, 'Indian', 2, 'Eggiest prata around'),
    ('Nippi Place', 'Banana Prata', 0, 5, true, 'Indian', 2, 'Special House Prata on Banana'),
    ('Nippi Place', 'Prata Bomb', 0, 5, true, 'Indian', 2, 'This prata is the bomb'),
    ('Nippi Place', 'Teh Halia', 1, 5, true, 'Indian', 1, 'Special House Teh Halia'),
    ('Nippi Place', 'Teh Chino', 0, 5, true, 'Indian', 1, 'Special House Teh Chino'),
    ('Nippi Place', 'Roti John', 0, 5, true, 'Indian', 4, 'Signature dish by Chef John'),

    ('Naknoh Thai', 'Pad Thai', 3, 7, true, 'Thai', 5, 'Best padthai in Naknoh Thai'),
    ('Naknoh Thai', 'Thai Milk Tea', 3, 3, false, 'Thai', 3, 'Original Thai Milk Tea'),
    ('Naknoh Thai', 'Green Thai Milk Tea', 3, 3, false, 'Thai', 3, 'Original Thai Milk Tea but Green'),
    ('Naknoh Thai', 'Mango Sticky Rice', 3, 10, true, 'Thai', 4, 'Desserts is stressed spelled backwards'),
    ('Naknoh Thai', 'Basil Pork Rice', 4, 3, false, 'Thai', 5, 'Freshest Basil with the freshset pork'),

    ('King Fried Chicken', 'Signature Fried Chicken', 3, 10, true, 'Western', 18, 'Chicken fit for a king'),
    ('King Fried Chicken', 'Spicy Fried Chicken', 3, 10, true, 'Western', 18, 'Chicken fit for a king that likes spices'),
    ('King Fried Chicken', 'Oven Roasted Chicken', 3, 10, true, 'Western', 18, 'For when you want to be slightly healthier'),
    ('King Fried Chicken', 'King Coffee', 3, 10, true, 'Western', 5, 'A King needs his Koffee'),
    ('King Fried Chicken', 'Kung Pao King Chicken', 3, 10, true, 'Western', 20, 'King chicken chinese style'),
    ('King Fried Chicken', 'Kimchi Fried Chicken', 11, 10, false, 'Western', 18, 'Korean Chicken fit for a king'),
    ('King Fried Chicken', 'Salted Fried Chicken', 3, 10, true, 'Western', 18, 'Salt+Chicken'),
    ('King Fried Chicken', 'Pepper Roasted Chicken', 3, 10, true, 'Western', 18, 'Pepper+Chicken'),
    ('King Fried Chicken', 'Thai Coffee', 3, 10, true, 'Thai', 5, 'Thai Tea? No Thai Coffee'),
    ('King Fried Chicken', 'Mexican Chicken', 3, 10, true, 'Western', 20, 'Mexican King chicken mexican style'),

    ('Sayonara', 'Chawamushi', 2, 20, true, 'Japanese', 3, 'Our chawamushi is the best'),
    ('Sayonara', 'Salmon don', 2, 20, true, 'Japanese', 15, 'Our salmon don is the best'),
    ('Sayonara', 'Edamame', 2, 20, true, 'Japanese', 3, 'Our edamame is the best'),
    ('Sayonara', 'Oyako don', 2, 20, true, 'Japanese', 14, 'Our oyako don is the best'),
    ('Sayonara', 'Donburi', 0, 20, true, 'Japanese', 12, 'Our donburi is the best'),
    ('Sayonara', 'Curry Rice', 5, 20, true, 'Japanese', 12, 'It is not really the best'),
    ('Sayonara', 'Mushroom skewer', 0, 20, true, 'Japanese', 3, 'So fresh that it is still alive'),
    ('Sayonara', 'Green Tea', 0, 20, true, 'Japanese', 1, 'Tea for aging'),

    ('McD', 'Salad', 18, 20, true, 'Western', 4, 'Salad for aging'),
    ('McD', 'Grilled Chicken Wrap', 0, 20, true, 'Western', 5, 'Chicken McWrap'),
    ('McD', 'Salad Bowl With Chicken', 21, 20, false, 'Western', 5, 'Chicken'),
    ('McD', 'Salad Bowl With Fish', 17, 20, true, 'Western', 5, 'Fish and salad'),
    ('McD', 'Fresh Grilled Chicken', 0, 20, true, 'Western', 5, 'Grilled chicken'),
    ('McD', 'Caesar Salad', 0, 20, true, 'Western', 4, 'Et Tu Brute'),
    ('McD', 'Lettuce', 0, 20, true, 'Western', 1, 'We will pluck it for you when you order')
;

INSERT INTO Orders
    (cid, rname, cartCost, location, ostatus)
VALUES
    (4, 'Chinese Kitchen', 24, 'Bukit Panjang', 'Completed'),
    (1, 'Song Feng Chicken', 9, 'Clementi', 'Completed'),
    (7, 'Nippi Place', 12, 'Chua Chu Kang', 'Completed'),
    (4, 'Chinese Kitchen', 24, 'Pasir Panjang', 'Completed'),
    (6, 'Naknoh Thai', 26, 'Kallang', 'Completed'),
    (1, 'Naknoh Thai', 15, 'Kallang', 'Completed'),
    (12, 'Naknoh Thai', 20, 'Toa Payoh', 'Completed'),
    (13, 'Chinese Kitchen', 24, 'Clementi', 'Completed'),
    (14, 'Song Feng Chicken', 15, 'Chua Chu Kang', 'Completed'),
    (15, 'Nippi Place', 8, 'Ang Mo Kio', 'Completed'),
    (12, 'Chinese Kitchen', 30, 'Toa Payoh', 'Completed'),
    (15, 'Nippi Place', 6, 'Ang Mo Kio', 'Completed'),
    (4, 'Chinese Kitchen', 36, 'Kallang', 'Completed'),
    (12, 'Naknoh Thai', 16, 'Kallang', 'Completed'),
    (25, 'Nippi Place', 14, 'Kallang', 'Completed'),
    (4, 'Chinese Kitchen', 36, 'Bukit Panjang', 'Completed'),
    (13, 'Chinese Kitchen', 30, 'Clementi', 'Completed'),
    (1, 'King Fried Chicken', 36, 'Jalan Basar', 'Completed'),
    (25, 'Nippi Place', 30, 'Clementi', 'Completed'),
    (25, 'Chinese Kitchen', 30, 'Bukit Timah', 'Completed'),

    --21 onwards
    (15, 'Nippi Place', 8, 'Ang Mo Kio', 'Completed'),
    (15, 'Nippi Place', 8, 'Ang Mo Kio', 'Completed'),
    (4, 'Nippi Place', 8, 'Ang Mo Kio', 'Completed'),
    (15, 'Chinese Kitchen', 24, 'Clementi', 'Completed'),

    --25 onwards
    (30, 'Nippi Place', 8, 'Macritche', 'Completed'),
    (30, 'Nippi Place', 8, 'Kallang', 'Completed'),
    (1, 'Nippi Place', 8, 'Ang Mo Kio', 'Completed'),
    (30, 'Chinese Kitchen', 24, 'Clementi', 'Completed'),
    (1, 'Sayonara', 9, 'Bishan', 'Completed'),
    (1, 'Sayonara', 20, 'Bukit Panjang', 'Completed'),
    (1, 'Sayonara', 40, 'Loyang', 'Completed'),
    (1, 'King Fried Chicken', 18, 'Clementi', 'Completed')

;

INSERT INTO Deliver
    (orid, rid, fee, dstatus)
VALUES
    (1, 2, 5, 'Rider has delivered your order.'),
    (2, 3, 5, 'Rider has delivered your order.'),
    (3, 2, 5, 'Rider has delivered your order.'),
    (4, 3, 5, 'Rider has delivered your order.'),
    (5, 3, 5, 'Rider has delivered your order.'),
    (6, 2, 5, 'Rider has delivered your order.'),
    (7, 16, 5, 'Rider has delivered your order.'),
    (8, 17, 5, 'Rider has delivered your order.'),
    (9, 18, 5, 'Rider has delivered your order.'),
    (10, 18, 5, 'Rider has delivered your order.'),
    (11, 16, 5, 'Rider has delivered your order.'),
    (12, 16, 5, 'Rider has delivered your order.'),
    (13, 27, 5, 'Rider has delivered your order.'),
    (14, 28, 5, 'Rider has delivered your order.'),
    (15, 27, 5, 'Rider has delivered your order.'),
    (16, 3, 5, 'Rider has delivered your order.'),
    (17, 27, 5, 'Rider has delivered your order.'),
    (18, 18, 5, 'Rider has delivered your order.'),
    (19, 16, 5, 'Rider has delivered your order.'),
    (20, 16, 5, 'Rider has delivered your order.'),
    (21, 3, 5, 'Rider has delivered your order.'),
    (22, 2, 5, 'Rider has delivered your order.'),
    (23, 3, 5, 'Rider has delivered your order.'),
    (24, 17, 5, 'Rider has delivered your order.'),

    (25, 27, 5, 'Rider has delivered your order.'),
    (26, 18, 5, 'Rider has delivered your order.'),
    (27, 16, 5, 'Rider has delivered your order.'),
    (28, 16, 5, 'Rider has delivered your order.'),
    (29, 3, 5, 'Rider has delivered your order.'),
    (30, 2, 5, 'Rider has delivered your order.'),
    (31, 3, 5, 'Rider has delivered your order.'),
    (32, 17, 5, 'Rider has delivered your order.')
;

INSERT INTO DeliveryTime
    (orid, departForR, arriveForR, departFromR, deliveredTime)
VALUES
    (1, '2020-03-20 10:23:54', '2020-03-20 10:30:03', '2020-03-20 10:32:50', '2020-03-20 10:40:24'),
    (2, '2020-03-20 13:13:54', '2020-03-20 13:20:03', '2020-03-20 13:22:50', '2020-03-20 13:30:24'),
    (3, '2020-03-20 18:23:54', '2020-03-20 18:30:03', '2020-03-20 18:32:50', '2020-03-20 18:40:24'),
    (4, '2020-03-21 12:24:54', '2020-03-21 12:32:03', '2020-03-21 12:34:50', '2020-03-21 12:43:24'),
    (5, '2020-03-21 19:25:54', '2020-03-21 19:31:03', '2020-03-21 19:36:50', '2020-03-21 19:46:24'),
    (6, '2020-04-01 19:20:54', '2020-04-01 19:31:03', '2020-04-01 19:36:50', '2020-04-01 19:46:24'),
    (7, '2020-04-15 10:23:54', '2020-04-15 10:30:03', '2020-04-15 10:32:50', '2020-04-15 10:40:24'),
    (8, '2020-04-20 13:13:54', '2020-04-20 13:20:03', '2020-04-20 13:22:50', '2020-04-20 13:30:24'),
    (9, '2020-04-20 18:23:54', '2020-04-20 18:30:03', '2020-04-20 18:32:50', '2020-04-20 18:40:24'),
    (10, '2020-04-21 12:24:54', '2020-04-21 12:32:03', '2020-04-21 12:34:50', '2020-04-21 12:43:24'),
    (11, '2020-04-25 19:25:54', '2020-04-25 19:31:03', '2020-04-25 19:36:50', '2020-04-25 19:46:24'),
    (12, '2020-04-28 19:20:54', '2020-04-28 19:31:03', '2020-04-28 19:36:50', '2020-04-28 19:46:24'),
    (13, '2020-05-01 19:10:54', '2020-05-01 19:20:54', '2020-05-01 19:30:54', '2020-05-01 19:32:54'),
    (14, '2020-05-02 19:20:54', '2020-05-02 19:31:03', '2020-05-02 19:36:50', '2020-05-02 19:46:24'),
    (15, '2020-05-02 19:20:56', '2020-05-02 19:32:54', '2020-05-02 19:40:54', '2020-05-02 19:52:54'),
    (16, '2020-05-03 18:23:54', '2020-05-03 18:30:03', '2020-05-03 18:32:50', '2020-05-03 18:40:24'),
    (17, '2020-05-03 12:24:54', '2020-05-03 12:32:03', '2020-05-03 12:34:50', '2020-05-03 12:43:24'),
    (18, '2020-05-03 19:25:54', '2020-05-03 19:31:03', '2020-05-03 19:36:50', '2020-05-03 19:46:24'),
    (19, '2020-05-03 13:20:54', '2020-05-03 13:31:03', '2020-05-03 13:36:50', '2020-05-03 13:46:24'),
    (20, '2020-05-03 10:23:54', '2020-05-03 10:30:03', '2020-05-03 10:32:50', '2020-05-03 10:40:24'),
    (21, '2020-05-03 10:23:54', '2020-05-03 10:30:03', '2020-05-03 10:32:50', '2020-05-03 10:40:24'),
    (22, '2020-05-04 19:25:54', '2020-05-04 19:31:03', '2020-05-04 19:36:50', '2020-05-04 19:46:24'),
    (23, '2020-05-04 18:23:54', '2020-05-04 18:30:03', '2020-05-04 18:32:50', '2020-05-04 18:40:24'),
    (24, '2020-05-07 18:25:54', '2020-05-07 18:31:03', '2020-05-07 18:36:50', '2020-05-07 18:46:24'),

    (25, '2020-05-15 10:23:54', '2020-05-15 10:30:03', '2020-05-15 10:32:50', '2020-05-15 10:40:24'),
    (26, '2020-05-15 9:25:54', '2020-05-15 9:31:03', '2020-05-15 9:36:50', '2020-05-15 9:46:24'),
    (27, '2020-05-15 8:23:54', '2020-05-15 8:30:03', '2020-05-15 8:32:50', '2020-05-15 8:40:24'),
    (28, '2020-05-15 8:25:54', '2020-05-15 8:31:03', '2020-05-15 8:36:50', '2020-05-15 8:46:24'),
    (29, '2020-05-15 10:23:54', '2020-05-15 10:30:03', '2020-05-15 10:32:50', '2020-05-15 10:40:24'),
    (30, '2020-05-15 9:25:54', '2020-05-15 9:31:03', '2020-05-15 9:36:50', '2020-05-15 9:46:24'),
    (31, '2020-05-15 8:23:54', '2020-05-15 8:30:03', '2020-05-15 8:32:50', '2020-05-15 8:40:24'),
    (32, '2020-05-15 8:25:54', '2020-05-15 8:31:03', '2020-05-15 8:36:50', '2020-05-15 8:46:24')
;

INSERT INTO OrderItems
    (orid, fname, quantity)
VALUES
    (1, 'Beef Horfun', 1),
    (1, 'Tomato Noodle Soup', 2),
    (2, 'Fried Rice', 1),
    (2, 'Set A Chicken Wing', 1),
    (3, 'Set B Fish', 2),
    (3, 'Plain Prata', 4),
    (4, 'Egg Prata', 2),
    (4, 'Seafood Horfun', 2),
    (5, 'Beef Horfun', 2),
    (5, 'Pad Thai', 3),
    (5, 'Thai Milk Tea', 3),
    (6, 'Pad Thai', 2),
    (7, 'Basil Pork Rice', 2),
    (7, 'Pad Thai', 2),
    (8, 'Sweet and Sour Pork Rice', 1),
    (8, 'Tomato Noodle Soup', 1),
    (8, 'Seafood Horfun', 1),
    (8, 'Beef Horfun', 1),
    (9, 'Set A Chicken Wing', 2),
    (9, 'Set C Vege', 3),
    (10, 'Banana Prata', 2),
    (10, 'Egg Prata', 2),
    (11, 'Tomato Noodle Soup', 5),
    (12, 'Banana Prata', 1),
    (12, 'Plain Prata', 1),
    (12, 'Egg Prata', 1),
    (13, 'Beef Horfun', 1),
    (13, 'Seafood Horfun', 2),
    (13, 'Fried Rice', 1),
    (13, 'Salted Egg Rice', 2),
    (14, 'Pad Thai', 1),
    (14, 'Basil Pork Rice', 1),
    (14, 'Thai Milk Tea', 1),
    (14, 'Green Thai Milk Tea', 1),
    (15, 'Plain Prata', 4),
    (15, 'Egg Prata', 2),
    (15, 'Banana Prata', 1),
    (16, 'Beef Horfun', 1),
    (16, 'Seafood Horfun', 2),
    (16, 'Fried Rice', 1),
    (16, 'Salted Egg Rice', 2),
    (17, 'Beef Horfun', 1),
    (17, 'Seafood Horfun', 2),
    (17, 'Fried Rice', 1),
    (17, 'Tomato Noodle Soup', 1),
    (18, 'Signature Fried Chicken', 1),
    (18, 'Spicy Fried Chicken', 1),
    (19, 'Egg Prata', 15),
    (20, 'Salted Egg Rice', 3),
    (20, 'Century Egg Porridge', 2),
    (21, 'Banana Prata', 4),
    (22, 'Egg Prata', 2),
    (22, 'Banana Prata', 2),
    (23, 'Plain Prata', 4),
    (24, 'Salted Egg Rice', 1),
    (24, 'Century Egg Porridge', 1),
    (24, 'Sweet and Sour Pork Rice', 1),
    (24, 'Tomato Noodle Soup', 1),

    (25, 'Plain Prata', 2),
    (25, 'Banana Prata', 2),
    (26, 'Roti John', 2),
    (27, 'Teh Chino', 4),
    (27, 'Roti John', 1),
    (28, 'Beef Horfun', 4),
    (29, 'Chawamushi', 3),
    (30, 'Curry Rice', 1),
    (30, 'Edamame', 2),
    (30, 'Green Tea', 2),
    (31, 'Curry Rice', 3),
    (31, 'Green Tea', 4),
    (32, 'Kimchi Fried Chicken', 1)
;

-- 5 Staffs: 5,8,9,10,11, 29
INSERT INTO Staffs
    (rname, stid)
VALUES
    ('Naknoh Thai', 5),
    ('Song Feng Chicken', 8),
    ('Nippi Place', 9),
    ('Chinese Kitchen', 10),
    ('King Fried Chicken', 11),
    ('Chinese Kitchen', 29),
    ('Sayonara', 31);

INSERT INTO Reviews
    (orid, foodReview, deliveryRating)
VALUES
    (1, 'Nice food!', 4),
    (2, 'Not bad', 5),
    (3, 'Horrible, I found a strand of hair', 4),
    (4, 'Food reminds me of home', 5),
    (5, 'Food was too bland', 3),
    (6, 'Very good, Me like', 3),
    (7, 'So oily that America wants to invade it', 3),
    (8, 'Best Fishing Chicken', 3),
    (9, 'Delectable', 3),
    (10, 'Palatable', 3),
    (11, 'Main Course was decent, 9/10. Love how fresh all the ingredients were. Good balance of flavours and spices. Soup was slightly salty but still decent.', 5),
    (12, 'This is one of the greatest meals of my life, I recently broke up with my girlfriend and lost my job due to COVID. This meal made my day, something decent out of all these misery. Thank you.', 5),
    (13, 'Yumz I love the food here!!', 5),
    (14, 'Tastes like hometown food, khob khun ka', 5),
    (15, 'The food is bad and expensive', 2),
    (16, 'Food is ok', 3),
    (17, 'Wow the food is amazing', 5),
    (18, 'I feel like a king now', 5),
    (19, 'I love egg prata', 4),
    (22, 'The prata is bomb', 5),
    (23, 'The prata is bombbay', 5),
    (24, 'Fried rice a bit dry and the tea abit wet. dissapointing', 3),
    (25, 'The prata is bomber', 5),
    (26, 'a bit dry', 3),
    (27, 'The tea is bomb', 5),
    (28, 'Fried rice a bit oily', 3),
    (29, 'Very nice', 5),
    (30, 'This helped me get through this tough period :)', 3),
    (31, 'Fried rice a bit dry', 3)
;

INSERT INTO FTRiders
    (rid)
VALUES
    (3),
    (16),
    (18),
    (28),
    (24);

INSERT INTO PTRiders
    (rid)
VALUES
    (2),
    (17),
    (27);

INSERT INTO WWS
    (rid, wDate, startT, endT)
VALUES
    (2, '2020-02-20', '10:00:00', '13:00:00'),
    (2, '2020-03-10', '16:00:00', '19:00:00'),
    (2, '2020-03-20', '10:00:00', '13:00:00'),
    (2, '2020-04-20', '10:00:00', '13:00:00'),
    (2, '2020-05-01', '10:00:00', '13:00:00'),
    (2, '2020-05-15', '10:00:00', '13:00:00'),
    (2, '2020-05-20', '10:00:00', '13:00:00'),

    (17, '2020-03-20', '16:00:00', '19:00:00'),
    (17, '2020-05-20', '16:00:00', '19:00:00'),
    (17, '2020-04-20', '16:00:00', '19:00:00'),
    (17, '2020-05-11', '10:00:00', '13:00:00'),
    (17, '2020-05-15', '10:00:00', '13:00:00'),

    (27, '2020-03-20', '10:00:00', '13:00:00'),
    (27, '2020-04-20', '10:00:00', '13:00:00'),
    (27, '2020-05-05', '10:00:00', '13:00:00'),
    (27, '2020-05-11', '10:00:00', '13:00:00'),
    (27, '2020-04-23', '10:00:00', '13:00:00'),
    (27, '2020-05-02', '16:00:00', '19:00:00'),
    (27, '2020-05-15', '10:00:00', '13:00:00');

INSERT INTO templateShift
    (Shift, Start1, End1, Start2, End2)
VALUES
    (1, '10:00:00', '14:00:00', '15:00:00', '19:00:00'),
    (2, '11:00:00', '15:00:00', '16:00:00', '20:00:00'),
    (3, '12:00:00', '16:00:00', '17:00:00', '21:00:00'),
    (4, '13:00:00', '17:00:00', '18:00:00', '22:00:00');

INSERT INTO MWS
    (rid, whichMonth, startDay, Day1Shift, Day2Shift, Day3Shift, Day4Shift, Day5Shift)
VALUES
    (3, 3, 'Thursday', 1, 1, 2, 3, 1),
    (3, 4, 'Thursday', 3, 3, 3, 3, 3),
    (3, 5, 'Thursday', 3, 1, 3, 3, 3),
    (16, 3, 'Monday', 1, 1, 1, 1, 1 ),
    (16, 4, 'Friday', 4, 4, 4, 4, 4),
    (16, 5, 'Wednesday', 1, 1, 1, 1, 1 ),
    (18, 4, 'Thursday', 2, 2, 2, 2, 2),
    (18, 5, 'Wednesday', 2, 4, 1, 4, 4),
    (24, 3, 'Sunday', 4, 4, 4, 4, 4),
    (24, 4, 'Wednesday', 1, 4, 2, 4, 4),
    (24, 5, 'Thursday', 1, 1, 2, 4, 4),
    (28, 3, 'Sunday', 4, 4, 4, 4, 4),
    (28, 4, 'Wednesday', 1, 4, 2, 4, 4),
    (28, 5, 'Friday', 1, 4, 2, 4, 4)
;

INSERT INTO Salary
    (rid, whichMonth, deliveryFees, basePay)
VALUES
    (2, 2, 9, 60),
    (2, 3, 9, 60),
    (2, 4, 9, 60),
    (2, 5, 9, 60),
    (3, 3, 9, 300),
    (3, 4, 9, 300),
    (3, 5, 9, 300),
    (16, 3, 9, 300),
    (16, 4, 9, 300),
    (16, 5, 9, 300),
    (17, 3, 3, 100),
    (18, 4, 6, 100),
    (18, 5, 6, 100),
    (27, 3, 15, 200),
    (27, 4, 15, 200),
    (27, 5, 15, 200),
    (28, 3, 20, 300),
    (28, 4, 20, 300),
    (28, 5, 0, 300);

INSERT INTO allPromotions
    (promotiondescript, promoname, promotiontype, discount,startD, endD)
VALUES
    ('Stay home and stay safe, enjoy all these food at a discounted price! Enjoy an additional $10 off your cart items courtesy of MoodPanda!', 'Stay Home Promo', 'fixed', 10 , '2020-05-3', '2020-05-26'),
    ('May the discounts be with you! Enjoy 50% off your cart items on MoodPanda! #StayHomeStaySafe', 'May the fourth', 'percentage', 50, '2020-04-23', '2020-05-24'),
    ('Chinese Kitchen onboarding promotion, feast on! Enjoy $2 off your food items', 'CK Promo', 'fixed', 2, '2020-05-01', '2020-05-24'),
    ('Here is a promo code to tide you through this rough period, enjoy $5 off!', 'Promo for the King', 'fixed', 5, '2020-05-14', '2020-05-20'),
    ('COVID PROMOTION 20% OFF', 'Stay Home Promo', 'percentage', 20 , '2020-05-23', '2020-05-26'),
    ('#SupportLocal 10$ off', '$10 off', 'fixed', 10, '2020-05-23', '2020-05-24'),
    ('Sayonara sale, literally we are going out of business $20 off', 'Sayonara $20 off', 'fixed', 20, '2020-05-01', '2020-05-24')
;

INSERT INTO RPromotions
    (pid, rname)
VALUES
    (3, 'Chinese Kitchen'),
    (4, 'King Fried Chicken'),
    (5, 'Nippi Place'),
    (6, 'Naknoh Thai'),
    (7, 'Sayonara')
;

INSERT INTO FDPromotions
    (pid)
VALUES
    (1),
    (2);