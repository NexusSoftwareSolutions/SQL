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
-- Description:	Updates a record in the Adjustments table by AdjustmentID
-- =============================================
ALTER PROCEDURE proc_UpdateAdjustment
	-- Add the parameters for the stored procedure here
	@AdjustmentID int,
	@Gutters bit,
	@Exterior bit,
	@Interior bit,
	@AdjustmentResultID int,
	@AdjustmentDate datetime,
	@AdjustmentComment varchar(255) = null,

	@SuccessFlag bit = 0 OUTPUT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT AdjustmentID FROM Adjustments
				WHERE AdjustmentID = @AdjustmentID)
			BEGIN
				UPDATE Adjustments
				SET Gutters = @Gutters,
					Exterior = @Exterior,
					Interior = @Interior,
					AdjustmentResultID = @AdjustmentResultID,
					AdjustmentDate = @AdjustmentDate,
					AdjustmentComment = @AdjustmentComment
				WHERE AdjustmentID = @AdjustmentID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Adjustments list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

