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
-- Description:	Get CalendarData by EmployeeID
-- =============================================
ALTER PROCEDURE proc_GetCalendarDataByEmployeeID 
	-- Add the parameters for the stored procedure here
	@EmployeeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @EmployeeID is null
		BEGIN
			SET FMTONLY ON;
			SELECT  EntryID,
					AppointmentTypeID,
					EmployeeID,
					StartTime,
					EndTime,
					ClaimID,
					LeadID,
					Note 
				FROM CalendarData;
			SET FMTONLY OFF;
		END
	ELSE
		BEGIN
			IF NOT EXISTS (SELECT EmployeeID FROM CalendarData
							WHERE EmployeeID = @EmployeeID)
				BEGIN
					BEGIN TRY
							THROW 51000, 'There is no Calendar in the system for the ID provided.', 16;
					END TRY
					BEGIN CATCH
							THROW;
					END CATCH
				END
			ELSE
				BEGIN
					SELECT  EntryID,
							AppointmentTypeID,
							EmployeeID,
							StartTime,
							EndTime,
							ClaimID,
							LeadID,
							Note 
						FROM CalendarData
					WHERE EmployeeID = @EmployeeID;
				END
		END
END
GO
