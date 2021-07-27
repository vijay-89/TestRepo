@isTest
public class TestingUtils {
    
    public static List<Contact> createContacts( Integer numOfContacts, Id accountId, Boolean doInsert ){
        List<Contact> contactList = new List<Contact>();
        for( Integer index = 0; index < numOfContacts; index++ ){
            Contact contact = new Contact();
            contact.LastName = 'TestLast' + index;
            contact.AccountId = accountId;
            contact.Email = 'test' + index + '@test.com';
            contactList.add( contact );
        }
        
        if( doInsert ){
            insert contactList;
        }
        
        return contactList;
    }
    public static Account createAccount(Boolean doInsert){
        Account acc = new Account();
        acc.Name = 'Test Account';
        if(doInsert){
            insert acc;
        }
        return acc;
        
    }
    public static Case createCase(Boolean doInsert){
        Case caseObj = new Case();
        caseObj.status = 'New';
        caseObj.Origin = 'Email';
        
        if(doInsert){
            insert caseObj;
        }
        return caseObj;
        
    }
    public static EmailMessage createEmailMessage(Boolean doInsert,Id caseId){
        EmailMessage em =new EmailMessage();
        //em.incoming = true;
        em.ParentId= caseId;
        em.TextBody='Test Body';
        em.FromAddress='test1@anthem.com';
        em.ToAddress='test2@anthem.com';
        em.subject='Testing';
        if(doInsert){
            insert em;
        }
        return em;
    }
}