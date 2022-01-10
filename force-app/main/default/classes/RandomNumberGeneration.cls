public class RandomNumberGeneration{
     
    @AuraEnabled
    Public static String generateRandomNumber()
    {
        Integer randomNumber = Integer.ValueOf(Math.floor(100000 + Math.random() * 9000));
        String hashString = String.valueOf(randomNumber);
        System.debug('==hashString =='+hashString);
        return hashString ;
    }
    }