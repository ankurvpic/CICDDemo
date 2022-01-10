//Simple Demo Program for Inserting Cache via Apex Instance
public class IVL_CacheDemoClass
{
    
  public String Name;
  public String leadId;
  public void cacheDemo()
  {
      Opportunity objOpp = [Select id,Name,IVL_Lead_Id__c from Opportunity where IVL_Lead_Id__c =:'2300001' limit 1];
      IVL_CacheDemoClass objCache = new IVL_CacheDemoClass();
      objCache = fillData(objOpp);
      String baseLeadId = objOpp.IVL_Lead_Id__c;
      //Filling Cache Data with Lead Id as a key
      for(Integer i=0;i<5000;i++)
      {
          Cache.Org.put(baseLeadId + i,objCache);
      }
  }
 
 public static IVL_CacheDemoClass fillData(Opportunity objOpp)
    {
        IVL_CacheDemoClass objDemo = new IVL_CacheDemoClass();
        objDemo.leadId = objOpp.IVL_Lead_Id__c ;
        objDemo.Name = objOpp.Name;
        return objDemo;
    } 
}