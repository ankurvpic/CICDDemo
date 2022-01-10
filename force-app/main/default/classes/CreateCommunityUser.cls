global class CreateCommunityUser {
  @auraEnabled 
  WebService static string createUserFromContact(String contactId) {
    Contact objectContact = [SELECT FirstName,LastName,Email,AccountId 
                       FROM Contact Where Email <> null AND Id =: contactId LIMIT 1];
    try {
      //Select community profile that you want to assign
      Profile pf = [SELECT Id FROM profile 
                    WHERE name='Partner Community Login User' LIMIT 1];
      //Create user 
      User newCommunitiesUser = new User(contactId=objectContact.Id, 
                          username=objectContact.Email, 
                          firstname=objectContact.FirstName,
                          lastname=objectContact.LastName, 
                          email=objectContact.Email,
                          communityNickname = objectContact.LastName + '_'+Math.random(),
                          alias = string.valueof(objectContact.FirstName.substring(0,1) + 
                                  objectContact.LastName.substring(0,1) + Math.random() ).substring(0,5), 
                          profileid = pf.Id, emailencodingkey='UTF-8',
                          languagelocalekey='en_US', 
                          localesidkey='en_US', 
                          timezonesidkey='America/Los_Angeles');                  
      insert newCommunitiesUser;
      return 'Contact Converted into partner community';
    } catch(DMLException ex) {
        if(ex.getDMLMessage(0).contains('Duplicate Username')) {
          return '[ERROR] Cannot enable communities access, a user with this email address already exists.';
        }
        return ex.getDMLMessage(0);
    }
  }
}