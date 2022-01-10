public class AM_NotifyDetail {

    public AM_NotifyDetail(ApexPages.StandardController controller) {
        
       //=new List<Event>();
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
    Id leadid=apexpages.currentPage().getParameters().get('id');
    List<Event> lstevent=[select id,Owner.name,Owner.email,ActivityDate,Subject,who.Name,whoid,ActivityDateTime,StartDateTime,EnddateTime,Type from Event where whoid =: leadid ];
        System.debug('++++++lstevent'+lstevent);
    if(lstevent != null && lstevent.size()>0)
       {
            for(Event ev:lstevent)
            {
                if(ev.WhoId !=null && string.valueOf(ev.WhoId.getSobjectType())=='Lead')
                {
                   //mail = new Messaging.SingleEmailMessage();
                   List<String> sendTo = new List<String>();
                    String body='';
                   sendTo.add(ev.owner.email);
                                      
                   mail.setToAddresses(sendTo);
                    system.debug('++++++sendTo'+sendTo);
                      mail.setTargetObjectId(ev.owner.id);
                   mail.setSubject('Reminder Notification For future appointments');
                   mail.setSaveAsActivity(false);
                   
                   body = '<b>*** Reminder Notification For future appointments and Link of FF1***</b>'+'<br/><br/><br/>';
                   body += '<b>Name : </b>'+ev.Who.Name+'<br/>';
                   body += '<b>Due Date : </b>'+ev.StartDateTime+'<br/>';
                   body += '<b>Subject : </b>'+ev.Subject+'<br/>';
                   
                   body += 'Please view the FF1 Form on click link below.'+'<br/>';
                   //body+= '<a href="https://google.com">click here</a>';
                   body += 'Thanks';
                   
                   mail.setHtmlBody(body);
                   
                   mails.add(mail);
                    
                }
                
            }
       }
    else
    {
          
    }
    
    if(mails.size()>0)
    {   
        System.debug('++++hi+++'+mails);
        Messaging.sendEmail(mails);
        System.debug('++++hello+++'+mails);
    }
    }

    public void SendEmail()
    {
    
    }

}