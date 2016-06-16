
create table Adjusters(

	AdjusterID int identity(1,1) primary key not null,
	FirstName varchar(50),
	LastName varchar(50) not null,
	Suffix varchar(10),
	PhoneNumber varchar(12),
	PhoneExt varchar(10),
	Email varchar(100) not null,
	InsuranceCompanyID int not null,
	Comments varchar(255)
	
	constraint UC_AdjusterInfo_Email unique (Email)
);

create table Adjustments(

	AdjustmentID int identity(1,1) primary key not null,
	AdjusterID int not null,
	ClaimID int not null,
	Gutters bit not null,
	Exterior bit not null,
	Interior bit not null,
	AdjustmentResultID int not null,
	AdjustmentDate datetime not null,
	AdjustmentComment varchar(255)
);

create table InsuranceCompanies(

	InsuranceCompanyID int identity(1,1) primary key not null,
	CompanyName varchar(255) not null,
	Address varchar(100),
	Zip varchar(10),
	ClaimPhoneNumber varchar(12) not null,
	ClaimPhoneExt varchar(10),
	FaxNumber varchar(12),
	FaxExt varchar(10),
	Email varchar(100),
	Independent bit not null constraint --Is the "company" an independent
			DF_InsuranceCompanies_Independent DEFAULT 0, 
);

-- allows multiple NULL values in Email field for InsuranceCompanies
CREATE UNIQUE NONCLUSTERED INDEX UniqueExceptNulls
	ON InsuranceCompanies (Email)
	WHERE Email IS NOT NULL;

create table Claims(

	ClaimID int identity(1,1) primary key not null,
	CustomerID int not null,
	LeadID int not null,
	BillingID int not null,
	PropertyID int not null,
	InsuranceCompanyID int not null,
	InsuranceClaimNumber varchar(255),
	MRNNumber varchar(50) not null, -- autogenerated in proc_AddClaim
	LossDate datetime not null,
	MortgageCompany varchar(50),
	MortgageAccount varchar(50),
	IsOpen bit not null,
	ContractSigned bit not null,

	constraint UC_Claim_ClaimNumber unique (MRNNumber)
);

create table Damages(

	DamageID int identity(1,1) primary key not null,
	PlaneID int not null,
	DamageTypeID int not null,
	DocumentID int not null,
	DamageMeasurement int not null,
	xCoordinate int not null,
	yCoordinate int not null
);

create table Inspections(

	InspectionID int identity(1,1) primary key not null,
	ClaimID int not null,
	RidgeMaterialTypeID int not null,
	ShingleTypeID int not null,
	InspectionDate datetime not null,
	SkyLights bit not null,
	Leaks bit not null,
	GutterDamage bit not null, 
	DrivewayDamage bit not null,
	MagneticRollers bit not null,
	IceWaterShield bit not null,
	EmergencyRepair bit not null,
	EmergencyRepairAmount float,
	QualityControl bit not null,
	ProtectLandscaping bit not null,
	RemoveTrash bit not null,
	FurnishPermit bit not null,
	CoverPool bit not null,
	InteriorDamage bit not null,
	ExteriorDamage bit not null,
	LightningProtection bit not null,
	TearOff bit not null constraint 
			DF_Inspections_TearOff DEFAULT 1,
	Satellite bit not null, 
	SolarPanels bit not null,
	RoofAge int not null,
	Comments varchar(255),
);

create table Planes(

	PlaneID int identity(1, 1) primary key not null,
	PlaneTypeID int not null,
	InspectionID int not null,
	GroupNumber int not null,
	NumOfLayers int,
	ThreeAndOne int,
	FourAndUp int,
	Pitch int,
	HipValley int,
	RidgeLength int,
	RakeLength int,
	EaveHeight int, 
	EaveLength int,
	NumberDecking int,
	StepFlashing int,
	SquareFootage float,
	ItemSpec varchar(50)
);

create table NewRoofs(
	
	NewRoofID int identity(1,1) primary key not null,
	ClaimID int not null,
	ProductID int not null,
	UpgradeCost float not null,
	Comments varchar(255)
);

create table Invoices(

	InvoiceID int identity(1,1) primary key not null,
	ClaimID int not null,
	InvoiceTypeID int not null,
	VendorID int not null,
	InvoiceAmount float not null,
	InvoiceDate datetime not null,
	Paid bit not null
);

create table Payments(

	PaymentID int identity(1,1) primary key not null,
	ClaimID int not null,
	PaymentTypeID int not null,
	PaymentDescriptionID int not null,
	Amount float not null,
	PaymentDate datetime not null
);

create table ClaimStatuses(

	ClaimStatusID int identity(1,1) primary key not null,
	ClaimID int not null,
	ClaimStatusTypeID int not null,
	ClaimStatusDate datetime not null
);

create table Scopes(

	ScopeID int identity(1,1) primary key not null,
	ScopeTypeID int not null,
	ClaimID int not null,
	Interior float not null,
	Exterior float not null,
	Gutter float not null,
	RoofAmount float not null,
	Tax float not null,
	Deductible float not null,
	Total float not null,
	OandP float not null,
	Accepted bit not null
);

create table ClaimDocuments(

	DocumentID int identity(1,1) primary key not null,
	ClaimID int not null,
	FilePath varchar(255) not null,	
	FileName varchar(50) not null,
	FileExt varchar(10) not null,
	DocTypeID int not null,
	DocumentDate datetime not null,
	SignatureImagePath varchar(255),
	NumSignatures int,
	InitialImagePath varchar(255),
	NumInitials int
);

create table Customers(

	CustomerID int identity(1,1) primary key not null,
	FirstName varchar(50) not null,
	MiddleName varchar(50),
	LastName varchar(50) not null,
	Suffix varchar(10),
	PrimaryNumber varchar(12) not null,
	SecondaryNumber varchar(12),
	Email varchar(100),
	MailPromos bit not null constraint 
			DF_Customer_MailPromo DEFAULT 1,
			
	constraint UC_Customers_Email unique (Email)
);

create table Employees(

	EmployeeID int identity(1,1) primary key not null,
	EmployeeTypeID int not null,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	Suffix varchar(10),
	Email varchar(50) not null,
	CellPhone varchar(12) not null,
	Active bit not null constraint
			DF_Employees_Active default 1
);

create table EmployeeDetails(

	EmployeeDetailsID int identity(1,1) primary key not null,
	EmployeeID int not null,
	MailingAddress varchar(100) not null,
	Zip varchar(10) not null,
	DateHired datetime not null,
	DateReleased datetime,
	ShirtSize varchar(12),
	PayRate float,
	PayTypeID int,
	PayFrequencyID int,
	PreviousEmployee bit not null constraint
			DF_EmployeeDetails_PreviousEmployee default 0,
	DLPhotoPath varchar(255),
	CompanyPhotoPath varchar(255),
	SignaturePath varchar(255)
);

create table Users(

	UserID int identity(1,1) primary key not null,
	EmployeeID int not null,
	Username varchar(50) not null,
	Pass varchar(255) not null,
	PermissionID int not null,
	Active bit not null constraint 
			DF_Users_Active DEFAULT 1,
			
	constraint UC_Users_Username unique (Username)
);

create table Referrers(

	ReferrerID int identity(1,1) primary key not null,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	Suffix varchar(10),
	MailingAddress varchar(100) not null,
	Zip varchar(10) not null,
	Email varchar(50) not null,
	CellPhone varchar(12) not null
);

create table Vendors(

	VendorID int identity(1,1) primary key not null,
	VendorTypeID int not null,
	CompanyName varchar(100) not null,
	EIN varchar(10),
	ContactFirstName varchar(50) not null,
	ContactLastName varchar(50),
	Suffix varchar(10),
	VendorAddress varchar(100),
	Zip varchar(10),
	Phone varchar(12) not null,
	CompanyPhone varchar(12),
	Fax varchar(12),
	Email varchar(50) not null,
	Website varchar(50),
	GeneralLiabilityExpiration datetime,

	constraint UC_Vendor_EIN unique (EIN)
);

create table AdditionalSupplies(

	AdditionalSuppliesID int identity(1,1) primary key not null,
	ClaimID int not null,
	PickUpDate datetime not null,
	DropOffDate datetime not null,
	Items varchar(255) not null,
	Cost float not null,
	ReceiptImagePath varchar(255) not null
);

create table SurplusSupplies(

	SurplusSuppliesID int identity(1,1) primary key not null,
	ClaimID int not null,
	UnitOfMeasureID int not null,
	Quantity int not null,
	PickUpDate datetime not null,
	DropOffDate datetime not null,
	Items varchar(255) not null,
);

create table Orders(

	OrderID int identity(1,1) primary key not null,
	VendorID int not null,
	ClaimID int not null,
	DateOrdered datetime not null,
	DateDropped datetime not null,
	ScheduledInstallation datetime not null
);

create table OrderItems(

	OrderItemID int identity(1,1) primary key not null,
	OrderID int not null,
	ProductID int not null,
	UnitOfMeasureID int not null,
	Quantity int not null,

);

create table ClaimContacts(

	ClaimContactID int identity(1,1) primary key not null,
	ClaimID int,
	CustomerID int not null,
	KnockerID int,
	SalesPersonID int not null,
	SupervisorID int,
	SalesManagerID int not null,
	AdjusterID int,
);

--intersect for claim and vendors
create table ClaimVendors(

	ClaimID int not null,
	VendorID int not null,
	ServiceTypeID int not null,

	primary key(ClaimID, VendorID)
);

create table KnockerResponses( --Needs to trigger a lead

	KnockerResponseID int identity(1,1) primary key not null,
	KnockerID int not null,
	KnockResponseTypeID int not null,
	Address varchar(100),
	Zip varchar(10),
	Lat float,
	Long float
);

create table Leads(

	LeadID int identity(1,1) primary key not null,
	LeadTypeID int not null,
	KnockerResponseID int,
	SalesPersonID int not null,
	CustomerID int not null,
	AddressID int not null,
	LeadDate datetime not null,
	Status char(1) not null
		constraint CHK_Leads_Status check (Status IN ('S', 'A', 'D')),
	CreditToID int, -- ID corresponding to LeadType(Knocker, Referral, etc.)
	Temperature char(1) not null
		constraint CHK_Leads_Temperature check (Temperature IN ('C', 'W', 'H'))
);

create table CalendarData(

	EntryID int identity(1,1) primary key not null,
	AppointmentTypeID int not null,
	EmployeeID int not null,
	StartTime datetime not null,
	EndTime datetime not null,
	ClaimID int,
	LeadID int,
	Note varchar(255),

	constraint UC_CalendarData_EEIDStartEndTime unique (EmployeeID, StartTime, EndTime)
);

create table CallLogs(

	CallLogID int identity(1,1) primary key not null,
	ClaimID int not null,
	EmployeeID int not null,
	WhoWasCalled varchar(50) not null,
	ReasonForCall varchar(255) not null,
	WhoAnswered varchar(50) not null,
	CallResults varchar(255) not null
);

create table Addresses(

	AddressID int identity(1,1) primary key not null,
	CustomerID int not null,
	Address varchar(100),
	Zip varchar(10)
);


-- LOOKUP TABLES
create table LU_ScopeTypes(
	ScopeTypeID int identity(1,1) primary key not null,
	ScopeType varchar(50) not null
)
create table LU_UnitOfMeasures(
	UnitOfMeasureID int identity(1,1) primary key not null,
	UnitOfMeasure varchar(50) not null
);

create table LU_KnockResponseTypes(
	KnockResponseTypeID int identity(1,1) primary key not null,
	KnockResponseType varchar(50) not null
);

create table LU_LeadTypes(
	LeadTypeID int identity(1,1) primary key not null,
	LeadType varchar(50) not null
);

create table LU_PayTypes(
	PayTypeID int identity(1,1) primary key not null,
	PayType varchar(50) not null
);

create table LU_PayFrequencies(
	PayFrequencyID int identity(1,1) primary key not null,
	PayFrequency varchar(50) not null
);

create table LU_EmployeeTypes(
	EmployeeTypeID int identity(1,1) primary key not null,
	EmployeeType varchar(50) not null
);

create table LU_Products(
	ProductID int identity(1,1) primary key not null,
	ProductTypeID int not null,
	VendorID int not null,
	Name varchar(50) not null,
	Color varchar(50),
	Price float not null,
	Info varchar(255),
	Warranty varchar(255)
);

create table LU_ProductTypes(
	ProductTypeID int identity(1,1) primary key not null,
	ProductType varchar(50) not null
);

create table LU_ClaimDocumentTypes(
	ClaimDocumentTypeID int identity(1,1) primary key not null,
	ClaimDocumentType varchar(50) not null
)

Create table LU_InvoiceTypes(
	InvoiceTypeID int identity(1,1) primary key not null,
	InvoiceType varchar(255)not null
);

Create table LU_PaymentTypes(
	PaymentTypeID int identity(1,1) primary key NOT null,
	PaymentType varchar(50) not null
);

Create table LU_PaymentDescriptions(
	PaymentDescriptionID int identity(1,1) primary key NOT null,
	PaymentDescription varchar(50) not null
);

create table LU_Permissions(
	PermissionID int identity(1, 1) primary key not null,
	PermissionLevel varchar(255)
);

create table LU_AdjustmentResults(
	AdjustmentResultID int identity(1, 1) primary key not null,
	AdjustmentResult varchar(50)
);

create table LU_AppointmentTypes(
	AppointmentTypeID int identity(1, 1) primary key not null,
	AppointmentType varchar(50)
);

create table LU_RidgeMaterialTypes(
	RidgeMaterialTypeID int identity(1, 1) primary key not null,
	RidgeMaterialType varchar(50)
);

create table LU_ShingleTypes(
	ShingleTypeID int identity(1, 1) primary key not null,
	ShingleType varchar(50)
);

create table LU_ClaimStatusTypes(
	
	ClaimStatusTypeID int identity(1, 1) primary key not null,
	ClaimStatusType varchar(100),
	SortOrder int
);

create table LU_PlaneTypes(

	PlaneTypeID int identity(1, 1) primary key not null,
	PlaneType varchar(100)
);

create table LU_DamageTypes(

	DamageTypeID int identity(1, 1) primary key not null,
	DamageType varchar(100)
);

create table LU_ServiceTypes(
	
	ServiceTypeID int identity(1, 1) primary key not null,
	ServiceType varchar(100)
);

create table LU_VendorTypes(

	VendorTypeID int identity(1, 1) primary key not null,
	VendorType varchar(100)
);



-- INSERTS FOR LOOKUPS
insert into LU_ScopeTypes (ScopeType)
values ('MRN'), ('Original'), ('Newest')

insert into LU_UnitOfMeasures (UnitOfMeasure)
values ('Box'), ('Piece'), ('Roll'), ('Square'), ('Feet')

insert into LU_LeadTypes (LeadType)
values ('Knocker'), ('Referral'), ('Online'), ('Phone'), ('Walk-In'), ('Self-Generated')

insert into LU_KnockResponseTypes (KnockResponseType)
values ('No Answer'), ('Appointment Set'), ('Come Back Later'), ('Not Interested')

insert into LU_PayTypes (PayType)
values ('Hourly'), ('Salary'), ('Commission')

insert into LU_PayFrequencies (PayFrequency)
values ('Weekly'), ('Bi-weekly'), ('Monthly'), ('Bi-monthly'), ('Quarterly'), ('Annually'), ('As Incurred')

insert into LU_ClaimDocumentTypes (ClaimDocumentType)
values('Inspection Report'), ('Inspection Images'), ('Roof Measurement'), ('Sketch'), ('Contract'), ('MRN Scope/Estimate'),
('Original Insurance Scope'), ('Newest Insurance Scope'), ('Job Order Form'), ('Interior Invoice'), ('Exterior Invoice'), 
('Gutter Invoice'), ('First Check'), ('Deductible Check'), ('Depreciation Check'), ('Supplement Check'), ('Chain of Custody'), 
('Lean Waiver'), ('Cap Out'), ('Certificate of Completion'), ('Authorization of Communication'), ('Satisfaction Survey'), ('Plane Damage')

insert into LU_InvoiceTypes (InvoiceType)
values ('Exterior-Labor/Material'), ('Gutter-Labor/Material'), ('Interior-Labor/Material'), ('Roof-Labor'), ('Roof-Material')

insert into LU_PaymentTypes (PaymentType)
values('Check'), ('Cash'), ('Credit Card'), ('Other')

insert into LU_PaymentDescriptions (PaymentDescription)
values('First Payment'), ('Supplement Payment'), ('Depreciation Payment'), 
('Upgrade Payment'), ('Deductible Payment'), ('Repairs Payment')

insert into LU_AdjustmentResults (AdjustmentResult)
values ('Approved'), ('Denied-Adjustment'), ('Denied-Reinspection'), ('Denied-Engineer')

insert into LU_AppointmentTypes (AppointmentType)
values ('Inspection'), ('Adjustment'), ('Reinspection'), ('Engineer')

insert into LU_EmployeeTypes (EmployeeType)
values ('Owner'), ('Branch Manager'), ('Superintendent'), ('Purchase Manager'), ('Executive Assistant'), 
('Sales Director'), ('Sales Manager'), ('Quality Control'), ('Production Manager'), ('Supervisor'), ('Intern'),
('Auditor'), ('Salesperson'), ('Knocker')

insert into LU_Permissions (PermissionLevel)
values ('Admin')

insert into LU_RidgeMaterialTypes (RidgeMaterialType)
values ('Composite'), ('Metal'), ('Plastic')

insert into LU_ShingleTypes (ShingleType)
values ('Defective'), ('Three-Tab'), ('Architectural')

insert into LU_ServiceTypes (ServiceType)
values ('Exterior'), ('Gutter'), ('Interior'), ('Roof')

insert into LU_VendorTypes (VendorType)
values ('Installer'), ('Supplier')

insert into LU_DamageTypes (DamageType)
values ('Hail'), ('Wind'), ('Fire'), ('Water'), ('Mold'), ('Vandalism')

insert into LU_ClaimStatusTypes (ClaimStatusType, SortOrder) 
values
('Contract Created','1'), 
('Inspection Date','2'), 
('Plane Measurements Received','3'), 
('Estimate Complete','4'),
('Adjustment Date','5'), 
('Original Scope Received','6'), 
('First Check Received','7'), 
('Roof Ordered','8'),
('Supplement Sent','9'), 
('Supplement Settled','10'), 
('Roof Scheduled','11'), 
('Roof Complete','12'), 
('Gutters Scheduled','13'), 
('Interior Scheduled','14'), 
('Exterior Scheduled','15'), 
('Certificate of Completion Sent','16'),
('Supplement Check Received','17'), 
('Supplement Check Collected','18'), 
('Depreciation Check Received','19'),
('Depreciation Check Collected','20'), 
('Deductible Check Collected','21'), 
('Capped Out','22'), 
('Warranty Sent','23')

insert into LU_PlaneTypes (PlaneType)
values
('Trapezoid A'), 
('Trapezoid B'), 
('Triangle A'), 
('Triangle B'), 
('Triangle C'), 
('Triangle D'), 
('Triangle E'), 
('Triangle F'), 
('Parallelogram A'), 
('Parallelogram B'), 
('Parallelogram C'), 
('Parallelogram D'), 
('Rectangle A'), 
('Rectangle B'),
('Trapezoid C'), 
('Trapezoid D')

insert into InsuranceCompanies 
			(CompanyName,Address,Zip,ClaimPhoneNumber,
			ClaimPhoneExt,FaxNumber,FaxExt,Email,Independent) 
values 
('21st Century Insurance',NULL,NULL,'888-244-6163',NULL,NULL,NULL,NULL,0),
('AAA Insurance (Auto Club Family Insurance Company)',NULL,NULL,'800-222-7623','5000',NULL,NULL,NULL,0),
('Acadia Insurance Company',NULL,NULL,'800-444-0049','2600',NULL,NULL,NULL,0),
('ACE Private Risk Services',NULL,NULL,'800-945-7461',NULL,NULL,NULL,NULL,0),
('ACE USA',NULL,NULL,'800 945-7461',NULL,NULL,NULL,NULL,0),
('Acuity',NULL,NULL,'800-242-7666',NULL,NULL,NULL,NULL,0),
('AGCS Marine',NULL,NULL,'800-558-1606',NULL,NULL,NULL,NULL,0),
('Alabama Department of Insurance',NULL,NULL,'334-269-3550',NULL,NULL,NULL,NULL,0),
('Alabama Municipal Insurance Corporation',NULL,NULL,'866-239-AMIC',NULL,NULL,NULL,NULL,0),
('Alfa Insurance Group',NULL,NULL,'888-964-2532',NULL,NULL,NULL,NULL,0),
('Allied Insurance',NULL,NULL,'800-421-3535',NULL,NULL,NULL,NULL,0),
('Allmerica',NULL,NULL,'800-628-0250',NULL,NULL,NULL,NULL,0),
('Allstate',NULL,NULL,'800-547-8676',NULL,NULL,NULL,NULL,0),
('Allstate Floridian Insurance Company',NULL,NULL,'800-547-8676',NULL,NULL,NULL,NULL,0),
('America First Insurance',NULL,NULL,'877-263-7890',NULL,NULL,NULL,NULL,0),
('America''s Health Insurance Plans (AHIP)',NULL,NULL,'800-644-1818',NULL,NULL,NULL,NULL,0),
('American Bankers Insurance Company',NULL,NULL,'800-245-1505',NULL,NULL,NULL,NULL,0),
('American Family Insurance',NULL,NULL,'800-MY-AMFAM',NULL,NULL,NULL,NULL,0),
('American Federation Insurance Company',NULL,NULL,'800-527-3907',NULL,NULL,NULL,NULL,0),
('American General Property Insurance Company of Florida',NULL,NULL,'800-321-2452',NULL,NULL,NULL,NULL,0),
('American International Group Inc. (AIG)',NULL,NULL,'877-244-0304',NULL,NULL,NULL,NULL,0),
('American National Property & Casualty Company & Affiliates',NULL,NULL,'800-333-2860',NULL,NULL,NULL,NULL,0),
('American Reliable Insurance Company',NULL,NULL,'800-245-1505',NULL,NULL,NULL,NULL,0),
('American Security Insurance Company',NULL,NULL,'800-326-2845',NULL,NULL,NULL,NULL,0),
('American Skyline Insurance Company',NULL,NULL,'888-298-5224',NULL,NULL,NULL,NULL,0),
('American States Insurance Company',NULL,NULL,'888-557-5010',NULL,NULL,NULL,NULL,0),
('American Strategic Insurance',NULL,NULL,'866-274-5677',NULL,NULL,NULL,NULL,0),
('American Superior Insurance',NULL,NULL,'954-577-2202',NULL,NULL,NULL,NULL,0),
('Arch Insurance',NULL,NULL,'800-817-3252',NULL,NULL,NULL,NULL,0),
('Argus Fire & Casualty',NULL,NULL,'866-291-4609',NULL,NULL,NULL,NULL,0),
('Armed Forces Insurance Exchange',NULL,NULL,'800-828-7736',NULL,NULL,NULL,NULL,0),
('Atlantic Mutual Insurance Company (New York Liquidation Bureau)',NULL,NULL,'212-341-6814',NULL,NULL,NULL,NULL,0),
('Atlantic Preferred Insurance Company',NULL,NULL,'800-673-4952',NULL,NULL,NULL,NULL,0),
('Auto Club Family Insurance Company (ACFIC)',NULL,NULL,'800-222-7623','5000',NULL,NULL,NULL,0),
('Auto Owners Insurance Group (Ft. Meyers)',NULL,NULL,'800-437-2256',NULL,NULL,NULL,NULL,0),
('Auto Owners Insurance Group (Palm City)',NULL,NULL,'800-783-1269',NULL,NULL,NULL,NULL,0),
('Avemco Insurance Company',NULL,NULL,'800-874-9124',NULL,NULL,NULL,NULL,0),
('AXA Re Property and Casualty',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('Bankers Insurance Company',NULL,NULL,'800-765-9700',NULL,NULL,NULL,NULL,0),
('Bankers Security Insurance Company',NULL,NULL,'800-765-9700',NULL,NULL,NULL,NULL,0),
('Berkley Mid-Atlantic Group',NULL,NULL,'866-262-4178',NULL,NULL,NULL,NULL,0),
('Bituminous',NULL,NULL,'800-475-4477',NULL,NULL,NULL,NULL,0),
('Bristol West Insurance Group',NULL,NULL,'800-274-7865',NULL,NULL,NULL,NULL,0),
('Capital Preferred',NULL,NULL,'800-734-4749',NULL,NULL,NULL,NULL,0),
('Capital Preferred',NULL,NULL,'888-388-2742',NULL,NULL,NULL,NULL,0),
('Catawba Insurance',NULL,NULL,'800-711-9386',NULL,NULL,NULL,NULL,0),
('Catlin US',NULL,NULL,'800-216-0652',NULL,NULL,NULL,NULL,0),
('Century Surety Insurance Company',NULL,NULL,'800-850-0432',NULL,NULL,NULL,NULL,0),
('Chartis Commercial and Personal',NULL,NULL,'877-399-6442',NULL,NULL,NULL,NULL,0),
('Chartis'' Private Client Group call',NULL,NULL,'888-760-9195',NULL,NULL,NULL,NULL,0),
('Chubb Group of Insurance Cos',NULL,NULL,'800-252-4670',NULL,NULL,NULL,NULL,0),
('Church Mutual Insurance',NULL,NULL,'800-554-2642',NULL,NULL,NULL,NULL,0),
('Cincinnati Insurance Company',NULL,NULL,'877-242-2544',NULL,NULL,NULL,NULL,0),
('Citizens Property Insurance Corp.',NULL,NULL,'866-411-2742',NULL,NULL,NULL,NULL,0),
('Clarendon National Insurance Company',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('Clarendon Select Insurance Company',NULL,NULL,'800-509-1592',NULL,NULL,NULL,NULL,0),
('CNA (First Notice Systems)',NULL,NULL,'877-262-2727',NULL,NULL,NULL,NULL,0),
('Coast National General Agency',NULL,NULL,'800-274-7865',NULL,NULL,NULL,NULL,0),
('Colony Insurance Company',NULL,NULL,'800-577-6614','1715',NULL,NULL,NULL,0),
('Colorado Casualty',NULL,NULL,'888-298-3778',NULL,NULL,NULL,NULL,0),
('Companion Property & Casualty',NULL,NULL,'800-649-2948',NULL,NULL,NULL,NULL,0),
('Connecticut FAIR Plan',NULL,NULL,'860-528-9546',NULL,NULL,NULL,NULL,0),
('Continental Western Insurance Company',NULL,NULL,'800-444-0049','2600',NULL,NULL,NULL,0),
('COUNTRY Financial',NULL,NULL,'866-COUNTRY',NULL,NULL,NULL,NULL,0),
('CUNA Mutual',NULL,NULL,'800-637-2676',NULL,NULL,NULL,NULL,0),
('Cypress',NULL,NULL,'888-352-9773',NULL,NULL,NULL,NULL,0),
('Dairyland Insurance Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Drive Insurance from Progressive',NULL,NULL,'800-925-2886',NULL,NULL,NULL,NULL,0),
('EMC Insurance Companies',NULL,NULL,'888-362-2255',NULL,NULL,NULL,NULL,0),
('Encompass Insurance Company',NULL,NULL,'800-588-7400',NULL,NULL,NULL,NULL,0),
('Erie Insurance Group',NULL,NULL,'800-367-3743',NULL,NULL,NULL,NULL,0),
('Farmers',NULL,NULL,'800-435-7764',NULL,NULL,NULL,NULL,0),
('Farmers: Spanish Language Line',NULL,NULL,'877-732-5266',NULL,NULL,NULL,NULL,0),
('FCCI',NULL,NULL,'800-226-3224',NULL,NULL,NULL,NULL,0),
('Federal Mutual',NULL,NULL,'888-333-4949',NULL,NULL,NULL,NULL,0),
('Federated National Insurance Company',NULL,NULL,'800-420-7075',NULL,NULL,NULL,NULL,0),
('FEMA',NULL,NULL,'800-427-4661',NULL,NULL,NULL,NULL,0),
('Fidelity & Casualty Insurance Company',NULL,NULL,'800-725-9472',NULL,NULL,NULL,NULL,0),
('Fidelity National Indemnity Insurance Company',NULL,NULL,'800-725-9472',NULL,NULL,NULL,NULL,0),
('Fidelity National Insurance Company',NULL,NULL,'800-220-1351',NULL,NULL,NULL,NULL,0),
('Fidelity National Property and Casualty Insurance Company',NULL,NULL,'800-725-9472',NULL,NULL,NULL,NULL,0),
('Fireman''s Fund',NULL,NULL,'888-347-3428',NULL,NULL,NULL,NULL,0),
('First Floridian',NULL,NULL,'800-252-4633',NULL,NULL,NULL,NULL,0),
('First Premium Insurance Group (Lloyd''s Mobile Home)',NULL,NULL,'800-432-3072',NULL,NULL,NULL,NULL,0),
('First Protective Insurance Company',NULL,NULL,'877-744-5224',NULL,NULL,NULL,NULL,0),
('First Trenton',NULL,NULL,'800-468-7341',NULL,NULL,NULL,NULL,0),
('Florida Department of Insurance',NULL,NULL,'800-342-2762',NULL,NULL,NULL,NULL,0),
('Florida Family Insurance Company',NULL,NULL,'888-486-4663',NULL,NULL,NULL,NULL,0),
('Florida Farm Bureau Insurance Companies',NULL,NULL,'800-330-3327',NULL,NULL,NULL,NULL,0),
('Florida Pennisula Insurance Company',NULL,NULL,'877-994-8368',NULL,NULL,NULL,NULL,0),
('Florida Preferred Property Insurance Company',NULL,NULL,'800-673-4952',NULL,NULL,NULL,NULL,0),
('Florida Select',NULL,NULL,'888-700-0101',NULL,NULL,NULL,NULL,0),
('FM Global',NULL,NULL,'877-639-5677',NULL,NULL,NULL,NULL,0),
('Foremost Insurance Company',NULL,NULL,'800-527-3907',NULL,NULL,NULL,NULL,0),
('Forest Insurance Facilities Inc.',NULL,NULL,'888-892-4381',NULL,NULL,NULL,NULL,0),
('GE Employers Re',NULL,NULL,'866-413-8978',NULL,NULL,NULL,NULL,0),
('GEICO',NULL,NULL,'800-841-3000',NULL,NULL,NULL,NULL,0),
('General Casualty (QBE)',NULL,NULL,'888-737-8256',NULL,NULL,NULL,NULL,0),
('General Star Indemnity Company',NULL,NULL,'800-624-5237',NULL,NULL,NULL,NULL,0),
('General Star National Insurance Company',NULL,NULL,'800-624-5237',NULL,NULL,NULL,NULL,0),
('Georgia Casualty & Surety',NULL,NULL,'800-279-8279',NULL,NULL,NULL,NULL,0),
('Georgia Farm Bureau',NULL,NULL,'866-842-3276',NULL,NULL,NULL,NULL,0),
('Germania Insurance',NULL,NULL,'877-437-6264',NULL,NULL,NULL,NULL,0),
('GMAC Insurance (Auto Claims)',NULL,NULL,'800-468-3466',NULL,NULL,NULL,NULL,0),
('Golden Eagle Insurance',NULL,NULL,'800-238-3085',NULL,NULL,NULL,NULL,0),
('Granada Insurance Company',NULL,NULL,'800-392-9966',NULL,NULL,NULL,NULL,0),
('Great American',NULL,NULL,'800-221-7274',NULL,NULL,NULL,NULL,0),
('Guardian Life Insurance Company of America',NULL,NULL,'866-367-4077',NULL,NULL,NULL,NULL,0),
('Guide One',NULL,NULL,'888-748-4326',NULL,NULL,NULL,NULL,0),
('Harbor Insurance Company',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('Harleysville Insurance',NULL,NULL,'800-892-8877',NULL,NULL,NULL,NULL,0),
('Hartford Steam',NULL,NULL,'800-HSB-LOSS',NULL,NULL,NULL,NULL,0),
('Holyoke Mutual',NULL,NULL,'800-225-2533',NULL,NULL,NULL,NULL,0),
('Horace Mann',NULL,NULL,'800-999-1030',NULL,NULL,NULL,NULL,0),
('Hull & Company',NULL,NULL,'800-241-4855',NULL,NULL,NULL,NULL,0),
('ICAT',NULL,NULL,'866-789-4228',NULL,NULL,NULL,NULL,0),
('IDS Life Insurance Company (Ameriprise Financial)',NULL,NULL,'800-862-7919',NULL,NULL,NULL,NULL,0),
('IDS Life Insurance Company of New York (Ameriprise Financial)',NULL,NULL,'800-541-2251',NULL,NULL,NULL,NULL,0),
('Imperial Fire & Casualty Insurance Company',NULL,NULL,'800-960-5677',NULL,NULL,NULL,NULL,0),
('Indiana Insurance',NULL,NULL,'800-279-7221',NULL,NULL,NULL,NULL,0),
('Industrial Risk Insurers',NULL,NULL,'860-520-7347',NULL,NULL,NULL,NULL,0),
('Infinity Insurance Companies',NULL,NULL,'800-334-1661',NULL,NULL,NULL,NULL,0),
('Insurance Placement Facility of Delaware',NULL,NULL,'800-462-4972',NULL,NULL,NULL,NULL,0),
('Insurance Placement Facility of Pennsylvania',NULL,NULL,'800-462-4972',NULL,NULL,NULL,NULL,0),
('Interstate Fire & Casualty',NULL,NULL,'800-456-8458','770',NULL,NULL,NULL,0),
('Kemper Auto and Home',NULL,NULL,'888-252-2799',NULL,NULL,NULL,NULL,0),
('Liberty Mutual Insurance',NULL,NULL,'800-225-2467',NULL,NULL,NULL,NULL,0),
('Liberty Northwest',NULL,NULL,'800-289-0930',NULL,NULL,NULL,NULL,0),
('Lloyd''s America Helpline',NULL,NULL,'866-264-2533',NULL,NULL,NULL,NULL,0),
('Louisiana Citizens Property Insurance Corporation',NULL,NULL,'800-931-9548',NULL,NULL,NULL,NULL,0),
('Louisiana Department of Insurance',NULL,NULL,'800-259-5300',NULL,NULL,NULL,NULL,0),
('Louisiana Farm Bureau',NULL,NULL,'866-275-7322',NULL,NULL,NULL,NULL,0),
('Main Street America Group',NULL,NULL,'877-282-3844',NULL,NULL,NULL,NULL,0),
('Maryland Joint Insurance Association',NULL,NULL,'800-492-5670',NULL,NULL,NULL,NULL,0),
('Massachusetts Bay Insurance Company',NULL,NULL,'800-628-0250',NULL,NULL,NULL,NULL,0),
('Massachusetts Property Insurance Underwriting Association',NULL,NULL,'800-851-8978',NULL,NULL,NULL,NULL,0),
('Mercury Insurance Group',NULL,NULL,'800-987-6000',NULL,NULL,NULL,NULL,0),
('MetLife Auto & Home',NULL,NULL,'800-854-6011',NULL,NULL,NULL,NULL,0),
('Middleoak Insurance',NULL,NULL,'800-225-2533','7',NULL,NULL,NULL,0),
('Middlesex Insurance Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Mississippi Farm Bureau',NULL,NULL,'866-275-7322',NULL,NULL,NULL,NULL,0),
('Mississippi Residential Property Insurance Association',NULL,NULL,'800-931-9548',NULL,NULL,NULL,NULL,0),
('Mississippi Windstorm Underwriting Association',NULL,NULL,'800-931-9548',NULL,NULL,NULL,NULL,0),
('Montgomery Insurance',NULL,NULL,'800-561-0178',NULL,NULL,NULL,NULL,0),
('MRN Homes of Georgia, LLC',NULL,NULL,'404-618-0771',NULL,NULL,NULL,NULL,0),
('National Automotive Insurance',NULL,NULL,'800-577-9471',NULL,NULL,NULL,NULL,0),
('National Casualty Company',NULL,NULL,'800-423-7675',NULL,NULL,NULL,NULL,0),
('National Farmers Union (QBE)',NULL,NULL,'866-638-5677',NULL,NULL,NULL,NULL,0),
('National Flood Insurance Program (NFIP)',NULL,NULL,'800-621-3362',NULL,NULL,NULL,NULL,0),
('National Insurance Company',NULL,NULL,'800-239-2121',NULL,NULL,NULL,NULL,0),
('Nationwide',NULL,NULL,'800-421-3535',NULL,NULL,NULL,NULL,0),
('New Jersey Insurance Underwriting Association',NULL,NULL,'973-297-5235',NULL,NULL,NULL,NULL,0),
('New York Property Insurance Underwriting Association',NULL,NULL,'212-208-9701',NULL,NULL,NULL,NULL,0),
('North Pointe Insurance Company',NULL,NULL,'877-878-1991',NULL,NULL,NULL,NULL,0),
('Ohio Casualty',NULL,NULL,'866-255-5530',NULL,NULL,NULL,NULL,0),
('Ohio Casualty and West American Insurance Company',NULL,NULL,'888-701-8727',NULL,NULL,NULL,NULL,0),
('Old Dominion Insurance Company',NULL,NULL,'877-425-2467',NULL,NULL,NULL,NULL,0),
('Omaha Property & Casualty',NULL,NULL,'800-638-2592',NULL,NULL,NULL,NULL,0),
('Omega Insurance Company',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('OneBeacon',NULL,NULL,'877-248-3455',NULL,NULL,NULL,NULL,0),
('Patriot General Insurance Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Peerless Insurance',NULL,NULL,'800-522-7152',NULL,NULL,NULL,NULL,0),
('Pharmacists Mutual Insurance Company',NULL,NULL,'800-247-5930',NULL,NULL,NULL,NULL,0),
('Poe Financial Group',NULL,NULL,'800-673-4952',NULL,NULL,NULL,NULL,0),
('Progressive',NULL,NULL,'800-776-4737',NULL,NULL,NULL,NULL,0),
('QBE Agri',NULL,NULL,'800-777-0078',NULL,NULL,NULL,NULL,0),
('QualSure Insurance Corp.',NULL,NULL,'877-563-0150',NULL,NULL,NULL,NULL,0),
('Regency (Tower Hill)',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('Republic Fire & Casualty',NULL,NULL,'800-451-0286',NULL,NULL,NULL,NULL,0),
('Republic Group',NULL,NULL,'800-451-0286',NULL,NULL,NULL,NULL,0),
('Republic Underwriters',NULL,NULL,'800-451-0286',NULL,NULL,NULL,NULL,0),
('Rhode Island Joint Reinsurance Association',NULL,NULL,'800-851-8978',NULL,NULL,NULL,NULL,0),
('RLI Insurance Company',NULL,NULL,'800-444-0406',NULL,NULL,NULL,NULL,0),
('Royal & SunAlliance',NULL,NULL,'800-847-6925',NULL,NULL,NULL,NULL,0),
('Safeco Insurance',NULL,NULL,'800-332-3226',NULL,NULL,NULL,NULL,0),
('Safeway Insurance Company',NULL,NULL,'800-252-3251',NULL,NULL,NULL,NULL,0),
('Scottsdale Insurance Company',NULL,NULL,'800-423-7675',NULL,NULL,NULL,NULL,0),
('Security National Insurance Company',NULL,NULL,'800-274-7865',NULL,NULL,NULL,NULL,0),
('Selective',NULL,NULL,'866-455-9969',NULL,NULL,NULL,NULL,0),
('Sentry Casualty Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Sentry Insurance a Mutual Company',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Sentry Life Insurance Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Sentry Select Insurance Company (see Sentry Insurance)',NULL,NULL,'800-638-8763',NULL,NULL,NULL,NULL,0),
('Service Insurance Company',NULL,NULL,'800-780-8423',NULL,NULL,NULL,NULL,0),
('Shelter Insurance Group',NULL,NULL,'800-743-5837',NULL,NULL,NULL,NULL,0),
('Sompo Japan',NULL,NULL,'800-444-6870',NULL,NULL,NULL,NULL,0),
('South Carolina Wind & Hail Association',NULL,NULL,'803-744-4319',NULL,NULL,NULL,NULL,0),
('Southern Family Insurance Company',NULL,NULL,'800-673-4952',NULL,NULL,NULL,NULL,0),
('Southern Fidelity',NULL,NULL,'866-874-7342',NULL,NULL,NULL,NULL,0),
('Southern Insurance Company',NULL,NULL,'800-451-0286',NULL,NULL,NULL,NULL,0),
('Southern Underwriters',NULL,NULL,'800-451-0286',NULL,NULL,NULL,NULL,0),
('Southwest Business Corp.',NULL,NULL,'800-527-0066','7389',NULL,NULL,NULL,0),
('St. Johns Insurance Company',NULL,NULL,'800-748-2030',NULL,NULL,NULL,NULL,0),
('State Farm Insurance',NULL,NULL,'800-732-5246',NULL,NULL,NULL,NULL,0),
('Sunshine State Insurance Company',NULL,NULL,'877-329-8795',NULL,NULL,NULL,NULL,0),
('TAPCO',NULL,NULL,'888-437-0373',NULL,NULL,NULL,NULL,0),
('Texas Department of Insurance Consumer Help Line',NULL,NULL,'800-252-3439',NULL,NULL,NULL,NULL,0),
('Texas Farm Bureau',NULL,NULL,'800-266-5458',NULL,NULL,NULL,NULL,0),
('Texas Select Lloyds Insurance Company',NULL,NULL,'866-887-7276',NULL,NULL,NULL,NULL,0),
('Texas Windstorm Insurance Association',NULL,NULL,'800-788-8247',NULL,NULL,NULL,NULL,0),
('The Hanover Insurance Company',NULL,NULL,'800-628-0250',NULL,NULL,NULL,NULL,0),
('The Hartford',NULL,NULL,'800-243-5860',NULL,NULL,NULL,NULL,0),
('The Timbermen Fund',NULL,NULL,'877-628-6730',NULL,NULL,NULL,NULL,0),
('Tower Hill Insurance Companies',NULL,NULL,'800-216-3711',NULL,NULL,NULL,NULL,0),
('Travelers Business Insurance',NULL,NULL,'800-238-6225',NULL,NULL,NULL,NULL,0),
('Travelers Personal Insurance',NULL,NULL,'800-252-4633',NULL,NULL,NULL,NULL,0),
('Unemployment Insurance',NULL,NULL,'866-432-0264',NULL,NULL,NULL,NULL,0),
('Unigard (QBE)',NULL,NULL,'800-777-0078',NULL,NULL,NULL,NULL,0),
('Union Insurance Company',NULL,NULL,'800-444-0049','2600',NULL,NULL,NULL,0),
('United Fire Insurance Company',NULL,NULL,'800-343-9131',NULL,NULL,NULL,NULL,0),
('United Property and Casualty Company',NULL,NULL,'800-861-4370',NULL,NULL,NULL,NULL,0),
('Universal Insurance Company',NULL,NULL,'888-846-7647',NULL,NULL,NULL,NULL,0),
('USAA',NULL,NULL,'800-531-8722',NULL,NULL,NULL,NULL,0),
('USF&G',NULL,NULL,'800-631-6478',NULL,NULL,NULL,NULL,0),
('USLI',NULL,NULL,'800-523-5545',NULL,NULL,NULL,NULL,0),
('Utica National',NULL,NULL,'800-216-1420',NULL,NULL,NULL,NULL,0),
('Valley Forge Life Insurance (Subsidiary of CNA)',NULL,NULL,'800-437-8854',NULL,NULL,NULL,NULL,0),
('Vanguard Fire & Casualty Company',NULL,NULL,'888-343-5585',NULL,NULL,NULL,NULL,0),
('Virginia Property Insurance Association',NULL,NULL,'804-591-3700',NULL,NULL,NULL,NULL,0),
('Westfield Insurance',NULL,NULL,'866-937-2663',NULL,NULL,NULL,NULL,0),
('Willis Group',NULL,NULL,'877-725-9679',NULL,NULL,NULL,NULL,0),
('XL Insurance',NULL,NULL,'800-688-1840',NULL,NULL,NULL,NULL,0),
('Zenith',NULL,NULL,'800-440-5020',NULL,NULL,NULL,NULL,0),
('Zurich Insurance Company',NULL,NULL,'800-987-3373',NULL,NULL,NULL,NULL,0)
