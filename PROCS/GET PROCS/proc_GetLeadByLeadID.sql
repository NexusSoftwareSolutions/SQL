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
-- Create date: 4/11/2016
-- Description:	Gets Lead by LeadID
-- =============================================
ALTER PROCEDURE proc_GetLeadByLeadID
	-- Add the parameters for the stored procedure here
	@LeadID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @LeadID is null
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
			IF NOT EXISTS (SELECT LeadID FROM Leads
							WHERE LeadID = @LeadID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Lead in the system for the ID provided.', 16;
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
					WHERE LeadID = @LeadID;
				END
		END
END
GO

