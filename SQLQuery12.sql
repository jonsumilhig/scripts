

select 'exec Proc_ReceiptReport ''1'', '+ a.TransactionNUmber +', ''Yes'', ''No'', ''C:\Program Files (x86)\PartnerSolutionsInc\Retailware\Journal\Receipt\2020\10\02\'', ''Receipt_1_100004029_2020-10-02 013219'', ''RAMCEL CONVENIENT BAG CORP.'', ''Invoice No.'', ''No'', '''', '''', ''W9AB3VL4'', ''18070916224686145''' 
from TransactionVatDetails a JOIN [Transaction] b ON a.TransactionNUmber = b.TransactionNUmber
and a.RegisterNo = b.RegisterNo AND (Vatable+ VatExempt + ZeroRated + VatAmt) <> Total
AND ABS((Vatable+ VatExempt + ZeroRated + VatAmt) - Total) > 1 and b.Voided = 0
order by  a.TransactionNUmber

select a.TransactionNUmber,(Vatable+ VatExempt + ZeroRated + VatAmt) ,Total 
from TransactionVatDetails a JOIN [Transaction] b ON a.TransactionNUmber = b.TransactionNUmber
and a.RegisterNo = b.RegisterNo AND (Vatable+ VatExempt + ZeroRated + VatAmt) <> Total
AND ABS((Vatable+ VatExempt + ZeroRated + VatAmt) - Total) > 1 and b.Voided = 0
order by  a.TransactionNUmber
