USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_GetClaimDocumentsByClaimID]    Script Date: 4/25/2016 11:47:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alyssa Harvey
-- Create date: 4/22/2016
-- Description:	Returns All Documents by ClaimID
-- =============================================
ALTER PROCEDURE proc_GetClaimDocumentsByClaimID
	-- Add the parameters for the stored procedure here
	@ClaimID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ClaimID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  DocumentID,
					ClaimID,
					FilePath,
					FileName,
					FileExt,
					DocTypeID,
					DocumentDate,
					SignatureImagePath,
					NumSignatures,
					InitialImagePath,
					NumInitials 
				FROM ClaimDocuments;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ClaimID FROM ClaimDocuments
							WHERE ClaimID = @ClaimID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There are no Claim Documents in the system for the ID provided.', 16;
						END TRY
						BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  DocumentID,
							ClaimID,
							FilePath,
							FileName,
							FileExt,
							DocTypeID,
							DocumentDate,
							SignatureImagePath,
							NumSignatures,
							InitialImagePath,
							NumInitials 
						FROM ClaimDocuments
					WHERE ClaimID = @ClaimID;
				END
		END
END
