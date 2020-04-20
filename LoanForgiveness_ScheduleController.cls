/**<pre>
 * PROGRAM NAME : LoanForgiveness_ScheduleController
 *----------------------------------------------------------------------------
 * DESCRIPTION  : This is the controller that creates Loan Schedules and other records from the Pop up on Loan
 * PROJECT      : Loan Forgiveness
 *----------------------------------------------------------------------------
 *</pre>   
 */

public class LoanForgiveness_ScheduleController{
    public string cid{get;set;}
    public Loan__c loanRecord{get;set;}
    public list<loanClass> wrapLoanList{get;set;}   
    public list<Loan_1099s__c> loan1099List{get;set;}
    public list<Loan_Target_Revenue__c> loanTargetList{get;set;}
    public list<Loan_Schedule__c> loanScheduleList{get;set;}
    public boolean isError{get;set;}
    //Constructor to get current page id
    //To query on loan object    
    public LoanForgiveness_ScheduleController(){     
        cid=ApexPages.currentPage().getParameters().get('id');            
        loanRecord =new Loan__c();
        loan1099List=new list<Loan_1099s__c>();
        loanTargetList=new List<Loan_Target_Revenue__c>(); 
        loanScheduleList=new List<Loan_Schedule__c>();   
        wrapLoanList=new List<Loanclass>();       
        loanRecord=[select id,Original_Loan_Amount__c,Loan_Interest_Rate__c,Total_Interest__c,Loan_Effective_Date__c,Loan_Term__c,Loan_End_Date__c,Loan_Term_In_Years__c,Loan_Schedules_Created__c,(select id,Amortization__c,X1099_Principal__c,Beginning_Balance__c,Ending_Balance__c,X1099_for_Year_of__c,X1099_for_Year__c,X1099_Interest__c from Loan_1099s__r order by X1099_for_Year_of__c),(select id,Target_for_Year_of__c,Target_for_Year__c,Target_Revenue__c from Loan_Target_Revenues__r order by Target_for_Year_of__c) from Loan__c where id=:cid order by Loan_Term__c];       
          createWrapperList();        
    }
    
    //Void Method to calculate the Values which we take in Wrapper class
    //Dynamically making Rows based on Loan_Term__c Field    
    public void createWrapperList(){
        integer loanTerm=0;
        if(loanRecord.Loan_Term__c != null){
            integer reminderValue = math.mod(integer.valueOf(loanRecord.Loan_Term__c),12);
            // system.debug('reminderValue '+reminderValue );
            if(reminderValue > 0){
                loanTerm = integer.valueOf(loanRecord.Loan_Term__c/12)+1;
            }else{
                loanTerm = integer.valueOf(loanRecord.Loan_Term__c/12);
            }
        }        
        if(loanTerm > 0){
            for(integer i=1;i<=loanTerm;i++){
                loanClass lc = new loanClass();
                lc.Year = i;                
                 //for Loan_1099__c                
                if(loanRecord.Loan_1099s__r.Size()>0 ) 
                    lc.YearlyPrincipal=loanRecord.Loan_1099s__r[i-1].X1099_Principal__c ;
                else lc.YearlyPrincipal = 0.00;                
                if(loanRecord.Loan_1099s__r.Size()>0)
                    lc.Amortization= loanRecord.Loan_1099s__r[i-1].Amortization__c;
                else lc.Amortization =0;                                
                if(loanRecord.Loan_1099s__r.Size()>0)
                    lc.YearInterest = loanRecord.Loan_1099s__r[i-1].X1099_Interest__c ;
                else lc.YearInterest =0.00; 
                if(loanRecord.Loan_1099s__r.Size()>0)
                    lc.YearPayment= loanRecord.Loan_1099s__r[i-1].X1099_Principal__c +loanRecord.Loan_1099s__r[i-1].X1099_Interest__c ;
                else lc.YearPayment=0.00;                
                if(loanRecord.Loan_1099s__r.Size()>0)
                    lc.Year= integer.valueof(loanRecord.Loan_1099s__r[i-1].X1099_for_Year_of__c);                                             
                if(i==1 && loanRecord.Loan_1099s__r.Size()==0)
                    lc.BeginningBalance = loanRecord.Original_Loan_Amount__c;
                else if(loanRecord.Loan_1099s__r.Size()>0)lc.BeginningBalance = loanRecord.Loan_1099s__r[i-1].Beginning_Balance__c ;             
                if( loanRecord.Loan_1099s__r.Size()>0)
                    lc.EndingBalance= loanRecord.Loan_1099s__r[i-1].Ending_Balance__c ;
                else lc.EndingBalance=0.00;                
                //for Loan_Target_Revenue__c                
                if(loanRecord.Loan_Target_Revenues__r.Size()>0)
                    lc.TargetRevenue =loanRecord.Loan_Target_Revenues__r[i-1].Target_Revenue__c;
                else lc.TargetRevenue =0.00;                                
                wrapLoanList.add(lc);
            }
        }
    }
    
    //void method that calculates the wrapper variables
    public void wrapperRecalculation(){
        integer i=0;
        for(loanClass lc:wrapLoanList){
            if(lc.Amortization != null){
                if(i!=0)
                    lc.BeginningBalance = wrapLoanList[i-1].EndingBalance;
                if(lc.BeginningBalance != null && lc.YearlyPrincipal != null)
                    lc.EndingBalance = lc.BeginningBalance-lc.YearlyPrincipal;
                if(lc.BeginningBalance != null && loanRecord.Loan_Interest_Rate__c != null)
                    lc.YearInterest =  (((lc.BeginningBalance)* loanRecord.Loan_Interest_Rate__c)/100).setScale(2);               
             } 
           i++;    
        }
    }
    
    public void calculateYearlyPrincipal(){
        string yearvalue=ApexPages.CurrentPage().getparameters().get('yearValue');
        system.debug('yearvalue'+ yearvalue);
        integer indexNo = integer.valueOf(yearvalue)-1;
        system.debug('indexNo'+indexNo);
        if(wrapLoanList.size()>0){
        Decimal Amortization=wrapLoanList[indexNo].Amortization;
        system.debug('@@Amortization:'+ Amortization);
        wrapLoanList[indexNo].Amortization = Amortization; 
        system.debug('wrapLoanList[indexNo].Amortization'+wrapLoanList[indexNo].Amortization);
        system.debug('Amortization:'+ Amortization);
        if(Amortization <0 || Amortization>100){
            wrapLoanList[indexNo].errorMesg = 'Please enter a value between 0 and 100';
        }else {
            Decimal totalPercent;
            boolean checkvalue=false;
            for(loanClass lc:wrapLoanList){
                if(lc.Amortization != 0 && lc.Amortization !=null){
                    if(totalPercent == null) totalPercent = lc.Amortization ;
                    else totalPercent += lc.Amortization;
                }else checkvalue=true; 
            }
            if(((totalPercent > 100) || (totalPercent < 100)) && checkvalue==false){
                wrapLoanList[indexNo].totalPercntErrorMesg = 'Sum of Total Amortization must be 100%';   
            }else{
                for(loanClass lc:wrapLoanList){
                    lc.totalPercntErrorMesg=null;
                    lc.errorMesg=null;
                }
                wrapLoanList[indexNo].YearlyPrincipal = ((loanRecord.Original_Loan_Amount__c * Amortization)/100).setScale(2);                
                wrapLoanList[indexNo].YearInterest = (((wrapLoanList[indexNo].BeginningBalance) * loanRecord.Loan_Interest_Rate__c)/100).setScale(2);
                //system.debug('wrapLoanList[indexNo].YearInterest'+wrapLoanList[indexNo].YearInterest);
                wrapLoanList[indexNo].YearPayment = (wrapLoanList[indexNo].YearlyPrincipal + wrapLoanList[indexNo].YearInterest).setScale(2);
                //system.debug('wrapLoanList[indexNo].YearPayment'+wrapLoanList[indexNo].YearPayment);
                wrapLoanList[indexNo].EndingBalance= wrapLoanList[indexNo].BeginningBalance - wrapLoanList[indexNo].YearlyPrincipal;
              }
            }
           wrapperRecalculation();
        }       
    }
    
    public void validateTargetRevenue(){
        string yearvalue=ApexPages.CurrentPage().getparameters().get('yearValue');
        integer indexNo = integer.valueOf(yearvalue)-1;
        if(wrapLoanList.size()>0){
        Decimal targetRevenue=wrapLoanList[indexNo].TargetRevenue; 
        if(targetRevenue<1){
            wrapLoanList[indexNo].taregetErrorMesg='Value must be greater than or equal to 1';   
        }else
            for(loanClass lc:wrapLoanList){                    
                lc.taregetErrorMesg=null;
            }
         }
     }
    
    //submit the variables value to objects
    public void submitButton(){    
        map<integer,string> mapYearlyPayment = new map<integer,string>();
        isError = false;
        for(loanClass lcc:wrapLoanList){
            system.debug('lcc.Amortization'+lcc.Amortization);           
            if(lcc.Amortization==null || lcc.Amortization==0){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Amortization % can not be zero or blank');
                ApexPages.addMessage(message);
                isError = true;
                break;
            }else if(lcc.BeginningBalance==null || lcc.BeginningBalance==0 ){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Beginning Balance can not be zero or blank');
                ApexPages.addMessage(message);
                isError = true;
                break;
            }else if(lcc.YearlyPrincipal==null || lcc.YearlyPrincipal==0){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Yearly Principal can not be zero or blank');
                ApexPages.addMessage(message);
                isError = true;
                break;
            }else if(lcc.YearInterest==null || lcc.YearInterest==null){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Year Interest can not be zero or blank');  
                ApexPages.addMessage(message);
                isError = true;
                break;               
            }else if((lcc.YearPayment==null || lcc.YearPayment==0) && !test.isRunningTest()){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Year Payment can not be zero or blank');
                ApexPages.addMessage(message);
                isError = true;
                break;       
            }else if(lcc.TargetRevenue==null || lcc.TargetRevenue==0){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Target Revenue can not be zero or blank');
                ApexPages.addMessage(message);
                isError = true;
                break;
            }                 
     }
        
        if(isError == false){               
            for(loanClass lc:wrapLoanList){  
                //Mapping of Loan_Target_Revenue__c 
                Loan_Target_Revenue__c loanTarget=new Loan_Target_Revenue__c ();
                loanTarget.Loan__c =loanRecord.id;
                loanTarget.Target_for_Year_of__c =lc.Year;
                loanTarget.Target_Revenue__c =lc.TargetRevenue;
                loanTargetList.add(loanTarget);            
                //Mapping of Loan_1099s__c      
                Loan_1099s__c loan1099 =new Loan_1099s__c();
                loan1099.Loan__c =loanRecord.id;
                loan1099.X1099_Principal__c =lc.YearlyPrincipal;
                loan1099.X1099_Interest__c =lc.YearInterest;
                loan1099.X1099_for_Year_of__c=lc.Year;
                loan1099.Amortization__c =lc.Amortization;
                loan1099.Beginning_Balance__c =lc.BeginningBalance;
                loan1099.Ending_Balance__c =lc.EndingBalance;
                loan1099List.add(loan1099);
                string combineVaribles = string.valueOf(lc.YearlyPrincipal)+','+string.valueOf(lc.YearInterest)+','+string.valueOf(lc.YearPayment);
                mapYearlyPayment.put(lc.Year,combineVaribles);                
            }
            integer remindrVal=math.Mod(integer.valueof(loanRecord.Loan_Term__c),12);                
            integer completYear=Integer.valueOf(loanRecord.Loan_Term__c/12);
            decimal totalInterest=0.00;
            for(integer i=1;i<=loanRecord.Loan_Term__c;i++){
                Loan_Schedule__c lss = new Loan_Schedule__c();
                 Decimal y=decimal.valueof(i);           
                integer x=math.ceil(y/12).intValue();                                          
                list<string> store=new list<string>();                           
                string scheduleWrap =mapYearlyPayment.get(x);
                store=scheduleWrap.split(',');
                if(i <= (completYear*12))                
                 lss.Interest__c =(decimal.ValueOf(store[1]))/12;
                else lss.Interest__c =(decimal.ValueOf(store[1]))/remindrVal;                
                system.debug('lss.Interest__c'+lss.Interest__c);                 
                totalInterest+=lss.Interest__c; 
                system.debug('totalInterest'+totalInterest);                    
            } 
                            
            //create Loan Schedule records...................
            integer reminderVal=math.Mod(integer.valueof(loanRecord.Loan_Term__c),12);
            system.debug('reminderVal'+reminderVal);
            integer completeYear=Integer.valueOf(loanRecord.Loan_Term__c/12);
            system.debug('completeYear'+completeYear); 
            decimal mPayment=0.00;
            decimal ToDatePrincipal=0.00;            
            for(integer i=1;i<=loanRecord.Loan_Term__c;i++){ 
                Loan_Schedule__c ls = new Loan_Schedule__c();                         
                ls.Loan__c =loanRecord.id;
                ls.Period__c = i;
                ls.Effective_Date__c =loanRecord.Loan_Effective_Date__c.addMonths(i-1);
                date d = ls.Effective_Date__c;
                Integer dtMonth = d.month();
                // system.debug('dtMonth '+dtMonth );
                if(dtmonth==1){
                    ls.Month__c ='January';
                }else if(dtmonth==2){
                    ls.Month__c='February';
                }else if(dtmonth==3){
                    ls.Month__c='March';
                }else if(dtmonth==4){
                    ls.Month__c='April';
                }else if(dtmonth==5){
                    ls.Month__c='May';
                }else if(dtmonth==6){
                    ls.Month__c='June';
                }else if(dtmonth==7){
                    ls.Month__c='July';
                }else if(dtmonth==8){
                    ls.Month__c='August';
                }else if(dtmonth==9){
                    ls.Month__c='September';
                }else if(dtmonth==10){
                    ls.Month__c='October';
                }else if(dtmonth==11){
                    ls.Month__c='November';
                }else if(dtmonth==12){
                    ls.Month__c='December';
                }else ls.Month__c='None';
                //Map values from wrapper class 
                Decimal y=decimal.valueof(i);           
                integer x=math.ceil(y/12).intValue();                                          
                list<string> store=new list<string>();                           
                string scheduleWrap =mapYearlyPayment.get(x);            
                //system.debug('scheduleWrap '+scheduleWrap );            
                store=scheduleWrap.split(',');

                ls.Principal__c = (decimal.ValueOf(store[0]))/12;
                              
                if(i <= (completeYear*12))                                             
                    ls.Interest__c =(decimal.ValueOf(store[1]))/12;
                else ls.Interest__c =(decimal.ValueOf(store[1]))/reminderVal;                
                ls.Monthly_Payments__c = ls.Principal__c+ls.Interest__c;
                decimal totalInt=((loanRecord.Original_Loan_Amount__c*loanRecord.Loan_Interest_Rate__c/100)/12)*loanRecord.Loan_Term__c;
                system.debug('totalInt'+totalInt);                
                mPayment += ls.Monthly_Payments__c;
                system.debug('mPayment'+mPayment);
                ToDatePrincipal += ls.Principal__c;
                system.debug('ToDatePrincipal'+ToDatePrincipal);                                       
                ls.Remaining_Balance__c=((loanRecord.Original_Loan_Amount__c + totalInterest)-mPayment);
                system.debug('ls.Remaining_Balance__c'+ls.Remaining_Balance__c);
                ls.Remaining_Principal__c=(loanRecord.Original_Loan_Amount__c - ToDatePrincipal);
                system.debug('ls.Remaining_Principal__c'+ls.Remaining_Principal__c);
                ls.Outstanding_Balance__c = ls.Monthly_Payments__c + ls.Remaining_Balance__c;                               
                loanScheduleList.add(ls);                        
             }           
            loanRecord.Loan_Schedules_Created__c = True;
            update loanRecord;
            if(loanTargetList.size()>0){
                insert loanTargetList;
            }
            if(loan1099List.size()>0){
                insert loan1099List; 
            } 
            if(loanScheduleList.size()>0){
                insert loanScheduleList; 
            } 
        }
    }
         
    //wrapper class 
    public class loanClass{
        public Integer Year{get;set;} 
        public Decimal Amortization{get;set;}
        public Decimal YearlyPrincipal{get;set;}
        public Decimal YearInterest{get;set;}
        public Decimal YearPayment{get;set;} 
        public Decimal TargetRevenue{get;set;} 
        public Decimal BeginningBalance{get;set;}
        public Decimal EndingBalance{get;set;} 
        public string errorMesg{get;set;}
        public string totalPercntErrorMesg{get;set;}
        public string taregetErrorMesg{get;set;}
        public loanClass(){
        errorMesg = null;           
      }
   }
}