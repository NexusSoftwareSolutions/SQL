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
-- Create date: 4/5/2016
-- Description:	Adds new data to CalendarData table
-- =============================================
ALTER PROCEDURE proc_AddCalendarData
	-- Add the parameters for the stored procedure here
	@AppointmentTypeID int,
	@EmployeeID int,
	@StartTime datetime,
	@EndTime datetime,
	@ClaimID int = null,
	@LeadID int = null,
	@Note varchar(255) = null,

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

	IF @LeadID = 0
		SET @LeadID = null;
	IF @ClaimID = 0
		SET @ClaimID = null;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT EntryID FROM CalendarData 
					WHERE EmployeeID = @EmployeeID
					AND StartTime = @StartTime
					AND EndTime = @EndTime)
		BEGIN
			INSERT INTO CalendarData 
						(AppointmentTypeID,
						EmployeeID, 
						StartTime, 
						EndTime, 
						ClaimID,
						LeadID, 
						Note)
			VALUES (@AppointmentTypeID,
					@EmployeeID, 
					@StartTime, 
					@EndTime, 
					@ClaimID, 
					@LeadID,
					@Note);

			SET @new_identity = IDENT_CURRENT('CalendarData');
		END
	ELSE
		BEGIN
			BEGIN TRY
				DECLARE @message varchar(255) = 
					(SELECT CONCAT((SELECT FirstName FROM Employees 
									WHERE EmployeeID = @EmployeeID), 
									' already has an appointment ' +
									'scheduled. Please choose another time.'));

				THROW 51000, @message, 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

