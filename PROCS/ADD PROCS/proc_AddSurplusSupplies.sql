USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_AddSurplusSupplies]    Script Date: 4/29/2016 9:50:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alyssa Harvey
-- Create date: 4/25/2016
-- Description:	Adds a SurplusSupplies record
-- =============================================
ALTER PROCEDURE [InfoTech].[proc_AddSurplusSupplies]
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@UnitOfMeasureID int,
	@Quantity int,
	@PickUpDate datetime,
	@DropOffDate datetime,
	@Items varchar(255),

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	
	IF NOT EXISTS (SELECT SurplusSuppliesID FROM SurplusSupplies 
					WHERE ClaimID = @ClaimID
					AND PickUpDate = @PickUpDate
					AND Items = @Items)
		BEGIN
			INSERT INTO SurplusSupplies 
				(ClaimID,
				UnitOfMeasureID,
				Quantity,
				PickUpDate,
				DropOffDate,
				Items)
			VALUES 
				(@ClaimID,
				@UnitOfMeasureID,
				@Quantity,
				@PickUpDate,
				@DropOffDate,
				@Items);
		
			SET @new_identity = IDENT_CURRENT('SurplusSupplies');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'That Surplus Supply record already exists in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
