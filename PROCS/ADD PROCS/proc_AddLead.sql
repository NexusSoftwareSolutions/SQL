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
-- Create date: 4/11/2016
-- Description:	Adds a Lead
-- =============================================
ALTER PROCEDURE proc_AddLead
	-- Add the parameters for the stored procedure here
	@LeadTypeID int,
	@KnockerResponseID int = null,
	@SalesPersonID int,
	@CustomerID int,
	@AddressID int,
	@LeadDate datetime,
	@CreditToID int = null,
	@Temperature char(1),

	@new_identity int = null OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	IF @KnockerResponseID = 0
		SET @KnockerResponseID = null;
	IF @CreditToID = 0
		SET @CreditToID = null;

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
	
	-- If the LeadID does not already exist, add the lead, else throw an error.
	IF NOT EXISTS (SELECT LeadID FROM Leads 
					WHERE CustomerID = @CustomerID
					AND AddressID = @AddressID
					AND LeadDate = @LeadDate)
		BEGIN
			INSERT INTO Leads
						(LeadTypeID,
						KnockerResponseID,
						SalesPersonID,
						CustomerID,
						AddressID,
						LeadDate,
						Status,
						CreditToID,
						Temperature)
			VALUES (@LeadTypeID,
					@KnockerResponseID,
					@SalesPersonID,
					@CustomerID,
					@AddressID,
					@LeadDate,
					'A',
					@CreditToID,
					@Temperature);
	
			SET @new_identity = IDENT_CURRENT('Leads');
		END
	ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'This Lead already exists in the system.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END
END
GO

