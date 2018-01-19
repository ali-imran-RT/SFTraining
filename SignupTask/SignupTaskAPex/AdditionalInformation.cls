public class AdditionalInformation {
    Public String Language{get;set;}
    Public String Description{get;set;}
    Public String Level{get;set;}
    Public List<SelectOption>LevelsDropDown{get;set;}
    
    public AdditionalInformation(){
        LevelsDropDown = new List<SelectOption>();
        LevelsDropDown.add(new SelectOption('Primary','Primary'));
        LevelsDropDown.add(new SelectOption('Secondary','Secondary'));
        LevelsDropDown.add(new SelectOption('Tertiary','Tertiary'));
    }
    
    public void SaveInfo(Contact con){
        con.Languages__c = this.Language;
        con.Description = this.Description;
        con.Level__c = this.Level;
    }
}