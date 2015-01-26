"""
    Get SurveyMonkey Survey 'H2H Employee Satisfaction Survey' through API
    Convert from JSON to Pandas, then analyze using Pandas and Scikit-learn
    Note: Runs fine on Pandas version 0.14, but not on .15
 """

import requests
import json
import pdb
import time
import pandas


pandas.set_option('display.max_rows', 500)
pandas.set_option('display.max_columns', 500)
pandas.set_option('display.width', 1000)

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
    }
client.params = {
    "api_key": "<insert api_key>"
    }


def pandas_survey_list():
    """ Returning the first page of a list of surveys in a user's account """
    SURVEY_LIST_ENDPOINT = "/v2/surveys/get_survey_list"
    uri = "%s%s" % (HOST, SURVEY_LIST_ENDPOINT)
    print "URI is: ", uri
    data = {}
    response = client.post(uri, data=json.dumps(data))
    response_json = response.text
    time.sleep(1)
    obj = open('survey_list.json', 'wb')
    obj.write(response_json)
    obj.close


def get_respondent_list_json(survey_id):
    """ Returns a list of respondents to the survey into JSON """
    RESPONDENT_LIST_ENDPOINT = "/v2/surveys/get_respondent_list"
    uri = "%s%s" % (HOST, RESPONDENT_LIST_ENDPOINT)
    data['survey_id'] = survey_id
    response = client.post(uri, data=json.dumps(data))
    response_json = response.text
    time.sleep(1)
    obj = open('get_respondent_list.json', 'wb')
    obj.write(response_json)
    obj.close


def convert_respondent_list(location):
    """ Converts a JSON list of respondents to a list """

    json_data = open(location)
    loaded_data = json.load(json_data)
    respondent_data = loaded_data['data']['respondents']
    respondent_df = pandas.io.json.json_normalize(respondent_data)
    #print respondent_df
    user_list = respondent_df['respondent_id'].values.tolist()

    return user_list


def get_responses(survey_id, respondent_ids):
    """ Returns a list of responses to the survey """

    RESPONSES_ENDPOINT = "/v2/surveys/get_responses"
    uri = "%s%s" % (HOST, RESPONSES_ENDPOINT)
    data['survey_id'] = survey_id
    data['respondent_ids'] = respondent_ids
    response = client.post(uri, data=json.dumps(data))
    response_json = response.text
    time.sleep(1)
    obj = open('get_responses.json', 'wb')
    obj.write(response_json)
    obj.close


def get_survey_details(survey_id):
    """ Returns a survey's metadata (e.g. questions) based on survey_id """
    SURVEY_DETAILS_ENDPOINT = "/v2/surveys/get_survey_details"
    uri = "%s%s" % (HOST, SURVEY_DETAILS_ENDPOINT)
    data['survey_id'] = survey_id  # {'session_id': '55029506'}
    #print type(data) # <type 'data'>
    #print type(json.dumps(data))  # <type 'str'>
    response = client.post(uri, data=json.dumps(data))
    response_json = response.text
    #return response_json
    time.sleep(1)
    obj = open('get_survey_details.json', 'wb')
    obj.write(response_json)
    obj.close


def pandas_survey_details(location, question_or_answer):
    """ Open JSON file and convert possible survey questions/answers to dfs """
    json_data = open(location)
    loaded_data = json.load(json_data)

    pages = len(loaded_data['data']['pages'])-1  # Get Pages, Last no questions
    all_questions = pandas.DataFrame()
    all_answers = pandas.DataFrame()

    # Goes through each page, gets JSON, normalizes/converts to df, appends
    for index in range(pages):
        # Questions Section
        questions_data = loaded_data['data']['pages'][index]['questions']
        questions_df = pandas.io.json.json_normalize(questions_data)
        all_questions = all_questions.append(questions_df, ignore_index=True)

        # For each Question, loops through all the Answers
        answers_per_page = len(loaded_data['data']['pages'][index]['questions'])
        for a_index in range(answers_per_page):
            answers_data = loaded_data['data']['pages'][index]['questions'][a_index]['answers']
            answers_df = pandas.io.json.json_normalize(answers_data)
            all_answers = all_answers.append(answers_df, ignore_index=True)

    #print "Questions DF: ", all_questions
    #print "Answers DF: ", all_answers

    ### Optional - Print to CSV to sanity check
    #all_questions.to_csv('all_questions.csv')
    #all_answers.to_csv('all_answers.csv')

    filtered_questions = all_questions[['heading', 'question_id', 'type.family', 'type.subtype']]
    filtered_answers = all_answers[['text','answer_id', 'position']]

    ### Optional - Print to CSV to sanity check
    filtered_questions.to_csv('all_questions.csv')
    filtered_answers.to_csv('all_answers.csv')

    if question_or_answer == 'question':
        return filtered_questions
    elif question_or_answer == 'answer':
        return filtered_answers
    else:
        return 0


def pandas_get_responses(location):
    """ Open JSON file and convert user's answers/matching question to df """
    json_data = open(location)
    loaded_data = json.load(json_data)
    user_data = loaded_data['data']
    user_df = pandas.io.json.json_normalize(user_data)
    all_users = user_df['respondent_id']

    #resp_question = loaded_data['data'][1]['questions']
    #answ_question = loaded_data['data'][1]['questions'][1]['answers']

    pages = len(loaded_data['data'])
    all_resps = pandas.DataFrame()
    all_user_answers = pandas.DataFrame()

    # Goes through each page, gets JSON, normalizes/converts to df, appends
    for index in range(pages):
        # Questions Section
        resp_data = loaded_data['data'][index]['questions']
        resp_df = pandas.io.json.json_normalize(resp_data)

        resp_df['respondent_id'] = all_users[index]  # Add respondent_id to questions
        all_resps = all_resps.append(resp_df, ignore_index=True)

        user_answers_per_page = len(loaded_data['data'][index]['questions'])
        for r_index in range(user_answers_per_page):
            user_answers_data = loaded_data['data'][index]['questions'][r_index]['answers']
            user_answers_df = pandas.io.json.json_normalize(user_answers_data)
            all_user_answers = all_user_answers.append(user_answers_df, ignore_index=True)


    #print "All Users: ", user_df  # Not needed since respondent_id in all_resps
    #user_df.to_csv('user_df.csv')
    #print "All Questions: ", all_resps
    #print "All User Answers: ", all_user_answers # all_user_answers['row']

    response_df = pandas.DataFrame.merge(all_resps, all_user_answers, left_on=all_resps.index, right_on=all_user_answers.index, how='left')
    response_df.drop(['key_0'], axis=1, inplace=True)  # Cleanup; remove extra columns


    # OPTIONAL - Create CSV files from DataFrames - Used to peak at all data
    #all_resps.to_csv('all_resps.csv')
    #all_user_answers.to_csv ('all_user_answers.csv')
    #response_df.to_csv('response_df.csv')

    return response_df

    ### TO-DO Flip weights of specific questions


def flip_number(x):
    "Takes a value and flips it (e.g. from 1 to 5 or 5 to 1"
    if x==1:
        return 5
    elif x==2:
        return 4
    elif x==3:
        return 3
    elif x==4:
        return 2
    elif x==5:
        return 1


def supervisor_hide(x):
    """ Takes a name and returns a new anonymous name """
    #print "Passing in :", x
    sups = {'Anitha': 'Batman',
            'Ellen': 'Grumpy',
            'Gloria': 'Superman',
            'Jackie': 'TheJoker',
            'Caroline': 'Wonderwoman',
            'Kelly': 'PiedPiper',
            'Derick': 'Sleepy',
            'Swayne': 'Robin',
            'Maria': 'Spiderman',
            'I do not receive any additional individual clinical supervision (Skip to Next Page)': 'I do not receive any additional individual clinical supervision (Skip to Next Page)',
            'I do not receive clinical supervision (Skip to Next Page)': 'I do not receive clinical supervision (Skip to Next Page)',
            'I do not receive group clinical supervision (Skip to Next Page)': 'I do not receive group clinical supervision (Skip to Next Page)'
            }
    # sups['Anitha'] # 'Batman'

    if pandas.isnull(x):  # Check NaN
        pass
        #print "X is NaN"
    else:
        print "Returning ", sups[x]
        return sups[x]

def supervisor_hide_num(x):
    """ Takes a supervisor's number and returns a new anonymous number to rearrange order"""
    #print "Passing in :", x
    sups = {1: 179,
            2: 154,
            3: 164,
            4: 175,
            5: 199,
            6: 132,
            7: 125,
            8: 155,
            9: 180,
            10: 999
            }
    # sups['Anitha'] # 'Batman'

    if pandas.isnull(x):  # Check NaN
        pass
        #print "X is NaN"
    else:
        print "Returning ", sups[x]
        return sups[x]

if __name__ == '__main__':

    ### Get all our JSON files from SurveyMonkey
    #print pandas_survey_list()  # Get list of all our surveys
    get_respondent_list_json('56008104')  # Creates get_respondent_list.json
    user_list = convert_respondent_list('/Users/williamliu/GitHub/surveys/get_respondent_list.json')
    get_responses('56008104', user_list)  # Creates get_responses.json
    get_survey_details('56008104')  # Creates get_survey_details.json

    ### Take JSON files and convert them into Pandas Dataframes
    question_key = pandas_survey_details('/Users/williamliu/GitHub/surveys/get_survey_details.json', 'question')
    answer_key =pandas_survey_details('/Users/williamliu/GitHub/surveys/get_survey_details.json', 'answer')
    responses = pandas_get_responses('/Users/williamliu/GitHub/surveys/get_responses.json')

    ### Join all Dataframes for an easy to analyze dataframe, merge answer and question key to responses
    #responses.to_csv('responses.csv')
    #answer_key.to_csv('answer_key.csv')
    #question_key.to_csv('question_key.csv')

    # Merge Questions with User Responses
    temp_df = pandas.DataFrame.merge(responses, question_key, left_on='question_id', right_on='question_id', how='left')
    # Working up to here

    #temp_df.to_csv('temp_df.csv')

    # Merge Answers data with User Responses
    final_df = pandas.DataFrame.merge(temp_df, answer_key, left_on='row', right_on='answer_id', how='left')
    final_df = pandas.DataFrame.merge(final_df, answer_key, left_on='col', right_on='answer_id', how='left')
    #final_df.drop(['key_0'], axis=1, inplace=True)  # Cleanup; remove extra columns

    ### Cleanup
    # Combine columns
    #print pandas.Series.isnull(final_df['text_x'])
    #print pandas.Series.isnull(final_df['text_y'])
    final_df['text_y'].fillna(final_df['text_x'], inplace=True)
    final_df['text_y'].fillna(final_df['text_x'], inplace=True)
    final_df['position_y'].fillna(final_df['position_x'], inplace=True)
    del final_df['text_x']
    del final_df['answer_id_x']
    del final_df['answer_id_y']
    del final_df['position_x']

    # Added 10/6/2014
    final_df['question_heading'] = final_df['question_id'].astype(str) + "_" + final_df['heading'].values
    final_df.to_csv('final_df.csv')

    raw_survey = pandas.DataFrame.from_csv('/Users/williamliu/GitHub/surveys/final_df.csv')
    survey = raw_survey.drop_duplicates(['respondent_id', 'question_heading'])  # Remove duplicate respondents, if any
    #survey.to_csv('survey.csv')

    pivoted_survey = survey.pivot(index='respondent_id', columns='question_heading', values='text_y')
    pivoted_survey = pivoted_survey.rename(columns=lambda x: x.replace(" ", "_"))  # Replace whitespaces
    pivoted_survey['701559548_I_receive_individual_clinical_supervision_with:_'] = pivoted_survey['701559548_I_receive_individual_clinical_supervision_with:_'].apply(lambda x: supervisor_hide(x))
    pivoted_survey['701568899_I_receive_individual_clinical_supervision_with:_'] = pivoted_survey['701568899_I_receive_individual_clinical_supervision_with:_'].apply(lambda x: supervisor_hide(x))
    pivoted_survey['701569440_I_receive_group_clinical_supervision_with:_'] = pivoted_survey['701569440_I_receive_group_clinical_supervision_with:_'].apply(lambda x: supervisor_hide(x))
    pivoted_survey.to_csv('pivoted_survey.csv')

    scaled_survey = survey.pivot(index='respondent_id', columns='question_heading', values='position_y')
    scaled_survey = scaled_survey.rename(columns=lambda x: x.replace(" ", "_"))  # Replace whitespaces

    ### Reverse Scores for Questions 1, 4, 15, 17, 29
    # Question 1: 701543957_I_am_happy._
    # Question 4: 701545007_I_feel_connected_to_others._
    # Question 15: 701547864_I_have_beliefs_that_sustain_me._
    # Question 17: 701548283_I_am_the_person_I_always_wanted_to_be._
    # Question 29: 701551109_I_can't_recall_important_parts_of_my_work_with_trauma_victims._

    scaled_survey['701543957_I_am_happy._'] = scaled_survey['701543957_I_am_happy._'].apply(lambda x: flip_number(x))
    scaled_survey['701545007_I_feel_connected_to_others._'] = scaled_survey['701545007_I_feel_connected_to_others._'].apply(lambda x: flip_number(x))
    scaled_survey['701547864_I_have_beliefs_that_sustain_me._'] = scaled_survey['701547864_I_have_beliefs_that_sustain_me._'].apply(lambda x: flip_number(x))
    scaled_survey['701548283_I_am_the_person_I_always_wanted_to_be._'] = scaled_survey['701548283_I_am_the_person_I_always_wanted_to_be._'].apply(lambda x: flip_number(x))
    scaled_survey["701551109_I_can't_recall_important_parts_of_my_work_with_trauma_victims._"] = scaled_survey["701551109_I_can't_recall_important_parts_of_my_work_with_trauma_victims._"].apply(lambda x: flip_number(x))
    scaled_survey['701559548_I_receive_individual_clinical_supervision_with:_'] = scaled_survey['701559548_I_receive_individual_clinical_supervision_with:_'].apply(lambda x: supervisor_hide_num(x))
    scaled_survey['701568899_I_receive_individual_clinical_supervision_with:_'] = scaled_survey['701568899_I_receive_individual_clinical_supervision_with:_'].apply(lambda x: supervisor_hide_num(x))
    scaled_survey['701569440_I_receive_group_clinical_supervision_with:_'] = scaled_survey['701569440_I_receive_group_clinical_supervision_with:_'].apply(lambda x: supervisor_hide_num(x))
    scaled_survey.to_csv('scaled_survey.csv')

    ##########

    '''
    ordered_cols = [
        'I_am_between:_', #1
        'I_have_been_employed_at_MHA_for:_', #2
        'I_have_other_employment_outside_MHA', #3
        'I_work_outside_of_MHA_in_a_clinical/therapeutic_capacity:_', #4
        'I_am_happy._', #5
        'I_am_preoccupied_with_more_than_one_person_I_help._', #6
        'I_get_satisfaction_from_being_able_to_help_people._', #7
        'I_feel_connected_to_others._', #8
        'I_jump_or_am_startled_by_unexpected_sounds._', #9
        'I_feel_invigorated_after_working_with_those_I_help._', #10
        'I_find_it_difficult_to_separate_my_personal_life_from_my_life_as_a_counselor._', #11
        'I_am_not_as_productive_at_work_because_I_am_losing_sleep_over_traumatic_experiences_of_a_person_I_help.', #12
        'I_think_that_I_might_have_been_affected_by_the_traumatic_stress_of_those_I_help._', #13
        'I_feel_trapped_by_my_job_as_a_counselor._', #14
        'Because_of_my_counseling,_I_have_felt_"on_edge"_about_various_things._', #15
        'I_like_my_work_as_a_counselor._', #16
        'I_feel_depressed_because_of_the_traumatic_experiences_of_the_people_I_help._', #17
        'I_feel_as_though_I_am_experiencing_the_trauma_of_someone_I_have_helped._', #18
        'I_have_beliefs_that_sustain_me._', #19
        'I_am_pleased_with_how_I_am_able_to_keep_up_with_counseling_techniques_and_protocols._', #20
        'I_am_the_person_I_always_wanted_to_be._', #21
        'My_work_makes_me_feel_satisfied._', #22
        'I_feel_worn_out_because_of_my_work_as_a_counselor.', #23
        'I_have_happy_thoughts_and_feelings_about_those_I_help_and_how_I_could_help_them._', #24
        'I_feel_overwhelmed_because_my_casework_load_seems_endless._', #25
        'I_believe_I_can_make_a_difference_through_my_work._', #26
        'I_avoid_certain_activities_or_situations_because_they_remind_me_of_frightening_experiences_of_the_people_I_help.', #27
        'I_am_proud_of_what_I_can_do_to_help._', #28
        'As_a_result_of_my_helping_I_have_intrusive,_frightening_thoughts._', #29
        'I_feel_"bogged_down"_by_the_system._', #30
        'I_have_thoughts_that_I_am_a_"success"_as_a_counselor._', #31
        "I_can't_recall_important_parts_of_my_work_with_trauma_victims._", #32
        "I_am_a_very_caring_person._", #33
        'I_am_happy_that_I_chose_to_do_this_work.', #34
        'I_am_fairly_compensated.', #35
        'I_am_happy_with_my_work_shift._', #36
        'I_am_learning_from_my_peers.', #37
        'I_am_learning_from_my_supervisor(s)._', #38
        'I_have_opportunities_for_growth_within_the_organization.', #39
        'I_have_opportunities_for_professional_development._', #40
        'I_receive_individual_clinical_supervision_with:_', #41
        'My_supervisor_was_approachable', #42   ### Start of Duplicates
        'My_supervisor_was_respectful_of_my_views_and_ideas', #43
        'My_supervisor_gave_me_feedback_in_a_way_that_felt_safe', #44
        'My_supervisor_was_enthusiastic_about_supervising_me', #45
        'I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor', #46
        'My_supervisor_was_non-judgemental_in_supervision', #47
        'My_supervisor_was_open-minded_in_supervision', #48
        'My_supervisor_gave_me_positive_feedback_on_my_performance', #49
        'My_supervisor_had_a_collaborative_approach_in_supervision', #50
        'My_supervisor_encouraged_me_to_reflect_on_my_practice', #51
        'My_supervisor_paid_attention_to_my_unspoken_feelings_and_anxieties', #52
        'My_supervisor_drew_flexibly_from_a_number_of_theoretical_models', #53
        'My_supervisor_paid_close_attention_to_the_process_of_supervision', #54
        'My_supervisor_helped_me_identify_my_own_learning/training_needs', #55
        'Supervision_sessions_were_focused', #56
        'Supervision_sessions_were_structured', #57
        'My_supervision_sessions_were_disorganised', #58
        'My_supervisor_made_sure_that_our_supervision_sessions_were_kept_free_from_interruptions', #59
        'I_receive_individual_clinical_supervision_with:_', #60
        'I_receive_group_clinical_supervision_with:_' #79
        ]

    sorted_survey = pivoted_survey[ordered_cols]
    sorted_survey.to_csv('sorted_survey.csv')
    '''

    """'My_supervisor_was_approachable', #61  ### DUPLICATE of 42, 61, 80
        'My_supervisor_was_respectful_of_my_views_and_ideas', #62  ### DUPLICATE 43, 62, 81
        'My_supervisor_gave_me_feedback_in_a_way_that_felt_safe', #63  ### DUPLICATE 44, 63, 82
        'My_supervisor_was_enthusiastic_about_supervising_me', #64  ### DUPLICATE 45, 64, 83
        'I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor', #65
        'My_supervisor_was_non-judgemental_in_supervision', #66  ### DUPLICATE 47, 66, 85
        'My_supervisor_was_open-minded_in_supervision', #67  ### DUPLICATE 48, 67, 86
        'My_supervisor_gave_me_positive_feedback_on_my_performance', #68  ### DUPLICATE 49, 68, 87
        'My_supervisor_had_a_collaborative_approach_in_supervision', #69  ### DUPLICATE 50, 69, 88
        'My_supervisor_encouraged_me_to_reflect_on_my_practice', #70  ### DUPLICATE 51, 70, 89
        'My_supervisor_paid_attention_to_my_unspoken_feelings_and_anxieties', #71  ### DUPLICATE 52, 71, 90
        'My_supervisor_drew_flexibly_from_a_number_of_theoretical_models', #72  ### DUPLICATE 53, 72, 91
        'My_supervisor_paid_close_attention_to_the_process_of_supervision', #73  ### DUPLICATE 54, 73, 92
        'My_supervisor_helped_me_identify_my_own_learning/training_needs', #74  ### DUPLICATE 55, 75, 94
        'Supervision_sessions_were_focused', #75  ### DUPLICATE 56, 75, 94
        'Supervision_sessions_were_structured', #76  ### DUPLICATE
        'My_supervision_sessions_were_disorganised', #77  ### DUPLICATE
        'My_supervisor_made_sure_that_our_supervision_sessions_were_kept_free_from_interruptions', #78  ### DUPLICATE"""

