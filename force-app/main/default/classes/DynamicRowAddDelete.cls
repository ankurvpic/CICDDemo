public class DynamicRowAddDelete
    {

    public String accwrap { get; set; }

    public String waAccList { get; set; }
    public List<AccountIndexWrapper> WrapAccList {get;set;}
    public Integer rowToRemove {get;set;}

    public DynamicRowAddDelete()
    {

    }
    public class AccountIndexWrapper
    {
        public Integer index {get;set;}
        public Account record {get;set;}
    }

    public List<AccountIndexWrapper> deleteAccountRow()
    {
    WrapAccList.remove(rowToRemove);
    return WrapAccList;
        
    }
    public  List<AccountIndexWrapper> addAccountRow()
    {
     AccountIndexWrapper  newAccountWrap=new AccountIndexWrapper();
     Account newAccountRecord = new Account();
     newAccountWrap.record = newAccountRecord ;
     newAccountWrap.index =  WrapAccList.size();
     WrapAccList.add(newAccountWrap);
     return WrapAccList;
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