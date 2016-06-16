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
-- Create date: 4/7/2016
-- Description:	Adds new Referrer
-- =============================================
ALTER PROCEDURE proc_AddReferrer
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50),
    @LastName varchar(50),
    @Suffix varchar(10) = null,
    @MailingAddress varchar(100),
    @Zip varchar(10),
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
	IF NOT EXISTS (SELECT Email FROM Referrers 
					WHERE Email = @Email)
		BEGIN
			INSERT INTO Referrers 
					(FirstName,
				   LastName,
				   Suffix,
				   MailingAddress,
				   Zip,
				   Email,
				   CellPhone)
			VALUES 
				(@FirstName,
				@LastName,
				@Suffix,
				@MailingAddress,
				@Zip,
				@Email,
				@CellPhone);
		
			SET @new_identity = IDENT_CURRENT('Referrers');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already a Referrer in the system with the Email provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

