public with sharing class AccountListController
{
@AuraEnabled(cacheable=true)

public static List<Account> getAccounts()
{
List<Account> acclst = [select id,name,phone,type from Account limit 10];
return acclst;
}
}