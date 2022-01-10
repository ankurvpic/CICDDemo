public class TestObject
{
    Map<Id, List<Loan__c>> m1 = new Map<Id, List<Loan__c>>();
    Map<Id, List<Applicant__c>> m2 = new Map<Id, List<Applicant__c>>();
    public List<Loan__c> lstobj{get;set;}
    public List<Applicant__c> lstapp{get;set;}
    Loan__c loan{get;set;}
    public Id leadid{get;set;}
    public TestObject()
    {
      leadid=ApexPages.currentPage().getParameters().get('id');
        for (Lead p : [
        SELECT Id, Name, (SELECT Id, Name,property__c FROM Loans__r)
        FROM Lead where id=:leadid]) {
                                        m1.put(p.Id, p.Loans__r);
                                    }
        for (Lead p : [
        SELECT Id, Name, (SELECT Id, Name FROM Applicants__r)
        FROM Lead where id=:leadid]) {
                                        m2.put(p.Id, p.Applicants__r);
                                    }
        System.debug('++++++m1'+m1);
        System.debug('++++++m1'+m2);
         lstobj=m1.get(leadid);
         lstapp=m2.get(leadid);
         
    }
    
  public PageReference saveLeadDeatil()
  {
          if(leadid!= null)
        {
        update lstobj;
        }  
return null;
}
}