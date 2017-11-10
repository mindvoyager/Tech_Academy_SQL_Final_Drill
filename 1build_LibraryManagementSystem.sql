USE master
GO

CREATE PROC dbo.build_LibraryManagementSystem
AS

	/******************************************************
	 * The following prevents any errors from occuring
	 * if the database or tables already exist.
	 * This code will close all active connections to the 
	 * database and then drop it
	 ******************************************************/

	WHILE EXISTS(SELECT * FROM sys.databases WHERE name='LibraryManagementSystem')
	BEGIN
		DECLARE @SQL VARCHAR(MAX)
		SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + CONVERT(VARCHAR, SPId) + ';'
		FROM MASTER.sys.sysprocesses
		WHERE DBID = DB_ID('LibraryManagementSystem') AND SPId <> @@SPId
		EXEC(@SQL)
		DROP DATABASE [LibraryManagementSystem]
	END

	/******************************************************
	 * Build the database.
	 ******************************************************/
	CREATE DATABASE LibraryManagementSystem
GO