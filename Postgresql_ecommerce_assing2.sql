
create TABLE users(
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	gender CHAR(1)
);


-- Insert into users(first_name,last_name,gender) values ('Ravi','Sharma','M'),
														('Rani','Garg','F')

select * from users
Select * from user_address
select * from role_type
select * from products
select * from cart

CREATE TABLE user_address(
	user_add_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES users (user_id),
	address_line VARCHAR(255),
	city VARCHAR(50),
	postal_code VARCHAR(8),
	country VARCHAR(50),
	phone_no VARCHAR(12)
);



-- insert into user_address (user_id, address_line, city, postal_code, country, phone_no)
-- values ((select user_id from users where first_name ='Ravi'),'Mahavir road','AJmer',234567,'India',9876543537),
-- 		((select user_id from users where first_name ='Rani'),'Tejaswi road','AJmer',234567,'India',9876546878)

-- drop table role_type
CREATE TABLE role_type(
 	role_id SERIAL PRIMARY KEY,
	r_name VARCHAR,
	can_read bool,
	can_modify bool,
	can_delete bool
);

-- insert into role_type(r_name,can_read,can_modify,can_delete)
-- values ('Saleperson','true','true','true'),
-- 		('Developer','true','true','true'),
-- 		('User','true','false','false')


CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50),
	product_descrip text,
	product_size CHAR,
	price INT,
	product_category VARCHAR(255),
	isreturnable bool
);

-- insert into products(product_name,product_descrip,product_size,price,product_category,isreturnable)
-- values ('Boat earphones','Best earphones in market','M',500,'Tech',true),
-- 		('NIke shoes','Best shoes in market','L',2500,'shoes',false),
-- 		('Doorbell','Best doorbell in market','M',1000,'Decor',true)

-- drop table cart
CREATE TABLE cart(
	user_id INT REFERENCES users (user_id),
	product_id INT REFERENCES products (product_id),
	quantity INT,
	price INT,
	date_of_order date
);

-- delete from cart where product_id !='1'
-- insert into cart(user_id,product_id,quantity,price,date_of_order)
-- values ((select user_id from users where first_name ='Ravi'),
-- 	     (select product_id from products where product_name='Boat earphones'),
-- 	   2,2*500,now())
	   
-- insert into cart(user_id,product_id,quantity,price,date_of_order)
-- values ((select user_id from users where first_name ='Ravi'),
-- 	     (select product_id from products where product_name='NIke shoes'),
-- 	   1,2500,now())



CREATE OR REPLACE VIEW view1
AS  
	Select  users.first_name, users.last_name,user_address.address_line,user_address.city,user_address.postal_code,user_address.phone_no
	from users 
	INNER JOIN user_address
	ON users.user_id=user_address.user_id

select* from view1


CREATE VIEW view2
AS
	Select users.first_name, users.last_name,
	cart.product_id, cart.quantity, cart.price
	from users
	INNER JOIN cart
	ON users.user_id=cart.user_id

select* from view2


drop table cart_discount
CREATE TABLE cart_discount(
	user_id INT,
	product_id INT,
	quantity INT,
	price INT
)

CREATE OR REPLACE FUNCTION trigger_function()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
		BEGIN
			IF NEW.quantity >1 THEN
				insert into cart_discount (user_id,product_id,quantity,price) values (OLD.user_id,
																								  OLD.product_id,OLD.quantity,OLD.price-100*NEW.quantity);
			END IF;
	
 			RETURN NEW;
		END;
	$$

 
CREATE TRIGGER triggerrr
BEFORE UPDATE
ON cart
FOR EACH ROW
	EXECUTE PROCEDURE trigger_function();
	   

select * from cart;
select * from cart_discount;

update cart set quantity=4 where user_id=1;




