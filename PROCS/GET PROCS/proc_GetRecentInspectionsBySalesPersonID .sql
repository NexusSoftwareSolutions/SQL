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
-- Create date: 6/15/2016
-- Description:	Retrieve all Inspections from the past 60 days by SalesPersonID
-- =============================================
CREATE PROCEDURE proc_GetRecentInspectionsBySalesPersonID 
	-- Add the parameters for the stored procedure here
	@SalesPersonID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	IF(@SalesPersonID IS NULL)
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
			IF NOT EXISTS (SELECT SalesPersonID FROM Leads WHERE SalesPersonID = @SalesPersonID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Inspections in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	i.InspectionID,
							i.ClaimID,
							i.RidgeMaterialTypeID,
							i.ShingleTypeID,
							i.InspectionDate,
							i.SkyLights,
							i.Leaks,
							i.GutterDamage,
							i.DrivewayDamage,
							i.MagneticRollers,
							i.IceWaterShield,
							i.EmergencyRepair,
							i.EmergencyRepairAmount,
							i.QualityControl,
							i.ProtectLandscaping,
							i.RemoveTrash,
							i.FurnishPermit,
							i.CoverPool,
							i.InteriorDamage,
							i.ExteriorDamage,
							i.LightningProtection,
							i.TearOff,
							i.Satellite,
							i.SolarPanels,
							i.RoofAge,
							i.Comments 
					FROM Inspections i
					JOIN Claims c ON i.ClaimID = c.ClaimID
					JOIN Leads l ON c.LeadID = l.LeadID
					WHERE l.SalesPersonID = @SalesPersonID
					AND l.LeadDate > DATEADD(DAY, -60, GETDATE())
				END
		END
END
GO
