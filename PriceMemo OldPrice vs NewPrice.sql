
Select Itemcode, b.Description, a.NewPrice, b.price from PriceMemo a join item b on a.Itemcode = b.ItemLookupCode where convert(char(8), EffectivityDate,112) between 20190801 and 20190827 and a.NewPrice <> b.Price

--update item set price = a.newprice from PriceMemo a join item b on a.Itemcode = b.ItemLookupCode where convert(char(8), EffectivityDate,112) between 20190801 and 20190827 and a.NewPrice <> b.Price