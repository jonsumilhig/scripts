update TransactionHold set [Status]='Cancelled' where isnull([Status],'')=''
