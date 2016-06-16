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
-- Description:	Add a CallLog entry
-- =============================================
ALTER PROCEDURE proc_AddCallLog
	-- Add the parameters for the stored procedure here
	@ClaimID int,
    @EmployeeID int,
    @WhoWasCalled varchar(50),
    @ReasonForCall varchar(255),
    @WhoAnswered varchar(50),
    @CallResults varchar(255),
			
	@new_identity int = null OUTPUT
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT CallLogID FROM CallLogs
					WHERE ClaimID = @ClaimID
					AND EmployeeID = @EmployeeID
					AND WhoWasCalled = @WhoWasCalled
					AND ReasonForCall = @ReasonForCall)
		BEGIN
			INSERT INTO CallLogs
						(ClaimID,
						EmployeeID,
						WhoWasCalled,
						ReasonForCall,
						WhoAnswered,
						CallResults)
			VALUES (@ClaimID,
					@EmployeeID,
					@WhoWasCalled,
					@ReasonForCall,
					@WhoAnswered,
					@CallResults);
	
			SET @new_identity = IDENT_CURRENT('CallLogs');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This call has already been logged into the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

