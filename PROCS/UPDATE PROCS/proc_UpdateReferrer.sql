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
-- Description:	Updates a record in the Referrers table by ReferrerID
-- =============================================
ALTER PROCEDURE proc_UpdateReferrer
	-- Add the parameters for the stored procedure here
	@ReferrerID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@Suffix varchar(10) = null,
	@MailingAddress varchar(100),
	@Zip varchar(10),
	@Email varchar(50) = null,
	@CellPhone varchar(12) = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ReferrerID FROM Referrers
				WHERE ReferrerID = @ReferrerID)
			BEGIN
				UPDATE Referrers
				SET FirstName = @FirstName,
					LastName = @LastName,
					Suffix = @Suffix,
					MailingAddress = @MailingAddress,
					Zip = @Zip,
					Email = @Email,
					CellPhone = @CellPhone
				WHERE ReferrerID = @ReferrerID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Referrers list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

