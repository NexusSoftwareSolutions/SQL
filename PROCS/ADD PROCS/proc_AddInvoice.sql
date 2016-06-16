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
-- Create date: 4/25/2016
-- Description:	Adds a new Invoice
-- =============================================
ALTER PROCEDURE proc_AddInvoice
	-- Add the parameters for the stored procedure here
	@ClaimID int,
    @InvoiceTypeID int,
    @InvoiceAmount float,
    @InvoiceDate datetime,
    @Paid bit,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT InvoiceID FROM Invoices
					WHERE ClaimID = @ClaimID
					AND InvoiceTypeID = @InvoiceTypeID
					AND InvoiceAmount = @InvoiceAmount
					AND InvoiceDate = @InvoiceDate)
		BEGIN
			INSERT INTO Invoices
					(ClaimID,
					InvoiceTypeID,
					InvoiceAmount,
					InvoiceDate,
					Paid)
			VALUES
				(@ClaimID,
				@InvoiceTypeID,
				@InvoiceAmount,
				@InvoiceDate,
				@Paid);
	
			SET @new_identity = IDENT_CURRENT('Invoices');
		END
	ELSE
		BEGIN
			BEGIN TRY
					THROW 51000, 'This invoice already exists in the system.', 16;
				END TRY
				BEGIN CATCH
					THROW;
			END CATCH
		END
END
GO
