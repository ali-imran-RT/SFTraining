public class RelatedTo {
    Public List<Account> AccountName{get;set;}
    Public List<Contact> ReportTo{get;set;}
    Public List<SelectOption>AccountNameList{get;set;} 
    Public List<SelectOption>ReportToList{get;set;}
    Public String AssistantPhone{get;set;}
    Public String SelectedAccount{get;set;}
    public String SelectedContact{get;set;}
    
    public RelatedTo()
    {
        AccountName = [select Name from account];
        ReportTo = [select Name from contact];
        
        AccountNameList = new List<SelectOption>();
        ReportToList = new List<SelectOption>();
        
        for(Account acc:AccountName){
            AccountNameList.add(new SelectOption(acc.Name,acc.Name));
        }
        
        for(Contact con:ReportTo){
            ReportToList.add(new SelectOption(con.Name,con.Name));
        }
    }
    
    public void SaveInfo(Contact con){
        con.AssistantPhone = this.AssistantPhone;
        con.AssistantName = this.SelectedContact;
        String searchCriteria = '%'+this.SelectedAccount+'%';
        Account selAccountid = [select id from Account where name like :searchCriteria];
        con.AccountId = selAccountid.Id;
        
    }
}