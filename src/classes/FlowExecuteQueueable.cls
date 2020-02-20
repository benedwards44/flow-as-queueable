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

        // Iterate over the inputs to run
        for (Input input :inputs) {

            // Build the map of parameters based on the input
            Map<String, Object> flowParams = new Map<String, Object>();
            if (String.isNotBlank(input.paramName1)) flowParams.put(input.paramName1, input.paramValue1);
            if (String.isNotBlank(input.paramName2)) flowParams.put(input.paramName2, input.paramValue2);
            if (String.isNotBlank(input.paramName3)) flowParams.put(input.paramName3, input.paramValue3);
            if (String.isNotBlank(input.paramName4)) flowParams.put(input.paramName4, input.paramValue4);
            if (String.isNotBlank(input.paramName5)) flowParams.put(input.paramName5, input.paramValue5);

            // If we've already reached our queueable limit
            if (Limits.getQueueableJobs() >= 1) {

                // Run flow synchronously
                new FlowExecuteQueueable(
                    input.flowName,
                    flowParams
                ).execute(null);
            }
            else {

                // Run the flow via queueable job
                System.enqueueJob(new FlowExecuteQueueable(
                    input.flowName,
                    flowParams
                ));
            }
        }
    }

    // Wrapper class to hold Flow name and inputs
    public class Input {

        @InvocableVariable(label='Flow API Name' required=true)
        public String flowName;

        @InvocableVariable(label='1. Variable 1 API Name')
        public String paramName1;

        @InvocableVariable(label='1. Variable 1 Value')
        public String paramValue1;

        @InvocableVariable(label='2. Variable 1 API Name')
        public String paramName2;

        @InvocableVariable(label='2. Variable 2 Value')
        public String paramValue2;

        @InvocableVariable(label='3. Variable 3 API Name')
        public String paramName3;

        @InvocableVariable(label='3. Variable 3 Value')
        public String paramValue3;

        @InvocableVariable(label='4. Variable 4 API Name')
        public String paramName4;

        @InvocableVariable(label='4. Variable 4 Value')
        public String paramValue4;

        @InvocableVariable(label='5. Variable 5 API Name')
        public String paramName5;

        @InvocableVariable(label='5. Variable 5 Value')
        public String paramValue5;
    }

    // Execute method called when 
    public void execute(QueueableContext context) {

        switch on flowName {

            // Rename "FLOW_API_NAME" with the API Name of your Flow
            when 'FLOW_API_NAME' { 

                // Rename "FLOW_API_NAME" with the API Name of your Flow
                // And uncomment the bottom 2x lines
                //Flow.Interview.FLOW_API_NAME asyncFlow = new Flow.Interview.FLOW_API_NAME(flowParams);
                //asyncFlow.start();
            }

            when 'FLOW_API_NAME2' { 

                // Rename "FLOW_API_NAME2" with the API Name of your Flow
                // And uncomment the bottom 2x lines
                //Flow.Interview.FLOW_API_NAME2 asyncFlow = new Flow.Interview.FLOW_API_NAME2(flowParams);
                //asyncFlow.start();
            }

            when 'FLOW_API_NAME3' { 

                // Rename "FLOW_API_NAME3" with the API Name of your Flow
                // And uncomment the bottom 2x lines
                //Flow.Interview.FLOW_API_NAME3 asyncFlow = new Flow.Interview.FLOW_API_NAME3(flowParams);
                //asyncFlow.start();
            }
        }
    }   
}