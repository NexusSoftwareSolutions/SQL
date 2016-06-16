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
-- Create date: 6/2/2016
-- Description:	Adds a new ClaimContact entry using the ClaimID to 
--		retrieve the CustomerID, KnockerID (if exists), and SalesPersonID
-- =============================================
ALTER PROCEDURE proc_AutoAddClaimContacts
	-- Add the parameters for the stored procedure here
	@ClaimID int,
		
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	-- Insert statements for procedure here
	IF NOT EXISTS (SELECT ClaimContactID FROM ClaimContacts 
					WHERE ClaimID = @ClaimID)
		BEGIN
			
			-- retrieves CustomerID from the Claims table
			DECLARE @CustomerID int = (SELECT CustomerID FROM Claims WHERE ClaimID = @ClaimID);
			
			-- retrieves the KnockerID, if it exists, from the KnockerResponses table
			DECLARE @KnockerID int;

			IF EXISTS (SELECT k.KnockerID 
						FROM KnockerResponses k
						JOIN Leads l ON k.KnockerResponseID = l.KnockerResponseID
						JOIN Claims c ON c.LeadID = l.LeadID
						WHERE c.ClaimID = @ClaimID)
				BEGIN
					SET @KnockerID = (SELECT k.KnockerID 
										FROM KnockerResponses k
										JOIN Leads l ON k.KnockerResponseID = l.KnockerResponseID
										JOIN Claims c ON c.LeadID = l.LeadID
										WHERE c.ClaimID = @ClaimID);
				END
			ELSE
				BEGIN
					SET @KnockerID = NULL;
				END

			-- retrieves the SalesPersonID from the Leads table
			DECLARE @SalesPersonID int = (SELECT l.SalesPersonID 
											FROM Leads l
											JOIN Claims c ON c.LeadID = l.LeadID
											WHERE c.ClaimID = @ClaimID);

				INSERT INTO ClaimContacts
							(ClaimID,
							CustomerID,
							KnockerID,
							SalesPersonID,
							SupervisorID,
							SalesManagerID,
							AdjusterID)
				VALUES
					(@ClaimID,
					@CustomerID,
					@KnockerID,
					@SalesPersonID,
					NULL,
					23,
					NULL);

			SET @new_identity = IDENT_CURRENT('ClaimContacts');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already an entry in the system for this Claim.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END		
END
GO
