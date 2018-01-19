public class AddressInformation {
    Public String MailingStreet{get;set;}
    Public String MailingCity{get;set;}
    Public String MailingState{get;set;}
    Public String MailingPostalCode{get;set;}
    Public String MailingCountry{get;set;}
    Public string OtherStreet{get; set;}
    Public string OtherCity{get; set;}
    Public string OtherState{get; set;}
    Public string OtherPostalCode{get; set;}
    Public string OtherCountry{get; set;}
    
    public void SaveInfo(Contact con){
        con.MailingStreet = this.MailingStreet;
        con.MailingCity = this.MailingCity;
        con.MailingState = this.MailingState;
        con.MailingPostalCode = this.MailingPostalCode;
        con.MailingCountry = this.MailingCountry;
        con.OtherStreet = this.OtherStreet;
        con.OtherCity = this.OtherCity;
        con.OtherState = this.OtherState;
        con.OtherPostalCode = this.OtherPostalCode;
        con.OtherCountry = this.OtherCountry;
        
    }
}