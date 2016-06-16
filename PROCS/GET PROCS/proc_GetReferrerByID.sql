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
-- Create date: 4/26/2016
-- Description:	Get Referrer by ReferrerID
-- =============================================
ALTER PROCEDURE proc_GetReferrerByID
	-- Add the parameters for the stored procedure here
	@ReferrerID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @ReferrerID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  ReferrerID,
					FirstName,
					LastName,
					Suffix,
					MailingAddress,
					Zip,
					Email,
					CellPhone
				FROM Referrers;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT ReferrerID FROM Referrers
							WHERE ReferrerID = @ReferrerID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Referrer in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  ReferrerID,
							FirstName,
							LastName,
							Suffix,
							MailingAddress,
							Zip,
							Email,
							CellPhone
						FROM Referrers
					WHERE ReferrerID = @ReferrerID;
				END
		END
END
GO
