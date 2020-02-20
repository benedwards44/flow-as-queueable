/**
* @author Ben Edwards (ben@edwards.nz)
* @date 12th February 2020
* @description Queueable class for dynamically running a flow asynchronously
*
*    Run for all objects:
*    System.enqueueJob(new FlowExecuteQueueable('FLOW_API_NAME', new Map<String, Object>{'recordId' => '8012v00000D7qnvAAB'}));
*
* CHANGE LOG
**/
public with sharing class FlowExecuteQueueable implements Queueable {    

    // Variables for the flow
    public String flowName;
    public Map<String, Object> flowParams; 

    // Constructor to accept parameters for the flow
    public FlowExecuteQueueable(String flowName, Map<String, Object> flowParams) {
        this.flowName = flowName;
        this.flowParams = flowParams;
    }

    @InvocableMethod(label='Run Flow Async' description='Run the given flow and parameters asynchronously.')
    public static void runRow(List<Input> inputs) { 

        // Build the map of parameters based on the input
        Map<String, Object> flowParams = new Map<String, Object>();
        if (String.isNotBlank(inputs[0].paramName1)) flowParams.put(inputs[0].paramName1, inputs[0].paramValue1);
        if (String.isNotBlank(inputs[0].paramName2)) flowParams.put(inputs[0].paramName2, inputs[0].paramValue2);
        if (String.isNotBlank(inputs[0].paramName3)) flowParams.put(inputs[0].paramName3, inputs[0].paramValue3);

        // If we've already reached our queueable limit
        if (Limits.getQueueableJobs() >= 1) {

            // Run flow synchronously
            new FlowExecuteQueueable(
                inputs[0].flowName,
                flowParams
            ).execute(null);
        }
        else {

            // Run the flow via queueable job
            System.enqueueJob(new FlowExecuteQueueable(
                inputs[0].flowName,
                flowParams
            ));
        }
    }

    // Wrapper class to hold Flow name and inputs
    public class Input {

        @InvocableVariable(label='Flow API Name' required=true)
        public String flowName;

        @InvocableVariable(label='Parameter One Key')
        public String paramName1;

        @InvocableVariable(label='Parameter One Value')
        public String paramValue1;

        @InvocableVariable(label='Parameter Two Key')
        public String paramName2;

        @InvocableVariable(label='Parameter Two Value')
        public String paramValue2;

        @InvocableVariable(label='Parameter Three Key')
        public String paramName3;

        @InvocableVariable(label='Parameter Three Value')
        public String paramValue3;
    }

    // Execute method called when 
    public void execute(QueueableContext context) {

        switch on flowName {

            when 'FLOW_API_NAME' {
                
                // Instantiate the flow
                //Flow.Interview.FLOW_API_NAME asyncFlow = new Flow.Interview.FLOW_API_NAME(flowParams);
                //asyncFlow.start();
            }
        }
    }   
}