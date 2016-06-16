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
-- Create date: 4/26/2016
-- Description:	Get all Planes associated with an InspectionID
-- =============================================
ALTER PROCEDURE proc_GetPlanesByInspectionID
	-- Add the parameters for the stored procedure here
	@InspectionID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @InspectionID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  PlaneID,
					PlaneTypeID,
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
					ItemSpec
				FROM Planes;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT PlaneID FROM Planes
							WHERE InspectionID = @InspectionID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Planes in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  PlaneID,
							PlaneTypeID,
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
							ItemSpec
						FROM Planes
					WHERE InspectionID = @InspectionID;
				END
		END
END
GO
