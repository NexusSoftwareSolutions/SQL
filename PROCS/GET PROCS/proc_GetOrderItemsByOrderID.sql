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
-- Create date: 4/26/2016
-- Description:	Get OrderItems by OrderID
-- =============================================
ALTER PROCEDURE proc_GetOrderItemsByOrderID
	-- Add the parameters for the stored procedure here
	@OrderID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @OrderID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  OrderItemID,
					OrderID,
					ProductID,
					UnitOfMeasureID,
					Quantity
				FROM OrderItems;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT OrderItemID FROM OrderItems
							WHERE OrderID = @OrderID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Order Items in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  OrderItemID,
							OrderID,
							ProductID,
							UnitOfMeasureID,
							Quantity
						FROM OrderItems
					WHERE OrderID = @OrderID;
				END
		END
END
GO
