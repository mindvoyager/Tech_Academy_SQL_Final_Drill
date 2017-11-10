USE LibraryManagementSystem
GO

CREATE PROC dbo.insert_LibraryManagementSystem
AS
	INSERT INTO Publisher
		(Name,"Address",Phone)
		VALUES
		('Fake Publisher','123 Qwerty Lane Bumblefuck, KS 10000 USA','888-888-8888'),
		('Tor Books','175 Fifth Avenue 14th floor New York, NY 10010 USA','212-388-0100'),
		('Del Rey','1745 Broadway New York, NY 10019 USA','212-782-9000'),
		('Orbit','Little Brown Book Group, 100 Victoria Embankment, London, EC4Y 0DY, United Kingdom','+44 (0)20 3122 7000')
	;

	INSERT INTO Book
		(Title,PublisherName)
		VALUES
		('The Gunslinger','Fake Publisher'),
		('Gravity Wells: Speculative Fiction Stories','Fake Publisher'),
		('Lord of Light','Fake Publisher'),
		('The City and the Stars','Fake Publisher'),
		('Newton''s Wake: A Space Opera','Tor Books'),
		('Blueprints of the Afterlife','Fake Publisher'),
		('Sunshine','Fake Publisher'),
		('The Gone-Away World','Fake Publisher'),
		('Pandora''s Star','Del Rey'),
		('The Girl with All the Gifts','Orbit'),
		('Judas Unchained','Del Rey'),
		('Use of Weapons (Culture, #3)','Orbit'),
		('14','Fake Publisher'),
		('The Final Empire (Mistborn, #1)','Tor Books'),
		('True Names','Fake Publisher'),
		('The Last Unicorn (The Last Unicorn, #1)','Fake Publisher'),
		('The Diamond Age: or, A Young Lady''s Illustrated Primer','Fake Publisher'),
		('Jonathan Strange & Mr Norrell','Fake Publisher'),
		('Sister Alice','Tor Books'),
		('Neverwhere','Fake Publisher'),
		('The Lost Tribe','Fake Publisher')
	;

	INSERT INTO Book_Authors
		(BookId,AuthorName)
		VALUES
		(1,'Stephen King'),
		(2,'James Alan Gardner'),
		(3,'Roger Zelazny'),
		(4,'Arthur C. Clarke'),
		(5,'Ken MacLeod'),
		(6,'Ryan Boudinot'),
		(7,'Robin McKinley'),
		(8,'Nick Harkaway'),
		(9,'Peter F. Hamilton'),
		(10,'M.R. Carey'),
		(11,'Peter F. Hamilton'),
		(12,'Iain M. Banks'),
		(13,'Peter Clines'),
		(14,'Brandon Sanderson'),
		(15,'Vernor Vinge'),
		(16,'Peter S. Beagle'),
		(17,'Neal Stephenson'),
		(18,'Susanna Clarke'),
		(19,'Robert Reed'),
		(20,'Neil Gaiman'),
		(21,'Matthew Caldwell')
	;

	INSERT INTO Library_Branch
		(BranchName,"Address")
		VALUES
		('Central','1 Fictional Drive Bumblefuck, KS 1000 USA'),
		('Sharpstown','2 Fictional Drive Sharpstown, KS 1001 USA'),
		('West','3 Fictional Drive West Sharpstown, KS 1001 USA'),
		('East','4 Fictional Drive East Sharpstown, KS 1001 USA')
	;

	INSERT INTO Borrower
		(Name,"Address",Phone)
		VALUES
		('Bud Gooden','Bumblefuck, KS','888-888-7771'),
		('Stacee O''Hanigan','West Sharpstown, KS','888-888-7772'),
		('Pravin Carlsson','East Sharpstown, KS','888-888-7773'),
		('Tea Eilerts','Sharpstown, KS','888-888-7774'),
		('Svyatoslav Acciaioli','Bumblefuck, KS','888-888-7775'),
		('Khazhak Ognianov','Bumblefuck, KS','888-888-7776'),
		('Feliciana Pesaresi','West Sharpstown, KS','888-888-7777'),
		('Zane Tordai','West Sharpstown, KS','888-888-7778'),
		('Hardeep Behrend','East Sharpstown, KS','888-888-7779')
	;

	INSERT INTO Book_Copies
		(BookId,BranchId,No_Of_Copies)
		VALUES
		(1,1,3),
		(2,1,3),
		(3,1,3),
		(4,1,3),
		(5,1,3),
		(6,1,3),
		(7,1,3),
		(8,1,3),
		(9,1,2),
		(10,1,2),
		(3,3,2),
		(4,3,2),
		(5,3,2),
		(6,3,2),
		(7,3,2),
		(8,3,3),
		(9,3,3),
		(10,3,3),
		(11,3,3),
		(12,3,3),
		(5,4,3),
		(6,4,3),
		(7,4,3),
		(8,4,3),
		(9,4,2),
		(10,4,2),
		(11,4,2),
		(12,4,2),
		(13,4,2),
		(14,4,2),
		(12,2,2),
		(13,2,2),
		(14,2,3),
		(15,2,3),
		(16,2,3),
		(17,2,3),
		(18,2,3),
		(19,2,3),
		(20,2,3),
		(21,2,3)
	;
	
	INSERT INTO Book_Loans
		(BookId,BranchId,CardNo,DateOut,DueDate)
		VALUES
		(1,1,100000,'2017-11-1','2017-12-1'),
		(2,1,100000,'2017-11-1','2017-12-1'),
		(3,1,100000,'2017-11-1','2017-12-1'),
		(4,1,100000,'2017-11-1','2017-12-1'),
		(5,1,100000,'2017-11-1','2017-12-1'),
		(6,1,100000,'2017-11-1','2017-12-1'),
		(7,1,100000,'2017-11-1','2017-12-1'),
		(8,1,100000,'2017-11-1','2017-12-1'),
		(9,1,100000,'2017-11-1','2017-12-1'),
		(10,1,100000,'2017-11-1','2017-12-1'),
		(3,3,100001,'2017-11-2','2017-12-2'),
		(4,3,100001,'2017-11-2','2017-12-2'),
		(5,3,100001,'2017-11-2','2017-12-2'),
		(6,3,100001,'2017-11-2','2017-12-2'),
		(7,3,100001,'2017-11-2','2017-12-2'),
		(8,3,100001,'2017-11-2','2017-12-2'),
		(9,3,100001,'2017-11-2','2017-12-2'),
		(10,3,100001,'2017-11-2','2017-12-2'),
		(11,3,100001,'2017-11-2','2017-12-2'),
		(12,3,100001,'2017-11-2','2017-12-2'),
		(5,4,100002,'2017-11-3','2017-12-3'),
		(6,4,100002,'2017-11-3','2017-12-3'),
		(7,4,100002,'2017-11-3','2017-12-3'),
		(8,4,100002,'2017-11-3','2017-12-3'),
		(9,4,100002,'2017-11-3','2017-12-3'),
		(10,4,100002,'2017-11-3','2017-12-3'),
		(11,4,100002,'2017-11-3','2017-12-3'),
		(12,4,100002,'2017-11-3','2017-12-3'),
		(13,4,100002,'2017-11-3','2017-12-3'),
		(14,4,100002,'2017-11-3','2017-12-3'),
		(12,2,100003,'2017-10-10','2017-11-10'),
		(13,2,100003,'2017-10-10','2017-11-10'),
		(14,2,100003,'2017-10-10','2017-11-10'),
		(15,2,100003,'2017-10-10','2017-11-10'),
		(16,2,100003,'2017-10-10','2017-11-10'),
		(17,2,100003,'2017-10-10','2017-11-10'),
		(18,2,100003,'2017-10-10','2017-11-10'),
		(19,2,100003,'2017-10-10','2017-11-10'),
		(20,2,100003,'2017-10-10','2017-11-10'),
		(21,2,100003,'2017-10-10','2017-11-10'),
		(1,1,100004,'2017-11-4','2017-12-4'),
		(2,1,100004,'2017-11-4','2017-12-4'),
		(3,1,100004,'2017-11-4','2017-12-4'),
		(4,1,100004,'2017-11-4','2017-12-4'),
		(5,1,100004,'2017-11-4','2017-12-4'),
		(6,1,100005,'2017-11-5','2017-12-5'),
		(7,1,100005,'2017-11-5','2017-12-5'),
		(8,1,100005,'2017-11-5','2017-12-5'),
		(9,1,100005,'2017-11-5','2017-12-5'),
		(10,1,100005,'2017-11-5','2017-12-5'),
		(3,3,100006,'2017-11-6','2017-12-6'),
		(4,3,100006,'2017-11-6','2017-12-6'),
		(5,3,100006,'2017-11-6','2017-12-6'),
		(6,3,100006,'2017-11-6','2017-12-6'),
		(7,3,100006,'2017-11-6','2017-12-6'),
		(8,3,100007,'2017-11-7','2017-12-7'),
		(9,3,100007,'2017-11-7','2017-12-7'),
		(10,3,100007,'2017-11-7','2017-12-7'),
		(11,3,100007,'2017-11-7','2017-12-7'),
		(12,3,100007,'2017-11-7','2017-12-7')
	;

GO