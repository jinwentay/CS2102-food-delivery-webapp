--Trigger to validate signup name,password,email
CREATE OR REPLACE FUNCTION check_signup_inputs
()
RETURNS TRIGGER AS $$
DECLARE 
    valid INT;
    Nname TEXT;
    Npassword TEXT;
    Nemail TEXT;
BEGIN
    SELECT 1
    INTO valid;
    IF NEW.name='' OR NEW.email='' OR NEW.password='' THEN 
        RAISE EXCEPTION 'Empty field detected';
    SELECT 0
    INTO valid;
END
IF;

    SELECT regexp_matches(NEW.name, ';--')
INTO Nname;
SELECT regexp_matches(NEW.password, ';--')
INTO Npassword;
SELECT regexp_matches(NEW.email, ';--')
INTO Nemail;
IF Nname IS NOT NULL OR Npassword IS NOT NULL OR Nemail IS NOT NULL THEN
        RAISE EXCEPTION 'Attempted SQL Injection detected';
SELECT 0
INTO valid;
END
IF;

    IF NEW.email !~ '^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*
      @[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$' THEN
        RAISE EXCEPTION 'Invalid email';
SELECT 0
INTO valid;
END
IF;

    IF valid = 1 THEN  
        NEW.name = btrim
(regexp_replace
(NEW.name, '\s+', ' ', 'g'));
        NEW.email = btrim
(regexp_replace
(NEW.email, '\s+', ' ', 'g'));
        NEW.password = btrim
(regexp_replace
(NEW.password, '\s+', ' ', 'g'));
RETURN NEW;
END
IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_signup_inputs_trigger
ON Users;
CREATE TRIGGER check_signup_inputs_trigger 
    BEFORE
INSERT
    ON
Users
FOR
EACH
ROW
EXECUTE FUNCTION check_signup_inputs
();

--Trigger to check the min order and return and exception if not hit
CREATE OR REPLACE FUNCTION check_min_order
() RETURNS TRIGGER AS $$
DECLARE
    minorder INT;
BEGIN
    SELECT R.minOrder
    INTO minorder
    FROM RESTAURANTS R
    WHERE R.rname = NEW.rname;
    IF NEW.cartCost < minOrder THEN
            RAISE EXCEPTION 'Order did not hit min order';
END
IF;
        RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_min_order_trigger
ON Orders;
CREATE TRIGGER check_min_order_trigger
    BEFORE
UPDATE OR INSERT
    ON ORDERS
    FOR EACH ROW
EXECUTE FUNCTION check_min_order
();

--trigger to update delivery time when rider update's status in deliver
CREATE OR REPLACE FUNCTION update_delivery_time
()
RETURNS TRIGGER AS $$
DECLARE
    deliveryStatus d_status;
BEGIN
    SELECT dstatus
    INTO deliveryStatus
    FROM deliver
    WHERE orid = NEW.orid;
    IF deliveryStatus = 'Rider has arrived at restaurant.' THEN
    UPDATE deliveryTime
        SET arriveforr = date_trunc('second', NOW())
        WHERE orid = NEW.orid;
END
IF;
    IF deliveryStatus = 'Rider is departing from restaurant.' THEN
UPDATE deliveryTime
        SET departfromr = date_trunc('second', NOW())
        WHERE orid = NEW.orid;
END
IF;
    IF deliveryStatus = 'Rider has delivered your order.' THEN
UPDATE deliveryTime
        SET deliveredtime = date_trunc('second', NOW())
        WHERE orid = NEW.orid;
END
IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_delivery_time_trigger
ON deliver;
CREATE TRIGGER update_delivery_time_trigger
    AFTER
UPDATE ON deliver
    FOR EACH ROW
EXECUTE FUNCTION update_delivery_time
();

-- trigger to insert order into deliverytime table once it has been placed for delivery   
CREATE OR REPLACE FUNCTION insert_new_delivery_time
() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO DeliveryTime
        (orid)
    VALUES
        (NEW.orid);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_new_delivery_time_trigger
ON deliver;
CREATE TRIGGER insert_new_delivery_time_trigger
    AFTER
INSERT
    ON
deliver
FOR
EACH
ROW
EXECUTE FUNCTION insert_new_delivery_time
();

-- Trigger to update quantity in sells
CREATE OR REPLACE FUNCTION update_food_qty
() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Sells s
    SET sold
    = sold + NEW.quantity
    WHERE s.fname = NEW.fname AND 
    s.rname =
    (SELECT rname
    FROM Orders o
    WHERE o.orid = NEW.orid);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_food_qty_trigger
ON orderItems;
CREATE TRIGGER update_food_qty_trigger
    BEFORE
UPDATE OR INSERT
    ON OrderItems
    FOR EACH ROW
EXECUTE FUNCTION update_food_qty
();

-- Trigger to check food quantity in sells
CREATE OR REPLACE FUNCTION check_food_qty
() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.last_updated < CURRENT_DATE THEN 
        NEW.sold = 0;
NEW.last_updated = CURRENT_DATE;
END
IF;
    IF NEW.sold > NEW.flimit THEN
        RAISE EXCEPTION 'Food limit hit';
END
IF;
    IF NEW.sold = NEW.flimit THEN 
        RAISE NOTICE USING MESSAGE = NEW;
        NEW.avail = FALSE;
END
IF;
    IF NEW.sold < NEW.flimit THEN 
        NEW.avail = TRUE;
END
IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_food_qty_triggerv
ON Sells;
CREATE TRIGGER check_food_qty_trigger
BEFORE
UPDATE OR INSERT
ON Sells FOR EACH ROW
EXECUTE FUNCTION check_food_qty
();

-- Trigger to update customer points after order completed
CREATE OR REPLACE FUNCTION update_customer_points
() RETURNS TRIGGER
    AS $$
BEGIN
    UPDATE customers c
    SET points
    = points + 1
    WHERE c.cid =  NEW.cid;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_customer_points_trigger
ON orders CASCADE;
CREATE TRIGGER update_customer_points_trigger 
    AFTER
UPDATE OF ostatus
    ON orders
    FOR EACH ROW
WHEN
(NEW.ostatus = 'Completed')
EXECUTE PROCEDURE update_customer_points
();

-- Trigger to ensure that order is not completed before rider is assigned or deliver is not included
CREATE OR REPLACE FUNCTION complete_order_check
() returns TRIGGER
    AS $$
DECLARE 
    violating_orid INTEGER;
BEGIN
    SELECT o.orid
    INTO violating_orid
    FROM orders o
    WHERE o.ostatus = 'Completed'
        AND (NOT EXISTS(
            SELECT 1
        FROM deliver d
        WHERE d.orid = o.orid
        ) OR EXISTS (
            SELECT 1
        FROM deliver d1
        WHERE d1.orid = o.orid AND d1.rid IS NULL
        ));
    IF violating_orid IS NOT NULL THEN 
        RAISE exception 'order % cannot be completed without rider or a deliver', violating_orid;
END
IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS complete_order_check_trigger
ON orders;
CREATE CONSTRAINT TRIGGER complete_order_check_trigger 
    AFTER
INSERT OR
UPDATE ON orders
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW
EXECUTE PROCEDURE complete_order_check
();

-- Trigger to enforce that all the food is from the same restaurant (checks that upon insert of orderitems, fname exist in sells with the orid and)
CREATE OR REPLACE FUNCTION ensure_single_restaurant
() returns TRIGGER
    AS $$
DECLARE 
    violating_orid INTEGER;
BEGIN
    SELECT o.orid
    into violating_orid
    FROM orderitems NATURAL JOIN orders o 
    WHERE NOT EXISTS ( 
        SELECT 1
        FROM orderitems oi1 NATURAL JOIN orders o1 INNER JOIN sells s ON o1.rname=s.rname 
        WHERE NEW.fname = s.fname
            AND o.orid = o1.orid
    ) AND o.orid = NEW.orid;

    IF violating_orid IS NOT NULL THEN 
        RAISE exception 'order % contains food not found in this restaurant', violating_orid;
END
IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS ensure_single_restaurant_trigger
ON orders;
CREATE CONSTRAINT TRIGGER ensure_single_restaurant_trigger 
    AFTER
INSERT ON
orderitems
DEFERRABLE
INITIALLY
DEFERRED
    FOR EACH ROW
EXECUTE PROCEDURE ensure_single_restaurant
();


-- Trigger to check that the promo start date is before the end date 
CREATE OR REPLACE FUNCTION check_promo_start_end
() returns TRIGGER
    AS $$
BEGIN
    IF NEW.startd > NEW.endd THEN
        RAISE exception 'promo % end date is earlier than the start date', NEW.pid;
RETURN NULL;
END
IF;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_promo_start_end_trigger
ON allpromotions;
CREATE TRIGGER check_promo_start_end_trigger 
    BEFORE
UPDATE OR INSERT
    ON allpromotions
    FOR EACH ROW
EXECUTE PROCEDURE check_promo_start_end
();

-- Trigger to check if that week he worked less than 10 or more than 40 
-- Trigger to check if there are any clashes in the schedule as well
-- CREATE OR REPLACE FUNCTION check_rider_schedule() returns TRIGGER
--     AS $$
-- DECLARE 
--     weekHours INTEGER;
-- BEGIN
--     weekHours = 0;
--     SELECT SUM(DATE_PART('hour', endt - startt)) INTO weekHours
--     FROM wws 
--     WHERE EXTRACT(week from CURRENT_DATE) = EXTRACT(week from wdate)
--     AND NEW.rid = wws.rid;
    
--    IF weekHours < 10 THEN
--         RAISE exception 'You are working too little';
--     END IF;
--     IF weekHours > 48 THEN 
--         RAISE exception 'You are working too much';
--     END IF;

--     RETURN NULL;
-- END
-- $$ LANGUAGE plpgsql;

-- DROP TRIGGER IF EXISTS check_rider_schedule_trigger ON wws;
-- CREATE TRIGGER check_rider_schedule_trigger 
--     AFTER UPDATE OR INSERT
--     ON wws
--     FOR EACH ROW
--     EXECUTE PROCEDURE check_rider_schedule();


