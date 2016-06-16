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
-- Create date: 4/12/2016
-- Description:	Adds a new ClaimContact
-- =============================================
ALTER PROCEDURE proc_AddClaimContact
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@CustomerID int,
	@KnockerID int = null,
	@SalesPersonID int,
	@SupervisorID int = null,
	@SalesManagerID int,
	@AdjusterID int = null,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	-- Insert statements for procedure here
	--IF @KnockerID = 0
	--	SET @KnockerID = null;
	--IF @SupervisorID = 0
	--	SET @SupervisorID = null;
	--IF @AdjusterID = 0
	--	SET @AdjusterID = null;
	
	IF NOT EXISTS (SELECT ClaimContactID FROM ClaimContacts 
					WHERE ClaimID = @ClaimID)
		BEGIN
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
					@SupervisorID,
					@SalesManagerID,
					@AdjusterID);

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


