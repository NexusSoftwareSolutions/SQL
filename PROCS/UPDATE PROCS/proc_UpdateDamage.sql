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
-- Create date: 5/4/2016
-- Description:	Updates a record in the Damages table by DamageID
-- =============================================
ALTER PROCEDURE proc_UpdateDamage
	-- Add the parameters for the stored procedure here
	@DamageID int,
	@PlaneID int,
	@DamageTypeID int,
	@DocumentID int,
	@DamageMeasurement int,
	@xCoordinate int,
	@yCoordinate int,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT DamageID FROM Damages
				WHERE DamageID = @DamageID)
			BEGIN
				UPDATE Damages
				SET PlaneID = @PlaneID,
					DamageTypeID = @DamageTypeID,
					DocumentID = @DocumentID,
					DamageMeasurement = @DamageMeasurement,
					xCoordinate = @xCoordinate,
					yCoordinate = @yCoordinate
				WHERE DamageID = @DamageID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Damages list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

