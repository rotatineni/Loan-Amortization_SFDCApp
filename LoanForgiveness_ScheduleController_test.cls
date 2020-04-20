@isTest(SeeAllData=true)
public class LoanForgiveness_ScheduleController_test {    
    static testMethod void testLoanForgiveness_test(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender1@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
               
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                              
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c = 15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Loan_Term__c=24;
        lr.Loan_Term_In_Years__c='2';
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;       
        lr.Loan_Type__c = 'Target';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();
        loanWrap.Year=1;
        loanWrap.Amortization=60;
        loanWrap.YearlyPrincipal=600;
        loanWrap.YearInterest=150;
        loanWrap.YearPayment=750;
        loanWrap.TargetRevenue=1;
        loanWrap.BeginningBalance=1000;
        loanWrap.EndingBalance=400;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3'; 
        
        loanWrap.Year=2;
        loanWrap.Amortization=40;
        loanWrap.YearlyPrincipal=400;
        loanWrap.YearInterest=60;
        loanWrap.YearPayment=460;
        loanWrap.TargetRevenue=2;
        loanWrap.BeginningBalance=400;
        loanWrap.EndingBalance=0;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3';
        
        ApexPages.currentPage().getParameters().put('Amortization',String.valueOf(loanWrap.Amortization));
        ApexPages.currentPage().getParameters().put('yearValue',String.valueOf(loanWrap.Year));
        
        lc.createWrapperList();
        lc.wrapperRecalculation();
        lc.calculateYearlyPrincipal();               
        lc.validateTargetRevenue();               
        lc.submitButton(); 
        test.stopTest(); 
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    } 
    static testMethod void testLoanForgiveness_test1(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender2@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                              
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c = 15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Term__c=24;
        lr.Loan_Term_In_Years__c='2';
        lr.Loan_Type__c = 'Target';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();
        
        loanWrap.Year=1;
        loanWrap.Amortization=60;
        loanWrap.YearlyPrincipal=600;
        loanWrap.YearInterest=150;
        loanWrap.YearPayment=750;
        loanWrap.TargetRevenue=1;
        loanWrap.BeginningBalance=1000;
        loanWrap.EndingBalance=400;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3';
        
        loanWrap.Year=2;
        loanWrap.Amortization=40;
        loanWrap.YearlyPrincipal=400;
        loanWrap.YearInterest=60;
        loanWrap.YearPayment=460;        
        loanWrap.BeginningBalance=400;
        loanWrap.EndingBalance=0;
        loanWrap.TargetRevenue=2;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3';
        ApexPages.currentPage().getParameters().put('amortization',String.valueOf(loanWrap.Amortization));
        ApexPages.currentPage().getParameters().put('yearValue',String.valueOf(loanWrap.Year));
        
        lc.createWrapperList();
        lc.wrapperRecalculation();
        lc.calculateYearlyPrincipal();               
        lc.validateTargetRevenue();               
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test2(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender3@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                             
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c = 15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;
        l1099.X1099_Principal__c=600;
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 60;
        l1099.Beginning_Balance__c= 1000;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;            
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();
        
        loanWrap.Year=1;
        loanWrap.Amortization=60;
        loanWrap.YearlyPrincipal=600;
        loanWrap.YearInterest=150;
        loanWrap.YearPayment=750;
        loanWrap.TargetRevenue=1;
        loanWrap.BeginningBalance=1000;
        loanWrap.EndingBalance=400;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3';      
        
        ApexPages.currentPage().getParameters().put('amortization',String.valueOf(loanWrap.Amortization));
        ApexPages.currentPage().getParameters().put('yearValue',String.valueOf(loanWrap.Year));
        
        lc.createWrapperList();
        lc.wrapperRecalculation();
        lc.calculateYearlyPrincipal();               
        lc.validateTargetRevenue();               
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test3(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender4@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();  
        lr.Rep_Name__c = con.id;                                          
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c = 15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;
        l1099.X1099_Principal__c=600;
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 60;
        l1099.Beginning_Balance__c= 1000;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;            
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();
        
        loanWrap.Year=1;
        loanWrap.Amortization=100;
        loanWrap.YearlyPrincipal=600;
        loanWrap.YearInterest=150;
        loanWrap.YearPayment=750;
        loanWrap.TargetRevenue=1;
        loanWrap.BeginningBalance=1000;
        loanWrap.EndingBalance=400;
        loanWrap.errorMesg='testing1';
        loanWrap.totalPercntErrorMesg='testing2';
        loanWrap.taregetErrorMesg='testing3';
        
        ApexPages.currentPage().getParameters().put('Amortization',String.valueOf(loanWrap.Amortization));
        ApexPages.currentPage().getParameters().put('yearValue',String.valueOf(loanWrap.Year));
        
        lc.createWrapperList();
        lc.wrapperRecalculation();
        lc.calculateYearlyPrincipal();               
        lc.validateTargetRevenue();               
        lc.submitButton(); 
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    } 
    
    static testMethod void testLoanForgiveness_test4(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender5@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                              
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;
        l1099.X1099_Principal__c=1000;
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c= 1000;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                 
        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test5(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender6@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                              
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;
        l1099.X1099_Principal__c=100;
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c= 1000;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                       
        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test6(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender8@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c(); 
        lr.Rep_Name__c = con.id;                                             
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;
        l1099.X1099_Principal__c=1000;
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c= 1000;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                 
        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test7(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender7@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();  
        lr.Rep_Name__c = con.id;                                          
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;       
        l1099.X1099_Interest__c=150;
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c=1000;
        l1099.X1099_Principal__c=15;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                        
        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test8(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender9@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                             
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;               
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c=1000;
        l1099.X1099_Principal__c=100;
        l1099.X1099_Interest__c=15;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                        
        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }
    
    static testMethod void testLoanForgiveness_test9(){
        test.startTest();
        
        Account acc = new Account();
        acc.name = 'Loan Reciever';
        acc.Firm_Account_Status__c ='Active';
        acc.Type = 'Owned / Acquired'; 
        acc.Recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Firm').getRecordTypeId();
        acc.SO_Business_Number__c = '257569';
        acc.SO_Client_Number__c = '257569';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Loan';
        con.LastName = 'Borrower';
        con.AccountId = acc.id;
        con.email = 'heylender10@gmail.com';
        con.Phone = '4569871230';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Firm Contact').getRecordTypeId();
        con.Firm_Contact_Status__c = 'Active';    
        insert con;
        
        Loan__c lr = new Loan__c();
        lr.Rep_Name__c = con.id;                                             
        lr.Original_Loan_Amount__c = 1000;
        lr.Loan_Interest_Rate__c =15;
        lr.Loan_Effective_Date__c = system.today();
        lr.Principal_Forgiven__c=12;
        lr.Interest_Forgiven__c=12;
        lr.Termed_Total_Balance_Due__c=2000;
        lr.Loan_Type__c = 'Target';
        lr.Loan_Term__c=12;
        lr.Loan_Term_In_Years__c='1';
        lr.Loan_Schedules_Created__c= false;
        lr.Loan_Description__c = 'Recruiting';
        lr.Company_Code__c = '7000';
        lr.Department_Code__c = 'KFI-2000';
        lr.Loan_Status__c = 'Open';
        lr.Rep_Status__c = 'Active';
        insert lr;
        
        Loan_1099s__c l1099 = new Loan_1099s__c();
        l1099.Loan__c=lr.id;               
        l1099.Amortization__c = 100;
        l1099.Beginning_Balance__c=1000;
        l1099.X1099_Principal__c=100;
        l1099.X1099_Interest__c=15;
        l1099.X1099_for_Year_of__c= 1;
        insert l1099;      
        
        Loan_Target_Revenue__c loanTrgRev = new Loan_Target_Revenue__c();
        loanTrgRev.Loan__c = lr.id;
        loanTrgRev.Target_for_Year_of__c = 1;
        loanTrgRev.Target_Revenue__c =2000;
        loanTrgRev.of_Target_Reached__c = 2;
        insert loanTrgRev;    
        
        ApexPages.currentPage().getParameters().put('id',lr.id);
        LoanForgiveness_ScheduleController lc = new LoanForgiveness_ScheduleController();           
        LoanForgiveness_ScheduleController.loanClass loanWrap = new LoanForgiveness_ScheduleController.loanClass();                        
        lc.submitButton();
        test.stopTest();
        system.assertEquals(lr.id,ApexPages.currentPage().getParameters().get('id'));
    }       
}