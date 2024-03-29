USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_GetLeadsBySalespersonID]    Script Date: 4/25/2016 9:26:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Padgett
-- Create date: 4/22/2016
-- Description:	Gets a Lead by the SalesPerson's ID
-- =============================================
ALTER PROCEDURE proc_GetLeadsBySalesPersonID
	-- Add the parameters for the stored procedure here
	@SalesPersonID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @SalesPersonID is null
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
			IF NOT EXISTS (SELECT SalesPersonID FROM Leads
							WHERE SalesPersonID = @SalesPersonID)
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
					WHERE SalesPersonID = @SalesPersonID;
				END
		END
END
