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
-- Create date: 4/14/2016
-- Description:	Gets all Employees by their EmployeeTypeID
-- =============================================
ALTER PROCEDURE proc_GetEmployeesByTypeID
	-- Add the parameters for the stored procedure here
	@EmployeeTypeID int	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @EmployeeTypeID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  EmployeeID,
					EmployeeTypeID,
					FirstName,
					LastName,
					Suffix,
					Email,
					CellPhone,
					Active 
				FROM Employees;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT EmployeeID FROM Employees 
							WHERE EmployeeTypeID = @EmployeeTypeID)
				BEGIN
					BEGIN TRY
						THROW 51000, 'No employees match the parameters.', 16;
					END TRY
					BEGIN CATCH
						THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  EmployeeID,
							EmployeeTypeID,
							FirstName,
							LastName,
							Suffix,
							Email,
							CellPhone,
							Active 
						FROM Employees
					WHERE EmployeeTypeID = @EmployeeTypeID;
				END
		END
END

