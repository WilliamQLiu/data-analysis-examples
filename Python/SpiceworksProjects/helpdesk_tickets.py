"""
    Calculate number of tickets open and closed (with source being a csv file)
"""
# pylint: disable=I0001,C0103,W0141


import os  # For filepaths
import datetime  # Needed for date calculations
import pandas as pd
import pdb

import pandas  # For dataframes
from pandas.tseries.offsets import *  # For Bday (Business Days) utility

# Specify directories
ORIGINAL_DIRECTORY = str(r'C:\Users\wliu\Desktop\Spiceworks\Original')
os.chdir(ORIGINAL_DIRECTORY)  # Change Local directory (where files go to)
FILENAME = 'myexport.csv'


def filter_person(mydf):
    """ Exclude specific columns from the data source """

    #mydf = mydf[mydf['Status'] == 'open']
    mydf = mydf[mydf['Assignee Name'].isin(['Zenzele B.', 'Norbert L.'])]  # 'Zenzele B.', 'Norbert L.'
    mydf.fillna(0, inplace=True)  # Fill NaN's with 0's

    # Sort Desc
    #print mydf.values  # print actual values instead of summary
    return mydf


def check_date(x):
    try:
        x = x[:10]
        return x
    except:
        pass


def clean_data(mydf):
    """ Clean Data Fields """
    created = mydf['Create Date'].apply(lambda x: x[:10])
    mydf['Created'] = created

    mydf['Close Date'].fillna('0', inplace=True)
    closed = mydf['Close Date'].apply(check_date)
    mydf['Closed'] = closed
    print mydf

    pd.to_datetime(mydf['Created'], format='%Y-%m-%d')
    pd.to_datetime(mydf['Closed'], format='%Y-%m-%d')

    return mydf


def write_dataframe_to_csv(mydf, name):
    """ Write a dataframe to a CSV file """

    newname = name + '.csv'  # Modify name to new csv name
    mydf.to_csv(newname, encoding='utf-8')  # Write dataframe to csv


if __name__ == "__main__":

    # Specify file locations
    mynewoutputfile = os.path.join(ORIGINAL_DIRECTORY, FILENAME)
    dataframe = pandas.io.parsers.read_table(mynewoutputfile, sep=',',
        quotechar='"', header=0, index_col=0, error_bad_lines=True,
        warn_bad_lines=True, encoding='utf-8')

    df = filter_person(dataframe)
    final_df = clean_data(df)

    # Write dataframes to csv files
    write_dataframe_to_csv(final_df, 'Helpdesk')
