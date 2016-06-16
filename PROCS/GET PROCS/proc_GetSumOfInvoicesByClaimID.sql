USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_GetSumOfInvoicesByClaimID]    Script Date: 4/27/2016 12:38:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maggie Seigler
-- Create date: 4/26/2016
-- Description:	Get Sum of Invoices by ClaimID
-- =============================================
ALTER PROCEDURE proc_GetSumOfInvoicesByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int,

	@result float = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here

	IF NOT EXISTS (SELECT InvoiceID FROM Invoices
					WHERE ClaimID = @ClaimID)
		BEGIN
			BEGIN TRY
					THROW 51000, 'There are no Invoices in the system for the ID provided.', 16;
			END TRY
			BEGIN CATCH
					THROW;
			END CATCH
		END
	ELSE
		BEGIN
			SET @result = (SELECT SUM(InvoiceAmount) FROM Invoices
							WHERE ClaimID = @ClaimID);
		END
END
