public class TestController1{
   public list<Account> tableRows{get;set;}
 public TestController1(){
     tableRows = [select id,Name from Account limit 5];
 }
 public pageReference getfilter1(){
     tableRows = [select id,Name from Account limit 2];
     return null;
 }

}