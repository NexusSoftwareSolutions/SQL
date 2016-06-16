USE [NexusTest]
GO
/****** Object:  StoredProcedure [InfoTech].[proc_GetUser]    Script Date: 4/20/2016 12:42:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maggie Seigler
-- Create date: 4/6/2016
-- Description:	Returns user data
-- =============================================
ALTER PROCEDURE proc_GetUser
	-- Add the parameters for the stored procedure here
	@Username varchar(50)
			
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	-- Insert statements for procedure here
	IF @Username IS null
		BEGIN
			SET FMTONLY ON;
			SELECT  UserID,
					EmployeeID,
					Username,
					Pass,
					PermissionID,
					Active
				FROM Users;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT UserID FROM Users
							WHERE Username = @Username)
				BEGIN
					BEGIN TRY
						THROW 51000, 'Invalid Username/Password.', 16;
					END TRY
					BEGIN CATCH
						THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  UserID,
							EmployeeID,
							Username,
							Pass,
							PermissionID,
							Active
						FROM Users
					WHERE Username = @Username;
				END
		END
END
