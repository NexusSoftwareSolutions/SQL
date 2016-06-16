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
-- Description:	Gets Leads by Status and SalesPersonID
-- =============================================
ALTER PROCEDURE proc_GetLeadsByStatus
	-- Add the parameters for the stored procedure here
	@Status char(1),
	@SalesPersonID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @Status is null
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
			RETURN;
		END
	ELSE IF @SalesPersonID is null
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
			WHERE Status = @Status;
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
					WHERE Status = @Status
					AND SalesPersonID = @SalesPersonID;
				END
		END
END
