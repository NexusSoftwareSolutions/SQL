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
-- Description:	Updates a record in the EmployeeDetails table by EmployeeDetailsID
-- =============================================
ALTER PROCEDURE proc_UpdateEmployeeDetails
	-- Add the parameters for the stored procedure here
	@EmployeeDetailsID int,
	@MailingAddress varchar(100),
	@Zip varchar(10),
	@DateHired datetime,
	@DateReleased datetime = null,
	@ShirtSize varchar(12) = null,
	@PayRate float = null,
	@PayTypeID int = null,
	@PayFrequencyID int = null,
	@PreviousEmployee bit,
	@DLPhotoPath varchar(255) = null,
	@CompanyPhotoPath varchar(255) = null,
	@SignaturePath varchar(255) = null,

	@Success bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF EXISTS (SELECT EmployeeDetailsID FROM EmployeeDetails
				WHERE EmployeeDetailsID = @EmployeeDetailsID)
			BEGIN
				UPDATE EmployeeDetails
				SET MailingAddress = @MailingAddress,
					Zip = @Zip,
					DateHired = @DateHired,
					DateReleased = @DateReleased,
					ShirtSize = @ShirtSize,
					PayRate = @PayRate,
					PayTypeID = @PayTypeID,
					PayFrequencyID = @PayFrequencyID,
					PreviousEmployee = @PreviousEmployee,
					DLPhotoPath = @DLPhotoPath,
					CompanyPhotoPath = @CompanyPhotoPath,
					SignaturePath = @SignaturePath
				WHERE EmployeeDetailsID = @EmployeeDetailsID;

				SET @Success = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in Employee Details for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

