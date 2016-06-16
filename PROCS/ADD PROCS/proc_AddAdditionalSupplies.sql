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
-- Create date: 4/12/2016
-- Description:	Add an Additional Supplies entry
-- =============================================
ALTER PROCEDURE proc_AddAdditionalSupplies
	-- Add the parameters for the stored procedure here
	@ClaimID int,
    @PickUpDate datetime,
    @DropOffDate datetime,
    @Items varchar(255),
    @Cost float,
    @ReceiptImagePath varchar(255),
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT ClaimID FROM AdditionalSupplies 
					WHERE ClaimID = @ClaimID
					AND Items = @Items
					AND Cost = @Cost)
		BEGIN
			INSERT INTO AdditionalSupplies	
						(ClaimID,
						PickUpDate,
						DropOffDate,
						Items,
						Cost,
						ReceiptImagePath)
			VALUES (@ClaimID,
					@PickUpDate,
					@DropOffDate,
					@Items,
					@Cost,
					@ReceiptImagePath);
			
			SET @new_identity = IDENT_CURRENT('AdditionalSupplies');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'These additional supplies have already been added to the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
