public class ServerSideController {
@AuraEnabled
    public static List<Account> getAnAccountName(){
        list<Account> alist = [SELECT id,Name FROM Account limit 10];
        if ( alist.size() == 0 ) {
            AuraHandledException e = new AuraHandledException('No Accounts Found');
            e.setMessage('No Accounts Found');
            throw e;
        }
        return alist;
    }
}