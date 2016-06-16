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
-- Create date: 5/18/2016
-- Description:	Returns Claims that need interior, exterior or gutters scheduled
-- =============================================
ALTER PROCEDURE proc_GetOtherClaimsToSchedule
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here
	SELECT DISTINCT s.ScopeID, 
					s.ScopeTypeID, 
					s.ClaimID, 
					s.Interior, 
					s.Exterior, 
					s.Gutter,
					s.RoofAmount,
					s.Tax,
					s.Deductible,
					s.Total,
					s.OandP,
					s.Accepted
		FROM Scopes s
	JOIN ClaimStatuses cs ON s.ClaimID = cs.ClaimID
		WHERE s.ClaimID IN
		(SELECT DISTINCT ClaimID FROM Claims
		WHERE ClaimID IN (SELECT c.ClaimID
							FROM Claims c
							JOIN Scopes s ON c.ClaimID = s.ClaimID
							WHERE c.ClaimID NOT IN (SELECT DISTINCT cs.ClaimID FROM ClaimStatuses cs
													JOIN Claims c ON c.ClaimID = cs.ClaimID
													JOIN Scopes s ON c.ClaimID = s.ClaimID
													WHERE (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
													AND s.Accepted = 1
													AND c.IsOpen = 1
													AND cs.ClaimStatusTypeID = 13)
							AND c.IsOpen = 1
							AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
							AND s.Accepted = 1
							AND s.Interior > 0)
		OR s.ClaimID IN (SELECT c.ClaimID
							FROM Claims c
							JOIN Scopes s ON c.ClaimID = s.ClaimID
							WHERE c.ClaimID NOT IN (SELECT DISTINCT cs.ClaimID FROM ClaimStatuses cs
													JOIN Claims c ON c.ClaimID = cs.ClaimID
													JOIN Scopes s ON c.ClaimID = s.ClaimID
													WHERE (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
													AND s.Accepted = 1
													AND c.IsOpen = 1
													AND cs.ClaimStatusTypeID = 14)
							AND c.IsOpen = 1
							AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
							AND s.Accepted = 1
							AND s.Exterior > 0)
		OR s.ClaimID IN (SELECT c.ClaimID
							FROM Claims c
							JOIN Scopes s ON c.ClaimID = s.ClaimID
							WHERE c.ClaimID NOT IN (SELECT DISTINCT cs.ClaimID FROM ClaimStatuses cs
													JOIN Claims c ON c.ClaimID = cs.ClaimID
													JOIN Scopes s ON c.ClaimID = s.ClaimID
													WHERE (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
													AND s.Accepted = 1
													AND c.IsOpen = 1
													AND cs.ClaimStatusTypeID = 15)
							AND c.IsOpen = 1
							AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
							AND s.Accepted = 1
							AND s.Gutter > 0))
		AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3);
END
GO
