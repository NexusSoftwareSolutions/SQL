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
-- Create date: 5/31/2016
-- Description:	Returns a ClaimStatusDate by the TypeID and ClaimID
-- =============================================
ALTER PROCEDURE proc_GetClaimStatusDateByTypeIDAndClaimID
	-- Add the parameters for the stored procedure here
	@ClaimStatusTypeID int,
	@ClaimID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ClaimStatusTypeID is null OR @ClaimID is null
		BEGIN
			SET FMTONLY ON;
			SELECT ClaimStatusID, ClaimStatusDate FROM ClaimStatuses;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ClaimID FROM Claims 
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Claim in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE IF NOT EXISTS (SELECT ClaimStatusDate FROM ClaimStatuses
								WHERE ClaimStatusTypeID = @ClaimStatusTypeID
								AND ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no date in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT ClaimStatusID, ClaimStatusDate FROM ClaimStatuses
					WHERE ClaimStatusTypeID = @ClaimStatusTypeID
					AND ClaimID = @ClaimID;
				END
		END
END
GO

