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
-- Description:	Adds an Order record
-- =============================================
ALTER PROCEDURE proc_AddOrder
	-- Add the parameters for the stored procedure here
	@VendorID int,
	@ClaimID int,
	@DateOrdered datetime,
	@DateDropped datetime,
	@ScheduledInstallation datetime,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT OrderID FROM Orders 
					WHERE VendorID = @VendorID
					AND ClaimID = @ClaimID
					AND DateOrdered = @DateOrdered)
		BEGIN
			INSERT INTO Orders 
				(VendorID,
				ClaimID,
				DateOrdered,
				DateDropped,
				ScheduledInstallation)
			VALUES 
				(@VendorID,
				@ClaimID,
				@DateOrdered,
				@DateDropped,
				@ScheduledInstallation);
		
			SET @new_identity = IDENT_CURRENT('Orders');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'That Order already exists in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
