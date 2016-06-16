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
-- Description:	Adds a new Payment
-- =============================================
ALTER PROCEDURE proc_AddPayment
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@PaymentTypeID int,
	@PaymentDescriptionID int,
	@Amount float,
	@PaymentDate datetime,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT PaymentID FROM Payments
					WHERE PaymentTypeID = @PaymentTypeID
					AND Amount = @Amount
					AND PaymentDate = @PaymentDate)
		BEGIN
			INSERT INTO Payments
							(ClaimID,
							PaymentTypeID,
							PaymentDescriptionID,
							Amount,
							PaymentDate)
			VALUES
				(@ClaimID,
				@PaymentTypeID,
				@PaymentDescriptionID,
				@Amount,
				@PaymentDate);

			SET @new_identity = IDENT_CURRENT('Payments');
		END
	ELSE
		BEGIN
			BEGIN TRY
					THROW 51000, 'This payment is already in the system.', 16;
				END TRY
				BEGIN CATCH
					THROW;
			END CATCH
		END
END
GO

