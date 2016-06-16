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
-- Description:	Updates a record in the Planes table by PlaneID
-- =============================================
ALTER PROCEDURE proc_UpdatePlane
	-- Add the parameters for the stored procedure here
	@PlaneID int,
	@PlaneTypeID int,
	@GroupNumber int,
	@NumOfLayers int = null,
	@ThreeAndOne int = null,
	@FourAndUp int = null,
	@Pitch int = null,
	@HipValley int = null,
	@RidgeLength int = null,
	@RakeLength int = null,
	@EaveHeight int = null,
	@EaveLength int = null,
	@NumberDecking int = null,
	@StepFlashing int = null,
	@SquareFootage float = null,
	@ItemSpec varchar(50) = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT PlaneID FROM Planes
				WHERE PlaneID = @PlaneID)
			BEGIN
				UPDATE Planes
				SET PlaneTypeID = @PlaneTypeID,
					GroupNumber = @GroupNumber,
					NumOfLayers = @NumOfLayers,
					ThreeAndOne = @ThreeAndOne,
					FourAndUp = @FourAndUp,
					Pitch = @Pitch,
					HipValley = @HipValley,
					RidgeLength = @RidgeLength,
					RakeLength = @RakeLength,
					EaveHeight = @EaveHeight,
					EaveLength = @EaveLength,
					NumberDecking = @NumberDecking,
					StepFlashing = @StepFlashing,
					SquareFootage = @SquareFootage,
					ItemSpec = @ItemSpec
				WHERE PlaneID = @PlaneID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Planes list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

