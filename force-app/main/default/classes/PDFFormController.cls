public class PDFFormController
{
    public ApexPages.StandardController stdController;
    public List<LoanWrapperClass> lstloan{get;set;}
    public List<Lead> lstlead{get;set;}
    public Lead ld{get;set;}
    public Id leadId{get;set;} 
    public PDFFormController(ApexPages.StandardController stdController)
    {
        this.stdController = stdController;
    }
    public PDFFormController()
    {
        leadId = ApexPages.currentPage().getParameters().get('id');
        lstloan=new List<LoanWrapperClass>();
        fetchlstLead(leadId);
    }
    public PageReference fetchlstLead(Id leadId1)
    {
        lstlead=[select id,name from Lead where id=: leadId1];
        for(Lead ld:lstlead)
        {
            lstloan.add(new LoanWrapperClass(ld.id));
        }
        return null;
    }
    public class LoanWrapperClass
    {
        public List<Loan__c> lstloan{get;set;}
        LoanWrapperClass(Id leadId2)
        {
            lstloan=new List<Loan__c>();
            
            for(Loan__c loan:[select id,name,property__c from loan__c where lead__c=:leadId2])
            {
                lstloan.add(loan);
            }   
        }
        
    }
    
    public PageReference save()
    {
        PageReference save = stdController.save();
        stdController.save();
        return save;
    }
    
    
}