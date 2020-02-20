/**
* @author Ben Edwards (ben@edwards.nz)
* @date 12th February 2020
* @description Test class for the FlowExecuteQueueable class
*
* CHANGE LOG
**/
@isTest 
public class FlowExecuteQueueableTest {

    @TestSetup
    static void makeData(){
        
        insert new Account(Name = 'Test Account');
    }

    @isTest 
    static void testRunFlow() {

        Account testAccount = [SELECT Id FROM Account];

        // Build the input
        FlowExecuteQueueable.Input flowInput = new FlowExecuteQueueable.Input();
        flowInput.flowName = 'FLOW_NAME';
        flowInput.paramName1 = 'recordId';
        flowInput.paramValue1 = testAccount.Id;

        // Call the invocable method
        Test.startTest();

        FlowExecuteQueueable.runRow(new List<FlowExecuteQueueable.Input>{flowInput});

        Test.stopTest();
    }
    
}