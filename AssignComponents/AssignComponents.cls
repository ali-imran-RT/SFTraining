public with sharing class AssignComponents {
    public String avaClickedName{get;set;}
    public String selClickedName{get;set;}
    public String PopUpUrl{get;set;}
    public String ClickedItem{get;set;}
    public String avaSearch {get;set;}
    public String selSearch {get;set;}
    public Component__c [] Avail{get;set;}
    public Component__c [] Slect{get;set;}
    public boolean Popup{get;set;}
    public Component__c ComponentToEdit{get;set;}
    
    public void showPopup(){
        this.ComponentToEdit = [select name,material_price__c,quantity__c from component__c where id=:this.ClickedItem];
        System.debug(''+this.ClickedItem);
        this.PopUpUrl = this.PopUpUrl +''+this.ComponentToEdit.id;
        
        this.Popup= true;
    }
    
    public void closePopup(){
        this.Popup= false;
    }
    
    public void hidePopup(){
        update ComponentToEdit;
        
        this.Avail = [select name,material_price__c,quantity__c from component__c where finished_good__c = null];
        this.Slect = [select name,material_price__c,quantity__c from component__c where finished_good__c != null];
 
        //PageReference p=new Pagereference('/assigncomponents');
        //p.setRedirect(true);
        this.Popup= false;
        //return p;
    }
    
    public AssignComponents(ApexPages.StandardController controller){
        this.PopUpUrl = '/apex/EditPopup?id=';
        this.Popup = false;
        this.avaSearch = '';
        this.selSearch = '';
        this.Avail = [select id,name,material_price__c,quantity__c from component__c where finished_good__c = null];
        this.Slect = [select id,name,material_price__c,quantity__c from component__c where finished_good__c != null];
    }
    public void avaupdate(){
        string para = '%'+avaSearch+'%';
        this.Avail = [select id,name,material_price__c,quantity__c from component__c where finished_good__c = null and name like :para];
    }
    
    public void selupdate(){
        string para = '%'+selSearch+'%';
        this.Slect = [select id,name,material_price__c,quantity__c from component__c where finished_good__c != null and name like :para];
    }
    
    public void addtoava(){
        Component__c[] c = [Select id, name,Finished_good__c from Component__c where name = :selClickedName];
        
        if(c.size()>0){
            c[0].Finished_Good__c = null;
            update c;    
        }
        
        this.Avail = [select id,name,material_price__c,quantity__c from component__c where finished_good__c = null];
        this.Slect = [select id,name,material_price__c,quantity__c from component__c where finished_good__c != null];
     }
    
    public void addtosel(){
        Component__c[] c = [Select id, name,Finished_good__c from Component__c where name = :avaClickedName];
        Finished_Good__c[] FG = [Select id from Finished_good__c where name='Laptop'];
        
        if(c.size()>0 && FG.size()>0){
            c[0].Finished_Good__c = FG[0].id;
            update c;            
        }
        
        this.Avail = [select name,material_price__c,quantity__c from component__c where finished_good__c = null];
        this.Slect = [select name,material_price__c,quantity__c from component__c where finished_good__c != null];
 
    }
    
}