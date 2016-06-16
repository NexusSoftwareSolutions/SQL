/*
-- Returns all Triggers in the Database
select * from sys.objects
where type = 'TR';

-- Creates the table to Audit Inserts and Updates to the tables
CREATE TABLE _ChangeLog
(
TableName varchar(100),
LastModified datetime
);

*/
----------------------------------------------------------------------------
-- Insert and Update triggers for AdditionalSupplies
ALTER TRIGGER trgAfterInsertAdditionalSupplies ON AdditionalSupplies
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'AdditionalSupplies';
GO

ALTER TRIGGER trgAfterUpdateAdditionalSupplies ON AdditionalSupplies
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(PickUpDate) 
		OR UPDATE(DropOffDate) 
		OR UPDATE(Items) 
		OR UPDATE(Cost) 
		OR UPDATE(ReceiptImagePath)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'AdditionalSupplies';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Addresses
ALTER TRIGGER trgAfterInsertAddresses ON Addresses
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Addresses';
GO

ALTER TRIGGER trgAfterUpdateAddresses ON Addresses
FOR UPDATE
AS
	IF UPDATE(CustomerID)
		OR UPDATE(Address) 
		OR UPDATE(Zip)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Addresses';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Adjusters
ALTER TRIGGER trgAfterInsertAdjusters ON Adjusters
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Adjusters';
GO

ALTER TRIGGER trgAfterUpdateAdjusters ON Adjusters
FOR UPDATE
AS
	IF UPDATE(FirstName) 
		OR UPDATE(LastName)
		OR UPDATE(Suffix)
		OR UPDATE(PhoneNumber)
		OR UPDATE(PhoneExt)
		OR UPDATE(Email)
		OR UPDATE(InsuranceCompanyID)
		OR UPDATE(Comments)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Adjusters';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Adjustments
ALTER TRIGGER trgAfterInsertAdjustments ON Adjustments
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Adjustments';
GO

ALTER TRIGGER trgAfterUpdateAdjustments ON Adjustments
FOR UPDATE
AS
	IF UPDATE(AdjusterID)
		OR UPDATE(ClaimID)
		OR UPDATE(Gutters) 
		OR UPDATE(Exterior)
		OR UPDATE(Interior)
		OR UPDATE(AdjustmentResultID)
		OR UPDATE(AdjustmentDate)
		OR UPDATE(AdjustmentComment)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Adjustments';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for CalendarData
ALTER TRIGGER trgAfterInsertCalendarData ON CalendarData
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'CalendarData';
GO

ALTER TRIGGER trgAfterUpdateCalendarData ON CalendarData
FOR UPDATE
AS
	IF UPDATE(AppointmentTypeID) 
		OR UPDATE(EmployeeID)
		OR UPDATE(StartTime)
		OR UPDATE(EndTime)
		OR UPDATE(ClaimID)
		OR UPDATE(LeadID)
		OR UPDATE(Note)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'CalendarData';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for CallLogs
ALTER TRIGGER trgAfterInsertCallLogs ON CallLogs
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'CallLogs';
GO

ALTER TRIGGER trgAfterUpdateCallLogs ON CallLogs
FOR UPDATE
AS
	IF UPDATE(ClaimID)
		OR UPDATE(EmployeeID)
		OR UPDATE(WhoWasCalled) 
		OR UPDATE(ReasonForCall)
		OR UPDATE(WhoAnswered)
		OR UPDATE(CallResults)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'CallLogs';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for ClaimContacts
ALTER TRIGGER trgAfterInsertClaimContacts ON ClaimContacts
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'ClaimContacts';
GO

ALTER TRIGGER trgAfterUpdateClaimContacts ON ClaimContacts
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(CustomerID)
		OR UPDATE(KnockerID)
		OR UPDATE(SalesPersonID)
		OR UPDATE(SupervisorID)
		OR UPDATE(SalesManagerID)
		OR UPDATE(AdjusterID)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'ClaimContacts';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for ClaimDocuments
ALTER TRIGGER trgAfterInsertClaimDocuments ON ClaimDocuments
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'ClaimDocuments';
GO

ALTER TRIGGER trgAfterUpdateClaimDocuments ON ClaimDocuments
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(FilePath)
		OR UPDATE(FileName)
		OR UPDATE(FileExt)
		OR UPDATE(DocTypeID)
		OR UPDATE(DocumentDate)
		OR UPDATE(SignatureImagePath)
		OR UPDATE(NumSignatures)
		OR UPDATE(InitialImagePath)
		OR UPDATE(NumInitials)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'ClaimDocuments';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Claims
ALTER TRIGGER trgAfterInsertClaims ON Claims
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Claims';
GO

ALTER TRIGGER trgAfterUpdateClaims ON Claims
FOR UPDATE
AS
	IF UPDATE(CustomerID) 
		OR UPDATE(LeadID)
		OR UPDATE(BillingID)
		OR UPDATE(PropertyID)
		OR UPDATE(InsuranceCompanyID)
		OR UPDATE(InsuranceClaimNumber)
		OR UPDATE(MRNNumber)
		OR UPDATE(LossDate)
		OR UPDATE(MortgageCompany)
		OR UPDATE(MortgageAccount)
		OR UPDATE(IsOpen)
		OR UPDATE(ContractSigned)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Claims';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for ClaimStatuses
ALTER TRIGGER trgAfterInsertClaimStatuses ON ClaimStatuses
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'ClaimStatuses';
GO

ALTER TRIGGER trgAfterUpdateClaimStatuses ON ClaimStatuses
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(ClaimStatusTypeID)
		OR UPDATE(ClaimStatusDate)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'ClaimStatuses';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for ClaimVendors
ALTER TRIGGER trgAfterInsertClaimVendors ON ClaimVendors
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'ClaimVendors';
GO

ALTER TRIGGER trgAfterUpdateClaimVendors ON ClaimVendors
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(VendorID)
		OR UPDATE(ServiceTypeID)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'ClaimVendors';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Customers
ALTER TRIGGER trgAfterInsertCustomers ON Customers
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Customers';
GO

ALTER TRIGGER trgAfterUpdateCustomers ON Customers
FOR UPDATE
AS
	IF UPDATE(FirstName) 
		OR UPDATE(MiddleName)
		OR UPDATE(LastName)
		OR UPDATE(Suffix)
		OR UPDATE(PrimaryNumber)
		OR UPDATE(SecondaryNumber)
		OR UPDATE(Email)
		OR UPDATE(MailPromos)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Customers';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Damages
ALTER TRIGGER trgAfterInsertDamages ON Damages
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Damages';
GO

ALTER TRIGGER trgAfterUpdateDamages ON Damages
FOR UPDATE
AS
	IF UPDATE(PlaneID) 
		OR UPDATE(DamageTypeID)
		OR UPDATE(DocumentID)
		OR UPDATE(DamageMeasurement)
		OR UPDATE(xCoordinate)
		OR UPDATE(yCoordinate)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Damages';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for EmployeeDetails
ALTER TRIGGER trgAfterInsertEmployeeDetails ON EmployeeDetails
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'EmployeeDetails';
GO

ALTER TRIGGER trgAfterUpdateEmployeeDetails ON EmployeeDetails
FOR UPDATE
AS
	IF UPDATE(EmployeeID) 
		OR UPDATE(MailingAddress)
		OR UPDATE(Zip)
		OR UPDATE(DateHired)
		OR UPDATE(DateReleased)
		OR UPDATE(ShirtSize)
		OR UPDATE(PayRate)
		OR UPDATE(PayTypeID)
		OR UPDATE(PayFrequencyID)
		OR UPDATE(PreviousEmployee)
		OR UPDATE(DLPhotoPath)
		OR UPDATE(CompanyPhotoPath)
		OR UPDATE(SignaturePath)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'EmployeeDetails';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Employees
ALTER TRIGGER trgAfterInsertEmployees ON Employees
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Employees';
GO

ALTER TRIGGER trgAfterUpdateEmployees ON Employees
FOR UPDATE
AS
	IF UPDATE(EmployeeTypeID) 
		OR UPDATE(FirstName)
		OR UPDATE(LastName)
		OR UPDATE(Suffix)
		OR UPDATE(Email)
		OR UPDATE(CellPhone)
		OR UPDATE(Active)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Employees';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Inspections
ALTER TRIGGER trgAfterInsertInspections ON Inspections
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Inspections';
GO

ALTER TRIGGER trgAfterUpdateInspections ON Inspections
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(RidgeMaterialTypeID)
		OR UPDATE(ShingleTypeID)
		OR UPDATE(InspectionDate)
		OR UPDATE(SkyLights)
		OR UPDATE(Leaks)
		OR UPDATE(GutterDamage)
		OR UPDATE(DrivewayDamage)
		OR UPDATE(MagneticRollers)
		OR UPDATE(IceWaterShield)
		OR UPDATE(EmergencyRepair)
		OR UPDATE(EmergencyRepairAmount)
		OR UPDATE(QualityControl)
		OR UPDATE(ProtectLandscaping)
		OR UPDATE(RemoveTrash)
		OR UPDATE(FurnishPermit)
		OR UPDATE(CoverPool)
		OR UPDATE(InteriorDamage)
		OR UPDATE(ExteriorDamage)
		OR UPDATE(LightningProtection)
		OR UPDATE(TearOff)
		OR UPDATE(Satellite)
		OR UPDATE(SolarPanels)
		OR UPDATE(RoofAge)
		OR UPDATE(Comments)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Inspections';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for InsuranceCompanies
ALTER TRIGGER trgAfterInsertInsuranceCompanies ON InsuranceCompanies
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'InsuranceCompanies';
GO

ALTER TRIGGER trgAfterUpdateInsuranceCompanies ON InsuranceCompanies
FOR UPDATE
AS
	IF UPDATE(CompanyName) 
		OR UPDATE(Address)
		OR UPDATE(Zip)
		OR UPDATE(ClaimPhoneNumber)
		OR UPDATE(ClaimPhoneExt)
		OR UPDATE(FaxNumber)
		OR UPDATE(FaxExt)
		OR UPDATE(Email)
		OR UPDATE(Independent)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'InsuranceCompanies';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Invoices
ALTER TRIGGER trgAfterInsertInvoices ON Invoices
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Invoices';
GO

ALTER TRIGGER trgAfterUpdateInvoices ON Invoices
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(InvoiceTypeID)
		OR UPDATE(VendorID)
		OR UPDATE(InvoiceAmount)
		OR UPDATE(InvoiceDate)
		OR UPDATE(Paid)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Invoices';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for KnockerResponses
ALTER TRIGGER trgAfterInsertKnockerResponses ON KnockerResponses
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'KnockerResponses';
GO

ALTER TRIGGER trgAfterUpdateKnockerResponses ON KnockerResponses
FOR UPDATE
AS
	IF UPDATE(KnockerID) 
		OR UPDATE(KnockResponseTypeID)
		OR UPDATE(Address)
		OR UPDATE(Zip)
		OR UPDATE(Lat)
		OR UPDATE(Long)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'KnockerResponses';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Leads
ALTER TRIGGER trgAfterInsertLeads ON Leads
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Leads';
GO

ALTER TRIGGER trgAfterUpdateLeads ON Leads
FOR UPDATE
AS
	IF UPDATE(LeadTypeID) 
		OR UPDATE(KnockerResponseID)
		OR UPDATE(SalesPersonID)
		OR UPDATE(CustomerID)
		OR UPDATE(AddressID)
		OR UPDATE(LeadDate)
		OR UPDATE(Status)
		OR UPDATE(CreditToID)
		OR UPDATE(Temperature)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Leads';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for NewRoofs
ALTER TRIGGER trgAfterInsertNewRoofs ON NewRoofs
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'NewRoofs';
GO

ALTER TRIGGER trgAfterUpdateNewRoofs ON NewRoofs
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(ProductID)
		OR UPDATE(UpgradeCost)
		OR UPDATE(Comments)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'NewRoofs';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for OrderItems
ALTER TRIGGER trgAfterInsertOrderItems ON OrderItems
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'OrderItems';
GO

ALTER TRIGGER trgAfterUpdateOrderItems ON OrderItems
FOR UPDATE
AS
	IF UPDATE(OrderID) 
		OR UPDATE(ProductID)
		OR UPDATE(UnitOfMeasureID)
		OR UPDATE(Quantity)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'OrderItems';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Orders
ALTER TRIGGER trgAfterInsertOrders ON Orders
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Orders';
GO

ALTER TRIGGER trgAfterUpdateOrders ON Orders
FOR UPDATE
AS
	IF UPDATE(VendorID) 
		OR UPDATE(ClaimID)
		OR UPDATE(DateOrdered)
		OR UPDATE(DateDropped)
		OR UPDATE(ScheduledInstallation)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Orders';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Payments
ALTER TRIGGER trgAfterInsertPayments ON Payments
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Payments';
GO

ALTER TRIGGER trgAfterUpdatePayments ON Payments
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(PaymentTypeID)
		OR UPDATE(PaymentDescriptionID)
		OR UPDATE(Amount)
		OR UPDATE(PaymentDate)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Payments';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Planes
ALTER TRIGGER trgAfterInsertPlanes ON Planes
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Planes';
GO

ALTER TRIGGER trgAfterUpdatePlanes ON Planes
FOR UPDATE
AS
	IF UPDATE(PlaneTypeID) 
		OR UPDATE(InspectionID)
		OR UPDATE(GroupNumber)
		OR UPDATE(NumOfLayers)
		OR UPDATE(ThreeAndOne)
		OR UPDATE(FourAndUp)
		OR UPDATE(Pitch)
		OR UPDATE(HipValley)
		OR UPDATE(RidgeLength)
		OR UPDATE(RakeLength)
		OR UPDATE(EaveHeight)
		OR UPDATE(EaveLength)
		OR UPDATE(NumberDecking)
		OR UPDATE(StepFlashing)
		OR UPDATE(SquareFootage)
		OR UPDATE(ItemSpec)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Planes';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Referrers
ALTER TRIGGER trgAfterInsertReferrers ON Referrers
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Referrers';
GO

ALTER TRIGGER trgAfterUpdateReferrers ON Referrers
FOR UPDATE
AS
	IF UPDATE(FirstName) 
		OR UPDATE(LastName)
		OR UPDATE(Suffix)
		OR UPDATE(MailingAddress)
		OR UPDATE(Zip)
		OR UPDATE(Email)
		OR UPDATE(CellPhone)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Referrers';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Scopes
ALTER TRIGGER trgAfterInsertScopes ON Scopes
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Scopes';
GO

ALTER TRIGGER trgAfterUpdateScopes ON Scopes
FOR UPDATE
AS
	IF UPDATE(ScopeTypeID) 
		OR UPDATE(ClaimID)
		OR UPDATE(Interior)
		OR UPDATE(Exterior)
		OR UPDATE(Gutter)
		OR UPDATE(RoofAmount)
		OR UPDATE(Tax)
		OR UPDATE(Deductible)
		OR UPDATE(Total)
		OR UPDATE(OandP)
		OR UPDATE(Accepted)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Scopes';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for SurplusSupplies
ALTER TRIGGER trgAfterInsertSurplusSupplies ON SurplusSupplies
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'SurplusSupplies';
GO

ALTER TRIGGER trgAfterUpdateSurplusSupplies ON SurplusSupplies
FOR UPDATE
AS
	IF UPDATE(ClaimID) 
		OR UPDATE(UnitOfMeasureID)
		OR UPDATE(Quantity)
		OR UPDATE(PickUpDate)
		OR UPDATE(DropOffDate)
		OR UPDATE(Items)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'SurplusSupplies';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Users
ALTER TRIGGER trgAfterInsertUsers ON Users
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Users';
GO

ALTER TRIGGER trgAfterUpdateUsers ON Users
FOR UPDATE
AS
	IF UPDATE(EmployeeID) 
		OR UPDATE(Username)
		OR UPDATE(Pass)
		OR UPDATE(PermissionID)
		OR UPDATE(Active)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Users';
			END
GO
----------------------------------------------------------------------------
-- Insert and Update triggers for Vendors
ALTER TRIGGER trgAfterInsertVendors ON Vendors
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Vendors';
GO

ALTER TRIGGER trgAfterUpdateVendors ON Vendors
FOR UPDATE
AS
	IF UPDATE(VendorTypeID) 
		OR UPDATE(CompanyName)
		OR UPDATE(EIN)
		OR UPDATE(ContactFirstName)
		OR UPDATE(ContactLastName)
		OR UPDATE(Suffix)
		OR UPDATE(VendorAddress)
		OR UPDATE(Zip)
		OR UPDATE(Phone)
		OR UPDATE(CompanyPhone)
		OR UPDATE(Fax)
		OR UPDATE(Email)
		OR UPDATE(Website)
		OR UPDATE(GeneralLiabilityExpiration)
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Vendors';
			END
GO
----------------------------------------------------------------------------
