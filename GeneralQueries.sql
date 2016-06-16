select * from AdditionalSupplies
select * from addresses
select * from Adjusters
select * from Adjustments
select * from CalendarData
select * from Claims
select * from claimcontacts
select * from ClaimDocumentPaths
select * from Customers
select * from employees
select * from lu_employeetypes
select * from inspections
select * from installers
select * from InsuranceCompanies
select * from knockerResponses
select * from leads
select * from planes
select * from referrers
select* from scopes
select * from users

select * from lu_claimdocumenttypes
select * from lu_employeetypes
select * from lu_knockresponsetypes
select * from lu_leadtypes
select * from lu_products

declare @salespersonid int = 3

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
					AND l.LeadDate > DATEADD(DAY, -8, GETDATE())

--truncate table knockerresponses

--truncate table lu_claimdocumenttypes

--declare @filepath varchar(255) = (Select FilePath from ClaimDocumentPaths where documentID = 1)

--UPDATE ClaimDocumentPaths
--				SET filepath = 'services.mrncontracting.com/files/MRN-3-25-30/Inspection/Images/'
--				WHERE DocumentID = 2;


--exec proc_UpdateCalendarData 6, 3, '2016-6-1', '2016-6-2', null, 'Updated Note'

--declare @output int
--exec proc_AddCalendarData 3, '2016-6-1', '2016-6-2', null, 'Second Testing proc for update', @output output
--print @output

--select * from customers

select * from INFORMATION_SCHEMA.COLUMNS
----where TABLE_NAME = 'Inspections' --returns single table
--where is_nullable = 'yes'
where data_type = 'datetime'

--sp_columns Inspections