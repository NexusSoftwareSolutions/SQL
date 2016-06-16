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
-- Description:	Updates a record in the OrderItems table by OrderItemID
-- =============================================
ALTER PROCEDURE proc_UpdateOrderItem
	-- Add the parameters for the stored procedure here
	@OrderItemID int,
	@ProductID int,
	@UnitOfMeasureID int,
	@Quantity int,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT OrderItemID FROM OrderItems
				WHERE OrderItemID = @OrderItemID)
			BEGIN
				UPDATE OrderItems
				SET ProductID = @ProductID,
					UnitOfMeasureID = @UnitOfMeasureID,
					Quantity = @Quantity
				WHERE OrderItemID = @OrderItemID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Order Items list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

