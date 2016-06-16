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
-- Create date: 4/27/2016
-- Description:	Updates a record in the Claims table by ClaimID
-- =============================================
ALTER PROCEDURE proc_UpdateClaim
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@CustomerID int,
	@BillingID int,
	@PropertyID int,
	@InsuranceCompanyID int,
	@InsuranceClaimNumber varchar(255),
	@LossDate datetime,
	@MortgageCompany varchar(50),
	@MortgageAccount varchar(50),
	@ContractSigned bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ClaimID FROM Claims
				WHERE ClaimID = @ClaimID)
			BEGIN
				UPDATE Claims
				SET CustomerID = @CustomerID,
					BillingID = @BillingID,
					PropertyID = @PropertyID,
					InsuranceCompanyID = @InsuranceCompanyID,
					InsuranceClaimNumber = @InsuranceClaimNumber,
					LossDate = @LossDate,
					MortgageCompany = @MortgageCompany,
					MortgageAccount = @MortgageAccount,
					ContractSigned = @ContractSigned
				WHERE ClaimID = @ClaimID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in Claims for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

