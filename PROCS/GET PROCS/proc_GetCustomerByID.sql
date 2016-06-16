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
-- Create date: 4/11/2016
-- Description:	Get Customer by CustomerID
-- =============================================
ALTER PROCEDURE proc_GetCustomerByID
	-- Add the parameters for the stored procedure here
	@CustomerID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @CustomerID is null
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
			IF NOT EXISTS (SELECT CustomerID FROM Customers
							WHERE CustomerID = @CustomerID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Customer in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  CustomerID,
							FirstName,
							MiddleName,
							LastName,
							Suffix,
							PrimaryNumber,
							SecondaryNumber,
							Email,
							MailPromos 
						FROM Customers
					WHERE CustomerID = @CustomerID;
				END
		END
END
GO
