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
-- Create date: 4/28/2016
-- Description:	Updates a record in the Invoices table by InvoiceID
-- =============================================
ALTER PROCEDURE proc_UpdateInvoice
	-- Add the parameters for the stored procedure here
	@InvoiceID int,
	@InvoiceTypeID int,
	@InvoiceAmount float,
	@InvoiceDate datetime,
	@Paid bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT InvoiceID FROM Invoices
				WHERE InvoiceID = @InvoiceID)
			BEGIN
				UPDATE Invoices
				SET InvoiceTypeID = @InvoiceTypeID,
					InvoiceAmount = @InvoiceAmount,
					InvoiceDate = @InvoiceDate,
					Paid = @Paid
				WHERE InvoiceID = @InvoiceID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in Invoices for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

