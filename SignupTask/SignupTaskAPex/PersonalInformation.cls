public class PersonalInformation {
    public String FirstName{get;set;}
    public String LastName{get;set;}
    public String Email{get;set;}
    Public String Owner{get;set;}
    Public String selected{get;set;}
    Public List<SelectOption> Salutations{get;set;}
    
    public PersonalInformation()
    {
        Salutations = new List<SelectOption>();
        Salutations.add(new SelectOption('','--None--'));
        Salutations.add(new SelectOption('Mr.','Mr.'));
        Salutations.add(new SelectOption('Ms.','Ms.'));
        Salutations.add(new SelectOption('Mrs','Mrs'));
        Salutations.add(new SelectOption('Dr.','Dr.'));
        Salutations.add(new SelectOption('Prof.','Prof.'));
    }
    
    public void SaveInfo(Contact con){
        con.FirstName = this.FirstName;
        con.LastName = this.LastName;
        con.Email = this.Email;
        con.Salutation = this.selected;
    }
    
}