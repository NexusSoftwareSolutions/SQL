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
-- Description:	Get Inspection by InspectionID
-- =============================================
ALTER PROCEDURE proc_GetInspectionByID
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
			SELECT	InspectionID,
					ClaimID,
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
					Comments 
				FROM Inspections;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT InspectionID FROM Inspections
							WHERE InspectionID = @InspectionID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Inspection in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	InspectionID,
							ClaimID,
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
							Comments 
						FROM Inspections
					WHERE InspectionID = @InspectionID;
				END
		END
END
GO
