USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_GetSumOfPaymentsByClaimID]    Script Date: 4/27/2016 12:39:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maggie Seigler
-- Create date: 4/26/2016
-- Description:	Get Sum of Payments by ClaimID
-- =============================================
ALTER PROCEDURE proc_GetSumOfPaymentsByClaimID
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
	IF NOT EXISTS (SELECT PaymentID FROM Payments
					WHERE ClaimID = @ClaimID)
		BEGIN
			BEGIN TRY
					THROW 51000, 'There are no Payments in the system for the ID provided.', 16;
			END TRY
			BEGIN CATCH
					THROW;
			END CATCH
		END
	ELSE
		BEGIN
			SET @result = (SELECT SUM(Amount) FROM Payments
							WHERE ClaimID = @ClaimID);
		END

END
