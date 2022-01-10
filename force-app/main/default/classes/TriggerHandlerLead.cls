public class TriggerHandlerLead {
    public void runTrigger()
    {
    
        if(trigger.isBefore && trigger.isInsert)
        {
            onBeforeInsert((list<Lead>)trigger.new); 
        }    
    }
    Public Void onBeforeInsert(List<Lead> triggerNew)
    {
        List<MOSData__c> moslst=new List<MOSData__c>();
        String s='';
       for(Sobject l:triggerNew)
       {
        Map<String,Schema.SObjectType> SchemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType ObjSchema = SchemaMap.get('lead');
        Map<String, Schema.SObjectField> FieldMap = ObjSchema.getDescribe().fields.getMap();
           Map<Schema.SObjectField,string> val=new Map<Schema.SObjectField,string>();
        system.debug('-----FieldMap-----'+FieldMap);
           for (String FieldName: FieldMap.keySet()) 
               { 
                s+='<'+FieldName+'>'+l.get(FieldName)+'</'+FieldName+'>';
                  
                }
           System.debug('+++++'+s);
           SobjectField sob=FieldMap.get('CheckData__c');
           System.debug('+++++'+sob);
           //Schema.getGlobalDescribe().get('Lead').getDescribe().fields.getMap().get('CheckData')=s;
           
           
                      
           
            
           
           
           
       }
        
       }
        
        
       
       
        
    

}