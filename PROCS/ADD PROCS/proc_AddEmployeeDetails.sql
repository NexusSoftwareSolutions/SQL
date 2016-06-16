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
-- Create date: 4/14/2016
-- Description:	Adds an EmployeeDetails entry
-- =============================================
ALTER PROCEDURE proc_AddEmployeeDetails
	-- Add the parameters for the stored procedure here
	@EmployeeID int,
    @MailingAddress varchar(100),
    @Zip varchar(10),
    @DateHired datetime,
    @DateReleased datetime = null,
    @ShirtSize varchar(12) = null,
    @PayRate float = null,
    @PayTypeID int = null,
    @PayFrequencyID int = null,
    @PreviousEmployee bit = 0,
    @DLPhotoPath varchar(255) = null,
    @CompanyPhotoPath varchar(255) = null,
    @SignaturePath varchar(255) = null,
	
	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	--IF @PayRate = 0
	--	SET @PayRate = null;
	--IF @PayTypeID = 0
	--	SET @PayTypeID = null;
	--IF @PayFrequencyID = 0
	--	SET @PayFrequencyID = null;

	--IF @DateReleased = '1900-01-01 00:00:00.000'
	--	SET @DateReleased = NULL;

	IF NOT EXISTS (Select EmployeeID FROM EmployeeDetails 
						WHERE EmployeeID = @EmployeeID)
		BEGIN
			INSERT INTO EmployeeDetails
						(EmployeeID,
						MailingAddress,
						Zip,
						DateHired,
						DateReleased,
						ShirtSize,
						PayRate,
						PayTypeID,
						PayFrequencyID,
						PreviousEmployee,
						DLPhotoPath,
						CompanyPhotoPath,
						SignaturePath)
				VALUES (@EmployeeID,
						@MailingAddress,
						@Zip,
						@DateHired,
						@DateReleased,
						@ShirtSize,
						@PayRate,
						@PayTypeID,
						@PayFrequencyID,
						@PreviousEmployee,
						@DLPhotoPath,
						@CompanyPhotoPath,
						@SignaturePath);

			SET @new_identity = IDENT_CURRENT('EmployeeDetails');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This Employee already exists in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO
