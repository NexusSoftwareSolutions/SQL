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
-- Create date: 5/4/2016
-- Description:	Adds a Vendor record
-- =============================================
ALTER PROCEDURE proc_AddVendor
	-- Add the parameters for the stored procedure here
	@VendorTypeID int,
	@CompanyName varchar(100),
	@EIN varchar(10) = null,
	@ContactFirstName varchar(50),
	@ContactLastName varchar(50) = null,
	@Suffix varchar(10) = null,
	@VendorAddress varchar(100) = null,
	@Zip varchar(10) = null,
	@Phone varchar(12),
	@CompanyPhone varchar(12) = null,
	@Fax varchar(12) = null,
	@Email varchar(50),
	@Website varchar(50) = null,
	@GeneralLiabilityExpiration datetime = null,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT VendorID FROM Vendors 
					WHERE VendorTypeID = @VendorTypeID
					AND CompanyName = @CompanyName
					AND Phone = @Phone
					AND Email = @Email)
		BEGIN
			INSERT INTO Vendors 
				(VendorTypeID,
				CompanyName,
				EIN,
				ContactFirstName,
				ContactLastName,
				Suffix,
				VendorAddress,
				Zip,
				Phone,
				CompanyPhone,
				Fax,
				Email,
				Website,
				GeneralLiabilityExpiration)
			VALUES 
				(@VendorTypeID,
				@CompanyName,
				@EIN,
				@ContactFirstName,
				@ContactLastName,
				@Suffix,
				@VendorAddress,
				@Zip,
				@Phone,
				@CompanyPhone,
				@Fax,
				@Email,
				@Website,
				@GeneralLiabilityExpiration);
		
			SET @new_identity = IDENT_CURRENT('Vendors');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'That Vendor already exists in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
