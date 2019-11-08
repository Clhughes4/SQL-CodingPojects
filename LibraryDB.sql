--Created DB named LibraryManagementSystem
CREATE DATABASE LibraryManagementSystem_db;

/* Used this process to clear up some bugs
USE MASTER
go
DROP DATABASE LibraryManagementSystem_db
go
CREATE DATABASE LibraryManagementSystem_db
go
USE LibraryManagementSystem_db
go
*****************************************/

/* Created Borrower first since Bookloans needs it to be referenced */
CREATE TABLE Borrower (
CardNo INT PRIMARY KEY NOT NULL IDENTITY(10, 10),
Name VARCHAR(75) NOT NULL,
Address VARCHAR(150) NOT NULL,
Phone VARCHAR(20) NOT NULL
);
--CREATE DATABASE LibraryManagementSystem_db;
--USE LibraryManagementSystem_db;
/* Created Tables */
CREATE TABLE LibraryBranch (
BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
BranchName VARCHAR(75) NOT NULL,
Address VARCHAR(150) NOT NULL
);

--issuing SELECT command to make sure the table shows the columns
SELECT * FROM LibraryBranch;--table shows the correct columns...now moving on to create the other tables

/* Step 2 is to create this table because Books wont allow to be created because of the foreign key reference */
CREATE TABLE Publisher (
PublisherName VARCHAR(100) PRIMARY KEY NOT NULL,
Address VARCHAR(150) NOT NULL,
Phone VARCHAR(30) NOT NULL
);

/* Step #3: Publisher table is created now the Books table can be created */
CREATE TABLE Books (
BookID INT PRIMARY KEY NOT NULL IDENTITY (100, 20),
Title VARCHAR(50) NOT NULL,
PublisherName VARCHAR(100) NOT NULL CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES Publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);


--executing SELECT on first 2 tables
SELECT * FROM LibraryBranch;
SELECT * FROM Publisher;
--Correct columns showing

CREATE TABLE BookAuthors (
BookAuthors INT PRIMARY KEY NOT NULL IDENTITY (1,1),
BookID INT NOT NULL CONSTRAINT fk_BookID FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
AuthorName VARCHAR(100) NOT NULL
);

/* Ran into a an issue creating the fk_BookID because BookAuthors already had the CONSTRAINT of BookID.
*Changed to Bcbo--stands for BookCopies Book ID-- & Bcbr--stands for BookCopies Branch ID.
*After changing the FK reference, table created successfully */
CREATE TABLE BookCopies (
Bcbo_ID INT NOT NULL CONSTRAINT fk_Bcbo_ID FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
Bcbr_ID INT NOT NULL CONSTRAINT fk_Bcbr_ID FOREIGN KEY REFERENCES LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
NumberCopies INT NOT NULL
);

--Running SELECT to see if the columns generated poperly
SELECT * FROM BookCopies;--generated correctly
/* Changed the FK for BookLoans as well */
CREATE TABLE BookLoans (
BookLoanID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Blbo_ID INT NOT NULL CONSTRAINT fk_Blbo_ID FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
Blbr_ID INT NOT NULL CONSTRAINT fk_Blbr_ID FOREIGN KEY REFERENCES LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
DateOut DATE NOT NULL,
DateDue DATE NOT NULL
);
SELECT * FROM BookLoans;
--DROP TABLE BookLoans;


/* All tables created successfully, now INSERT +'ing' data into them */

INSERT INTO LibraryBranch
(BranchName, Address)
VALUES
('Sharpstown','401 Almedia Ave'),
('Montyhill','4231 Climbing Heights Rd'),
('Rivercrest','8193 Grizzly Mountain Way'),
('Central','2238 Grace Dr')
;
--Data was inserted successfully
SELECT * FROM LibraryBranch;
--Data was inserted successfully
SELECT * FROM LibraryBranch;
INSERT INTO Publisher
	(PublisherName, Address, Phone)
	VALUES
	('Doubleday', '1745 Broadway', '718-225-7694'),
	('Harper Collins', '195 Broadway', '917-375-7719'),
	('Bloomsbury Publishing', '1385 Broadway', '718-776-2364'),
	('Allen & Unwin', '83 Alexander St', '281-892-5532'),
	('W. W. Norton & Company', '500 5th Ave # 6', '917-664-3767'),
	('Geoffrey Bles', '335 Madison Square', '145-279-8843'),
	('Alfred A. Knopf', '1745 Broadway', '917-344-2769'),
	('Picador USA', '175 5th Ave', '718-176-5534')
;

INSERT INTO Books
	(Title, PublisherName)
	VALUES
	('Divergent', 'Harper Collins'),
	('Insurgent', 'Harper Collins'),
	('Allegiant', 'Harper Collins'),
	('Harry Potter and the Sorcer''s Stone','Bloomsbury Publishing'),
	('Harry Potter and the Chamber of Secrets', 'Bloomsbury Publishing'),
	('Harry Potter and the Prisoner of Azkaban', 'Bloomsbury Publishing'),
	('Harry Potter and the Goblet of Fire', 'Bloomsbury Publishing'),
	('Harry Potter and the Order of the Phoenix', 'Bloomsbury Publishing'),
	('Harry Potter and the Half Blood Prince', 'Bloomsbury Publishing'),
	('Harry Potter and the Deathly Hallows', 'Bloomsbury Publishing'),
	('The Fellowship of the Ring', 'Allen & Unwin'),
	('The Two Towers', 'Allen & Unwin'),
	('Fight Club', 'W. W. Norton & Company'),
	('The Shining', 'Doubleday'),
	('It', 'Doubleday'),
	('The Lion, the Witch and the Wardrobe', 'Geoffrey Bles'),
	('Prince Caspian', 'Geoffrey Bles'),
	('Forest Gump', 'Doubleday'),
	('Willy Wonka and the Chocolate Factory', 'Alfred A. Knopf'),
	('The Lost Tribe', 'Picador USA'),
	('Jaws', 'Doubleday')
;
SELECT * FROM Books;
INSERT INTO BookAuthors
	(BookID, AuthorName)
	VALUES
	(100,'Verionica Roth'),
	(120,'Verionica Roth'),
	(140,'Verionica Roth'),
	(160,'JK Rowling'),
	(180,'JK Rowling'),
	(200,'JK Rowling'),
	(220,'JK Rowling'),
	(240,'JK Rowling'),
	(260,'JK Rowling'),
	(280,'JK Rowling'),
	(300,'J.R.R Tolkien'),
	(320,'J.R.R Tolkien'),
	(340,'Chuck Palahniuk'),
	(360,'Stephen King'),
	(380,'Stephen King'),
	(400,'C.S. Lewis'),
	(420,'C.S. Lewis'),
	(440,'Winston Groom'),
	(460,'Ronald Dahl'),
	(480,'Mark Lee'),
	(500, 'Peter Benchley')
;
SELECT * FROM BookAuthors;
/*When trying to insert running into an issue about column doesnt allow nulls
so deleted the primary key because it didn't have an auto incramented value and INSERT worked */

INSERT INTO BookCopies
	(Bcbo_ID, Bcbr_ID, NumberCopies)
	VALUES
	(100, 1, 8),
	(100, 2, 5),
	(100, 3, 8),
	(120, 1, 6),
	(120, 2, 10),
	(120, 3, 8),
	(120, 4, 9),
	(140, 1, 6),
	(140, 3, 12),
	(140, 4, 3),
	(160, 1, 7),
	(160, 2, 5),
	(160, 3, 10),
	(160, 4, 3),
	(180, 1, 7),
	(180, 2, 5),
	(180, 4, 6),
	(200, 1, 4),
	(200, 2, 8),
	(200, 3, 2),
	(200, 4, 5),
	(220, 2, 6),
	(220, 3, 5),
	(240, 1, 10),
	(240, 2, 9),
	(240, 3, 4),
	(240, 4, 11),
	(260, 1, 6),
	(260, 2, 5),
	(260, 3, 6),
	(260, 4, 7),
	(280, 1, 6),
	(280, 2, 8),
	(280, 3, 4),
	(280, 4, 8),
	(300, 1, 3),
	(300, 2, 8),
	(300, 3, 5),
	(320, 1, 3),
	(320, 2, 6),
	(320, 4, 7),
	(340, 1, 4),
	(340, 2, 7),
	(340, 3, 12),
	(340, 4, 4),
	(360, 1, 3),
	(360, 2, 8),
	(360, 3, 2),
	(360, 4, 8),
	(380, 1, 9),
	(380, 2, 8),
	(380, 3, 5),
	(380, 4, 6),
	(400, 1, 8),
	(400, 2, 6),
	(400, 3, 3),
	(400, 2, 4),
	(420, 2, 6),
	(420, 3, 9),
	(420, 4, 8),
	(440, 1, 6),
	(440, 2, 4),
	(440, 3, 3),
	(440, 4, 8),
	(460, 1, 4),
	(460, 2, 6),
	(460, 3, 5),
	(460, 4, 3),
	(480, 1, 9),
	(480, 2, 6),
	(480, 3, 8),
	(480, 4, 6),
	(500, 2, 5),
	(500, 3, 4),
	(500, 4, 5)
;

INSERT INTO BookLoans
	(Blbo_ID, Blbr_ID, CardNo, DateOut, DateDue)
	VALUES
	(100, 2, 80, '2019-10-28', '2019-11-11'),
	(120, 4, 30, '2019-10-28', '2019-11-11'),
	(120, 3, 10, '2019-10-28', '2019-11-11'),
	(140, 1, 60, '2019-10-28', '2019-11-11'),
	(140, 1, 80, '2019-10-29', '2019-11-12'),
	(160, 2, 50, '2019-10-29', '2019-11-12'),
	(160, 4, 20, '2019-10-29', '2019-11-12'),
	(160, 3, 80, '2019-10-30', '2019-11-13'),
	(180, 3, 30, '2019-10-30', '2019-11-13'),
	(180, 3, 50, '2019-10-30', '2019-11-13'),
	(180, 2, 70, '2019-10-30', '2019-11-13'),
	(220, 2, 70, '2019-10-30', '2019-11-13'),
	(240, 3, 10, '2019-10-30', '2019-11-13'),
	(260, 3, 80, '2019-10-31', '2019-11-14'),
	(260, 4, 50, '2019-10-31', '2019-11-14'),
	(260, 4, 30, '2019-10-31', '2019-11-14'),
	(280, 2, 20, '2019-10-31', '2019-11-14'),
	(280, 1, 10, '2019-10-31', '2019-11-14'),
	(300, 4, 30, '2019-11-01', '2019-11-15'),
	(300, 3, 60, '2019-11-01', '2019-11-15'),
	(300, 2, 60, '2019-11-01', '2019-11-15'),
	(320, 2, 70, '2019-11-01', '2019-11-15'),
	(320, 3, 60, '2019-11-02', '2019-11-16'),
	(340, 4, 80, '2019-11-02', '2019-11-16'),
	(340, 2, 10, '2019-11-02', '2019-11-16'),
	(360, 3, 30, '2019-11-02', '2019-11-16'),
	(360, 1, 40, '2019-11-02', '2019-11-16'),
	(380, 1, 60, '2019-11-02', '2019-11-16'),
	(400, 4, 80, '2019-11-03', '2019-11-17'),
	(400, 3, 70, '2019-11-03', '2019-11-17'),
	(400, 2, 30, '2019-11-03', '2019-11-17'),
	(420, 2, 10, '2019-11-03', '2019-11-17'),
	(420, 4, 20, '2019-11-03', '2019-11-17'),
	(440, 3, 20, '2019-11-03', '2019-11-17'),
	(440, 3, 50, '2019-11-03', '2019-11-17'),
	(440, 2, 60, '2019-11-03', '2019-11-17'),
	(440, 1, 10, '2019-11-04', '2019-11-18'),
	(440, 4, 80, '2019-11-04', '2019-11-18'),
	(440, 4, 30, '2019-11-04', '2019-11-18'),
	(440, 3, 40, '2019-11-04', '2019-11-18'),
	(440, 3, 40, '2019-11-04', '2019-11-18'),
	(460, 1, 20, '2019-11-05', '2019-11-19'),
	(460, 2, 10, '2019-11-05', '2019-11-19'),
	(460, 3, 60, '2019-11-05', '2019-11-19'),
	(460, 4, 50, '2019-11-05', '2019-11-19'),
	(480, 1, 30, '2019-11-06', '2019-11-20'),
	(480, 1, 30, '2019-11-06', '2019-11-20'),
	(480, 2, 80, '2019-11-06', '2019-11-20'),
	(500, 1, 60, '2019-11-06', '2019-11-20'),
	(500, 3, 40, '2019-11-06', '2019-11-20'),
	(500, 4, 70, '2019-11-06', '2019-11-20')
;
/* Deleted the column CardNo because it is auto incremented, so it didnt need a value assigned */
INSERT INTO Borrower
	 (Name, Address, Phone)
	VALUES
	('Jessica', '4458 Petunia Dr', '360-778-1246'),
	('Leonids', '2847 Assassin Loop', '576-993-6687'),
	('Brandon', '205 1st St', '216-884-3382'),
	('Brinley', '1252 Paradise Ln', '617-718-2973'),
	('Liam', ' 22787 River Mountain Hwy', '216-596-9987'),
	('Amber', '18909 Sunset Blvd', '405-388-2161'),
	('Dex', '1889 St Joseph', '379-997-6543'),
	('Camillie', '742 Triple Falls Pl', '485-394-8112')
;
--Inserted additional Borrower to reflect data output in step #3 instead of returning no data
INSERT INTO Borrower (Name, Address, Phone) VALUES ('Jason', '341 Hop Ln', '667-589-3392')


--#1
/* Created Procedure as LostTribe_Sharpstown */
SELECT 
	a1.BranchName, a2.NumberCopies, a3.Title
	FROM LibraryBranch a1
	INNER JOIN BookCopies a2 ON a2.Bcbr_ID = a1.BranchID
	INNER JOIN Books a3 ON a2.Bcbo_ID = a3.BookID
	WHERE Title = 'The Lost Tribe' AND BranchName = 'Sharpstown'
;

--#2--works
/* Created Procedure as LostTribe */
SELECT 
	a1.BranchName, a2.NumberCopies, a3.Title
	FROM LibraryBranch a1
	INNER JOIN BookCopies a2 ON a2.Bcbr_ID = a1.BranchID
	INNER JOIN Books a3 ON a2.Bcbo_ID = a3.BookID
	WHERE Title = 'The Lost Tribe'
;

--#3--works
/* Created Procedure as NoLoans */
SELECT 
	a2.name AS "Borrower with no loaned books"
	FROM BookLoans a1 
	FULL OUTER JOIN Borrower a2 ON a1.CardNo = a2.CardNo
	WHERE DateOut IS NULL
;

--#4--works
/* Create Procedure Sharpstown_DateDue */
SELECT
	a1.BranchName, a2.Title, a3.DateDue, a3.Blbr_ID,
	a4.Name, a4.Address
	FROM BookLoans a3
	INNER JOIN LibraryBranch a1 ON a1.BranchID = a3.Blbr_ID
	INNER JOIN Books a2 ON a2.BookID = a3.Blbo_ID
	INNER JOIN Borrower a4 ON a4.CardNo = a3.CardNo
	WHERE BranchName = 'Sharpstown'
	AND DateDue = '2019-11-16'
;

--#5
/* Created Procedure TotalBooksOut */
SELECT 
	a1.BranchName, COUNT(*) AS "Total # of books out"
	FROM LibraryBranch a1
	INNER JOIN BookLoans a2 ON a1.BranchID = a2.Blbr_ID
	WHERE BranchName IN ('Sharpstown','Montyhill','RiverCrest','Central')
	GROUP BY BranchName
;

--#6
/* Created Procedure LOANS_5 */
SELECT 	a1.Name, a1.Address, COUNT(a2.CardNo) AS "Checked out books"	FROM Borrower a1	INNER JOIN BookLoans a2 ON a2.CardNo = a1.CardNo	GROUP BY Name, Address	HAVING COUNT(a2.CardNo) > 5;
--#7
/* Created Procedure find_StephenKing */
SELECT
	a1.BranchName, a2.NumberCopies, 
	a3.Title
	FROM BookAuthors a4 
	INNER JOIN Books a3 ON a3.BookID = a4.BookID
	INNER JOIN BookCopies a2 ON a3.BookID = a2.Bcbo_ID
	INNER JOIN LibraryBranch a1 ON a2.Bcbr_ID = a1.BranchID
	WHERE BranchName = 'Central'
	AND AuthorName = 'Stephen King'
;
