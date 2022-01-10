@isTest
public class SumOfNumberFunctionalityTest
{
    public static testMethod void testDoSumFun()
    {
        //Creating test data
        double fNum = 10.00;
        double secNum = 20.00;
        double fres= 40.00;
        double finalResult = SumOfNumberFunctionality.doSum(fNum,secNum);
        System.assertEquals(finalResult,fres);
        
    }
}