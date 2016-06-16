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
-- Description:	Updates a record in the KnockerResponses table by KnockerResponseID
-- =============================================
ALTER PROCEDURE proc_UpdateKnockerResponse
	-- Add the parameters for the stored procedure here
	@KnockerResponseID int,
	@KnockResponseTypeID int,
	@Address varchar(100) = null,
	@Zip varchar(10) = null,
	@Lat float = null,
	@Long float = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	IF @Lat = 0
		SET @Lat = null;
	IF @Long = 0
		SET @Long = null;

    -- Insert statements for procedure here
	IF EXISTS (SELECT KnockerResponseID FROM KnockerResponses
				WHERE KnockerResponseID = @KnockerResponseID)
			BEGIN
				UPDATE KnockerResponses
				SET KnockResponseTypeID = @KnockResponseTypeID,
					Address = @Address,
					Zip = @Zip,
					Lat = @Lat,
					Long = @Long
				WHERE KnockerResponseID = @KnockerResponseID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Knocker Responses list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

