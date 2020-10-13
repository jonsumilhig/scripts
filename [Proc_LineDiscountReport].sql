
/****** Object:  StoredProcedure [dbo].[Proc_LineDiscountReportCustom]    Script Date: 10/23/2019 11:48:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER Procedure [dbo].[Proc_LineDiscountReport] @DateFrom Datetime, @ToDate Datetime
as
	
	IF OBJECT_ID('dbo.LineDiscounts', 'U') IS NOT NULL DROP TABLE dbo.LineDiscounts
	IF OBJECT_ID('dbo.LineDiscountSummary', 'U') IS NOT NULL DROP TABLE dbo.LineDiscountSummary

	SELECT 
		a.DateTime as Date, a.Itemlookupcode as Itemcode, b.Description, a.TransactionNumber, a.Registerno, a.Quantity, 
		isnull(LineDiscount,0) as Amount, 
	CASE 
		WHEN f.SCFlag = 1 THEN '20% SC'
		WHEN f.SCFlag = 2 THEN '5% SC'
		WHEN a.DiscountReasonCode = 'SC' THEN '20% SC'
		ELSE a.DiscountReasonCode
	END as Reason, c.FullName as Cashier
	INTO LineDiscounts
	FROM [TransactionEntries] a WITH (nolock) 
	LEFT OUTER JOIN [Item] b ON a.Itemlookupcode = b.Itemlookupcode
	COLLATE Latin1_General_BIN
	LEFT OUTER JOIN [Transaction] d WITH (nolock) ON a.TransactionNumber = d.TransactionNumber AND a.Registerno = d.Registerno
	LEFT OUTER JOIN [Users] c WITH (nolock) ON d.CashierID = c.Id
	LEFT OUTER JOIN [TransactionHold] e WITH (nolock) ON a.TransactionNumber = e.TransactionNumber AND a.RegisterNo = e.RegisterNo
	LEFT OUTER JOIN [TransactionFlag] f WITH (nolock) ON a.TransactionNumber = f.TransactionNumber AND a.RegisterNo = f.RegisterNo and a.SaleType = f.SaleType
	WHERE a.DiscountReasoncode <> '' AND a.DiscountReasoncode <> 'Price A' AND d.Voided = 0
	AND a.DiscountReasoncode <> 'Manual Price Change' AND a.DiscountReasoncode <> 'Bundled'
	AND a.DiscountReasoncode NOT IN (SELECT Code FROM [ReasonCode] WHERE type = 'Zero Revenue')
	AND a.Datetime BETWEEN @DateFrom AND @ToDate

	SELECT @Datefrom as Date,CONVERT(nvarchar,REPLACE(convert(nvarchar(20),Date,111),'/','-')) as Date2,Reason, b.Description,SUM(Amount) as Amount,
	SUM(Quantity) as ItemCount, Count(Distinct TransactionNumber) as NoOfTrx
	INTO LineDiscountSummary FROM LineDiscounts a JOIN ReasonCode b on REPLACE(a.Reason,' - AmtOff','') = b.Code 
	GROUP BY CONCAT(REPLACE(convert(nvarchar(20),Date,111),'/','-'),' 00:00:00.000'),Reason,b.Description,
	CONVERT(nvarchar,REPLACE(convert(nvarchar(20),Date,111),'/','-'))

	select * from LineDiscounts
	select * from LineDiscountSummary