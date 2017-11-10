USE LibraryManagementSystem
GO

CREATE PROC dbo.query_LibraryManagementSystem
AS

/*1. How many copies of the book titled "The Lost Tribe"
are owned by the library branch whose name is "Sharpstown"?*/
	SELECT a.Title, c.BranchName, b.No_Of_Copies
		FROM Book a
		INNER JOIN Book_Copies b ON a.BookId = b.BookId 
		INNER JOIN Library_Branch c ON b.BranchId = c.BranchId
		WHERE a.Title = 'The Lost Tribe' AND c.BranchName = 'Sharpstown'
	;

/*2. How many copies of the book titled "The Lost Tribe"
are owned by each library branch?*/
	SELECT a.Title, c.BranchName, b.No_Of_Copies
		FROM Book a
		INNER JOIN Book_Copies b ON a.BookId = b.BookId 
		INNER JOIN Library_Branch c ON b.BranchId = c.BranchId
		WHERE a.Title = 'The Lost Tribe'
	;

/*3. Retrieve the names of all borrowers who do not have any books checked out.*/
	SELECT Borrower.Name
		FROM Borrower
		LEFT JOIN Book_Loans ON Borrower.CardNo = Book_Loans.CardNo
		WHERE Book_Loans.BookId IS NULL
	;

/*4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
retrieve the book title, the borrower's name, and the borrower's address.*/
/*CONVERT(DATE,GETDATE())*/
	SELECT a.Title, c.Name, c."Address"
		FROM Book a
		INNER JOIN Book_Loans b ON a.BookId = b.BookId
		INNER JOIN Borrower c ON b.CardNo = c.CardNo
		INNER JOIN Library_Branch d ON b.BranchId = d.BranchId
		WHERE d.BranchName = 'Sharpstown' AND b.DueDate = '2017-11-10'	/*Since I don't know when this will be
																		  checked, I entered the date manually,
																		  but to retrieve today's date:
																		  CONVERT(DATE,GETDATE()) */
	;

/*5. For each library branch,
retrieve the branch name and the total number of books loaned out from that branch.*/
	SELECT  b.BranchName, COUNT(a.BookId) AS BooksLoaned
		FROM Book_Loans a
		INNER JOIN Library_Branch b ON a.BranchId = b.BranchId
		GROUP BY b.BranchName, a.BranchId
	;

	/*Instructor Solution*/
	/*SELECT DISTINCT b.BranchName, COUNT(a.BranchId) AS QtyPerBranch
		FROM Library_Branch b
		INNER JOIN Book_Loan a
		ON b.BranchID = a.BranchID
		GROUP BY b.BranchName, a.BranchId
	;*/

/*6. Retrieve the names, addresses, and number of books checked out
for all borrowers who have more than five books checked out.*/
	SELECT L.CardNo, COUNT(L.BookId) AS NumberCheckedOut
		FROM Book_Loans L
		GROUP BY L.CardNo
		HAVING COUNT(L.BookId) > 5
	;

/*7. For each book authored (or co-authored) by "Stephen King",
retrieve the title and the number of copies owned by the library branch whose name is "Central".*/
	SELECT B.Title, C.No_Of_Copies
		FROM Book B
		INNER JOIN Book_Authors A ON B.BookId = A.BookId
		INNER JOIN Book_Copies C ON B.BookId = C.BookId
		INNER JOIN Library_Branch L ON C.BranchId = L.BranchId
		WHERE A.AuthorName = 'Stephen King' AND L.BranchName = 'Central'
	;

GO