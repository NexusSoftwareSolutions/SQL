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
-- Create date: 4/1/2016
-- Description:	Adds a new Employee
-- =============================================
ALTER PROCEDURE proc_AddEmployee
	-- Add the parameters for the stored procedure here
	@EmployeeTypeID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@Suffix varchar(10) = null,
	@Email varchar(50),
	@CellPhone varchar(12),

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;
   
	-- Insert statements for procedure here
	IF NOT EXISTS (SELECT EmployeeID FROM Employees WITH (UPDLOCK, HOLDLOCK)
					WHERE Email = @Email)
		BEGIN
			INSERT INTO Employees 
						(EmployeeTypeID, 
						FirstName, 
						LastName, 
						Suffix, 
						Email, 
						CellPhone, 
						Active)
			VALUES 
				(@EmployeeTypeID, 
				@FirstName, 
				@LastName, 
				@Suffix, 
				@Email, 
				@CellPhone, 
				1);

			SET @new_identity = ident_current('Employees');
		END
	ELSE
		BEGIN
			BEGIN TRY
				DECLARE @message varchar(255) = 
						'There is already an employee in the system with the email address: ' + @Email;

				THROW 51000, @message, 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
