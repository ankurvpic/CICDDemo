public class LoanApprovalClass
{
    @auraEnabled
    public static LoanDetailWrapper getLoanDetails(string strOppId)
    {
        LoanDetailWrapper objLoanWrapper;
        List<Loan__c> lstLoans = [select id,Name,Status__c from Loan__c where Opportunity__c ='0062800000Gsz4ZAAR'];
        
        if(lstLoans != null && lstLoans.size()>0)
        {
            objLoanWrapper = new LoanDetailWrapper();
            objLoanWrapper.lstLoanData = lstLoans;
            objLoanWrapper.lstActions = CommonClass.getPickListValuesCommon('Loan__c','Status__c');
            
        }
        System.debug('===objLoanWrapper==='+objLoanWrapper);
        return objLoanWrapper;
    }
    @auraEnabled      
    public static string updateData(String strReturnDataWrapper)
    {
        system.debug('strReturnDataWrapper::'+strReturnDataWrapper);
        LoanDetailWrapper oReturnDataWrapper = new LoanDetailWrapper();
        if(strReturnDataWrapper != null)
        {
            try
            {
                oReturnDataWrapper = (LoanDetailWrapper)JSON.deserialize(strReturnDataWrapper,LoanDetailWrapper.class);
                
                list<Loan__c> lstLoanDataUpdate = new list<Loan__c>();
                
                lstLoanDataUpdate  = oReturnDataWrapper.lstLoanData;
                if(lstLoanDataUpdate != null && lstLoanDataUpdate .size() > 0)
                {
                    update lstLoanDataUpdate;
                }
            }
            catch(Exception ex)
            {
            
            }
        }
        return 'Success';  
    }

public class LoanDetailWrapper
{
    @AuraEnabled public list<Loan__c> lstLoanData;
    @AuraEnabled public list<CommonClass.picklistFieldsWrapper> lstActions;
}
}