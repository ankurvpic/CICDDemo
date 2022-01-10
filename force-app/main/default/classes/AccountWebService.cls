@RestResource(urlMapping='/AccountRest/*')
global with sharing class AccountWebService {

    @HttpGet
    global static Account getAcccById() {
        RestRequest request = RestContext.request;
        // grab the AccountId from the end of the URL
        String AccId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Id,Name
                        FROM Account
                        WHERE Id = :AccId];
        return result;
    }

    @HttpPost
    global static ID createAccount(String AccName) {
        Account thisAcc = new Account(
            Name=AccName);
        insert thisAcc;
        return thisAcc.Id;
    }   

    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String AccId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account thisAcc = [SELECT Id FROM Account WHERE Id = :AccId];
        delete thisAcc;
    }   

}