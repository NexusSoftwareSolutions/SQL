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
-- Create date: 4/12/2016
-- Description:	Adds an Adjuster
-- =============================================
ALTER PROCEDURE proc_AddAdjuster
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50) = null,
    @LastName varchar(50),
    @Suffix varchar(10) = null,
    @PhoneNumber  varchar(12) = null,
    @PhoneExt varchar(10) = null,
    @Email varchar(100),
    @InsuranceCompanyID int,
    @Comments varchar(255) = null,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT AdjusterID FROM Adjusters 
					WHERE LastName = @LastName
					AND Email = @Email
					AND InsuranceCompanyID = @InsuranceCompanyID)
		BEGIN
			INSERT INTO Adjusters (FirstName,
								   LastName,
								   Suffix,
								   PhoneNumber,
								   PhoneExt,
								   Email,
								   InsuranceCompanyID,
								   Comments)
			VALUES (@FirstName,
				   @LastName,
				   @Suffix,
				   @PhoneNumber,
				   @PhoneExt,
				   @Email,
				   @InsuranceCompanyID,
				   @Comments);
	
			SET @new_identity = IDENT_CURRENT('Adjusters');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This adjuster is already in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
