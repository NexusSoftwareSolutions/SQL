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
-- Create date: 4/6/2016
-- Description:	Adds new Customer
-- =============================================
ALTER PROCEDURE proc_AddCustomer 
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50),
	@MiddleName varchar(50) = null,
	@LastName varchar(50),
	@Suffix varchar(10) = null,
	@PrimaryNumber varchar(12),
	@SecondaryNumber varchar(12) = null,
	@Email varchar(100) = null,
	@MailPromos bit,
		
	@new_identity int = null OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	
	IF NOT EXISTS (Select Email FROM Customers 
					WHERE Email = @Email)
		BEGIN
			INSERT INTO Customers 
				(FirstName, 
				MiddleName, 
				LastName, 
				Suffix, 
				PrimaryNumber, 
				SecondaryNumber, 
				Email, 
				MailPromos)
			VALUES 
				(@FirstName, 
				@MiddleName, 
				@LastName, 
				@Suffix, 
				@PrimaryNumber, 
				@SecondaryNumber, 
				@Email, 
				@MailPromos);
		
			SET @new_identity = IDENT_CURRENT('Customers');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already a Customer in the system with the Email provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
