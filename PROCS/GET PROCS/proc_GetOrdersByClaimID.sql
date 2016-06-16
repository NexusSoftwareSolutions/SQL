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
-- Description:	Get Orders by ClaimID
-- =============================================
ALTER PROCEDURE proc_GetOrdersByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ClaimID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  OrderID,
					VendorID,
					ClaimID,
					DateOrdered,
					DateDropped,
					ScheduledInstallation
				FROM Orders;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT OrderID FROM Orders
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Orders in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  OrderID,
							VendorID,
							ClaimID,
							DateOrdered,
							DateDropped,
							ScheduledInstallation
						FROM Orders
					WHERE ClaimID = @ClaimID;
				END
		END
END
GO
