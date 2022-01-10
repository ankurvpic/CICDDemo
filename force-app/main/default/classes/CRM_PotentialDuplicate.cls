public class CRM_PotentialDuplicate{
@AuraEnabled
 public static MetaDataWrapper fetchMetaDataComponent(String sObjectName,String sObjectRecordId){
     MetaDataWrapper objMetadata = new MetaDataWrapper();
     
     List<FieldDataWrapper> objWrapperList = new List<FieldDataWrapper> ();
     Map<String,Object> mapOfDuplicateFieldWithValue = new Map<String,Object> ();
     //Fetch Data From which we needs to fetch duplicate
     
     List<CRM_Potential_Duplicate__mdt> lstMetadataComp = [select id, CRM_SObjectType__c, CRM_Field_API_Name__c, CRM_Field_Label__c, CRM_Duplicate_Fields__c from CRM_Potential_Duplicate__mdt where 
                                 CRM_SObjectType__c =: sObjectName];
     if(lstMetadataComp != null && lstMetadataComp.size()>0){
         String fieldLabel = lstMetadataComp[0].CRM_Field_Label__c;
         String fieldAPIName = lstMetadataComp[0].CRM_Field_API_Name__c;
         String duplicateFields = lstMetadataComp[0].CRM_Duplicate_Fields__c;
         List<Object> lstBaseRecord = fetchBaseData(sObjectName,duplicateFields,sObjectRecordId);
         
         Map<String, Object> queriedFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(lstBaseRecord[0]));
         
         SObjectType sObjectInstanse = Schema.getGlobalDescribe().get(sObjectName);
         Map<String,Schema.SObjectField> mfields = sObjectInstanse.getDescribe().fields.getMap();
         
         List<Schema.SObjectField> lstSObjectField = new List<Schema.SObjectField> ();
         System.debug('==mfields=='+mfields);
         System.debug('==='+fieldAPIName);
         for(String str : fieldAPIName.split('\\,')){
             lstSObjectField.add(mfields.get(str));
         }
         
         for(Schema.SObjectField objField : lstSObjectField){
             FieldDataWrapper objFieldWrapper = new FieldDataWrapper();
             objFieldWrapper.label = objField.getDescribe().getLabel();
             objFieldWrapper.fieldName = objField.getDescribe().getName();
             objFieldWrapper.type = objField.getDescribe().getType();
             objWrapperList.add(objFieldWrapper);
         }
         //Fetch record based on dynamic query
         List<Object> lstRecord = fetchDuplicateRecord(sObjectName,fieldAPIName,queriedFieldValues,sObjectRecordId);
         
         //String strQuery = 'Select '+ fieldAPIName + ' From ' + sObjectName +' limit 10';
         //List<SObject> lstRecord = DataBase.query(strQuery);
         system.debug('==lstRecord=='+lstRecord);
         if(lstRecord != null && lstRecord.size()>0){
             objMetadata.columnList = objWrapperList;
             objMetadata.lstData = lstRecord;
             
         }
     } 
     return objMetadata;         
 }
   public static List<Object> fetchBaseData(String sObjectType,string duplicateFields,String recordId){
   
       String strQuery = 'Select '+ duplicateFields + ' From ' + sObjectType + ' where Id =\''+ recordId+'\'';
       System.debug('==strQuery=='+strQuery);
       List<Object> lstBaseRecord = DataBase.query(strQuery);
       return lstBaseRecord; 
   }
   public static List<Object> fetchDuplicateRecord(String sObjectType,string fieldsToDisplay,Map<String, Object> queriedFieldValues,String recordId){
       String whereClause = '';
       System.debug('===key=='+queriedFieldValues.keySet());
       for(String queriedFieldName : queriedFieldValues.keySet())
       {
           // Skip this information, its not a field
            if(!String.escapeSingleQuotes(queriedFieldName).equals('attributes') && !String.escapeSingleQuotes(queriedFieldName).equals('Id'))
             {   
                // Check if the queried value represents a related field reference?
                Object queriedFieldValue = queriedFieldValues.get(String.escapeSingleQuotes(queriedFieldName));
                
                whereClause += queriedFieldName +' =\''+ queriedFieldValue + '\''+' And ';
            }
       }
       if(String.isNotBlank(whereClause)){
           whereClause += ' Id != \''+ recordId+'\'';
       }
       
       System.debug('==whereClause=='+whereClause);
       String strQuery = 'Select '+ fieldsToDisplay + ' From ' + sObjectType + ' where ' + whereClause;
       
       System.debug('===strQuery=='+strQuery);
       List<Object> lstDuplicateRecord = DataBase.query(strQuery);
       return lstDuplicateRecord; 
   }
    public class MetaDataWrapper{
         @AuraEnabled
         public List<FieldDataWrapper> columnList{get;set;}
         @AuraEnabled
         public List<Object> lstData{get;set;}
         
     }
     public class FieldDataWrapper{
         @AuraEnabled
         public string label;
         @AuraEnabled
         public string fieldName;
         @AuraEnabled
         public Schema.DisplayType type;
     
     }
     
 }