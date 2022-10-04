--1. Total Revenue 
--2. Total Order Placed
--3. Avg Basket Size
--4. New Customers
--5. Gross Profit

Select Sum(tr.saleprice) [Saleprice],
       Count (Distinct S.OrderId) [TotalOrder],
       Sum(tr.saleprice)/Count(distinct s.OrderId) [AverageBasketSize],
       Count (Distinct (case when O.FirstCompletedOrderForCustomer=1 then O.CustomerId End)) [New_Customer],
       Sum(saleprice)-Sum(CostPrice) [Profit]

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
Join [Order] O On O.id=S.OrderId
Join thing t on t.id=tr.AssignedThingId

where ReconciledOn is not null
and ReconciledOn >= '2022-01-01 00:00 +06:00'
and  ReconciledOn < '2022-02-01 00:00 +06:00'
and tr.IsMissingAfterDispatch=0
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and ShipmentStatus not in (1,9,10)