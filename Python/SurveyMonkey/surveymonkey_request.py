""" Make a sample request using surveymonkey's API
    Similar to: https://developer.surveymonkey.com/api_console

    v2 Methods:
        get_survey_list
        get_survey_details
        get_collector_list
        create_collector
        get_respondent_list
        get_responses
        get_response_counts
        get_user_details
        get_template_list

    Response Status:
        0 Success
        1 Not Authenticated
        2 Invalid User Credentials
        3 Invalid Request
        4 Unknown User
        5 System Error

 """

import requests
import json
#import simplejson as json
import pdb
import time


ACCESS_TOKEN = '<insert access_token>'
HOST = "https://api.surveymonkey.net"
#SURVEY_ID = '21484206'  # Crisis Centers Survey
#SURVEY_ID = '55029506'  # DBT Training Evaluation
#SURVEY_ID = '22227198'  # The Lifeline Crisis Center Conference Survey
data = {}
# Initialize Client for making API requests
client = requests.session()
client.headers = {
    "Authorization": "bearer %s" % ACCESS_TOKEN,
    "Content-Type": "application/json"
    #"encoding": "utf-8"
    #"encoding": "ascii"
    }
client.params = {
    "api_key": "<insert api_key>"
    }


def get_survey_list_simple():
    """ Returns the first page of a list of surveys in a user's account """
    SURVEY_LIST_ENDPOINT = "/v2/surveys/get_survey_list"
    uri = "%s%s" % (HOST, SURVEY_LIST_ENDPOINT)
    data = {}
    response = client.post(uri, data=json.dumps(data))
    response_json = response.json()
    survey_list = response_json["data"]["surveys"]
    time.sleep(1)
    print type(survey_list)  # List of dicts
    return survey_list


def get_survey_list_all():
    """ Returns all the surveys in a user's account (even if past the
        maximum page size); use page input param to iterate through pages """
    SURVEY_LIST_ENDPOINT = "/v2/surveys/get_survey_list"
    uri = "%s%s" % (HOST, SURVEY_LIST_ENDPOINT)
    # uri example: https://api.surveymonkey.net/v2/surveys/get_survey_list
    survey_list = []
    current_page = 1

    while True:
        # Set the page of surveys to retrieve
        data["page"] = current_page
        response = client.post(uri, data=json.dumps(data))
        response_json = response.json()
        for survey in response_json["data"]["surveys"]:
            survey_list.append(survey)

        # If the number of surveys returned equals the page size,
        # there could still be surveys to retrieve
        if len(response_json["data"]["surveys"]) == response_json["data"]["page_size"]:
            current_page += 1
        else:
            # Finished retrieving all surveys
            break
        time.sleep(1)

    #print type(survey_list)  # <type 'list'>
    test = json.dumps(survey_list)
    print type(test)
    return survey_list


def get_survey_details(survey_id):
    """ Returns a given survey's metadata (e.g. questions) based on survey_id """
    SURVEY_DETAILS_ENDPOINT = "/v2/surveys/get_survey_details"
    uri = "%s%s" % (HOST, SURVEY_DETAILS_ENDPOINT)
    data['survey_id'] = survey_id  # {'session_id': '55029506'}
    #print type(data) # <type 'data'>
    #print type(json.dumps(data))  # <type 'str'>
    response = client.post(uri, data=json.dumps(data))  # <class 'requests.models.Response'>
    response_json = response.json()  # <type 'dict'>
    #return response_json
    time.sleep(1)
    return response_json


def get_respondent_list(survey_id):
    """ Returns a list of respondents to the survey """
    RESPONDENT_LIST_ENDPOINT = "/v2/surveys/get_respondent_list"
    uri = "%s%s" % (HOST, RESPONDENT_LIST_ENDPOINT)
    data['survey_id'] = survey_id
    response = client.post(uri, data=json.dumps(data))
    response_json = response.json()
    time.sleep(1)
    return response_json


def get_responses(survey_id, respondent_ids):
    """ Returns a list of responses to the survey """
    RESPONSES_ENDPOINT = "/v2/surveys/get_responses"
    uri = "%s%s" % (HOST, RESPONSES_ENDPOINT)
    data['survey_id'] = survey_id
    data['respondent_ids'] = respondent_ids
    response = client.post(uri, data=json.dumps(data))
    response_json = response.json()
    time.sleep(1)
    return response_json


def get_all_dbt_training_evaluation(survey_id='55029506'):
    """ Gets the data specifically for the DBT_Training_Evaluation Training
        Ties in respond_list() with get_responses() function"""    # Tie in respond_list() with get_responses()
    respond_list = get_respondent_list(survey_id)  # Returns people who responded to this survey
    test = respond_list["data"]["respondents"]
    replied = []
    #print test  # list of dicts # Sample is [{u'respondent_id': '3421548096'}, u'respondent_id': '3420940970'},]
    for item in test:
        for value in item.itervalues():
            replied.append(value)
    time.sleep(1)
    #print replied  # People who replied
    print get_responses(survey_id, replied)  # Questions and Answers of those that replied


if __name__ == '__main__':
    ### SurveyMonkey API BASICS
    print get_survey_list_simple()
    #print get_survey_list_all()  # Returns all surveys in a user's account
    #print get_survey_details('55029506')  # Returns just this survey's questions
    #print get_respondent_list('55029506')  # Returns people who responded to this survey
    #test_respondent_ids = ['3428838384', '3428495145', '3428134611']
    #print get_responses('55029506', test_respondent_ids)

    ### Exploration
    #print type(client)  # <class 'requests.sessions.Session'>
    #print client  # <requests.sessions.Session object at 0x102f047d0>

    ### Specific Surveys
    #get_all_dbt_training_evaluation()
