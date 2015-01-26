import pandas
import pandas.tools.rplot as rplot
from pandas.tseries.offsets import MonthBegin
import matplotlib.pyplot as plt
#import pylab
import numpy

pandas.set_option('expand_frame_repr', False) # expand text on build
pandas.set_option('display.max_columns', 0) # Display any number of columns
pandas.set_option('display.max_rows', 0) # Display any number of rows

# Load SightMax Data
sm_svy = pandas.read_csv(
    #r'C:\Users\wliu\Desktop\Lifeline Chat\SightMax_Survey2small.csv'
    #r'/Users/williamliu/Dropbox/GA/OriginalData/SightMax_Survey_small.csv'
    r'/Users/williamliu/Dropbox/GA/OriginalData/SightMax_Survey_ChatID.csv'
    #, index_col='SessionID'
    )

# Load iCarol Data
ic_svy = pandas.read_csv(
    #r'C:\Users\wliu\Desktop\Lifeline Chat\iCarol_Survey.csv'
    #r'/Users/williamliu/Dropbox/GA/CleanData/iCarol_Surveys_Clean.csv'
    r'/Users/williamliu/GitHub/MHAPython/Lifeline/Chats/ic_survey_clean.csv'
    )

mydict = {
    0:'ChatID',
    1:'StartTime',
    2:'EndTime',
    3:'City_x',
    4:'Region',
    5:'Country (optional)',
    6:'<strong>Do you have thoughts of suicide?</strong>',
    7:'<strong>Now that you have finished your chat session, how upset are you?</strong>',
    8:'<strong>On a scale of 1-5: How upset are you?</strong>',
    9:'Age',
    10:'Age:',
    11:'City_y',
    12:'City of Residence:',
    13:'Company Name:',
    14:'Contact Number',
    15:'Did you find this chat service helpful?',
    16:'Do you have thoughts of Suicide?',
    17:'Do you have thoughts of suicide?',
    18:'E-mail address',
    19:'Email Address',
    20:'Email Address:',
    21:'Feedback (optiona):',
    22:'Feedback (optional):',
    23:'Gender',
    24:'Gender:',
    25:'How did you find out about crisis chat?',
    26:'How upset are you today? [Scale of 1 - 5]',
    27:'How upset are you?',
    28:'If Other, please specify:',
    29:'In order to provide the best service possible, we would like to receive feedback on your experience with the Lifeline Chat',
    30:'MissingLabel',
    31:'Name/Alias',
    32:'Name/Alias:',
    33:'Now that you have finished your chat session, how upset are you?',
    34:'On a scale of 1-5: How upset are you?',
    35:'Other (Please list):',
    36:'Phone Number',
    37:'Phone Number(optional):',
    38:'Phone number (optional)',
    39:'Please choose one:',
    40:'School Name',
    41:'Should our chat session end unexpectedly is there an email address or phone number we may reach you at?',
    42:'Should our chat session ends unexpectedly is there an email address or phone number we may reach you at?',
    43:'State',
    44:'What are you concerned about today?',
    45:'What is your main concern?',
    46:'Where did you hear about us?',
    47:'Your Name or Alias:',
    48:'Your Name:',
    49:'Zip Code',
    50:'Message:'
}


def merge_columns(maindataframe, column1, column2, newname):
    """ Merging data from two columns """

    df1 = pandas.DataFrame(maindataframe[column1])
    df1.rename(columns={column1:newname}, inplace=True)
    #print "Dataframe 1 \n", df1, "\n"

    df2 = pandas.DataFrame(maindataframe[column2])
    df2.rename(columns={column2:newname}, inplace=True)
    #print "Dataframe 2 \n", df2, "\n"

    df3 = df1.combine_first(df2) # Replaces df1's NaNs with df2's values
    #print "Dataframe 3 \n", df3, "\n"

    # Delete old columns on main dataframe
    maindataframe = maindataframe.drop(column1, axis=1) # Remove first column
    if column1 != column2:
        maindataframe = maindataframe.drop(column2, axis=1)
        # Remove second column
    #print maindataframe

    maindataframe = pandas.concat([maindataframe, df3], axis=1)

    return maindataframe

if __name__ == '__main__':


    # sm_svy['Label'] has a lot of blanks, causes issues if you pivot
    sm_svy['Label'] = sm_svy['Label'].fillna('MissingLabel')
    sm_svy.drop_duplicates(['ChatID', 'Label'], inplace=True)

    #Pivot on Question/Answers to be their own columns to match iCarol data
    #sm_svy = sm_svy.drop_duplicates(['ChatID', 'Label','Answer'])
    df_answers = sm_svy.pivot(columns='Label', values='Answer', index='ChatID')
    df_answers = df_answers.reset_index()

    # Demographics Details
    df_demo = sm_svy[['ChatID','Expr1', 'StartTime', 'EndTime', 'City',
        'Region', 'Country']]
    df_demo.drop_duplicates(inplace=True)
    #print "DataFrame Demographics\n", df_demo.head()

    df_merged = pandas.merge(df_demo, df_answers, on="ChatID", how="inner")

    ### Clean data through mergining, renaming, and dropping columns

    # Thoughts of suicide
    df_merged = merge_columns(df_merged, \
        mydict[16], mydict[17], \
        "Do you have thoughts of suicide?")
    df_merged = merge_columns(df_merged, \
        "Do you have thoughts of suicide?", mydict[6], \
        "Do you have thoughts of suicide?")

    #Age
    df_merged = merge_columns(df_merged, \
        mydict[10], mydict[9], \
        "Age")

    #City
    df_merged = merge_columns(df_merged, \
        mydict[3], mydict[11], \
        "City")
    df_merged = merge_columns(df_merged, \
        "City", mydict[12], \
        "City")

    #Now that you finished your chat session, how upset are you?
    df_merged = merge_columns(df_merged, \
        mydict[7], mydict[33], \
        "Now that you have finished your chat session, how upset are you?")

    #On a scale of 1-5, how upset are you?
    df_merged = merge_columns(df_merged, \
        mydict[8], mydict[34], \
        "On a scale of 1-5, how upset are you?")
    df_merged = merge_columns(df_merged, \
        "On a scale of 1-5, how upset are you?", mydict[26], \
        "On a scale of 1-5, how upset are you?")
    df_merged = merge_columns(df_merged, \
        "On a scale of 1-5, how upset are you?", mydict[27], \
        "On a scale of 1-5, how upset are you?")

    #Feedback (Optional)
    df_merged = merge_columns(df_merged, \
        mydict[22], mydict[21], \
        "Feedback (Optional)")
    df_merged = merge_columns(df_merged, \
        "Feedback (Optional)", mydict[29], \
        "Feedback (Optional)")
    df_merged = merge_columns(df_merged, \
        "Feedback (Optional)", mydict[50], \
        "Feedback (Optional)")

    #Gender
    df_merged = merge_columns(df_merged, \
        mydict[23], mydict[24], \
        "Gender")

    #Name
    df_merged = merge_columns(df_merged, \
        mydict[31], mydict[32], \
        "Name")
    df_merged = merge_columns(df_merged, \
        "Name", mydict[47], \
        "Name")
    df_merged = merge_columns(df_merged, \
        "Name", mydict[48], \
        "Name")

    #Email
    df_merged = merge_columns(df_merged, \
        mydict[18], mydict[19], \
        "Email")
    df_merged = merge_columns(df_merged, \
        "Email", mydict[20], \
        "Email")
    df_merged = merge_columns(df_merged, \
        "Email", mydict[41], \
        "Email")
    df_merged = merge_columns(df_merged, \
        "Email", mydict[42], \
        "Email")

    #Phone Number
    df_merged = merge_columns(df_merged, \
        mydict[36], mydict[37], \
        "Phone Number")
    df_merged = merge_columns(df_merged, \
        "Phone Number", mydict[38], \
        "Phone Number")
    df_merged = merge_columns(df_merged, \
        "Phone Number", mydict[14], \
        "Phone Number")

    #What are you concerned about today?
    df_merged = merge_columns(df_merged, \
        mydict[44], mydict[45], \
        "What are you concerned about today?")

    #How did you hear about crisis chat?
    df_merged = merge_columns(df_merged, \
        mydict[25], mydict[46], \
        "How did you hear about crisis chat?")

    #State
    df_merged = merge_columns(df_merged, \
        mydict[4], mydict[43], \
        "State")

    #Crisis Center - Rename
    df_merged.rename(columns={'Expr1':'CrisisCenter'}, inplace=True)

    #Zip Code
    df_merged.rename(columns={'Zip Code':'ZipCode'}, inplace=True)


    ### Remove unnecessary columns
    del df_merged['Company Name:']
    del df_merged['School Name']
    del df_merged['Email']
    del df_merged['Phone Number']
    del df_merged['(optional)'] # Not Used
    del df_merged['Other (Please list):'] # Not Used

    # Remove Ages that are not a number
    #df_merged['Age'] = df_merged['Age']._get_numeric_data()

    #print "After Cleaning \n", df_merged.head()

    #df_merged.to_csv('sm_survey_clean.csv')



    df_final = pandas.merge(df_merged, ic_svy, how="outer")
    df_final.to_csv('final_clean.csv')

    print df_final.head()


