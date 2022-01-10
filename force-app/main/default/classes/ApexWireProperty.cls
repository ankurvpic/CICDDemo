public with sharing class ApexWireProperty {
    public ApexWireProperty() {
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
            return [select id,Name from Account limit 10];
    }
}