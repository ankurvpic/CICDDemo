public class TriggerHandlerChild {
    public void runTrigger()
    {
    
        if(trigger.isAfter && trigger.isInsert)
        {
            onAfterInsert((list<Lead>)trigger.new); 
        }    
    }
    Public Void onAfterInsert(List<Lead> triggerNew)
    {
     List<Loan__c> lstloan=new List<Loan__c>();
     for(lead l:triggerNew)
     	{
          Loan__c loan=new Loan__c(name=l.company,Lead__c=l.id); 
            lstloan.add(loan);
		}
       insert lstloan; 
    }

}