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
-- Description:	Updates a record in the Vendors table by VendorID
-- =============================================
ALTER PROCEDURE proc_UpdateVendor
	-- Add the parameters for the stored procedure here
	@VendorID int,
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

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT VendorID FROM Vendors
				WHERE VendorID = @VendorID)
			BEGIN
				UPDATE Vendors
				SET VendorTypeID = @VendorTypeID,
					CompanyName = @CompanyName,
					EIN = @EIN,
					ContactFirstName = @ContactFirstName,
					ContactLastName = @ContactLastName,
					Suffix = @Suffix,
					VendorAddress = @VendorAddress,
					Zip = @Zip,
					Phone = @Phone,
					CompanyPhone = @CompanyPhone,
					Fax = @Fax,
					Email = @Email,
					Website = @Website,
					GeneralLiabilityExpiration = @GeneralLiabilityExpiration
				WHERE VendorID = @VendorID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Vendors list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

