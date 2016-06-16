SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alyssa Harvey
-- Create date: 4/20/2016
-- Description:	Returns an Address based on ID
-- =============================================
ALTER PROCEDURE proc_GetAddressByID
	-- Add the parameters for the stored procedure here
	@AddressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @AddressID is null
		BEGIN
			SET FMTONLY ON;
			SELECT	AddressID,
					CustomerID,
					Address,
					Zip 
				FROM Addresses;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT AddressID FROM Addresses 
							WHERE AddressID = @AddressID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no address in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT	AddressID,
							CustomerID,
							Address,
							Zip 
						FROM Addresses
					WHERE AddressID = @AddressID;
				END
		END
END

