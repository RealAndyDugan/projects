@RestResource(urlMapping='/SurveyMonkey/*')
global with sharing class webservices {
    @HttpGet
    global static void doGet() {
        RestResponse res = RestContext.response;
        RestRequest req = RestContext.request;

        try { 
            String recordId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
            // write your GET code here
            
            res.statusCode = 200;  
            res.responseBody = Blob.valueof(JSON.serialize('SUCCESS'));

        } catch(Exception e) {                
            res.statusCode = 500;
            res.responseBody = Blob.valueof('ERROR: ' + e.getStackTraceString());
        }
    }
       
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try { 
            // write your POST code here

            res.statusCode = 200;
            res.responseBody = Blob.valueof(JSON.serialize('SUCCESS'));

        } catch(Exception e) { 
            res.statusCode = 500;
            res.responseBody = Blob.valueof('ERROR: ' + e.getStackTraceString());
        }
    }
}