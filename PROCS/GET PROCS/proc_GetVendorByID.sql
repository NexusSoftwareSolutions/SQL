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
-- Description:	Get Vendor by VendorID
-- =============================================
ALTER PROCEDURE proc_GetVendorByID
	-- Add the parameters for the stored procedure here
	@VendorID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @VendorID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  VendorID,
					VendorTypeID,
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
					GeneralLiabilityExpiration
				FROM Vendors;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT VendorID FROM Vendors
							WHERE VendorID = @VendorID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Vendors in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  VendorID,
							VendorTypeID,
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
							GeneralLiabilityExpiration
						FROM Vendors
					WHERE VendorID = @VendorID;
				END
		END
END
GO
