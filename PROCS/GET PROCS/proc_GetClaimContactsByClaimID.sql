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
-- Create date: 4/20/2016
-- Description:	Gets ClaimContacts by ClaimID
-- =============================================
ALTER PROCEDURE proc_GetClaimContactsByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int
	
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
			SELECT  ClaimContactID,
					ClaimID,
					CustomerID,
					KnockerID,
					SalesPersonID,
					SupervisorID,
					SalesManagerID,
					AdjusterID 
				FROM ClaimContacts;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ClaimContactID FROM ClaimContacts
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Claim Contacts in the system for the ID provided.', 16;
						END TRY
						BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  ClaimContactID,
							ClaimID,
							CustomerID,
							KnockerID,
							SalesPersonID,
							SupervisorID,
							SalesManagerID,
							AdjusterID 
						FROM ClaimContacts
					WHERE ClaimID = @ClaimID;
				END
		END
END
GO

