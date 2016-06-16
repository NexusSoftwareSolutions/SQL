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
-- Create date: 6/1/2016
-- Description:	Gets Customers by SalesPersonID
-- =============================================
ALTER PROCEDURE proc_GetCustomersBySalesPersonID
	-- Add the parameters for the stored procedure here
	@SalesPersonID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @SalesPersonID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  CustomerID,
					FirstName,
					MiddleName,
					LastName,
					Suffix,
					PrimaryNumber,
					SecondaryNumber,
					Email,
					MailPromos
			FROM Customers;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT EmployeeID FROM Employees
							WHERE EmployeeID = @SalesPersonID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no SalesPerson in the system with the id provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT c.CustomerID,
									c.FirstName,
									c.MiddleName,
									c.LastName,
									c.Suffix,
									c.PrimaryNumber,
									c.SecondaryNumber,
									c.Email,
									c.MailPromos
					FROM Customers c
					JOIN Leads l ON c.customerID = l.CustomerID
					WHERE l.SalesPersonID = @SalesPersonID;
				END
		END
END
GO

