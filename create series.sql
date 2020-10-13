declare @reg int = 1
declare @datetime datetime = '2018-09-18 18:24:00.000'
declare @controlNo int = 100000001
declare @storeCode int = 101

--insert into series 
select @reg, 6, @datetime, 'Close', (select isnull(min(Transactionnumber),0) from [transaction] where convert(char(8),time,112) = convert(char(8),@datetime,112) and registerno = @reg), (select isnull(max(Transactionnumber),0) from [transaction] where convert(char(8),time,112) = convert(char(8),@datetime,112) and registerno = @reg), 0, @controlNo , @storeCode, '1'