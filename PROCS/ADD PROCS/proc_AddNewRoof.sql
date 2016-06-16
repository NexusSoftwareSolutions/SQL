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
-- Author:		Alyssa Harvey
-- Create date: 4/25/2016
-- Description:	Adds a NewRoof record.
-- =============================================
ALTER PROCEDURE proc_AddNewRoof
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@ProductID int,
	@UpgradeCost float,
	@Comments varchar(255) = null,

	@new_identity int = null OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (Select NewRoofID FROM NewRoofs 
					WHERE ClaimID = @ClaimID)
		BEGIN
			INSERT INTO NewRoofs 
				(ClaimID,
				ProductID,
				UpgradeCost,
				Comments)
			VALUES 
				(@ClaimID,
				@ProductID,
				@UpgradeCost,
				@Comments);
		
			SET @new_identity = IDENT_CURRENT('NewRoofs');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This New Roof already exists for the Claim ID provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
