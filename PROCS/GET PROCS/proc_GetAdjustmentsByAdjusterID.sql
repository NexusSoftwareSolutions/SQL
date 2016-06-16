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
-- Create date: 4/25/2016
-- Description:	Get Adjustments by AdjusterID
-- =============================================
ALTER PROCEDURE proc_GetAdjustmentsByAdjusterID
	-- Add the parameters for the stored procedure here
	@AdjusterID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @AdjusterID is null
		BEGIN
			SET FMTONLY ON;
			SELECT	AdjustmentID,
					AdjusterID,
					ClaimID,
					Gutters,
					Exterior,
					Interior,
					AdjustmentResultID,
					AdjustmentDate,
					AdjustmentComment 
				FROM Adjustments;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT AdjusterID FROM Adjustments
							WHERE AdjusterID = @AdjusterID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Adjustments in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	AdjustmentID,
							AdjusterID,
							ClaimID,
							Gutters,
							Exterior,
							Interior,
							AdjustmentResultID,
							AdjustmentDate,
							AdjustmentComment 
						FROM Adjustments
					WHERE AdjusterID = @AdjusterID;
				END
		END
END
GO
