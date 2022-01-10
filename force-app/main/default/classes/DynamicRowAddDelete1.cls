public class DynamicRowAddDelete1
    {
    public List<AccountIndexWrapper> WrapAccList {get;set;}
    public Integer rowToRemove {get;set;}

    public DynamicRowAddDelete1()
    {
        WrapAccList=new List<AccountIndexWrapper>(); 
    }
    public class AccountIndexWrapper
    {
        public Integer index {get;set;}
        public Account record {get;set;}
    }

    public PageReference  deleteAccountRow()
    {
    //WrapAccList=new List<AccountIndexWrapper>(); 
    WrapAccList.remove(rowToRemove );
    return null;
        
    }
    public  PageReference   addAccountRow()
    {
    
     AccountIndexWrapper  newAccountWrap=new AccountIndexWrapper();
     Account newAccountRecord = new Account();
     newAccountWrap.record = newAccountRecord ;
     newAccountWrap.index =  WrapAccList.size();
     WrapAccList.add(newAccountWrap);
     return null;
    }

    public PageReference SaveMultipleAccounts()
    {
        
        List<Account> accountRecordsToBeInserted = new List<Account>();
        if(WrapAccList!=null && WrapAccList.size()>0)
        {
            for(AccountIndexWrapper accwrap:WrapAccList)
            {
                accountRecordsToBeInserted.add(accwrap.record);
            }
        }
        if(accountRecordsToBeInserted!=null && accountRecordsToBeInserted.size()>0)
        {
            insert accountRecordsToBeInserted;
        }
        return null;
        
    }

    }