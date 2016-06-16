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
-- Description:	Updates a record in the Inspections table by InspectionID
-- =============================================
ALTER PROCEDURE proc_UpdateInspection
	-- Add the parameters for the stored procedure here
	@InspectionID int,
	@RidgeMaterialTypeID int,
	@ShingleTypeID int,
	@InspectionDate datetime,
	@SkyLights bit,
	@Leaks bit,
	@GutterDamage bit,
	@DrivewayDamage bit,
	@MagneticRollers bit,
	@IceWaterShield bit,
	@EmergencyRepair bit,
	@EmergencyRepairAmount float = null,
	@QualityControl bit,
	@ProtectLandscaping bit,
	@RemoveTrash bit,
	@FurnishPermit bit,
	@CoverPool bit,
	@InteriorDamage bit,
	@ExteriorDamage bit,
	@LightningProtection bit,
	@TearOff bit,
	@Satellite bit,
	@SolarPanels bit,
	@RoofAge int,
	@Comments varchar(255) = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT InspectionID FROM Inspections
				WHERE InspectionID = @InspectionID)
			BEGIN
				UPDATE Inspections
				SET RidgeMaterialTypeID = @RidgeMaterialTypeID,
					ShingleTypeID = @ShingleTypeID,
					InspectionDate = @InspectionDate,
					SkyLights = @SkyLights,
					Leaks = @Leaks,
					GutterDamage = @GutterDamage,
					DrivewayDamage = @DrivewayDamage,
					MagneticRollers = @MagneticRollers,
					IceWaterShield = @IceWaterShield,
					EmergencyRepair = @EmergencyRepair,
					EmergencyRepairAmount = @EmergencyRepairAmount,
					QualityControl = @QualityControl,
					ProtectLandscaping = @ProtectLandscaping,
					RemoveTrash = @RemoveTrash,
					FurnishPermit = @FurnishPermit,
					CoverPool = @CoverPool,
					InteriorDamage = @InteriorDamage,
					ExteriorDamage = @ExteriorDamage,
					LightningProtection = @LightningProtection,
					TearOff = @TearOff,
					Satellite = @Satellite,
					SolarPanels = @SolarPanels,
					RoofAge = @RoofAge,
					Comments = @Comments
				WHERE InspectionID = @InspectionID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Inspections list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

