/*** Strike Toolbelt v2.0.1 ***/
public with sharing class constants {
    // Namespaces
    private static FINAL String thisString = String.valueOf(constants.class);
    private static FINAL List<String> thisStrings = thisString.split('[.]', 2);
    public static FINAL String NAMESPACE = thisStrings.size() > 1 ? thisStrings[0] : 'c';
    public static FINAL String NAMESPACE_API = NAMESPACE == 'c' ? '' : NAMESPACE + '__';

    // Sandbox identifcation
    private static FINAL Organization ORG = [SELECT Id, InstanceName, IsSandbox FROM Organization LIMIT 1];
    public static FINAL String ORG_ID = ORG.Id;
    public static FINAL String ORG_INSTANCE = ORG.InstanceName;
    public static FINAL Boolean IS_SANDBOX = ORG.IsSandBox;

    // oAuth callout urls
    public static FINAL String SALESFORCE_INSTANCE_URI = System.URL.getSalesforceBaseURL().toExternalForm();
    public static FINAL String SALESFORCE_BASE_URI = 'https://' + (IS_SANDBOX ? 'test' : 'login') + '.salesforce.com';
    public static FINAL String SALESFORCE_OAUTH_URI = SALESFORCE_BASE_URI + '/services/oauth2';


    // Blur
    public static FINAL String BLUR_STRING = '********';

    public String getNamespace() {
        return constants.NAMESPACE;
    }

    public String getNamespaceApi() {
        return constants.NAMESPACE_API;
    }

    public constants() {
        // empty
    }

    public constants(ApexPages.StandardController sc) {
        // empty
    }
}