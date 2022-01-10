public with sharing class PaginationController {
    @AuraEnabled (cacheable=true)
    public static List<Account> retrieveAccounts(){
        return [SELECT Id, Name, Type, BillingCountry
                FROM Account
                LIMIT 1000];
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchOpportunity(List<Id> lstAccid){
        return [Select Id,Name,Account.Name from Opportunity where accountId in:lstAccid];
    }
}