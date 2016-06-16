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
-- Create date: 4/11/2016
-- Description:	Add a Plane
-- =============================================
ALTER PROCEDURE proc_AddPlane
	-- Add the parameters for the stored procedure here
	@PlaneTypeID int,
	@InspectionID int,
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

	@new_identity int = null OUTPUT

AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	--IF @NumOfLayers = 0
	--	SET @NumOfLayers = null;
	--IF @ThreeAndOne = 0
	--	SET @ThreeAndOne = null;
	--IF @FourAndUp = 0
	--	SET @FourAndUp = null;
	--IF @Pitch = 0
	--	SET @Pitch = null;
	--IF @HipValley = 0
	--	SET @HipValley = null;
	--IF @RidgeLength = 0
	--	SET @RidgeLength = null;
	--IF @RakeLength = 0
	--	SET @RakeLength = null;
	--IF @EaveHeight = 0
	--	SET @EaveHeight = null;
	--IF @EaveLength = 0
	--	SET @EaveLength = null;
	--IF @NumberDecking = 0
	--	SET @NumberDecking = null;
	--IF @StepFlashing = 0
	--	SET @StepFlashing = null;
	--IF @SquareFootage = 0
	--	SET @SquareFootage = null;

	IF NOT EXISTS (SELECT PlaneID FROM Planes
					WHERE PlaneTypeID = @PlaneTypeID
					AND InspectionID = @InspectionID
					AND GroupNumber = @GroupNumber)
		BEGIN
			INSERT INTO Planes
						(PlaneTypeID,
						InspectionID,
						GroupNumber,
						NumOfLayers,
						ThreeAndOne,
						FourAndUp,
						Pitch,
						HipValley,
						RidgeLength,
						RakeLength,
						EaveHeight,
						EaveLength,
						NumberDecking,
						StepFlashing,
						SquareFootage,
						ItemSpec)
			VALUES (@PlaneTypeID,
					@InspectionID,
					@GroupNumber,
					@NumOfLayers,
					@ThreeAndOne,
					@FourAndUp,
					@Pitch,
					@HipValley,
					@RidgeLength,
					@RakeLength,
					@EaveHeight,
					@EaveLength,
					@NumberDecking,
					@StepFlashing,
					@SquareFootage,
					@ItemSpec);

			SET @new_identity = IDENT_CURRENT('Planes');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already a Plane in the system for the Inspection ID provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END 
GO
