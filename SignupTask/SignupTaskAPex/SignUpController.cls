public class SignUpController {
    
    public Contact NewContact{get;set;}
    public PersonalInformation PersonalInfo{get;set;}
    public ContactInformation ContactInfo{get;set;}
    public AddressInformation AddressInfo{get;set;}
    public RelatedTo RelatedToInfo{get;set;}
    Public AdditionalInformation AdditionalInfo{get;set;}
    
    public SignUpController()
    {
        NewContact = new Contact();
        PersonalInfo = new PersonalInformation();
        ContactInfo = new ContactInformation();
        AddressInfo = new AddressInformation();
        RelatedToInfo = new RelatedTo();
        AdditionalInfo = new AdditionalInformation();
        NewContact.Birthdate = null;
        NewContact.ownerId = [select name from user where name like 'Ali Imran' limit 1].id;
        PersonalInfo.Owner = [select name from user where name like 'Ali Imran' limit 1].name;
    }
    
    public PageReference SaveRecord()
    {
        PersonalInfo.SaveInfo(NewContact);
        ContactInfo.SaveInfo(NewContact);
        AddressInfo.SaveInfo(NewContact);
        RelatedToInfo.SaveInfo(NewContact);
        AdditionalInfo.SaveInfo(NewContact);
        
        upsert NewContact;
        System.debug('this is new contact id: '+NewContact.Id);
        SendEmail();
        return new PageReference('https://resourceful-raccoon-171582-dev-ed.lightning.force.com/one/one.app#/sObject/'+NewContact.Id+'/view');
    }
    
    public void SendEmail()
    {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { this.PersonalInfo.Email };
            message.optOutPolicy = 'FILTER';
        message.setTemplateId('00X7F000000lIfXUAU');
        System.debug('this is new contact related account id: '+NewContact.AccountId);
        message.setWhatId(NewContact.AccountId);
        message.setTargetObjectId(NewContact.Id);
        message.setSaveAsActivity(false);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages,false);
        
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
        
        /*Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
        
        // Who you are sending the email to
        mail.toAddresses = new String[] { this.PersonalInfo.Email };
        
        // The email template ID used for the email
        mail.setTemplateId('00X7F000000lIfXUAU');
        
        mail.setWhatId(NewContact.Id);    
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setSenderDisplayName('Salesforce Contact Manager');
        mail.setSaveAsActivity(false);  
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        */
    }
    
    public PageReference NavigateToSignUp(){
        return new PageReference('/apex/SignUp');
    }
    
    public PageReference NavigateToPersoanlInfo(){
        return new PageReference('/apex/Personal_Information');
    }
    
    public PageReference NavigateToContactInfo(){
        Boolean redirect = true;
        if(!validateAlphabets(PersonalInfo.LastName)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Last Name'));
            redirect=false;
        }
        if(!validateEmail(PersonalInfo.Email)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Valid Email'));
            redirect=false;
        }
        if(redirect){
            return new PageReference('/apex/ContactInformation');
        }
        else{
            return null;
        }
        
    }
    
    public PageReference NavigateToRelatedToInfo(){
        Boolean redirect = true;
        if(!validatePhone(ContactInfo.Phone)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Phone '));
            redirect=false;
        }
        if(!validateAlphabets(ContactInfo.Department)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Department'));
            redirect=false;
        }
        if(redirect){
            return new PageReference('/apex/RelatedTo');
        }
        else{
            return null;
        }
        
        
    }
    
    public PageReference NavigateToAddressInfo(){
        Boolean redirect = true;
        if(!validatePhone(RelatedToInfo.AssistantPhone)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Phone '));
            redirect=false;
        }
        
        if(redirect){
            return new PageReference('/apex/AddressInformation');
        }
        else{
            return null;
        }
        
    }
    
    public PageReference NavigateToAdditionalInfo(){
        return new PageReference('/apex/AdditionalInformation');
    }
    
    public PageReference NavigateToPendingInfo(){
        return new PageReference('/apex/Pending');
    }
    
    
    public Boolean validateEmail(String e_mail) {
        Boolean isValid = true;
        if(!Pattern.matches('^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+\\.[com]{2,4}$', e_mail))
            isValid = false;
        return isValid;
    }
    
    public Boolean validateAlphabets(String str) {
        Boolean isValid = true;
        if(!Pattern.matches('[a-zA-Z]+', str) || str.length() == 0)
            isValid = false;
        return isValid;
    }
    
    public Boolean validatePhone(String phone) {
        Boolean isValid = true;
        if(!Pattern.matches('[0-9_+-]+', phone))
            isValid = false;
        return isValid;
    }
}