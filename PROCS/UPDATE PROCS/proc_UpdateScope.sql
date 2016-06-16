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
-- Description:	Updates a record in the Scopes table by ScopeID
-- =============================================
ALTER PROCEDURE proc_UpdateScope
	-- Add the parameters for the stored procedure here
	@ScopeID int,
	@ScopeTypeID int,
	@Interior float,
	@Exterior float,
	@Gutter float,
	@RoofAmount float,
	@Tax float,
	@Deductible float,
	@Total float,
	@OandP float,
	@Accepted bit,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ScopeID FROM Scopes
				WHERE ScopeID = @ScopeID)
			BEGIN
				UPDATE Scopes
				SET ScopeTypeID = @ScopeTypeID,
					Interior = @Interior,
					Exterior = @Exterior,
					Gutter = @Gutter,
					RoofAmount = @RoofAmount,
					Tax = @Tax,
					Deductible = @Deductible,
					Total = @Total,
					OandP = @OandP,
					Accepted = @Accepted
				WHERE ScopeID = @ScopeID;
	
				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Scopes list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

