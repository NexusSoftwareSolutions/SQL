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
-- Create date: 4/27/2016
-- Description:	Updates a record in the ClaimDocuments table by DocumentID
-- =============================================
ALTER PROCEDURE proc_UpdateClaimDocument
	-- Add the parameters for the stored procedure here
	@DocumentID int,
	@FilePath varchar(255),
	@FileName varchar(50),
	@FileExt varchar(10),
	@DocTypeID int,
	@DocumentDate datetime,
	@SignatureImagePath varchar(255) = null,
	@NumSignatures int = null,
	@InitialImagePath varchar(255) = null,
	@NumInitials int = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT DocumentID FROM ClaimDocuments
				WHERE DocumentID = @DocumentID)
			BEGIN
				UPDATE ClaimDocuments
				SET FilePath = @FilePath,
					FileName = @FileName,
					FileExt = @FileExt,
					DocTypeID = @DocTypeID,
					DocumentDate = @DocumentDate,
					SignatureImagePath = @SignatureImagePath,
					NumSignatures = @NumSignatures,
					InitialImagePath = @InitialImagePath,
					NumInitials = @NumInitials
				WHERE DocumentID = @DocumentID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Claim Documents list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

