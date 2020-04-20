# Loan-Amortization_SFDCApp
A custom loan tool in Salesforce to calculate the amortization schedule. 

1. Create Custom Object first before saving the apex class/VF Page. 

2. There mgiht be some changes necessary for lookup fields in the list of objects based on your org setup. 

3. Static Resource JQuery is necessary for pop up on the Loan object to work. 

4. Object Definintions:
-- A. Loan: Main object on which you enter all the loan financial information and generate monthly schedules using button. 
-- B. Loan Schedules: Object that is related to Loan and holds all the monthly payment info for the amortization schedule. 
-- C. Loan 1099: Object to store the yearly Principal/Interest information that is useful for 1099 filing. 
-- D. Loan Target Revenue: Object to set Targets for a customer to meet specific goals. 

5. Review Validation rules per your need. 
