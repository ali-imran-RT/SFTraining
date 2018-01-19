public class ContactInformation {
    public String Phone{get;set;}
    public String HomePhone{get;set;}
    public String Department{get;set;}
    public String Fax{get;set;}
    public String OtherPhone{get;set;}
    
    public void SaveInfo(Contact con){
        con.Phone = this.Phone;
        con.HomePhone = this.HomePhone;
        con.Department = this.Department;
        con.Fax = this.Fax;
        con.OtherPhone = this.OtherPhone;
    }
}