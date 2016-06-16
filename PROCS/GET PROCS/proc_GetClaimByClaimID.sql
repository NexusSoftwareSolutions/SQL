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
-- Create date: 4/20/2016
-- Description:	Gets a Claim by the ClaimID
-- =============================================
ALTER PROCEDURE proc_GetClaimByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ClaimID is null
		BEGIN
			SET FMTONLY ON;
			SELECT	ClaimID,
					CustomerID,
					LeadID,
					BillingID,
					PropertyID,
					InsuranceCompanyID,
					InsuranceClaimNumber,
					MRNNumber,
					LossDate,
					MortgageCompany,
					MortgageAccount,
					IsOpen,
					ContractSigned
				FROM Claims;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ClaimID FROM Claims 
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Claim in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	ClaimID,
							CustomerID,
							LeadID,
							BillingID,
							PropertyID,
							InsuranceCompanyID,
							InsuranceClaimNumber,
							MRNNumber,
							LossDate,
							MortgageCompany,
							MortgageAccount,
							IsOpen,
							ContractSigned
						FROM Claims
					WHERE ClaimID = @ClaimID;
				END
		END
END
GO


