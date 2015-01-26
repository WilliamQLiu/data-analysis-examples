""" How to import iCarol chats into SQL Table """
# -*- coding: utf-8 -*-
# pylint: disable=I0011,C0103,W0142

import os
import csv
import codecs

#from pandas import concat, DataFrame
import pandas
import sqlalchemy

### Settings

# Will's PC Settings
#mydirectory = str(r'C:\iCarolFTPFiles\Chat')
#myfilename = 'iCarolExportChat.csv'
#myoutputfilename = 'iCarolExportChatClean.csv'
#myfinalfilename = 'iCarolExportFinal.csv'

# Will's Mac Settings
mydirectory = str(r'/Users/williamliu/Dropbox/GA/OriginalData')
myfilename = 'iCarol_Surveys.csv'
myoutputfilename = 'ic_survey_clean.csv'
#myfinalfilename = 'iCarol_Surveys_Final.csv'

### Initialize File Location
os.chdir(mydirectory)
myfullfilepath = os.path.join(mydirectory, myfilename)

"""
# Use the SQLAlchemy section if writing to SQL database
# Connect to SQLAlchemy
DB_DRIVER = '{SQL Server}'
DB_SERVER = 'LL-SQL-PI01'
DB_DATABASE = 'DataWarehouse'
#DB_UID = 'enter user id here' # Commented out real id
#DB_PWD = 'enter password here' # Commented out real password
DB_DRIVER_SQLALCHEMY = 'mssql'
SQLALCHEMY_CONNECTION = (DB_DRIVER_SQLALCHEMY + '://'
        + DB_UID + ":" + DB_PWD + "@" + DB_SERVER + "/" + DB_DATABASE
        )

engine = sqlalchemy.create_engine(SQLALCHEMY_CONNECTION, echo=True)
metadata = sqlalchemy.MetaData(bind=engine)
try:
    iCarolChatSurveyClean = sqlalchemy.Table('iCarolChatSurveyClean',
        metadata, autoload=True)
    print "Successfully loaded tables"
except IOError as my_msg:
    print "Error connecting:", my_msg
metadata.create_all(engine)
conn = engine.connect()
"""

### Define schema
mydict = {
    0:'CallReportNum',
    1:'ReportVersion',
    2:'LinkedToCallReportNum',
    3:'CallDateAndTimeStart',
    4:'CallDateAndTimeEnd',
    5:'CallLength',
    6:'CallerNum',
    7:'CallerName',
    8:'CallerMiddleName',
    9:'CallerLastName',
    10:'PhoneWorkerNum',
    11:'PhoneWorkerName',
    12:'WasRealCall',
    13:'WasHangup',
    14:'WasSexCall',
    15:'WasWrongNumber',
    16:'WasPrankCall',
    17:'WasSilentCall',
    18:'GeoCode',
    19:'GeoAssignment',
    20:'CallerAddress',
    21:'Neighborhood',
    22:'CityName',
    23:'CountyName',
    24:'StateProvince',
    25:'CountryName',
    26:'PostalCode',
    27:'CensusDivision',
    28:'CensusTrack',
    29:'CensusReportingArea',
    30:'PhoneNumberFull',
    31:'PhoneExtension',
    32:'PhoneType',
    33:'ThirdPartyName',
    34:'ThirdPartyOrganization',
    35:'ThirdPartyPhoneNumber',
    36:'ThirdPartyAddress',
    37:'ThirdPartyCity',
    38:'ThirdPartyCounty',
    39:'ThirdPartyStateProvince',
    40:'ThirdPartyPostalCode',
    41:'Narrative',
    42:'VolunteerComments',
    43:'Feedback',
    44:'CallersFeedback',
    45:'TextField2',
    46:'TextField3',
    47:'TextField4',
    48:'TextField5',
    49:'TextField6',
    50:'TextField7',
    51:'TextField8',
    52:'TextField9',
    53:'TextField10',
    54:'EnteredByWorkerNum',
    55:'EnteredByName',
    56:'EnteredOn',
    57:'Supervisor',
    58:'Reviewed',
    59:'FeedbackStatus',
    60:'FeedbackFromPhoneWorkerNum',
    61:'FeedbackFromPhoneWorkerName',
    62:'ReferralsMade',
    63:'IM Demographics - Age',
    64:'IM Demographics - Contact Info',
    65:'IM Demographics - Other please specify',
    66:'Post-Chat Survey - Feedback',
    67:'IM Demographics - Do you have thoughts of suicide?',
    68:'IM Demographics - Do you have thoughts of suicide? ',
    69:'IM Demographics - Ethnicity',
    70:'IM Demographics - Gender',
    71:'IM Demographics - How did you find out about Crisis Chat?',
    72:'IM Demographics - How upset are you? [Scale of 1–5]',
    73:'IM Demographics - How upset are you? [Scale of 1–5] ',
    74:'IM Demographics - How upset are you today? [Scale of 1–5]',
    75:'IM Demographics - How upset are you today? [Scale of 1–5)',
    76:'IM Demographics - If you didn’t connect with us who would you connect with?',
    77:'IM Demographics - Origin of Chat',
    78:'IM Demographics - Race – How do you identify yourself?',
    79:'IM Demographics - What is your main concern?',
    80:'IM Demographics - What is your main concern? ',
    81:'Post-Chat Survey - Did you find this chat helpful?',
    82:'Post-Chat Survey - Now that you have finished your chat session how upset are you? [Scale of 1–5]',
    83:'Post-Chat Survey - Now that you have finished your chat session how upset are you? [Scale of 1–5] ',
    84:'Suicide Risk Screening - Was emergency rescue dispatched?',
    85:'Suicide Risk Screening - Was suicidal ideation present?',
    86:'Suicide Risk Screening - Was suicidal ideation present? ',
    87:'Suicide Risk Screening - Was user at imminent risk for suicide?'
}

def delete_table():
    """ Delete the data from the current table """

    print "Deleting the data in the table: iCarolChatSurveyClean"
    try:
        conn.execute("""DELETE FROM
            [DataWarehouse].[dbo].[iCarolChatSurveyClean]""")
        print "Successfully deleted old records from iCarolChatSurveyClean"
    except IOError as my_msg:
        print "Error dropping table:", my_msg

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


def clean_file(infilename, outfilename):
    """Write file from original directory to a clean directory"""

    myinputfile = codecs.open(filename=infilename, mode='rb',
        encoding='utf-8', errors='ignore')
    myoutputfile = codecs.open(filename=outfilename, mode='wb',
        encoding='utf-8', errors='ignore')

    #myinputfile.next() #Skip first row
    #myinputfile.next() #Skip second row, header on third row

    for line in myinputfile:
        try:
            #newline = unicode(line, decoding='utf-8', errors='ignore')
            newline = line.encode('utf-8', errors='replace')

        except UnicodeDecodeError:
            print "Decode Error"
            newline = line.decode('utf-8', errors='ignore')
        #newline = line.encode('utf-8', errors='replace')
        newline = newline.decode('ascii', errors='ignore')
        myoutputfile.write(newline)

    myinputfile.close()
    myoutputfile.close()

def write_file_to_table(myfile, mytable):
    """Open file, read dict matches with INSERT statement, then inserts"""

    print "Inserting data from file", myfile
    ins = mytable.insert() # Create an Insert construct
    print ins # INSERT INTO q1import ([CALLKO_callid], [CALLKO_agentOut], ..)

    input_file = csv.DictReader(open(myfile), delimiter=',', quotechar='"')

    for row in input_file:
        conn.execute(ins, **row) # INSERT INTO table based on dict matches
    # Each iteration of the loop produces a dictionary of strings to write

if __name__ == '__main__':

    #delete_table() # Use if need to write to SQL table

    # Load data frame from CSV file
    ic_svy = pandas.DataFrame.from_csv(path=myfullfilepath, \
        header=2, sep=',')

    # List of columns, check if column exists
    #mycolumns = list(ic_svy.columns.values)
    #print mydict[0] # CallReportNum
    #print ic_svy[mydict[1]]
    #print ic_svy['IM Demographics - How upset are you? [Scale of 1–5]']

    ### Clean data
    ic_svy = merge_columns(ic_svy, \
        mydict[76], mydict[76], \
        "IM Demographics - If you didn't connect with us who would you connect with?")

    ic_svy = merge_columns(ic_svy, \
        mydict[78], mydict[78], \
        'IM Demographics - Race - How do you identify yourself?')

    ic_svy = merge_columns(ic_svy, \
        mydict[79], mydict[80], \
        'IM Demographics - What is your main concern?')

    ic_svy = merge_columns(ic_svy, \
        mydict[82], mydict[83], \
        'Post-Chat Survey - Now that you have finished your chat session how upset are you?  Scale of 1-5')

    ic_svy = merge_columns(ic_svy, \
        mydict[85], mydict[86], \
        'Suicide Risk Screening - Was suicidal ideation present?')

    ic_svy = merge_columns(ic_svy, \
        mydict[67], mydict[68], \
        'IM Demographics - Do you have thoughts of suicide?')
    #print "First run \n", ic_svy

    ic_svy = merge_columns(ic_svy, \
        mydict[72], mydict[73], \
        'IM Demographics - How upset are you? Scale of 1-5')

    #ic_svy = merge_columns(ic_svy, \
    #    mydict[74], mydict[75], \
    #    'IM Demographics - How upset are you? Scale of 1-5 2')

    #ic_svy = merge_columns(ic_svy, \
    #    'IM Demographics - How upset are you? Scale of 1-5 1',
    #    'IM Demographics - How upset are you? Scale of 1-5 2',
    #    'IM Demographics - How upset are you? Scale of 1-5')

    # Select only the data we need - remove unnecessary columns
    ic_svy = ic_svy[['ReportVersion', 'CallDateAndTimeStart',
        'CallDateAndTimeEnd', 'PhoneWorkerName', 'CityName', 'CountyName',
        'StateProvince', 'PostalCode', 'IM Demographics - Age',
        'IM Demographics - Other please specify', 'Post-Chat Survey - Feedback',
        'IM Demographics - Ethnicity', 'IM Demographics - Gender',
        'IM Demographics - How did you find out about Crisis Chat?',
        'IM Demographics - Origin of Chat',
        'Post-Chat Survey - Did you find this chat helpful?',
        'Suicide Risk Screening - Was emergency rescue dispatched?',
        'Suicide Risk Screening - Was user at imminent risk for suicide?',
        "IM Demographics - If you didn't connect with us who would you connect with?",
        'IM Demographics - Race - How do you identify yourself?',
        'IM Demographics - What is your main concern?',
        'Post-Chat Survey - Now that you have finished your chat session how upset are you?  Scale of 1-5',
        'Suicide Risk Screening - Was suicidal ideation present?',
        'IM Demographics - Do you have thoughts of suicide?',
        'IM Demographics - How upset are you? Scale of 1-5']]

    ic_svy.rename(columns={
        'ReportVersion':'CrisisCenter',
        'CallDateAndTimeStart':'StartTime', 'CallDateAndTimeEnd':'EndTime',
        'CityName':'City', 'CountyName':'County', 'StateProvince': 'State',
        'PostalCode':'ZipCode', 'IM Demographics - Age':'Age',
        'IM Demographics - Other please specify':'If Other, please specify:',
        'Post-Chat Survey - Feedback':'Feedback (Optional)',
        'IM Demographics - Ethnicity':'Ethnicity',
        'IM Demographics - Gender':'Gender',
        'IM Demographics - How did you find out about Crisis Chat?':
        'How did you hear about crisis chat?',
        'Post-Chat Survey - Did you find this chat helpful?':
        'Did you find this chat service helpful?',
        'IM Demographics - What is your main concern?':
        'What are you concerned about today?',
        'Post-Chat Survey - Now that you have finished your chat session how upset are you?  Scale of 1-5':
        'Now that you have finished your chat session, how upset are you?',
        'IM Demographics - Do you have thoughts of suicide?':
        'Do you have thoughts of suicide?',
        'IM Demographics - How upset are you? Scale of 1-5':
        'On a scale of 1-5, how upset are you?'
        }, inplace=True)

    ic_svy.to_csv(myoutputfilename)

    # Writing file out to csv still has weird encodings
    # clean_file(myoutputfilename, myfinalfilename)
    #write_file_to_table('iCarolFinal.csv', iCarolChatSurveyClean)
