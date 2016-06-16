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
-- Create date: 4/25/2016
-- Description:	Adds a OrderItem record
-- =============================================
ALTER PROCEDURE proc_AddOrderItem
	-- Add the parameters for the stored procedure here
	@OrderID int,
	@ProductID int,
	@UnitOfMeasureID int,
	@Quantity int,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT OrderItemID FROM OrderItems 
					WHERE OrderID = @OrderID
					AND ProductID = @ProductID
					AND Quantity = @Quantity)
		BEGIN
			INSERT INTO OrderItems 
				(OrderID,
				ProductID,
				UnitOfMeasureID,
				Quantity)
			VALUES 
				(@OrderID,
				@ProductID,
				@UnitOfMeasureID,
				@Quantity);
		
			SET @new_identity = IDENT_CURRENT('OrderItems');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'That Order Item already exists in that Order.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
