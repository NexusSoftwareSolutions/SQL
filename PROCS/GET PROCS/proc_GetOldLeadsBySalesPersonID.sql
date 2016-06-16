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
-- Create date: 6/3/2016
-- Description:	Gets Active Leads older than specified number of days by SalesPersonID
-- =============================================
ALTER PROCEDURE proc_GetOldLeadsBySalesPersonID
	-- Add the parameters for the stored procedure here
	@NumberOfDays int,
	@SalesPersonID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @NumberOfDays is null OR @SalesPersonID is null
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
					WHERE Status = 'A'
					AND SalesPersonID = @SalesPersonID
					AND LeadDate < DATEADD(DAY, -@NumberOfDays, GETDATE());
				END
		END
END
