USE LibraryManagementSystem
GO

CREATE PROC dbo.create_LibraryManagementSystem
AS

	/******************************************************
	 * If any tables already exist, drop them
	 * Code from stackoverflow
	 * For some reason, this doesn't completely work,
	 * but it's still better than doing it all by hand
	 ******************************************************/
	/* Drop all Foreign Key constraints */
	DECLARE @name VARCHAR(128)
	DECLARE @constraint VARCHAR(254)
	DECLARE @SQL VARCHAR(254)

	SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' ORDER BY TABLE_NAME)

	WHILE @name is not null
	BEGIN
		SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
		WHILE @constraint IS NOT NULL
		BEGIN
			SELECT @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint) +']'
			EXEC (@SQL)
			PRINT 'Dropped FK Constraint: ' + @constraint + ' on ' + @name
			SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' AND CONSTRAINT_NAME <> @constraint AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
		END
	SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' ORDER BY TABLE_NAME)
	END
	GO

	/* Drop all Primary Key constraints */
	DECLARE @name VARCHAR(128)
	DECLARE @constraint VARCHAR(254)
	DECLARE @SQL VARCHAR(254)

	SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' ORDER BY TABLE_NAME)

	WHILE @name IS NOT NULL
	BEGIN
		SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
		WHILE @constraint is not null
		BEGIN
			SELECT @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint)+']'
			EXEC (@SQL)
			PRINT 'Dropped PK Constraint: ' + @constraint + ' on ' + @name
			SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' AND CONSTRAINT_NAME <> @constraint AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
		END
	SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' ORDER BY TABLE_NAME)
	END
	GO

	/* Drop all tables */
	DECLARE @name VARCHAR(128)
	DECLARE @SQL VARCHAR(254)

	SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 ORDER BY [name])

	WHILE @name IS NOT NULL
	BEGIN
		SELECT @SQL = 'DROP TABLE [dbo].[' + RTRIM(@name) +']'
		EXEC (@SQL)
		PRINT 'Dropped Table: ' + @name
		SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 AND [name] > @name ORDER BY [name])
	END
	GO

	/*Kludge to remove other tables*/
	DROP TABLE Borrower;
	DROP TABLE Book;
	DROP TABLE Publisher;
	GO

	/******************************************************
	 * Build database tables and define ther schema
	 ******************************************************/
	CREATE TABLE Borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY(100000,1),
		Name VARCHAR(100) NOT NULL,
		"Address" VARCHAR(100) NOT NULL,
		Phone VARCHAR(22) NOT NULL
	);

	CREATE TABLE Publisher (
		Name VARCHAR(50) PRIMARY KEY NOT NULL,
		"Address" VARCHAR(100) NOT NULL,
		Phone VARCHAR(22) NOT NULL
	);

		CREATE TABLE Book (
		BookId INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		Title VARCHAR(100),
		PublisherName VARCHAR(50) CONSTRAINT fk_book_PublisherName FOREIGN KEY REFERENCES Publisher(Name) ON UPDATE CASCADE ON DELETE CASCADE
	);

		CREATE TABLE Library_Branch (
		BranchId INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		BranchName VARCHAR(50) NOT NULL,
		"Address" VARCHAR(70) NOT NULL
	); 

	CREATE TABLE Book_Copies (
		BookId INT NOT NULL CONSTRAINT fk_Book_Copies_BookId FOREIGN KEY REFERENCES Book(BookId) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchId INT NOT NULL CONSTRAINT fk_Book_Copies_BranchId FOREIGN KEY REFERENCES Library_Branch(BranchId) ON UPDATE CASCADE ON DELETE CASCADE,
		No_Of_Copies INT NOT NULL,
	);

	CREATE TABLE Book_Authors (
		BookId INT NOT NULL CONSTRAINT fk_Book_Authors_BookId FOREIGN KEY REFERENCES Book(BookId) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(100) NOT NULL
	);

	CREATE TABLE Book_Loans (
		BookId INT NOT NULL CONSTRAINT fk_Book_Loans_BookId FOREIGN KEY REFERENCES Book(BookId) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchId INT NOT NULL CONSTRAINT fk_Book_Loans_BranchId FOREIGN KEY REFERENCES Library_Branch(BranchId) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL CONSTRAINT fk_Book_Loans_CardNo FOREIGN KEY REFERENCES Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut DATE NOT NULL,
		DueDate DATE NOT NULL
	);

GO