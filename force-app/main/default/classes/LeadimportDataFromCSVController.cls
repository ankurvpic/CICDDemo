public class LeadimportDataFromCSVController {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public String[] header{get;set;}
public List<SObject> Leadlist{get;set;}
public Map<String,Schema.SObjectField>mfields{get;set;}
public Map<Integer,Schema.SObjectField> finalmap{get;set;}
  public LeadimportDataFromCSVController()
  {
    csvFileLines = new String[]{};
    Leadlist= New List<SObject>();
    mfields=new Map<String,Schema.SObjectField>(); 
    SObjectType accountType = Schema.getGlobalDescribe().get('Lead');
    mfields = accountType.getDescribe().fields.getMap(); 
  }
  
  public void importCSVFile(){
       try{
           finalmap=new Map<Integer,Schema.SObjectField>();
           csvAsString = csvFileBody.toString();
           System.debug('++test+++'+csvAsString );
           
           csvFileLines = csvAsString.split('\r\n');
           header=csvFileLines[0].split(',');
           System.debug('++header+++'+header+'****');
           for(integer i=0;i<header.size();i++)
           {
             System.debug('+++check+++'+header[i]);
                 finalmap.put(i,mfields.get(header[i]));
             
           }
           System.debug('++++final map+++'+finalmap);
           System.debug('++test+++'+csvFileLines ); 
            
           for(Integer i=0;i<csvFileLines.size();i++){
           integer k=0;
               SObject leadObj= new Lead() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               leadObj.put(finalmap.get(k),csvRecordData[k]);
               leadObj.put(finalmap.get(++k),csvRecordData[k]);
               leadObj.put(finalmap.get(++k),csvRecordData[k]);
               leadObj.put(finalmap.get(++k),csvRecordData[k]);
               //leadObj.put(finalmap.get(k++),csvRecordData[4]);
               //accObj.Parent.Name=csvRecordData[2];
                System.debug('+++++++++++++'+leadObj);                                                                           
               Leadlist.add(leadObj);   
           }
           System.debug('+++++++++++++'+Leadlist);
        insert Leadlist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error occured on Importing data');
            ApexPages.addMessage(errorMessage);
        }  
  }
}