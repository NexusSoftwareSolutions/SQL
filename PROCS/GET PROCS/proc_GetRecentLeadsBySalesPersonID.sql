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
-- Description:	Retrieve all Leads from the past 60 days by SalesPersonID
-- =============================================
CREATE PROCEDURE proc_GetRecentLeadsBySalesPersonID 
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
				FROM Leads;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT SalesPersonID FROM Leads WHERE SalesPersonID = @SalesPersonID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Leads in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
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
					WHERE SalesPersonID = @SalesPersonID
					AND LeadDate > DATEADD(DAY, -60, GETDATE())
				END
		END
END
GO
