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
-- Create date: 6/2/2016
-- Description:	Returns all leads that do not have a claim attached.
-- =============================================
ALTER PROCEDURE proc_GetLeadsWithNoClaim
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	SELECT	LeadID,
			LeadTypeID,
			KnockerResponseID,
			SalesPersonID,
			CustomerID,
			AddressID,
			LeadDate,
			Status,
			CreditToID,
			Temperature
	FROM Leads
	WHERE LeadID NOT IN (SELECT LeadID FROM Claims);
END
GO



