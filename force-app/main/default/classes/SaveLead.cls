public class SaveLead {
public id leadid{get;set;}
public Map<String,Schema.SObjectField> mfields{get;set;}
public String s{get;set;}
public String xmlstring{get;set;}
public String key{get;set;}
public List<Lead> lst{get;set;}

   
    /*private ApexPages.StandardController stdController  { get; set; }
    Lead l{get;set;}
    public SaveLead(ApexPages.StandardController stdController)
    {
     this.stdController = stdController;
        l=(Lead)this.stdController.getRecord();
    }

    public PageReference saveAndReturn()
        {
            stdController.save();
            
            PageReference parentPage = new Pagereference('/apex/MosFileGeneration/?id='+l.id);
            parentPage.setRedirect(true);
            return parentPage;
        }*/
        public SaveLead()
        {
		leadid=ApexPages.currentPage().getParameters().get('id');
        mfields=new Map<String,Schema.SObjectField>();
        xmlstring='';
        lst=new List<Lead>();
        s='select ';
		SObjectType accountType = Schema.getGlobalDescribe().get('Lead');
        mfields = accountType.getDescribe().fields.getMap();
        system.debug('mfields '+mfields );
        for(String q:mfields.keySet())
        {
        s+=q+',';
        }
        s=s.substring(0,s.length()-1);
        s=s+' from lead where id=:leadid';
      lst=Database.query(s);
      system.debug('lst'+lst);
      for (String FieldName: mfields .keySet()) 
                   { 
                    xmlstring+='<'+FieldName+'>'+lst[0].get(FieldName)+'</'+FieldName+'>';
                   }
         
        }
 
 	public PageReference pageReferenceMethod()
        {
        system.debug('xmlstring'+xmlstring); 
        PageReference pageRef = new PageReference('/apex/MosFileGeneration?key='+xmlstring);
        pageRef.setRedirect(true);  
        return pageRef; 
        }
}