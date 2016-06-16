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
-- Author:		Maggie Seigler
-- Create date: 4/28/2016
-- Description:	Updates a record in the Employees table by EmployeeID
-- =============================================
ALTER PROCEDURE proc_UpdateEmployee
	-- Add the parameters for the stored procedure here
	@EmployeeID int,
	@EmployeeTypeID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@Suffix varchar(10) = null,
	@Email varchar(50),
	@CellPhone varchar(12),
	@Active bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT EmployeeID FROM Employees
				WHERE EmployeeID = @EmployeeID)
			BEGIN
				UPDATE Employees
				SET EmployeeTypeID = @EmployeeTypeID,
					FirstName = @FirstName,
					LastName = @LastName,
					Suffix = @Suffix,
					Email = @Email,
					CellPhone = @CellPhone,
					Active = @Active				
				WHERE EmployeeID = @EmployeeID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Employees list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

