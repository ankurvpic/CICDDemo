//=======================================================================================
//  Description: Attaching Selfie web service.
//=======================================================================================
//  Version#     Date                           Author                    Description
//=======================================================================================
//  1.0          09-June-2017                   Ankur Tripathi              Initial Version
//=======================================================================================
@RestResource(urlMapping='/selfieinfotocrm')
global with sharing class IVL_SElfieInfoToCRMWebService
{    
    @HttpPost
    global static SelfieInfoWrapper DoPost(string lead_id,String image)
    {
        // variable decleration
        SelfieInfoWrapper ObjSelfieInfoWrapper = new SelfieInfoWrapper();
        try
        {
            if(string.isNotBlank(lead_id))
            {
                //list<IVL_Document__c> documentToInsert = new list<IVL_Document__c>();
                Blob jsonStr = EncodingUtil.base64Decode(image);
                list<Opportunity> lstOpportunity = [select id, IVL_Lead_Id__c from Opportunity 
                                                    where IVL_Lead_Id__c =: lead_id limit 1];
                if(lstOpportunity != null && lstOpportunity.size() > 0)
                {
                   Attachment ObjAttach = new Attachment();
                   ObjAttach.ParentId = lstOpportunity[0].id;
                   ObjAttach.ContentType = 'image/jpg';
                   ObjAttach.Body = jsonStr ;
                   ObjAttach.Name ='test';
                   insert ObjAttach;
                   /*IVL_Document__c objDocument = new IVL_Document__c();
                   objDocument.Opportunity__c = lstOpportunity[0].id;
                   objDocument.IVL_Type__c ='Photo';
                   insert objDocument;*/
                   ObjSelfieInfoWrapper.success = true;
                }
                
                else
                {    
                    // final response error string for Wrong Lead Id
                    ObjSelfieInfoWrapper.success = false;
                    ObjSelfieInfoWrapper.error_message = 'No Opportunity record found for the Lead Id';
                }
            }
            else
            {
                // final response error string for No Lead Id
                ObjSelfieInfoWrapper.success = false;
                ObjSelfieInfoWrapper.error_message = 'Please provide Lead Id';
            }
        }
        catch (exception ex)
        {
            // final response error string for any exception
            ObjSelfieInfoWrapper.success = False;           
            ObjSelfieInfoWrapper.error_message = ex.getMessage();
        }
        return ObjSelfieInfoWrapper;
    }               
                
  global class SelfieInfoWrapper {
        
        public Boolean success;
        public String  error_message;
        
        global SelfieInfoWrapper() {
            success = false;
        }
    }
 }