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
-- Description:	Add a ClaimVendor
-- ===========================================rr==
ALTER PROCEDURE proc_AddClaimVendor
	-- Add the parameters for the stored procedure here
	@ClaimID int,
	@VendorID int,
	@ServiceTypeID int,

	@output_ClaimID int = null OUTPUT,
	@output_VendorID int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT ClaimID FROM ClaimVendors
					WHERE ClaimID = @ClaimID
					AND VendorID = @VendorID
					AND ServiceTypeID = @ServiceTypeID) 
			BEGIN
				IF EXISTS (SELECT ClaimID FROM Claims
							WHERE ClaimID = @ClaimID)
					BEGIN
						IF EXISTS (SELECT VendorID FROM Vendors
									WHERE VendorID = @VendorID)
							BEGIN
								INSERT INTO ClaimVendors
												(ClaimID,
												VendorID,
												ServiceTypeID)
								VALUES (@ClaimID,
										@VendorID,
										@ServiceTypeID);

								SET @output_ClaimID = @ClaimID;
								SET @output_VendorID = @VendorID;
							END
						ELSE
							BEGIN
								BEGIN TRY
										THROW 51000, 'There is no Vendor in the system with the id provided.', 16;
									END TRY
									BEGIN CATCH
										THROW;
								END CATCH
							END
					END
				ELSE
					BEGIN
						BEGIN TRY
								THROW 51000, 'There is no Claim in the system with the id provided.', 16;
							END TRY
							BEGIN CATCH
								THROW;
						END CATCH
					END
			END
				ELSE
					BEGIN
						BEGIN TRY
								THROW 51000, 'There is already an entry in the system for this Claim id and Vendor id.', 16;
							END TRY
							BEGIN CATCH
								THROW;
						END CATCH
					END
END
GO

