--foreign keys

	--Addresses
alter table Leads
add constraint FK_Leads_AddressID
foreign key (AddressID)
references Addresses(AddressID)

alter table Claims
add constraint FK_Claims_BillingID
foreign key (BillingID)
references Addresses(AddressID)

alter table Claims
add constraint FK_Claims_PropertyID
foreign key (PropertyID)
references Addresses(AddressID)

	--Adjuster
alter table Adjustments
add constraint FK_Adjustments_AdjusterID
foreign key (AdjusterID)
references Adjusters(AdjusterID)

alter table ClaimContacts
add constraint FK_ClaimContacts_AdjusterID
foreign key (AdjusterID)
references Adjusters(AdjusterID)

	--AdjustmentResults
alter table Adjustments
add constraint FK_Adjustments_AdjustmentResultID
foreign key(AdjustmentResultID)
references LU_AdjustmentResults(AdjustmentResultID)

	--AppointmentType
alter table CalendarData
add constraint FK_CalendarData_AppointmentType
foreign key (AppointmentTypeID)
references LU_AppointmentTypes(AppointmentTypeID)

	--Claims
alter table ClaimContacts
add constraint FK_ClaimContacts_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Orders
add constraint FK_Orders_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Adjustments
add constraint FK_Adjustments_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table AdditionalSupplies
add constraint FK_AdditionalSupplies_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table SurplusSupplies
add constraint FK_SurplusSupplies_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table ClaimDocuments
add constraint FK_ClaimDocuments_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Invoices
add constraint FK_Invoices_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table NewRoofs
add constraint FK_NewRoofs_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table ClaimStatuses
add constraint FK_ClaimStatuses_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table CalendarData
add constraint FK_CalendarData_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Scopes
add constraint FK_Scopes_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table ClaimVendors
add constraint FK_ClaimVendors_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Inspections
add constraint FK_Inspections_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table CallLogs
add constraint FK_CallLogs_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

alter table Payments
add constraint FK_Payments_ClaimID
foreign key (ClaimID)
references Claims(ClaimID)

	--ClaimDocType
alter table ClaimDocuments
add constraint FK_ClaimDocuments_DocTypeID
foreign key(DocTypeID)
references LU_ClaimDocumentTypes(ClaimDocumentTypeID)

	--ClaimDocuments
alter table Damages
add constraint FK_Damages_DocumentID
foreign key (DocumentID)
references ClaimDocuments(DocumentID)

	--ClaimStatusTypes
alter table ClaimStatuses
add constraint FK_ClaimStatuses_ClaimStatusTypeID
foreign key(ClaimStatusTypeID)
references LU_ClaimStatusTypes(ClaimStatusTypeID)

	--Customers
alter table Leads
add constraint FK_Leads_CustomerID
foreign key (CustomerID)
references Customers(CustomerID)

alter table Claims
add constraint FK_Claims_CustomerID
foreign key (CustomerID)
references Customers(CustomerID)

alter table ClaimContacts
add constraint FK_ClaimContacts_CustomerID
foreign key (CustomerID)
references Customers(CustomerID)

alter table Addresses
add constraint FK_Addresses_CustomerID
foreign key (CustomerID)
references Customers(CustomerID)

	--DamageTypes
alter table Damages
add constraint FK_Damages_DamageTypeID
foreign key (DamageTypeID)
references LU_DamageTypes(DamageTypeID)

	--Employees
alter table Users
add constraint FK_Users_EmployeeID
foreign key (EmployeeID)
references Employees(EmployeeID)

alter table Users
add constraint FK_Users_PermissionID
foreign key (PermissionID)
references LU_Permissions(PermissionID)

alter table CallLogs
add constraint FK_CallLog_EmployeeID
foreign key (EmployeeID)
references Employees(EmployeeID)

alter table CalendarData
add constraint FK_CalendarData_EmployeeID
foreign key (EmployeeID)
references Employees(EmployeeID)

alter table KnockerResponses
add constraint FK_KnockerResponses_KnockerID
foreign key (KnockerID)
references Employees(EmployeeID)

alter table EmployeeDetails
add constraint FK_EmployeeDetails_EmployeeID
foreign key (EmployeeID)
references Employees(EmployeeID)

alter table ClaimContacts
add constraint FK_ClaimContacts_KnockerID
foreign key (KnockerID)
references Employees(EmployeeID)

alter table ClaimContacts
add constraint FK_ClaimContacts_SalesPersonID
foreign key (SalesPersonID)
references Employees(EmployeeID)

alter table ClaimContacts
add constraint FK_ClaimContacts_SupervisorID
foreign key (SupervisorID)
references Employees(EmployeeID)

alter table ClaimContacts
add constraint FK_ClaimContacts_SalesManagerID
foreign key (SalesManagerID)
references Employees(EmployeeID)

alter table Leads
add constraint FK_Leads_SalesPersonID
foreign key (SalesPersonID)
references Employees(EmployeeID)

	--EmployeeType
alter table Employees
add constraint FK_Employees_EmployeeTypeID
foreign key (EmployeeTypeID)
references LU_EmployeeTypes(EmployeeTypeID)

	--Inspections


	--InsuranceCompany
alter table Adjusters
add constraint FK_Adjusters_InsuranceCompanyID
foreign key (InsuranceCompanyID)
references InsuranceCompanies(InsuranceCompanyID)

alter table Claims
add constraint FK_Claims_InsuranceCompanyID
foreign key (InsuranceCompanyID)
references InsuranceCompanies(InsuranceCompanyID)

	--Invoices


	--InvoiceType
alter table Invoices
add constraint FK_Invoices_InvoiceTypeID
foreign key(InvoiceTypeID)
references LU_InvoiceTypes(InvoiceTypeID)

	--KnockResponseTypes
alter table KnockerResponses
add constraint FK_KnockerResponse_ResponseTypeID
foreign key(KnockResponseTypeID)
references LU_KnockResponseTypes(KnockResponseTypeID)

	--KnockerResponses
alter table Leads
add constraint FK_Leads_KnockerResponseID
foreign key (KnockerResponseID)
references KnockerResponses(KnockerResponseID)

	--Leads
alter table CalendarData
add constraint FK_CalendarData_LeadID
foreign key (LeadID)
references Leads(LeadID)

alter table Claims
add constraint FK_Claims_LeadID
foreign key (LeadID)
references Leads(LeadID)

	--LeadTypes
alter table Leads
add constraint FK_Leads_LeadTypeID
foreign key(LeadTypeID)
references LU_LeadTypes(LeadTypeID)

	--Order
alter table OrderItems
add constraint FL_OrderItems_OrderID
foreign key (OrderID)
references Orders(OrderID)

	--PaymentDescription
alter table Payments
add constraint FK_Payments_PaymentDescriptionID
foreign key (PaymentDescriptionID)
references LU_PaymentDescriptions(PaymentDescriptionID)

	--PayFrequency
alter table EmployeeDetails
add constraint FK_EmployeeDetails_PayFrequencyID
foreign key (PayFrequencyID)
references LU_PayFrequencies(PayFrequencyID)

	--PayTypes
alter table EmployeeDetails
add constraint FK_EmployeeDetails_PayTypeID
foreign key (PayTypeID)
references LU_PayTypes(PayTypeID)

	--PaymentType
alter table Payments
add constraint FK_Payments_PaymentTypeID
foreign key (PaymentTypeID)
references LU_PaymentTypes(PaymentTypeID)

	--Planes
alter table Planes
add constraint FK_Planes_InspectionID
foreign key (InspectionID)
references Inspections(InspectionID)

alter table Damages
add constraint FK_Damages_PlaneID
foreign key (PlaneID)
references Planes(PlaneID)

	--PlaneTypes
alter table Planes
add constraint FK_Planes_PlaneTypeID
foreign key (PlaneTypeID)
references LU_PlaneTypes(PlaneTypeID)

	--Products
alter table OrderItems
add constraint FK_OrderItems_ProductID
foreign key (ProductID)
references LU_Products(ProductID)

alter table NewRoofs
add constraint FK_NewRoofs_ProductID
foreign key (ProductID)
references LU_Products(ProductID)

	--ProductType
alter table LU_Products
add constraint FK_Products_ProductTypeID
foreign key (ProductTypeID)
references LU_ProductTypes(ProductTypeID)

	--RidgeMaterialTypes
alter table Inspections
add constraint FK_Inspections_RidgeMaterialTypeID
foreign key (RidgeMaterialTypeID)
references LU_RidgeMaterialTypes

	--ScopeTypes
alter table Scopes
add constraint FK_Scopes_ScopeTypeID
foreign key(ScopeTypeID)
references LU_ScopeTypes(ScopeTypeID)

	--ServiceTypes
alter table ClaimVendors
add constraint FK_ClaimVendors_ServiceTypeID
foreign key (ServiceTypeID)
references LU_ServiceTypes(ServiceTypeID)

	--ShingleTypes
alter table Inspections
add constraint FK_Inspections_ShingleTypeID
foreign key (ShingleTypeID)
references LU_ShingleTypes(ShingleTypeID)

	--Vendors
alter table ClaimVendors
add constraint FK_ClaimVendors_VendorID
foreign key (VendorID)
references Vendors(VendorID)

alter table Orders
add constraint FK_Orders_VendorID
foreign key (VendorID)
references Vendors(VendorID)

alter table LU_Products
add constraint FK_Products_VendorID
foreign key (VendorID)
references Vendors(VendorID)

alter table Invoices
add constraint FK_Invoices_VendorID
foreign key (VendorID)
references Vendors(VendorID)

	--UnitOfMeasure
alter table OrderItems
add constraint FK_OrderItems_UnitOfMeasureID
foreign key (UnitOfMeasureID)
references LU_UnitOfMeasures(UnitOfMeasureID)

alter table SurplusSupplies
add constraint FK_SurplusSupplies_UnitOfMeasureID
foreign key (UnitOfMeasureID)
references LU_UnitOfMeasures(UnitOfMeasureID)

	--VendorTypes
alter table Vendors
add constraint FK_Vendors_VendorTypeID
foreign key (VendorTypeID)
references LU_VendorTypes(VendorTypeID)
