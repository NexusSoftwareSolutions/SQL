USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_UpdateSurplusSupplies]    Script Date: 4/29/2016 9:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maggie Seigler
-- Create date: 4/28/2016
-- Description:	Updates a record in the SurplusSupplies table by SurplusSuppliesID
-- =============================================
ALTER PROCEDURE [InfoTech].[proc_UpdateSurplusSupplies]
	-- Add the parameters for the stored procedure here
	@SurplusSuppliesID int,
	@UnitOFMeasureID int,
	@Quantity int,
	@PickUpDate datetime,
	@DropOffDate datetime,
	@Items varchar(255),

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT SurplusSuppliesID FROM SurplusSupplies
				WHERE SurplusSuppliesID = @SurplusSuppliesID)
			BEGIN
				UPDATE SurplusSupplies
				SET UnitOfMeasureID = @UnitOfMeasureID,
					Quantity = @Quantity,
					PickUpDate = @PickUpDate,
					DropOffDate = @DropOffDate,
					Items = @Items				
				WHERE SurplusSuppliesID = @SurplusSuppliesID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Surplus Supplies list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
