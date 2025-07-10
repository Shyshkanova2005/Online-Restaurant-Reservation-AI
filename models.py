from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Customer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    phone = db.Column(db.String(20), nullable=False)  
    email = db.Column(db.String(100), nullable=False)

    bookings = db.relationship('Booking', backref='customer', lazy=True)

class Tables(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    table_number = db.Column(db.String(10), nullable=False, unique=True)
    seats = db.Column(db.Integer, nullable=False)

    bookings = db.relationship('Booking', backref='table_ref', lazy=True)

class Booking(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(20), nullable=False)
    time = db.Column(db.String(10), nullable=False)
    during = db.Column(db.String(10), nullable=False) 
    guests = db.Column(db.Integer, nullable=False)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.id'), nullable=False)
    table_id = db.Column(db.Integer, db.ForeignKey('tables.id'), nullable=False)


class MenuItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    price = db.Column(db.Float, nullable=False)
    image_url = db.Column(db.String(255))

class OrderItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    booking_id = db.Column(db.Integer, db.ForeignKey('booking.id'), nullable=False)
    menu_item_id = db.Column(db.Integer, db.ForeignKey('menu_item.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)

    booking = db.relationship('Booking', backref='order_items')
    menu_item = db.relationship('MenuItem')



    