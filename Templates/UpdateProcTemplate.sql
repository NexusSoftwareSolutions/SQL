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
-- Description:	Updates a record in the table_name table by ID
-- =============================================
CREATE PROCEDURE proc_Update
	-- Add the parameters for the stored procedure here
	@ID int,

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT ID FROM table_name
				WHERE ID = @ID)
			BEGIN
				UPDATE table_name
				SET 
				
				WHERE ID = @ID;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the table_name list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

