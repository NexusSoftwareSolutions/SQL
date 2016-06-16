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
-- Description:	Adds a Damage record
-- =============================================
ALTER PROCEDURE proc_AddDamage
	-- Add the parameters for the stored procedure here
	@PlaneID int,
	@DamageTypeID int,
	@DocumentID int,
	@DamageMeasurement int,
	@xCoordinate int,
	@yCoordinate int,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT DamageID FROM Damages
					WHERE PlaneID = @PlaneID
					AND DamageTypeID = @DamageTypeID)
		BEGIN
			INSERT INTO Damages 
							(PlaneID,
							DamageTypeID,
							DocumentID,
							DamageMeasurement,
							xCoordinate,
							yCoordinate)
			VALUES 
				(@PlaneID,
				@DamageTypeID,
				@DocumentID,
				@DamageMeasurement,
				@xCoordinate,
				@yCoordinate);
		
			SET @new_identity = IDENT_CURRENT('Damages');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'The damage for this plane has already been entered into the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO


