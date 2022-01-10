public class CommonClass
{
public static list<picklistFieldsWrapper> getPickListValuesCommon(String sObjectName, String fieldName){
    
        list<picklistFieldsWrapper> Options = new list<picklistFieldsWrapper>();   
        Schema.SObjectType t = Schema.getGlobalDescribe().get(sObjectName);        
        Schema.DescribeSObjectResult r = t.getDescribe();       
        Schema.DescribeFieldResult fieldResult = r.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            picklistFieldsWrapper option = new picklistFieldsWrapper();
            option.label = p.getLabel();
            option.value = p.getValue();            
            Options.add(option);
        }
        return Options;
    }
    public class picklistFieldsWrapper{
        @AuraEnabled public String label;
        @AuraEnabled public String value;
    } 
}