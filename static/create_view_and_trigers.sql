CREATE TABLE IF NOT EXISTS customer(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS tables(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    table_number TEXT NOT NULL,
    seats INTEGER NOT NULL
);
 
CREATE TABLE IF NOT EXISTS booking(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    day TEXT NOT NULL,
    time TEXT NOT NULL,
    during TEXT,
    guests INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    table_id INTEGER NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);

CREATE TABLE IF NOT EXISTS menu_item(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price FLOAT NOT NULL,
    image_url TEXT
);

CREATE TABLE IF NOT EXISTS order_item(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    menu_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(id),
    FOREIGN KEY (menu_item_id) REFERENCES menu_item(id)
);


CREATE VIEW booking_view AS
SELECT
    b.id AS booking_id,
    c.name AS customer_name,
    c.phone AS customer_phone,
    c.email AS customer_email,
    b.day, b.time, b.guests, b.during, b.table_id
FROM booking b
JOIN customer c ON b.customer_id = c.id; 

CREATE TRIGGER trigger_booking 
INSTEAD OF INSERT ON booking_view
BEGIN 
    INSERT INTO customer (name, phone, email)
    VALUES (NEW.customer_name, NEW.customer_phone, NEW.customer_email);

    INSERT INTO booking (day, time, guests, during, customer_id, table_id)
    VALUES (NEW.day, NEW.time, NEW.guests, NEW.during, (SELECT last_insert_rowid()), NEW.table_id);
END;

