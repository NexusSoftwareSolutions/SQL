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
-- Create date: 4/6/2016
-- Description:	Adds new Inspection
-- =============================================
ALTER PROCEDURE proc_AddInspection
	-- Add the parameters for the stored procedure here
	@ClaimID int,
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

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	--IF @ClaimID = 0
	--	SET @ClaimID = null;
	--IF @EmergencyRepairAmount = 0
	--	SET @EmergencyRepairAmount = null;

	IF NOT EXISTS (SELECT InspectionID FROM Inspections
					WHERE ClaimID = @ClaimID)
		BEGIN
			INSERT INTO Inspections 
						(ClaimID,
						RidgeMaterialTypeID,
						ShingleTypeID,
						InspectionDate,
						SkyLights, 
						Leaks, 
						GutterDamage, 
						DrivewayDamage, 
						MagneticRollers, 
						IceWaterShield, 
						EmergencyRepair, 
						EmergencyRepairAmount,
						QualityControl, 
						ProtectLandscaping, 
						RemoveTrash, 
						FurnishPermit, 
						CoverPool, 
						InteriorDamage, 
						ExteriorDamage, 
						LightningProtection,
						TearOff,
						Satellite,
						SolarPanels,
						RoofAge,
						Comments)
			VALUES 
				(@ClaimID,
				@RidgeMaterialTypeID,
				@ShingleTypeID,
				@InspectionDate,
				@SkyLights,
				@Leaks,
				@GutterDamage,
				@DrivewayDamage,
				@MagneticRollers,
				@IceWaterShield,
				@EmergencyRepair,
				@EmergencyRepairAmount,
				@QualityControl,
				@ProtectLandscaping,
				@RemoveTrash,
				@FurnishPermit,
				@CoverPool,
				@InteriorDamage,
				@ExteriorDamage,
				@LightningProtection,
				@TearOff,
				@Satellite,
				@SolarPanels,
				@RoofAge,
				@Comments)

			SET @new_identity = IDENT_CURRENT('Inspections');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already an inspection in the system for this customer and claim.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO



			