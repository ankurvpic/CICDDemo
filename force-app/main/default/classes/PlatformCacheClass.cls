global class PlatformCacheClass {
    Cache.OrgPartition orgPart ;
    
    public PlatformCacheClass(){
                
    }
    public SObject fetchData(String ObjectType,String leadid){
        String keytoStoreorRet = leadid;
        If(checkKeyInCache(keytoStoreorRet)){
            System.debug('==========From Cache');
            System.debug('========Field'+Cache.Org.get(keytoStoreorRet));
            Opportunity objOpp = (Opportunity)Cache.Org.get(keytoStoreorRet);
            return (sObject)Cache.Org.get(keytoStoreorRet);
            
        }else{
            
            String objType = ObjectType;
            Map<String,Schema.SObjectField> mfields;
            String queryString;
            String lead_id = leadid;
            SObjectType sObj = Schema.getGlobalDescribe().get(objType);
            mfields = sObj.getDescribe().fields.getMap();
            system.debug('mfields '+mfields );
            queryString='select ';
            for(String q:mfields.keySet())
            {
            queryString+=q+',';
            }
            queryString =queryString.substring(0,queryString.length()-1);
            if(objType == 'Lead')
            {
                queryString =queryString +'from'+ objType + 'where IVL_Lead_Id__c=:'+lead_id+'and IsConverted = false'; 
            }
            else
            {
                queryString =queryString +' from ' + objType + ' where IVL_Lead_Id__c=: lead_id';
            }
            System.debug('======='+queryString );
            sObject objsObject=(sObject)Database.query(queryString);
            if(objsObject!=null)
            {
                //Cache.Org.put(lead_id , objsObject);
                updateKeyinCache(lead_id,objsObject);
            }
            System.debug('======='+Cache.Org.get(lead_id ));
            
            return objsObject;
        }
        
    }
    
    
    public void updateKeyinCache(String key ,SObject values){
        if(!checkKeyInCache(key)){
            Cache.Org.put(key, values);
        }
    }
    public boolean checkKeyInCache(String key){
        if (Cache.Org.contains(key)) {
        System.debug('========'+Cache.Org.contains(key));
            return true ; 
        }else{
            return false ; 
        }
        
    }
    
}