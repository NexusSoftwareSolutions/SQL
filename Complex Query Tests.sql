--198.71.227.2

select * from adjusters
select * from adjustments
select * from claims
select * from leads
select * from users
select * from employees

select * from adjustments a
join ClaimContacts cc on a.ClaimID = cc.ClaimID
Where cc.SalesPersonID = 3

print DateAdd(day, -30, getdate())

select cl.ClaimID, cl.MRNNumber, c.FirstName + ' ' + c.LastName AS 'Customer Name', 
	   e.FirstName + ' ' + e.LastName AS 'Salesperson'
from claims cl 
join Customers c on cl.CustomerID = c.CustomerID
join Leads l on cl.LeadID = l.LeadID
join Employees e on e.EmployeeID = l.SalesPersonID

select * from addresses where customerid = 1
union 
select * from addresses where customerid=2

select l.salespersonid, count(c.claimid) AS 'Total Claims'
from claims c
join leads l on c.leadid = l.leadid
where c.IsOpen = 1
group by l.salespersonid
having l.salespersonID > 0

select claimid, isopen, 
	case when isopen = 0 then 'Is Not Open'
		 when isopen = 1 then 'is open' end as 'Status'
	from claims

select * from claimstatuses
where claimstatusdate > '2016-06-02'

select * from claims
join claimcontacts cc on claims.ClaimID = cc.ClaimID
where cc.SalespersonID = 3