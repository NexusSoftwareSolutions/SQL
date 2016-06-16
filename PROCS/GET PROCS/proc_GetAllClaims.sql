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
-- Create date: 4/29/2016
-- Description:	Returns Claims table
-- =============================================
ALTER PROCEDURE proc_GetAllClaims
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
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
END
GO


