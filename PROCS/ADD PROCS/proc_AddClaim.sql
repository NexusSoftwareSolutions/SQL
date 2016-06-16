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
-- Create date: 4/6/2016
-- Description:	Adds new Claim
-- The locking code below was modified from a post on this website: 
--https://www.mssqltips.com/sqlservertip/3202/prevent-multiple-users-from-running-the-same-sql-server-stored-procedure-at-the-same-time/
-- =============================================
ALTER PROCEDURE proc_AddClaim
	-- Add the parameters for the stored procedure here
	@CustomerID int,
	@LeadID int,
	@BillingID int,
	@PropertyID int,
    @InsuranceCompanyID int,
    @InsuranceClaimNumber varchar(255) = null,
    @LossDate datetime,
    @MortgageCompany varchar(50) = null,
    @MortgageAccount varchar(50) = null,

	@new_identity int = null OUTPUT

AS
BEGIN TRY
	BEGIN TRAN

		-- return code, might not need this
		DECLARE @return_code int = 0;

		EXECUTE @return_code = sp_getapplock @Resource = 'proc_AddClaim', -- the resource to be locked
								@LockMode = 'Exclusive', -- type of lock
								@LockOwner = 'Transaction', -- transaction or session
								@LockTimeOut = 15000; -- timeout in milliseconds, 15 seconds

		IF @return_code < 0
			BEGIN
				BEGIN TRY
					THROW 51000, 'Error. Could not access Claims data, please try again.', 16;
				END TRY
				BEGIN CATCH
					THROW;
				END CATCH
			END
		ELSE IF @return_code >= 0 
			BEGIN

				-- SET NOCOUNT ON added to prevent extra result sets from
				-- interfering with SELECT statements.
				SET NOCOUNT ON;
				SET FMTONLY OFF;

				-- MRN prefix
				DECLARE @MRN varchar(4) = 'MRN-';
	
				-- gets the SalesPersonID
				DECLARE @SalesPersonID_int int = (SELECT SalesPersonID FROM Leads
												WHERE LeadID = @LeadID);

				-- increments identity to get new ClaimID
				DECLARE @incremented_id_int int;

				IF ((SELECT COUNT(*) FROM Claims) = 0)
					BEGIN
						SET @incremented_id_int = 1;
					END
				ELSE
					BEGIN
						SET @incremented_id_int = IDENT_CURRENT('Claims') + 1;
					END

				-- convert incremented_id
				DECLARE @incremented_id_varchar varchar(50) = CONVERT(varchar(50), @incremented_id_int);

				-- declare MRNNumber and concat
				DECLARE @MRNNumber varchar(50) = CONCAT(@MRN, 
														CONVERT(varchar(50), @SalesPersonID_int),
														'-', 
														@CustomerID,
														'-', 
														CONVERT(varchar(50), @incremented_id_int));
				
				IF NOT EXISTS (SELECT ClaimID FROM Claims 
								WHERE CustomerID = @CustomerID
								AND PropertyID = @PropertyID
								AND LossDate = @LossDate)
					BEGIN
						INSERT INTO Claims
									(CustomerID,
									LeadID,
									BillingID,
									PropertyID,
									InsuranceCompanyID,
									InsuranceClaimNumber,
									MRNNumber,
									LossDate,
									MortgageCompany,
									MortgageAccount,
									IsOpen,
									ContractSigned)
						VALUES
								(@CustomerID,
								@LeadID,
								@BillingID,
								@PropertyID,
								@InsuranceCompanyID,
								@InsuranceClaimNumber,
								@MRNNumber,
								@LossDate,
								@MortgageCompany,
								@MortgageAccount,
								1,
								0);

						SET @new_identity = IDENT_CURRENT('Claims');
						COMMIT TRAN;
					END
				ELSE
					BEGIN
						BEGIN TRY
								THROW 51000, 'There is already a Claim in the system for this customer, property and loss date.', 16;
						END TRY
						BEGIN CATCH
								THROW;
						END CATCH
					END
			END
		ELSE 
			BEGIN
				ROLLBACK TRAN;
				SET @return_code = 50000;
			END
END TRY
	BEGIN CATCH
		BEGIN TRY
				THROW;
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END CATCH
GO
		   

		   