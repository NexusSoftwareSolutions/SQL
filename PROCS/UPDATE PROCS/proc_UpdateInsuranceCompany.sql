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
-- Create date: 4/28/2016
-- Description:	Updates a record in the InsuranceCompanies table by InsuranceCompanyID
-- =============================================
ALTER PROCEDURE proc_UpdateInsuranceCompany
	-- Add the parameters for the stored procedure here
	@InsuranceCompanyID int,
	@CompanyName varchar(255),
	@Address varchar(100) = null,
	@Zip varchar(10) = null,
	@ClaimPhoneNumber varchar(12),
	@ClaimPhoneExt varchar(10) = null,
	@FaxNumber varchar(12) = null,
	@FaxExt varchar(10) = null,
	@Email varchar(100) = null,
	@Independent bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT InsuranceCompanyID FROM InsuranceCompanies
				WHERE InsuranceCompanyID = @InsuranceCompanyID)
			BEGIN
				UPDATE InsuranceCompanies
				SET CompanyName = @CompanyName,
					Address = @Address,
					Zip = @Zip,
					ClaimPhoneNumber = @ClaimPhoneNumber,
					ClaimPhoneExt = @ClaimPhoneExt,
					FaxNumber = @FaxNumber,
					FaxExt = @FaxExt,
					Email = @Email,
					Independent = @Independent
				WHERE InsuranceCompanyID = @InsuranceCompanyID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Insurance Companies list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

