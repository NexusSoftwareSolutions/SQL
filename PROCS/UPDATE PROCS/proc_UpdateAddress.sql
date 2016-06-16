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
-- Description:	Updates a record in the Addresses table by AddressID
-- =============================================
ALTER PROCEDURE proc_UpdateAddress
	-- Add the parameters for the stored procedure here
	@AddressID int,
	@Address varchar(100) = null,
	@Zip varchar(10) = null,

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT AddressID FROM Addresses
				WHERE AddressID = @AddressID)
			BEGIN
				UPDATE Addresses
				SET Address = @Address,
					Zip = @Zip
				WHERE AddressID = @AddressID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Addresses list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

