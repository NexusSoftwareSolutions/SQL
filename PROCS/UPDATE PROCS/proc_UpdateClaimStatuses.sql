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
-- Description:	Updates a record in the ClaimStatuses table by ClaimStatusID
-- =============================================
ALTER PROCEDURE proc_UpdateClaimStatuses
	-- Add the parameters for the stored procedure here
	@ClaimStatusID int,
	@ClaimStatusTypeID int,
	@ClaimStatusDate datetime,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ClaimStatusID FROM ClaimStatuses
				WHERE ClaimStatusID = @ClaimStatusID)
			BEGIN
				UPDATE ClaimStatuses
				SET ClaimStatusTypeID = @ClaimStatusTypeID,
					ClaimStatusDate = @ClaimStatusDate
				WHERE ClaimStatusID = @ClaimStatusID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Claim Statuses list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
