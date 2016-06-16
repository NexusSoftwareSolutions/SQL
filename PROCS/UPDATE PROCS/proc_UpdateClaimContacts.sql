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
-- Create date: 4/27/2016
-- Description:	Updates a record in the ClaimContacts table by ClaimContactID
-- =============================================
ALTER PROCEDURE proc_UpdateClaimContacts
	-- Add the parameters for the stored procedure here
	@ClaimContactID int,
	@CustomerID int,
	@KnockerID int = null,
	@SalesPersonID int,
	@SupervisorID int = null,
	@SalesManagerID int,
	@AdjusterID int = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ClaimContactID FROM ClaimContacts
				WHERE ClaimContactID = @ClaimContactID)
			BEGIN
				UPDATE ClaimContacts
				SET CustomerID = @CustomerID,
					KnockerID = @KnockerID,
					SalesPersonID = @SalesPersonID,
					SupervisorID = @SupervisorID,
					SalesManagerID = @SalesManagerID,
					AdjusterID = @AdjusterID
				WHERE ClaimContactID = @ClaimContactID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in Claim Contacts for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

