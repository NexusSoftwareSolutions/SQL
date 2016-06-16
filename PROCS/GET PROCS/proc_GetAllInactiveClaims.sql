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
-- Create date: 5/12/2016
-- Description:	Returns All Inactive Claims (Claims older than 10 days)
-- =============================================
ALTER PROCEDURE proc_GetAllInactiveClaims
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	SELECT  c.ClaimID,
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
	JOIN ClaimStatuses cs ON c.ClaimID = cs.ClaimID
	WHERE c.IsOpen = 1
	GROUP BY c.ClaimID, 
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
	HAVING (SELECT MAX(ClaimStatusDate) FROM ClaimStatuses 
			WHERE ClaimID = c.ClaimID) < DATEADD(DAY,-10, GETDATE())
	ORDER BY c.ClaimID;
END
GO



