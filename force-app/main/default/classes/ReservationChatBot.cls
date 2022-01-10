public class ReservationChatBot {
    
    @InvocableMethod
    public static List<Account> fetchResturantDetail() {
        List<Account> lstAccount = [select id,Name from Account limit 3];
        return lstAccount;
    }
    }