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
-- Create date: 4/11/2016
-- Description:	Adds a new Address to Addresses table
-- =============================================
ALTER PROCEDURE proc_AddAddress
	-- Add the parameters for the stored procedure here
	@CustomerID int,
	@Address varchar(100) = null,
	@Zip varchar(10) = null,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT CustomerID FROM Addresses 
					WHERE CustomerID = @CustomerID 
					AND Address = @Address 
					AND Zip = @Zip) 
		BEGIN
			INSERT INTO Addresses
						(CustomerID,
						Address,
						Zip)
			VALUES (@CustomerID,
					@Address,
					@Zip);

			SET @new_identity = IDENT_CURRENT('Addresses');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This Customer''s address is already in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
