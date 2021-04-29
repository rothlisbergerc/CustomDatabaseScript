--Author: Cheryl Rothlisberger--
use master
DROP DATABASE IF EXISTS GroomingSalon

CREATE DATABASE GroomingSalon
GO

USE GroomingSalon
GO

--======================================================================--
--							  CREATE TABLES                             --
--======================================================================--

--===Create Accounts Table===--
CREATE TABLE Accounts
(
	AccountNo				int				IDENTITY(1000,1) PRIMARY KEY
	,AccountDescription		varchar(100)				NOT NULL
)


--===Create Customers Table===--
CREATE TABLE Customers
(
	CustomerId				int				IDENTITY(1, 1) PRIMARY KEY
	,CustomerFirstName		varchar(80)		NOT NULL
	,CustomerLastName		varchar(80)		NOT NULL
	,Email					varchar(200)	NULL
	,IsSubscribed			bit				NOT NULL DEFAULT 'False'
	,PhoneNumber			varchar(50)		NOT NULL
	,StreetAddress			varchar(100)	NOT NULL
	,CustomerCity			varchar(50)		NOT NULL
	,CustomerState			varchar(50)		NOT NULL
	,CustomerZipCode		varchar(20)		NOT NULL
	,AccountNo				int				NOT NULL
		REFERENCES	Accounts(AccountNo)
)

--===Create Pets Table===--
CREATE TABLE Pets
(
	PetId					int				IDENTITY(1, 1) PRIMARY KEY
	,PetName				varchar(80)		NOT NULL
	,PetType				char(3)			NOT NULL
		CHECK(PetType IN ('Cat', 'Dog'))
	,Breed					varchar(80)		NOT NULL
	,Age					varchar(30)		NOT NULL
	,Sex					char(1)			NOT NULL
		CHECK (Sex IN('F','M'))
	,Size					varchar(2)		NOT NULL
		CHECK (Size IN ('XS', 'S', 'MD', 'L', 'XL'))
	,Allergies				varchar(300)	NULL 
	,MedicalConditions		varchar(500)	NULL
	,Notes					varchar(1500)	NULL
	,AccountNo				int				NOT NULL
		REFERENCES Accounts(AccountNo)
)

--===Create Invoices Table===--
CREATE TABLE Invoices
(
	InvoiceId				int				IDENTITY(1, 1) PRIMARY KEY
	,InvoiceNumber			int				NOT NULL
	,InvoiceDate			date			NOT NULL
	,InvoiceTotal			smallmoney		NOT NULL
		CHECK(InvoiceTotal >= 0)
	,[Status]				varchar(10)		NOT NULL
		CHECK (Status IN ('Pending', 'Completed', 'Cancelled'))
	,CustomerId				int				NOT NULL
		REFERENCES Customers(CustomerId)
)

--===Create Employees Table===--
CREATE TABLE Employees
(
	EmployeeId				int				IDENTITY(1, 1)	PRIMARY KEY
	,EmployeeTitle			varchar(200)	NOT NULL
	,EmployeeFirstName		varchar(80)		NOT NULL
	,EmployeeLastName		varchar(80)		NOT NULL
	,ComissionRate			decimal(3, 2)	NOT NULL
		CHECK (ComissionRate BETWEEN 0 AND 100 )
	,HrlyPayRate			smallmoney		NOT NULL
	,Preferences			varchar(1500)	NULL
)

--===Create Appointments Table===--
CREATE TABLE Appointments
(
	AppointmentId			int				IDENTITY(1, 1)	PRIMARY KEY
	,AppointmentDate		date			NOT NULL
	,AppointmentTime		time			NOT NULL
	,AppointmentStatus		varchar(15)		NOT NULL
		CHECK (AppointmentStatus IN ('Prebooked', 'In-Progress', 'Cancelled', 'Completed'))
	,AppointmentNotes		varchar(1500)	NULL
	,PetId					int
		REFERENCES Pets(PetId)
	,CustomerId				int				
		REFERENCES Customers(CustomerId)
	,EmployeeId				int
		REFERENCES Employees(EmployeeId)
)

--===Create ServicesCategories Table===--
CREATE TABLE ServicesCategories
(
	ServicesCategoryId				int				IDENTITY(1, 1)	PRIMARY KEY
	,ServicesCategoryName			varchar(100)	NOT NULL		UNIQUE
	,ServicesCategoryDescription	varchar(500)	NOT NULL
)

--===Create Services Table===--
CREATE TABLE [Services]
(
	ServicesId				int				IDENTITY(1, 1)  PRIMARY KEY
	, ServicesName			varchar(300)	NOT NULL		UNIQUE
	,ServicesDescription	varchar(1500)	NULL
	,ServicesCost			smallmoney		NOT NULL
	,ServicesCategoryId		int
		REFERENCES ServicesCategories(ServicesCategoryId)
)

--===Create InvoiceLineItems Table===--
CREATE TABLE InvoiceLineItems
(
	InvoiceLineItemsId		int				IDENTITY(1, 1) PRIMARY KEY
	,InvoiceId				int
		REFERENCES Invoices(InvoiceId)
	,ServicesId				int
		REFERENCES [Services](ServicesId)
	,LineItemPrice			smallmoney		NOT NULL
	,LineItemDescription	varchar(150)	NOT NULL
)

--===Create AppointmentServices Table===--
CREATE TABLE AppointmentServices
(
	AppointmentId		int			REFERENCES Appointments(AppointmentId)
	,ServicesId			int			REFERENCES [Services](ServicesId)
	,Quantity			smallint	NOT NULL
	,PRIMARY KEY(AppointmentId, ServicesId)   
)

--======================================================================--
--						INSERT DATA INTO TABLES                         --
--======================================================================--

--===Accounts Table===-
INSERT INTO Accounts(AccountDescription)
VALUES('Pet Owner')

,('Pet Owner')

,('Pet Owner')

,('Pet Owner')

,('Pet Owner')

--===Customers Table===-
INSERT INTO Customers (CustomerFirstName, CustomerLastName, Email, IsSubscribed, PhoneNumber,
			StreetAddress, CustomerCity, CustomerState, CustomerZipCode, AccountNo )
VALUES(
		'Naomi'										--CustomerFirstName
		,'Nagata'									--CustomerLastName
		,'NagataNaomi@gmail.com'					--Email
		,'True'										--IsSubscribed
		,'(206)555-6169'							--PhoneNumber
		,'2011 Leviathan St'				        --StreetAddress
		,'Seattle'									--CustomerCity
		,'WA'										--CustomerState
		,'98103'									--CustomerZipCode
		,1001										--AccountNo
)

	,(
			'James'										--CustomerFirstName
			,'Holden'									--CustomerLastName
			,'HoldenJames@gmail.com'					--Email
			,'True'										--IsSubscribed
			,'(206)555-8905'							--PhoneNumber
			,'2011 Leviathan St'						--StreetAddress
			,'Seattle'									--CustomerCity
			,'WA'										--CustomerState
			,'98103'									--CustomerZipCode
			,1001										--AccountNo
	)

	,(
			'Amos'										--CustomerFirstName
			,'Burton'									--CustomerLastName
			,'BurtonAmos@gmail.com'						--Email
			,'False'									--IsSubscribed
			,'(775)555-9445'							--PhoneNumber
			,'2014 Cibola Dr'							--StreetAddress
			,'Reno'										--CustomerCity
			,'NV'										--CustomerState
			,'89403'									--CustomerZipCode
			,1002										--AccountNo
	)

	,(
			'Alex'										--CustomerFirstName
			,'Kamal'									--CustomerLastName
			,'ScreaminFirehawk@gmail.com'				--Email
			,'True'										--IsSubscribed
			,'(530)555-1203'							--PhoneNumber
			,'2012 Caliban Ave S'						--StreetAddress
			,'Auburn'									--CustomerCity
			,'CA'										--CustomerState
			,'95603'									--CustomerZipCode
			,1003										--AccountNo
	)

	,(
			'Juliette Andromeda'						--CustomerFirstName
			,'Mao'										--CustomerLastName
			,'RazorbackRebel@gmail.com'					--Email
			,'False'									--IsSubscribed
			,'(212)555-1829'							--PhoneNumber
			,'2019 Tiamat St Ct W'						--StreetAddress
			,'New York'									--CustomerCity
			,'NY'										--CustomerState
			,'10019'									--CustomerZipCode
			,1004										--AccountNo
	)

--===Pets Table===-
INSERT INTO Pets(PetName, PetType, Breed, Age, Sex, Size, Allergies, MedicalConditions,
			Notes, AccountNo)
VALUES(
	'Gaspode'						--PetName
	,'Dog'							--PetType
	,'Lhasa Apso, Shih Tzu mix'		--Breed
	,'8 yrs'						--Age
	,'M'							--Sex
	,'S'							--Size
	,'Perfumes, Dyes'				--Allergies
	,'Hip Dysplasia'				--MedicalConditions
	,'WILL BITE FOR NAIL TRIM.'		--Notes
	,1001							--AccountNo
)

	,(
			'Greebo'											--PetName
			,'Cat'												--PetType
			,'Maine Coon'										--Breed
			,'13 yrs'											--Age
			,'M'												--Sex
			,'XL'												--Size
			,NULL												--Allergies
			,'Blind in left eye, Diabetes'						--MedicalConditions
			,'Aggressive. Must be sedated for ALL services.'	--Notes
			,1002												--AccountNo
		)

	,(
			'Peaches'													--PetName
			,'Dog'														--PetType
			,'Belgian Malinois'											--Breed
			,'8 mo'														--Age
			,'F'														--Sex
			,'MD'														--Size
			,NULL														--Allergies
			,NULL														--MedicalConditions
			,'Owner is training Peaches for guarding. DO NOT let her '
				+ 'get away with any bad behavior. Use the clicker.'		--Notes
			,1002														--AccountNo
	)

	,(
			'Deimos'											--PetName
			,'Dog'												--PetType
			,'Jack Russell Terrier'								--Breed
			,'2 yrs'											--Age
			,'F'												--Sex
			,'S'												--Size
			,'Fleas'											--Allergies
			,NULL												--MedicalConditions
			,'Owner prefers nails to be dremeled'				--Notes
			,1003												--AccountNo
	)

	,(
			'Ceres'												--PetName
			,'Dog'												--PetType
			,'Border Collie'									--Breed
			,'5 yrs'											--Age
			,'F'												--Sex
			,'L'												--Size
			,NULL												--Allergies
			,NULL												--MedicalConditions
			,'Full spa treatment every appointment.'			--Notes
			,1004												--AccountNo
	)

	,(
			'Lional'																--PetName
			,'Cat'																	--PetType
			,'Domestic Shorthair'													--Breed
			,'3 yrs'																--Age
			,'M'																	--Sex
			,'S'																	--Size
			,NULL																	--Allergies
			,NULL																	--MedicalConditions
			,'Full spa treatment every appointment. Do not use pressure dryer.'		--Notes
			,1004																	--AccountNo
	)

--===Invoices Table===--
INSERT INTO Invoices (InvoiceNumber, InvoiceDate, InvoiceTotal, [Status], CustomerId)
VALUES
(
	1				--InvoiceNumber
	,'01/23/2021'	--InvoiceDate
	,38.00			--InvoiceTotal
	,'Completed'	--Status
	,2				--CustomerId
)

	,(
		2				--InvoiceNumber
		,'01/23/2021'	--InvoiceDate
		,30.00			--InvoiceTotal
		,'Cancelled'	--Status
		,1				--CustomerId
	)

	,(
		3				--InvoiceNumber
		,'01/26/2021'	--InvoiceDate
		,128.00			--InvoiceTotal
		,'Completed'	--Status
		,5				--CustomerId
	)

	,(
		4				--InvoiceNumber
		,'01/30/2021'	--InvoiceDate
		,65.00			--InvoiceTotal
		,'Completed'	--Status
		,3				--CustomerId
	)

	,(
		5				--InvoiceNumber
		,'01/30/2021'	--InvoiceDate
		,10.00			--InvoiceTotal
		,'Completed'	--Status
		,4				--CustomerId
	)

	,(
		6				--InvoiceNumber
		,'02/14/2021'	--InvoiceDate
		,30.00			--InvoiceTotal
		,'Pending'		--Status
		,3				--CustomerId
	)

	,(
		7				--InvoiceNumber
		,'02/14/2021'	--InvoiceDate
		,13.00			--InvoiceTotal
		,'Pending'		--Status
		,4				--CustomerId
	)


--===Employees Table===--
INSERT INTO Employees(EmployeeTitle, EmployeeFirstName, EmployeeLastName, ComissionRate, 
			HrlyPayRate, Preferences)
VALUES 
(
	'Bather'	--EmployeeTitle
	,'Melba'	--EmployeeFirstName
	,'Koh'		--EmployeeLastName
	,0.40		--ComissionRate
	,14.00		--HrlyPayRate
	,'No Cats'	--Preferences
)

	,(
		'Bather'	--EmployeeTitle
		,'David'	--EmployeeFirstName
		,'Draper'	--EmployeeLastName
		,0.40		--ComissionRate
		,14.00		--HrlyPayRate
		,NULL		--Preferences
	)

	,(
		'Bather'		--EmployeeTitle
		,'Felcia'		--EmployeeFirstName
		,'Mazur'		--EmployeeLastName
		,0.40			--ComissionRate
		,14.00			--HrlyPayRate
		,NULL			--Preferences
	)

	,(
		'Groomer'	--EmployeeTitle
		,'Chandra'	--EmployeeFirstName
		,'Wei'		--EmployeeLastName
		,0.50		--ComissionRate
		,14.00		--HrlyPayRate
		,NULL		--Preferences
	)

	,(
		'Groomer'			--EmployeeTitle
		,'Lucia'			--EmployeeFirstName
		,'Mazur'			--EmployeeLastName
		,0.50				--ComissionRate
		,14.00				--HrlyPayRate
		,NULL				--Preferences
	)

	,(
		'Groomer'	--EmployeeTitle
		,'Shed'		--EmployeeFirstName
		,'Garvey'	--EmployeeLastName
		,0.50		--ComissionRate
		,14.00		--HrlyPayRate
		,'No Cats'	--Preferences
	)

	,(
		'Manager & Groomer'	--EmployeeTitle
		,'Annushka'			--EmployeeFirstName
		,'Volovodov'		--EmployeeLastName
		,0.50				--ComissionRate
		,18.00				--HrlyPayRate
		,'No Sundays'		--Preferences
	)

	,(
		'Manager & Groomer'	--EmployeeTitle
		,'Carol'			--EmployeeFirstName
		,'Chiwewe'			--EmployeeLastName
		,0.50				--ComissionRate
		,18.00				--HrlyPayRate
		,NULL				--Preferences
	)

--===Appointments Table===--
INSERT INTO Appointments (AppointmentDate, AppointmentTime, AppointmentStatus, AppointmentNotes,
			PetId, CustomerId, EmployeeId)
VALUES
(
	'01/23/2021'						--AppointmentDate
	,'10:00AM'							--AppointmentTime
	,'Completed'						--AppointmentStatus
	,'#7 all over, leave ears natural'	--AppointmentNotes
	,1									--PetId
	,2									--CustomerId
	,7									--EmployeeId
)

	,(
		'01/23/2021'						--AppointmentDate
		,'10:30AM'							--AppointmentTime
		,'Cancelled'						--AppointmentStatus
		,NULL								--AppointmentNotes
		,1									--PetId
		,1									--CustomerId
		,2									--EmployeeId
	)

	,(
		'01/26/2021'														--AppointmentDate
		,'2:30PM'															--AppointmentTime
		,'Completed'														--AppointmentStatus
		,'Deshedding moisturizing shampoo/conditioner, Sweet Pea perfume, '
		  + '#3 comb on body, dremel nails.'								--AppointmentNotes
		,5																	--PetId
		,5																	--CustomerId
		,5																	--EmployeeId
	)

	,(
		'01/26/2021'														--AppointmentDate
		,'2:30PM'															--AppointmentTime
		,'Completed'														--AppointmentStatus
		,'Deshedding moisturizing shampoo/conditioner, Sweet Pea perfume. '
		  + 'No pressure dryer'												--AppointmentNotes
		,6																	--PetId
		,5																	--CustomerId
		,2																	--EmployeeId
	)

	,(
		'01/30/2021'												--AppointmentDate
		,'8:00AM'													--AppointmentTime
		,'Completed'												--AppointmentStatus
		,'Confirm with owner that Greebo has been sedated prior to '
		  + 'drop off.'												--AppointmentNotes
		,2															--PetId
		,3															--CustomerId
		,8															--EmployeeId
	)

	,(
		'01/30/2021'						--AppointmentDate
		,'4:00PM'							--AppointmentTime
		,'Completed'						--AppointmentStatus
		,NULL								--AppointmentNotes
		,4									--PetId
		,4									--CustomerId
		,3									--EmployeeId
	)

	,(
		'02/14/2021'								--AppointmentDate
		,'11:00AM'									--AppointmentTime
		,'In-Progress'								--AppointmentStatus
		,'Owner wants Melba handling Peaches only'	--AppointmentNotes
		,3											--PetId
		,3											--CustomerId
		,1											--EmployeeId
	)

	,(
		'02/14/2021'						--AppointmentDate
		,'1:00PM'							--AppointmentTime
		,'In-Progress'						--AppointmentStatus
		,'Dremel Nails'						--AppointmentNotes
		,4									--PetId
		,4									--CustomerId
		,3									--EmployeeId
	)

	,(
		'03/14/2021'						--AppointmentDate
		,'1:00PM'							--AppointmentTime
		,'Prebooked'						--AppointmentStatus
		,'Dremel Nails'						--AppointmentNotes
		,4									--PetId
		,4									--CustomerId
		,2									--EmployeeId
	)

	,(
		'03/09/2021'														--AppointmentDate
		,'9:30AM'															--AppointmentTime
		,'Prebooked'														--AppointmentStatus
		,'Deshedding moisturizing shampoo/conditioner, Sweet Pea perfume, '
		  + '#3 comb on body, dremel nails.'								--AppointmentNotes
		,5																	--PetId
		,5																	--CustomerId
		,7																	--EmployeeId
	)

	,(
		'03/09/2021'														--AppointmentDate
		,'9:30AM'															--AppointmentTime
		,'Prebooked'														--AppointmentStatus
		,'Deshedding moisturizing shampoo/conditioner, Sweet Pea perfume. '
		  + 'No pressure dryer'												--AppointmentNotes
		,6																	--PetId
		,5																	--CustomerId
		,4																	--EmployeeId
	)

--===ServicesCategories Table===-
INSERT INTO ServicesCategories(ServicesCategoryName, ServicesCategoryDescription)
VALUES
(
	'Bath'					--ServicesCategoriesName
	,'Basic Bath Service'	--ServicesCategoryDesciption
)

	,(
		'Groom'							--ServicesCategoriesName
		,'Basic Bath Service + haircut'	--ServicesCategoryDesciption
	)

	,(
		'Maintenance'									--ServicesCategoriesName
		,'Extras, add-ons, and stand-alone services'	--ServicesCategoryDesciption
	)

--===Services Table===--
INSERT INTO [Services](ServicesName, ServicesDescription, ServicesCost, ServicesCategoryId)
VALUES
(
	'Spa Treatment'										--ServicesName
	,'Add on to Basic Bath Package or Groom Service: '
	 + 'Nail dremeling, moisturizing conditioner, '
	 + 'moisturizing spray, teeth brushing, and a '
	 + 'bow or bandana'									--ServicesDescription
	,22.00												--ServicesCost
	,1													--ServicesCategoryId
)

	,(
		'Basic Bath Package: Short Hair (Cat)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,36.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Long Hair (Cat)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,46.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Short Hair (XSmall - Small)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,20.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Short Hair (Medium)'			--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,26.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Short hair (Large - XLarge)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,32.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Medium hair (XSmall - Small)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,24.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Medium Hair (Medium)'			--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,30.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Medium hair (Large - XLarge)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,36.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Long hair (XSmall - Small)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,30.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Long Hair (Medium)'			--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,34.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Basic Bath Package: Long hair (Large - XLarge)'	--ServicesName
		,'Shampoo, brushing, ear cleaning, nail clipping, '
		  + 'sannitary cut, and gland expression.'			--ServicesDescription
		,40.00												--ServicesCost
		,1													--ServicesCategoryId
	)

	,(
		'Groom Service: Medium Hair (XSmall - Small)'		--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,32.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Medium Hair (Medium)'				--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,38.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Medium Hair (Large - XLarge)'		--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,44.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Long Hair (XSmall - Small)'			--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,38.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Long Hair (Medium)'					--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,42.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Long Hair (Large - XLarge)'			--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,48.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Groom Service: Long Hair (Cat)'					--ServicesName
		,'Full-body haircut, Shampoo, brushing, ear '
		 + 'cleaning, nail clipping'						--ServicesDescription
		,60.00												--ServicesCost
		,2													--ServicesCategoryId
	)

	,(
		'Nail Trim'		--ServicesName
		,NULL			--ServicesDescription
		,10.00			--ServicesCost
		,3				--ServicesCategoryId
	)

	,(
		'Nail Dremel'	--ServicesName
		,NULL			--ServicesDescription
		,13.00			--ServicesCost
		,3				--ServicesCategoryId
	)

	,(
		'Ear Cleaning'	--ServicesName
		,NULL			--ServicesDescription
		,7.00			--ServicesCost
		,3				--ServicesCategoryId
	)


	,(
		'Gland Expression'	--ServicesName
		,NULL				--ServicesDescription
		,10.00				--ServicesCost
		,3					--ServicesCategoryId
	)

	,(
		'Hand Scissoring'	--ServicesName
		,NULL				--ServicesDescription
		,5.00				--ServicesCost
		,3					--ServicesCategoryId
	)

	,(
		'Handling Fee'	--ServicesName
		,NULL			--ServicesDescription
		,5.00			--ServicesCost
		,3				--ServicesCategoryId
	)

	,(
		'Nail Polish'											--ServicesName
		,'Paint nails with pet-safe nail polish (Dogs only)'	--ServicesDescription
		,10.00													--ServicesCost
		,3														--ServicesCategoryId
	)

	,(
		'Teeth Brushing'	--ServicesName
		,NULL				--ServicesDescription
		,10.00				--ServicesCost
		,3					--ServicesCategoryId
	)

	,(
		'Sannitary Trim'	--ServicesName
		,NULL				--ServicesDescription
		,10.00				--ServicesCost
		,3					--ServicesCategoryId
	)

	,(
		'Conditioner'		--ServicesName
		,'Add-on to bath'	--ServicesDescription
		,3.00				--ServicesCost
		,3					--ServicesCategoryId
	)

	,(
		'Moisturizing Shampoo'	--ServicesName
		,'Add-on to bath'		--ServicesDescription
		,3.00					--ServicesCost
		,3						--ServicesCategoryId
	)

--===InvoiceLineItems Table===--
INSERT INTO InvoiceLineItems(InvoiceId, ServicesId, LineItemPrice, LineItemDescription)
VALUES
(
	1										--InvoiceId
	,14										--ServicesId
	,38.00									--LineItemPrice
	,'Groom Service: Medium Hair (Medium)'	--LineItemDescription
)

	,(
		2											--InvoiceId
		,8											--ServicesId
		,30.00										--LineItemPrice
		,'Basic Bath Package: Medium Hair (Medium)'	--LineItemDescription
	)

	,(
		3												--InvoiceId
		,18												--ServicesId
		,48.00											--LineItemPrice
		,'Groom Service: Long Hair (Large - XLarge)'	--LineItemDescription
	)

	,(
		3					--InvoiceId
		,1					--ServicesId
		,22.00				--LineItemPrice
		,'Spa Treatment'	--LineItemDescription
	)

	,(
		3											--InvoiceId
		,2											--ServicesId
		,36.00										--LineItemPrice
		,'Basic Bath Package: Short Hair (Cat)'		--LineItemDescription
	)

	,(
		3					--InvoiceId
		,1					--ServicesId
		,22.00				--LineItemPrice
		,'Spa Treatment'	--LineItemDescription
	)

	,(
		4									--InvoiceId
		,19									--ServicesId
		,60.00								--LineItemPrice
		,'Groom Service: Long Hair (Cat)'	--LineItemDescription
	)

	,(
		4					--InvoiceId
		,25					--ServicesId
		,5.00				--LineItemPrice
		,'Handling Fee'		--LineItemDescription
	)

	,(
		5					--InvoiceId
		,20					--ServicesId
		,10.00				--LineItemPrice
		,'Nail Trim'		--LineItemDescription
	)

	,(
		6											--InvoiceId
		,8											--ServicesId
		,30.00										--LineItemPrice
		,'Basic Bath Package: Medium Hair (Medium)'	--LineItemDescription
	)

	,(
		7				--InvoiceId
		,21				--ServicesId
		,13.00			--LineItemPrice
		,'Nail Dremel'	--LineItemDescription
	)



--===AppointmentServices Table===--
INSERT INTO AppointmentServices(AppointmentId, ServicesId, Quantity)
VALUES
	(1, 14, 1), (3, 18, 1), (3, 1, 2), (3, 2, 1), (4, 19, 1), (4, 25, 1), (5, 20, 1)
	,(6, 8, 1), (7, 21, 1)


--======================================================================--
--							 TEST QUERIES                               --
--======================================================================--

/* Pull appointment history for all pets that have medical 
   conditions. See how often they have been coming in and
   which employees have worked with them.*/

SELECT *
FROM Appointments JOIN Pets ON
	Appointments.PetId = Pets.PetId
WHERE MedicalConditions IS NOT NULL
---------------------------------------------------------------------

/* Get all the customers who have more than one pet, and list
   the number of pets. Can be useful for keeping track of which
   customers are most likely to book group appointments.*/

SELECT Customers.CustomerFirstName + Customers.CustomerLastName AS CustomerFullName
		,COUNT(*) AS NumberOfPets
FROM Customers JOIN Accounts ON
	Customers.AccountNo = Accounts.AccountNo 
JOIN Pets ON 
	Pets.AccountNo = Accounts.AccountNo
GROUP BY CustomerFirstName + CustomerLastName  
HAVING COUNT(Pets.AccountNo) > 1
---------------------------------------------------------------------

/* Get the top 3 most expensive invoices within the last month.
   Useful information when analyzing monthly income. Which customers, 
   services, dates, etc. stand out or overlap that may account for 
   these high price invoices?										*/		--Joe, Can you double check that I did this right please?--

SELECT TOP 3 InvoiceTotal, Invoices.CustomerId, InvoiceId
FROM Customers JOIN Invoices ON
	Customers.CustomerId = Invoices.CustomerId
WHERE Status NOT IN ('Cancelled') AND 
InvoiceDate BETWEEN DATEADD(DAY, -30, GETDATE()) AND GETDATE()
ORDER BY InvoiceTotal DESC
---------------------------------------------------------------------

/* Get the appointment history for customer Amos Burton. The 
   customer may have requested this information or an employee  
   referring to past appointment notes ie type of cut, behavior 
   issues, how much time has passed between appointments.          */

SELECT *
FROM Appointments JOIN Customers ON
	Appointments.CustomerId = Customers.CustomerId
WHERE Customers.CustomerId = 3
ORDER BY AppointmentDate
---------------------------------------------------------------------

/* Get all appointment information and corrosponding customer
   information for January 2021. Useful for analyzing monthly
   customer traffic.*/

SELECT *
FROM Appointments JOIN Customers ON
	Appointments.CustomerId = customers.CustomerId
WHERE AppointmentDate BETWEEN '2021-01-01' AND '2021-01-31'
---------------------------------------------------------------------

/* Find the top 3 most popular services. Useful for deciding which
   services to keep, discontinue, or promote.                      */

SELECT TOP 3 AppointmentServices.ServicesId, Quantity, ServicesName, 
			ServicesDescription
FROM AppointmentServices JOIN [Services] ON
	AppointmentServices.ServicesId = [Services].ServicesId
ORDER BY Quantity DESC
---------------------------------------------------------------------

/* Get all groomers. Useful for scheduling grooming appts, since
   bathers cannot be scheduled for appts that require haircuts.   */

SELECT *
FROM Employees
WHERE EmployeeTitle LIKE '%Groomer%'
--------------------------------------------------------------------

--======================================================================--
--							     NOTES                                  --
--======================================================================--

/* I could expand the database to include online accounts for customers including
   account usernames, passwords, and profile pictures for their pets. I also could
   expand the accounts table to include employees who bring their own pets in to 
   get groomed and factor in an employee discount somewhere. I'd also like to 
   have this website give the customer an option to prepay online (and offer a
   discount for prepaying), though I'm not sure what would be included in making 
   that happen. It would also be nice to have a history of who has accessed account
   information, like a list of employeeId's and the corrosponding date/time that 
   they accessed the customer's account, as well as a record of who scheduled an 
   appointment if it was done over the phone/in person.
   
   Any notes you have on how I can improve and expand on this database (as if it 
   were a real database) would be very appreciated! Thanks Joe!
   
   
   P.S. if you're feeling squirrely:
   
   Can you tell me if it's possible to do this / how to do this query:

   Pull the top 3 customers who have spent the most money since their first appointment.
   
   I couldn't figure it out. Not sure if I just needed to set up the database differently
   or what. No worries if you've got a lot on your plate, though. I totally get it.
   */

