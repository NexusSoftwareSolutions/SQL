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
-- Description:	Gets most recent date by ClaimID from ClaimStatuses
-- =============================================
ALTER PROCEDURE proc_GetMostRecentDateByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	
	@MostRecentDate datetime = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ClaimID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  ClaimStatusID,
					ClaimID,
					ClaimStatusTypeID,
					ClaimStatusDate 
				FROM ClaimStatuses;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ClaimStatusID FROM ClaimStatuses
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Claim Status in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN

					SET @MostRecentDate = (SELECT MAX(ClaimStatusDate) FROM ClaimStatuses
												WHERE ClaimID = @ClaimID);
				END
		END
END
GO

