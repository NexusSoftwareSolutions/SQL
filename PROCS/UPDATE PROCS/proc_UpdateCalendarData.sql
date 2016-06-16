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
-- Description:	Updates a record in CalendarData table by EntryID
-- =============================================
ALTER PROCEDURE proc_UpdateCalendarData
	-- Add the parameters for the stored procedure here
	@EntryID int,
	@AppointmentTypeID int,
	@EmployeeID int,
	@StartTime datetime,
	@EndTime datetime,
	@ClaimID int,
	@LeadID int,
	@Note varchar(255),

	@SuccessFlag bit = 0 OUTPUT

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
	IF EXISTS (SELECT EntryID FROM CalendarData 
				WHERE EntryID = @EntryID)
			BEGIN
				UPDATE CalendarData
				SET AppointmentTypeID = @AppointmentTypeID,
					StartTime = @StartTime,
					EndTime = @EndTime,
					Note = @Note
				WHERE EntryID = @EntryID;

				IF @ClaimID is null
					UPDATE CalendarData
					SET ClaimID = @ClaimID
					WHERE EntryID = @EntryID;

				IF @LeadID is null
					UPDATE CalendarData
					SET LeadID = @LeadID
					WHERE EntryID = @EntryID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'That calendar entry does not exist.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

