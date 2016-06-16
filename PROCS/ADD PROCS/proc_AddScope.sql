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
-- Description:	Add a Scope
-- =============================================
ALTER PROCEDURE proc_AddScope
	-- Add the parameters for the stored procedure here
	@ScopeTypeID int,
    @ClaimID int,
    @Interior float,
    @Exterior float,
    @Gutter float,
	@RoofAmount float,
    @Tax float,
    @Deductible float,
    @Total float,
    @OandP float,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT ScopeID FROM Scopes 
					WHERE ScopeTypeID = @ScopeTypeID
					AND ClaimID = @ClaimID)
		BEGIN
			INSERT INTO Scopes
						(ScopeTypeID,
						ClaimID,
						Interior,
						Exterior,
						Gutter,
						RoofAmount,
						Tax,
						Deductible,
						Total,
						OandP,
						Accepted)
			VALUES (@ScopeTypeID,
				   @ClaimID,
				   @Interior,
				   @Exterior,
				   @Gutter,
				   @RoofAmount,
				   @Tax,
				   @Deductible,
				   @Total,
				   @OandP,
				   0);

			SET @new_identity = IDENT_CURRENT('Scopes');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is already a scope of this type in the system for the Claim ID provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

