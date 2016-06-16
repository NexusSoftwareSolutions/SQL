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
-- Create date: 4/___/2016
-- Description:	
-- =============================================
CREATE PROCEDURE proc_
	-- Add the parameters for the stored procedure here

	
		--@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	
	
	--SET @new_identity = IDENT_CURRENT('TABLENAME');
	
END
GO
--DBCC CHECKIDENT(tableName, reseed, 0);

/*
IF NOT EXISTS (SELECT Email FROM Customers WHERE Email = @Email)
		BEGIN
			BEGIN TRY
					THROW 51000, 'ERROR MESSAGE HERE.', 16;
				END TRY
				BEGIN CATCH
					THROW;
			END CATCH
		END
	ELSE
		BEGIN
			--INSERT or UPDATE, etc.
		END

		BEGIN
			-- insert or update etc
			
			SET @new_identity = IDENT_CURRENT('TABLE_NAME');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'ERROR MESSAGE HERE.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
	
*/