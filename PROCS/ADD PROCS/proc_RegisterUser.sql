-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alyssa Harvey
-- Create date: 4/5/2016
-- Description:	Register a new User for current Employee
-- =============================================
ALTER PROCEDURE proc_RegisterUser
	-- Add the parameters for the stored procedure here
	@EmployeeID int,
	@Pass varchar(255),
	@PermissionID int,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	DECLARE @UserName varchar(50);

	-- throws exception if employee does not exist
	IF NOT EXISTS (SELECT EmployeeID FROM Employees 
					WHERE EmployeeID = @EmployeeID)
		BEGIN
			BEGIN TRY
				THROW 51000, 'The employee does not exist.', 16
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
	ELSE
		BEGIN
			SET @UserName = (SELECT Email FROM Employees
							WHERE EmployeeID = @EmployeeID);
		END

	-- throws exception if the username (email) already exists.
	IF EXISTS (SELECT UserID FROM Users WITH (UPDLOCK, HOLDLOCK)
				WHERE Username = @UserName) 
		BEGIN
			BEGIN TRY
				THROW 51000, 'The username (email) already exists.', 16
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
	ELSE 
		BEGIN
			INSERT INTO Users 
							(EmployeeID, 
							Username, 
							Pass, 
							PermissionID, 
							Active)
			VALUES (@EmployeeID, 
					@UserName, 
					@Pass, 
					@PermissionID, 
					1);

			SET @new_identity = IDENT_CURRENT('Users');
		END
END