import json
from pandas.io.json import json_normalize


def parse_respondent_list():
    """ Get Respondent List - unidentified user IDs """
    print "Loading Respondent List JSON"
    json_data = open('/Users/williamliu/GitHub/surveys/get_respondent_list.json')
    loaded_data = json.load(json_data)

    print type(loaded_data) # dict, entire thing
    print loaded_data['data']
    print loaded_data['data']['respondents']


def parse_survey_details():
    """ Get Survey Details, e.g. questions and answer types on survey """
    json_data = open('/Users/williamliu/GitHub/surveys/get_survey_details.json')
    loaded_data = json.load(json_data)

    print loaded_data['data']['pages'][1]['questions'][1]['heading']
    # I am preoccupied with more than one person I help


def parse_get_responses():
    """ Get Question and Response ID from each respondent """
    json_data = open('/Users/williamliu/GitHub/surveys/get_responses.json')
    loaded_data = json.load(json_data)
    test = json_normalize(loaded_data['data'])

    print type(test)
    print test.head()

    # Get first respondent's questions and answers back
    #print loaded_data['data'][1]['questions'][1]['question_id']  # Get respondent's question_id
    #print loaded_data['data'][1]['questions'][1]['answers']  # Get respondent's question_id


if __name__ == '__main__':
    #parse_respondent_list()
    #parse_survey_details()
    parse_get_responses()

