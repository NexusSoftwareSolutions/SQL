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
-- Description:	Adds an Adjustment
-- =============================================
ALTER PROCEDURE proc_AddAdjustment
	-- Add the parameters for the stored procedure here
	@AdjusterID int,
	@ClaimID int,
	@Gutters bit,
	@Exterior bit,
	@Interior bit,
	@AdjustmentResultID int,
	@AdjustmentDate datetime,
	@AdjustmentComment varchar(255) = null,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT AdjustmentID FROM Adjustments
					WHERE AdjusterID = @AdjusterID
					AND ClaimID = @ClaimID
					AND AdjustmentDate = @AdjustmentDate)
		BEGIN
			INSERT INTO Adjustments
						(AdjusterID,
						ClaimID,
						Gutters,
						Exterior,
						Interior,
						AdjustmentResultID,
						AdjustmentDate,
						AdjustmentComment)
			VALUES (@AdjusterID,
					@ClaimID,
					@Gutters,
					@Exterior,
					@Interior,
					@AdjustmentResultID,
					@AdjustmentDate,
					@AdjustmentComment);
	
			SET @new_identity = IDENT_CURRENT('Adjustments');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This adjustment is already in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

