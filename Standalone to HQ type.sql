select Window from securitymanager group by window

select * from securitymanager where window in ('Item','Location','ReasonCodes','SalesRep','Supplier','UserGroupPrivileges','Users','')

update securitymanager set new='1',edit_Update='1',ReadOnly='1' where window in ('Item','Location','ReasonCodes','SalesRep','Supplier','UserGroupPrivileges','Users')

--Item
--Department
--Category
--Subcategory
--Users
--Tendertypes
--Style
--Color
--Style
--Concessionaire
--Reasoncode
--Pricememo
--PricememoHeader
--Store
--Supplier
--Supplierlist