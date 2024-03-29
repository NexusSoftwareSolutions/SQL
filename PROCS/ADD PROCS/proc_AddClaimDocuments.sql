USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_AddClaimDocuments]    Script Date: 4/25/2016 11:40:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maggie Seigler
-- Create date: 4/13/2016
-- Description:	Adds a ClaimDocument
-- =============================================
ALTER PROCEDURE proc_AddClaimDocuments
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@FilePath varchar(255),
	@FileName varchar(50),
	@FileExt varchar(10),
	@DocTypeID int,
	@DocumentDate datetime,
	@SignatureImagePath varchar(255) = null,
	@NumSignatures int = null,
	@InitialImagePath varchar(255) = null,
	@NumInitials int = null,

	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	--IF @NumSignatures = 0
	--	SET @NumSignatures = null;
	--IF @NumInitials = 0
	--	SET @NumInitials = null;

	IF NOT EXISTS (SELECT DocumentID FROM ClaimDocuments
					WHERE ClaimID = @ClaimID
					AND FilePath = @FilePath
					AND FileName = @FileName)
		BEGIN
			INSERT INTO ClaimDocuments
						(ClaimID,
						FilePath,
						FileName,
						FileExt,
						DocTypeID,
						DocumentDate,
						SignatureImagePath,
						NumSignatures,
						InitialImagePath,
						NumInitials)
			VALUES 
					(@ClaimID,
					@FilePath,
					@FileName,
					@FileExt,
					@DocTypeID,
					@DocumentDate,
					@SignatureImagePath,
					@NumSignatures,
					@InitialImagePath,
					@NumInitials);
	
			SET @new_identity = IDENT_CURRENT('ClaimDocuments');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This document is already in the system for this Claim.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
