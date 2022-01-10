public class CryptoUtil
{
    // This should be stored and referred from custom setting.
    static Blob encryptionKey = Blob.valueOf('5Hye9rRl3QABTWMpkLoOMmy9CNOHxdxY9iisIhm5Poo=');
     //static Blob encryptionKey = Blob.valueOf('7P/Z4vsPE+glYpFlMavyJ1dXm6pYIpJQCz4ADelg5WI=');
    public static string encyptData(String decryptedString)
    {
        Blob data = Blob.valueOf(decryptedString);
        Blob encryptedBlobData = Crypto.encryptWithManagedIV('AES256', encryptionKey , data );
        String base64EncryptedString = EncodingUtil.base64Encode(encryptedBlobData);
        return base64EncryptedString;
    }
   
    public static string decryptData(String encryptedString)
    {
        Blob data = EncodingUtil.base64Decode(encryptedString);
        Blob decryptedBlobData = Crypto.decryptWithManagedIV('AES256', encryptionKey , data);
        String decryptedString= decryptedBlobData.toString();
        return decryptedString;
    }
 
}