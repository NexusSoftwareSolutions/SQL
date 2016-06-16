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
-- Author:		Alyssa Harvey
-- Create date: 6/15/2016
-- Description:	Retrieve all Claims from the past 60 days by SalesPersonID
-- =============================================
ALTER PROCEDURE proc_GetRecentClaimsBySalesPersonID 
	-- Add the parameters for the stored procedure here
	@SalesPersonID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	IF(@SalesPersonID IS NULL)
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
			IF NOT EXISTS (SELECT SalesPersonID FROM Leads WHERE SalesPersonID = @SalesPersonID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Claims in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	c.ClaimID,
							c.CustomerID,
							c.LeadID,
							c.BillingID,
							c.PropertyID,
							c.InsuranceCompanyID,
							c.InsuranceClaimNumber,
							c.MRNNumber,
							c.LossDate,
							c.MortgageCompany,
							c.MortgageAccount,
							c.IsOpen,
							c.ContractSigned
					FROM Claims c
					JOIN Lead l ON c.LeadID = l.LeadID
					WHERE l.SalesPersonID = @SalesPersonID
					AND l.LeadDate > DATEADD(DAY, -60, GETDATE())
				END
		END
END
GO
