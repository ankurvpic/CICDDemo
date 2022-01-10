public class LeadConversion
{
    public  string leadid {set;get;}
    public List<Lead> lstLeadinfo{set;get;}
    public boolean IsError{set;get;}
    public List<Loan__c> loanlst;
    public List<Loan__c> loanlst1;
    public List<Loan__c> loanlst2;
    public List<Loan__c> loanlst3;
    public loan__c loan {set;get;}
    public string name{set;get;}
    Public Id accId{set;get;}
    Integer keysize=0;
    public Map<String,list<loan__c>> loanpurposeMap;
    public LeadConversion(ApexPages.StandardController controller)
     {
        leadid = Apexpages.currentPage().getParameters().get('id');
        
        lstLeadinfo=[select id,IsConverted,company,firstname,lastname,MobilePhone,Email,(select id,name,purpose__c,property__c from Loans__r) from lead where id=:leadid ];
        if(lstLeadinfo[0].IsConverted )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'You can not convert this lead because this lead already converted by user '));
            IsError=true;
        }
        else
        {
        if(!lstLeadinfo.isEmpty())
            {
                IsError=false;
            }
        }

    }
    Public pagereference AT_convertLead()
    {
    List<Opportunity> lstOppInsert = new list<Opportunity>();
    loanpurposeMap=new Map<String,List<Loan__c>>();
    loanlst=new List<Loan__c>();
    loanlst1=new List<Loan__c>();
    loanlst2=new List<Loan__c>();
    loanlst3=new List<Loan__c>();
    if(lstLeadinfo[0].loans__r.size()>0)
    {
        for(Loan__c loan:lstLeadinfo[0].loans__r)
              {
                IF(loanpurposeMap.containsKey(loan.purpose__c))
                {
                    loanpurposeMap.get(loan.purpose__c).add(loan);
                }
                else
                {
                    loanpurposeMap.put(loan.purpose__c,new List<Loan__c>{loan});
                }
            
          }
      }
     Database.LeadConvert lc = new database.LeadConvert(); 
     lc.setLeadId(lstLeadinfo[0].id);
     LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
     lc.setConvertedStatus(convertStatus.MasterLabel);
      Database.LeadConvertResult lcr = Database.convertLead(lc);
      id Convertedaccountid = lcr.getAccountId();
      id ConvertOpportunityid=lcr.getOpportunityId();
      Opportunity firstOpp=[select id,name from Opportunity where id=:ConvertOpportunityid limit 1];
      //firstOpp
      System.debug('+++++++++++++++'+ConvertOpportunityid);
      System.debug('+++++++++++++++'+lstLeadinfo[0].loans__r);
      String fkey=loanpurposeMap.keySet().iterator().next();
      loanlst=loanpurposeMap.get(fkey);
      for(Loan__c l:loanlst)
        {
            l.Opportunity__c=ConvertOpportunityid;
            loanlst3.add(l);
                
        }
      
      update loanlst3;
      
     //Loan__c loan=new Loan__c(name='testloan',Opportunity__c=ConvertOpportunityid);
      try{
      update loanlst;
      }
      catch(Exception e)
      {
      System.debug(e);
      }
      Account acc=[select name,id from account where id=:Convertedaccountid];
      
      update acc;
      
      for(String s:loanpurposeMap.keySet())
      {
      if(fkey!=s)
      {
         integer i=1;
        Opportunity opp=new Opportunity(name= acc.name+''+i++
                                            , AccountId = Convertedaccountid
                                            , StageName = 'Prospecting'
                                            , CloseDate = Date.today(),purpose__c=s);
            lstOppInsert.add(opp);
            }
      }
      
      insert lstOppInsert;
        
      for(Opportunity op:lstOppInsert)
      {
         loanlst1=loanpurposeMap.get(op.purpose__c); 
         for(Loan__c l:loanlst1)
             {
                l.opportunity__c=op.id;
                loanlst2.add(l);
             }
      } 
      update loanlst2;
      pagereference page = new pageReference('/'+Convertedaccountid);
      
      return page;
    }
    public pagereference AT_Onload()
    {
        pagereference pr;
        if(lstLeadinfo.size()!=null && IsError==false)
        {
           pr =AT_convertLead();
            return pr;
        }
        return null;
    }

}