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
-- Description:	Updates a record in the Customers table by CustomerID
-- =============================================
ALTER PROCEDURE proc_UpdateCustomer
	-- Add the parameters for the stored procedure here
	@CustomerID int,
	@FirstName varchar(50),
	@MiddleName varchar(50) = null,
	@LastName varchar(50),
	@Suffix varchar(10) = null,
	@PrimaryNumber varchar(12),
	@SecondaryNumber varchar(12) = null,
	@Email varchar(100) = null,
	@MailPromos bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT CustomerID FROM Customers
				WHERE CustomerID = @CustomerID)
			BEGIN
				UPDATE Customers
				SET FirstName = @FirstName,
					MiddleName = @MiddleName,
					LastName = @LastName,
					Suffix = @Suffix,
					PrimaryNumber = @PrimaryNumber,
					SecondaryNumber = @SecondaryNumber,
					Email = @Email,
					MailPromos = @MailPromos
				WHERE CustomerID = @CustomerID;
				
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Customers list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

