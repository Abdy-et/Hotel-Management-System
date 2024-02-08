
    
	select * from hotel;
	select * from guest;
	select * from employee;
	select * from booking;
	select * from room;
	select * from hotel_services;
	select * from payment;
	select * from hotel_services_used_by_guests;


	
	--Stored Procedure With One Parameter used to Cascaded delete from all table 
	/*CREATE PROCEDURE cascadedelete @hotel_id nchar(10)
          AS
            Delete from hotel
            where hotel_id = @hotel_id;

    EXEC cascadedelete @hotel_id ='';
   */
     EXEC cascadedelete @hotel_id ='H008';

 UPDATE hotel set hotel_id= 'H008' WHERE hotel_id = 'H002';

	 --delete
	 Delete from guest
        where guest_id ='G001';

		--update
		UPDATE employee
			SET addresse = 'Adama/Ethiopia',city='Adama'
				WHERE emp_id ='E0014';

				-- Select 
	select emp_id, guest_id,guest_first_name
        from employee,guest
		where emp_id= 'E0011';

 -- add unique constraint to an existing column
	ALTER TABLE employee
       ADD UNIQUE (emp_contact_number,emp_email_address);
	
	  --- FULL OUTER JOIN
	  SELECT employee.emp_first_name, guest.guest_id
        FROM employee
     FULL OUTER JOIN guest ON employee.emp_id=guest.emp_id
        ORDER BY employee.emp_first_name;

-- How many rooms are booked in a particular hotel on a given date?
	SELECT SUM(total_rooms_booked) AS 'Total Rooms Booked' 		-- sum of total rooms
	FROM booking 
	WHERE booking_date LIKE '2023-05-17' AND hotel_id = 'H001';

	-- How many books has a customer made in one year?
	SELECT count(*) AS 'Total Bookings' 		-- count of total bookings 		
	FROM booking
	WHERE YEAR(booking_date) = 2023 AND guest_id ='G001';		-- bookings in Year 2023 by guest Jane with id 1
	

	--hotels
	CREATE TABLE hotel(
		hotel_id nchar(10) PRIMARY KEY NOT NULL,
		hotel_name varchar (50) NULL,
		addresse varchar(50) NULL,
		city varchar(50)  NULL,
		country varchar(50) DEFAULT 'Ethiopia',
		hotel_contact_number varchar(50) NULL,
		hotel_email_address varchar(50) NULL,
		hotel_website varchar(50) NULL,
		hotel_floor_count int NULL,
		hotel_room_capacity int NULL,
		check_in_date date NULL,
		check_out_date date NULL,
		);
		ALTER TABLE hotel
		drop column    hotel_floor_count;

insert into hotel(hotel_id,hotel_name,addresse,city,country,hotel_contact_number,hotel_email_address,hotel_website,hotel_room_capacity,check_in_date,check_out_date) 
		values ('H001','Blue Sky','Addis ababa/ethiopia','addis ababa','ethiopia','0912207711','bluesky@gmail.com','bluesky.com',12,'2023/05/17','2025/05/19'),
			   ('H002','Blue Sky','Addis ababa/ethiopia','addis ababa','ethiopia','0912207711','bluesky@gmail.com','bluesky.com',12,'2023/05/17','2025/05/19');

	select * from hotel;
	

	--employee

	CREATE TABLE employee(
		emp_id nchar(10) PRIMARY KEY NOT NULL,
		emp_first_name varchar(50) NULL,
		emp_last_name varchar(50) NULL,
		addresse varchar(50) NULL,
		city varchar(50)  NULL,
		country varchar(50)  DEFAULT 'Ethiopia',
		emp_designation varchar(50) NULL,
		emp_contact_number varchar(50) NULL,
		emp_email_address varchar(50) NULL,
		hotel_id nchar(10) NULL,
		department varchar(50) NULL,
	);
	
	ALTER TABLE employee  WITH CHECK ADD  CONSTRAINT FK_employee_hotel FOREIGN KEY(hotel_id)
		REFERENCES hotel (hotel_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		ALTER TABLE employee CHECK CONSTRAINT FK_employee_hotel
         GO

	insert into employee(emp_id,emp_first_name,emp_last_name,addresse,city,country,emp_designation,emp_contact_number,emp_email_address,hotel_id,department) 
	values ('E0014','Tomas','Dawit','Addis ababa/ethiopia','addis ababa','ethiopia','manager',0911258791,'tomas@gmail.com','H001','Managment'),
	       ('E0011','markos','hadis','Addis ababa/ethiopia','addis ababa','ethiopia','baresta',0911258792,'markos@gmail.com','H001','Managment'),
		   ('E0012','kibru','daniel','Addis ababa/ethiopia','addis ababa','ethiopia','waiter',0911258793,'kib@gmail.com','H002','Managment'),
		   ('E0013','fikir','Dawit','Addis ababa/ethiopia','addis ababa','ethiopia','manager',0911258794,'fik@gmail.com','H001','Managment'),
		   ('E0015','denekew','haile','Addis ababa/ethiopia','addis ababa','ethiopia','seller',0911258795,'den@gmail.com','H002','marketing'),
		   ('E0016','mulatu','admasu','Addis ababa/ethiopia','addis ababa','ethiopia','casher',0911258796,'mul@gmail.com','H002','accounting'),
		   ('E0018','tika','admasu','Addis ababa/ethiopia','addis ababa','ethiopia','casher',0911258797,'mule@gmail.com','H002','accounting'),
		   ('E0017','abdu','ali','Dessie/ethiopia','Dessie','ethiopia','camera Technishial',0911258798,'abdu@gmail.com','H001','IT');

	select * from employee;
	select * from hotel;
	
	
		--guest

	CREATE TABLE guest(
		guest_id nchar(10) PRIMARY KEY NOT NULL,
		guest_first_name varchar(50) NULL,
		guest_last_name varchar(50) NULL,
		addresse varchar(50) NULL,
		city varchar(50)  NULL,
		country varchar(50)  NULL,
		guest_contact_number varchar(50) NULL,
		guest_email_address varchar(50) NULL,
		guest_credit_card varchar(50) NULL,
		hotel_id nchar(10) NULL,
		emp_id nchar(10) NULL,
		);

		ALTER TABLE guest  WITH CHECK ADD  CONSTRAINT FK_guest_hotel FOREIGN KEY(hotel_id)
			REFERENCES hotel  (hotel_id)ON DELETE CASCADE ON UPDATE CASCADE
			GO

			ALTER TABLE guest CHECK CONSTRAINT FK_guest_hotel
				GO

		ALTER TABLE guest  WITH CHECK ADD  CONSTRAINT FK_guest_employee FOREIGN KEY(emp_id)
			REFERENCES employee (emp_id) ON DELETE CASCADE ON UPDATE CASCADE
			GO

			ALTER TABLE guest CHECK CONSTRAINT FK_guest_employee
				GO

insert into guest(guest_id,guest_first_name,guest_last_name,addresse,city,country,guest_contact_number,guest_email_address,guest_credit_card,hotel_id,emp_id)
		values ('G001','Abebe','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258711,'abebe@gmail.com','master card','H001','E0014'),
			   ('G002','kebe','degu','Addis ababa/ethiopia','addis ababa','ethiopia',0911258722,'abebe@gmail.com','master card','H001','E0016'),
			   ('G003','hikma','nur','Addis ababa/ethiopia','addis ababa','ethiopia',0911258791,'abebe@gmail.com','master card','H001','E0015'),
			   ('G004','belay','addis','Addis ababa/ethiopia','addis ababa','ethiopia',0911258792,'abebe@gmail.com',' cash','H002','E0015'),
			   ('G005','vare','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258793,'abebe@gmail.com','master card','H001','E0018'),
			   ('G006','Abebe','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258794,'abebe@gmail.com','master card','H002','E0017'),
			   ('G007','Abebe','koke','Addis ababa/ethiopia','addis ababa','ethiopia',0911258795,'abebe@gmail.com','master card','H001','E0011'),
			   ('G008','mahme','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258796,'abebe@gmail.com','master card','H001','E0012'),
			   ('G009','Abebe','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258790,'abebe@gmail.com','master card','H002','E0013'),
			   ('G0010','abdu','ali','Addis ababa/ethiopia','addis ababa','ethiopia',0911258797,'abebe@gmail.com','master card','H002','E0015'),
			   ('G0011','tadesse','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258798,'abebe@gmail.com','cash ','H002','E0011'),
			   ('G0012','mule','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258799,'abebe@gmail.com','master card','H001','E0016'),
			   ('G0013','gach','girma','Addis ababa/ethiopia','addis ababa','ethiopia',0911258700,'abebe@gmail.com','master card','H001','E0014');
	
		
	--booking

	CREATE TABLE booking(
		booking_id nchar(10)  PRIMARY KEY NOT NULL,
		booking_date date NULL,
		check_in_date date NULL,
		check_out_date date NULL,
		booking_payment_type varchar(50) NULL,
		total_rooms_booked int NULL,
		hotel_id nchar(10) NULL,
		guest_id nchar(10) NULL,
		total_amount decimal(10, 2) NULL,
	 );

	ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT FK_booking_hotel FOREIGN KEY(hotel_id)
		REFERENCES hotel (hotel_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		ALTER TABLE booking CHECK CONSTRAINT FK_booking_hotel
				GO

	ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT FK_booking_guest FOREIGN KEY(guest_id)
		REFERENCES guest (guest_id)--ON DELETE CASCADE ON UPDATE CASCADE
		GO

		--ALTER TABLE booking CHECK CONSTRAINT FK_booking_guest
				--GO


	insert into booking(booking_id,booking_date,check_in_date,check_out_date,booking_payment_type,total_rooms_booked,hotel_id,guest_id,total_amount) 
		 values ('B0011','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',9000),
				('B0010','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',9500),
				('B001','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',9600),
				('B002','2023/05/17','2023/05/17','2023/05/19','cash',3,'H002','G001',9000),
				('B003','2023/05/17','2023/05/17','2023/05/19','cash',3,'H002','G001',9000),
				('B004','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',8000),
				('B005','2023/05/17','2023/05/17','2023/05/19','cash',3,'H002','G001',7500),
				('B006','2023/05/17','2023/05/17','2023/05/19','cash',3,'H002','G001',8500),
				('B007','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',8000),
				('B008','2023/05/17','2023/05/17','2023/05/19','cash',3,'H001','G001',9000),
				('B009','2023/05/17','2023/05/17','2023/05/19','cash',3,'H002','G001',8520);

	select * from booking;
	select * from hotel;
	select * from guest;


		    Delete from booking
			where booking_id ='B0011';

		  --room
	-- Add UNIQUE Constraint

	CREATE TABLE room(
		room_id nchar(10)PRIMARY KEY NOT NULL,
		room_number int NOT NULL UNIQUE, -- Add UNIQUE Constraint
		room_type_description varchar(255) NULL,
		hotel_id nchar(10) NULL,
	);

	ALTER TABLE room  WITH CHECK ADD  CONSTRAINT FK_room_hotel FOREIGN KEY(hotel_id)
		REFERENCES hotel (hotel_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		ALTER TABLE room CHECK CONSTRAINT FK_room_hotel
				GO

	insert into room(room_id,room_number,room_type_description,hotel_id) 
		 values ('R001',9,'all type','H001'),
				('R003',1,'all type','H001'),
				('R002',21,'all type','H002'),
				('R004',20,'all type','H002'),
				('R005',19,'all type','H001'),
				('R006',18,'all type','H001'),
				('R007',16,'all type','H001'),
				('R008',14,'all type','H002'),
				('R009',4,'all type','H002'),
				('R0010',12,'all type','H001'),
				('R0011',11,'all type','H002'),
				('R0012',10,'all type','H002');
	
	

	select * from room;
	select * from hotel;

	--hotel_services

	CREATE TABLE hotel_services(
		service_id nchar(10)PRIMARY KEY NOT NULL,
		[service_name] varchar(50) NULL,
		service_description varchar(50) NULL,
		service_cost decimal(10, 2) CHECK (service_cost >=1 ),
		hotel_id nchar(10) NULL,
	);

	ALTER TABLE hotel_services  WITH CHECK ADD  CONSTRAINT FK_hotel_services_hotel FOREIGN KEY(hotel_id)
		REFERENCES hotel (hotel_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		ALTER TABLE hotel_services CHECK CONSTRAINT FK_hotel_services_hotel
				GO

	insert into hotel_services(service_id,service_name,service_description,service_cost,hotel_id) 
		 values ('S002','Massage','massage',500,'H001'),
				('S001','Pizza','Pizza',800,'H001'),
				('S003','Pizza','Pizza',600,'H002'),
				('S004','Burger','Burger',500,'H002'),
				('S005','woin','woin',4000,'H002'),
				('S006','woin','woin',5000,'H001'),
				('S007','Pizza','Pizza',700,'H002'),
				('S008','Burger','Burger',500,'H001'),
				('S009','water','water',300,'H001'),
				('S0010','Pizza','Pizza',900,'H002'),
				('S0011','Massage','massage',500,'H002'),
				('S0012','Pizza','Pizza',500,'H001'),
				('S0013','Burger','Burger',600,'H002');

	select * from hotel_services;
	select * from hotel;


	--payment

	CREATE TABLE payment(
		Payment_id nchar(10)PRIMARY KEY NOT NULL,
		Payment_type varchar(50) NULL,
		Payment_amount decimal(10, 2)  CHECK (Payment_amount >= 1),
		Payment_detail varchar(50) NULL,
		Payment_date date NULL,
		booking_id nchar(10) NULL,
	);

	ALTER TABLE payment  WITH CHECK ADD  CONSTRAINT FK_payment_booking FOREIGN KEY(booking_id)
		REFERENCES booking (booking_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		
		ALTER TABLE payment CHECK CONSTRAINT FK_payment_booking
				GO

	insert into payment(Payment_id,Payment_type,Payment_amount,Payment_detail,Payment_date,booking_id) 
		values  ('P0013','Cash',5000,'Cash on delivery','2023/05/19','B001'),
				('P0011','Cash',5200,'Cash on delivery','2023/05/19','B002'),
				('P0012','Cash',5000,'Cash on delivery','2023/05/19','B003'),
				('P0014','Cash',5300,'Cash on delivery','2023/05/19','B004'),
				('P0015','Cash',5100,'Cash on delivery','2023/05/19','B005'),
				('P0016','Cash',5000,'Cash on delivery','2023/05/19','B006'),
				('P0017','Cash',5000,'Cash on delivery','2023/05/19','B007'),
				('P0018','Cash',5300,'Cash on delivery','2023/05/19','B008'),
				('P0019','Cash',5980,'Cash on delivery','2023/05/19','B009'),
				('P0020','Cash',5360,'Cash on delivery','2023/05/19','B0010'),
				('P0021','Cash',550,'Cash on delivery','2023/05/19','B0011');

	select * from payment;
	select * from booking;


	---hotel_services_used_by_guests

	CREATE TABLE hotel_services_used_by_guests(
		service_used_id nchar(10)PRIMARY KEY NOT NULL,
		service_id nchar(10) NULL,
		guest_id nchar(10) NULL,
);
	
	ALTER TABLE hotel_services_used_by_guests  WITH CHECK ADD  CONSTRAINT FK_hotel_services_used_by_guests_hotel_services FOREIGN KEY(service_id)
		REFERENCES hotel_services (service_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		ALTER TABLE hotel_services_used_by_guests CHECK CONSTRAINT FK_hotel_services_used_by_guests_hotel_services
				GO

	ALTER TABLE hotel_services_used_by_guests WITH CHECK ADD  CONSTRAINT FK_hotel_services_used_by_guests_guest FOREIGN KEY(guest_id)
		REFERENCES guest (guest_id)ON DELETE CASCADE ON UPDATE CASCADE
		GO

		
		ALTER TABLE hotel_services_used_by_guests CHECK CONSTRAINT FK_hotel_services_used_by_guests_guest
				GO

	insert into hotel_services_used_by_guests(service_used_id,service_id,[guest_id]) 
	values	('SU001','S002','G001'),
			('SU002','S002','G002'),
			('SU003','S003','G003'),
			('SU004','S004','G004'),
			('SU005','S005','G005'),
			('SU006','S002','G006'),
			('SU007','S006','G007'),
			('SU008','S007','G008'),
			('SU009','S008','G009'),
			('SU0010','S009','G0010'),
			('SU0011','S0010','G0011'),
			('SU0012','S0012','G0012'),
			('SU0013','S0011','G0013');

		select * from hotel_services_used_by_guests;
		select * from hotel_services;
		select * from guest;
	
	    Delete from hotel_services_used_by_guests
		where service_used_id ='SU001';
