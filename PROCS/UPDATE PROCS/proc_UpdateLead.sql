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
-- Description:	Updates a record in the Leads table by LeadID
-- =============================================
ALTER PROCEDURE proc_UpdateLead
	-- Add the parameters for the stored procedure here
	@LeadID int,
	@CustomerID int,
	@AddressID int,
	@Status char,
	@CreditToID int = null,
	@Temperature char(1),

	@SuccessFlag bit = 0 OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @CreditToID = 0
		SET @CreditToID = null;

	DECLARE @KnockerResponseID int = (SELECT KnockerResponseID FROM Leads WHERE LeadID = @LeadID);

	-- If @KnockerResponseID is null, throws an error if the
	-- ReferrerID does not exist and exits the procedure
	IF @KnockerResponseID is null
		BEGIN
			IF NOT EXISTS(SELECT ReferrerID FROM Referrers
							WHERE ReferrerID = @CreditToID)
				BEGIN
				BEGIN TRY
					THROW 51000, 'There is no Referrer in the list that matches the id provided.', 16;
					RETURN;
				END TRY
				BEGIN CATCH
					THROW;
				END CATCH
			END
		END

	-- If @KnockerResponseID is not null, throws an error if the
	-- EmployeeID does not exist and exits the procedure
	IF @KnockerResponseID is not null
		BEGIN
			IF NOT EXISTS(SELECT EmployeeID FROM Employees
							WHERE EmployeeID = @CreditToID)
				BEGIN
				BEGIN TRY
					THROW 51000, 'There is no Employee in the list that matches the id provided.', 16;
					RETURN;
				END TRY
				BEGIN CATCH
					THROW;
				END CATCH
			END
		END

	-- If the Lead exists, update it, else throw an error.
	IF EXISTS (SELECT LeadID FROM Leads
				WHERE LeadID = @LeadID)
			BEGIN
				UPDATE Leads
				SET CustomerID = @CustomerID,
					AddressID = @AddressID,
					Status = @Status,
					CreditToID = @CreditToID,
					Temperature = @Temperature
				WHERE LeadID = @LeadID;

				SET @SuccessFlag = 1;
			END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'There is no record in the Leads list for the id provided.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

