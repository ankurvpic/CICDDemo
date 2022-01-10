public class MemberPopup 
{
    public List<Lead> memberList {get;set;}
    public List<Lead> memberAddList {get;set;}
    public String memberName {get;set;}   
     
    public MemberPopup()
    {
        String sql = 'SELECT Name, email FROM Lead';
        memberList = Database.Query(sql);
        memberAddList = new List<Lead>();
        memberAddList.add(new Lead());
    }
    
    public void AddRow()
    {
        memberAddList.add(new Lead());
    }  
}