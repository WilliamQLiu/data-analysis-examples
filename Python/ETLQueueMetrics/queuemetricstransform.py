""" Transform QueueMetrics exported data (csv) into tables in SQL """
# http://docs.sqlalchemy.org/en/latest/core/tutorial.html
# pylint: disable=I0011,C0103,W0142

import os
import csv

import sqlalchemy

# CSV File Locations (for Calls Answered and Calls Abandoned)
OS_DIRECTORY = r"C:\QueueMetricsLoad"
os.chdir(OS_DIRECTORY)
CALLS_ABANDONED = u"callsko.csv"
CALLS_ANSWERED = u"callsok.csv"

# Connect and create tables if they don't exist
DB_DRIVER = '{SQL Server}'
DB_SERVER = 'myservername'
DB_DATABASE = 'mydatabasename'
DB_UID = 'myusername'
DB_PWD = 'mypassword'
DB_DRIVER_SQLALCHEMY = 'mssql'
SQLALCHEMY_CONNECTION = (DB_DRIVER_SQLALCHEMY + '://' + DB_UID + ":" + DB_PWD
                         + "@" + DB_SERVER + "/" + DB_DATABASE)

engine = sqlalchemy.create_engine(SQLALCHEMY_CONNECTION, echo=True)
metadata = sqlalchemy.MetaData(bind=engine)
try:
    q1import = sqlalchemy.Table('q1import', metadata, autoload=True)
    q2import = sqlalchemy.Table('q2import', metadata, autoload=True)
    queuemetrics = sqlalchemy.Table('QueueMetrics', metadata, autoload=True)
    print "Successfully loaded tables"
except IOError as my_msg:
    print "Error connecting:", my_msg
metadata.create_all(engine)
conn = engine.connect()


def step_1_drop_copy_table():
    """ Drop current copy of table so we can update the copy"""
    print "Running Step 1 - Drop current copy of QueueMetrics table"
    try:
        conn.execute("USE LifeNetDW DROP TABLE QueueMetricsCopy")
        print "Successfully Dropped Table QueueMetricsCopy table"
    except IOError as my_msg:
        print "Error dropping table:", my_msg


def step_2_create_new_copy_table():
    """ Create an updated copy of the QueueMetrics table"""
    print "Running Step 2 - Making a copy of QueueMetrics table"
    try:
        conn.execute("""USE LifeNetDW SELECT * INTO QueueMetricsCopy
            FROM QueueMetrics""")
        print "Successfully Made a Copy of QueueMetrics table"
    except IOError as my_msg:
        print "Error creating a new copy table:", my_msg


def step_3_delete_import_table():
    """ Deleting the old import tables"""
    print "Running Step 3 - Delete old import tables"
    try:
        conn.execute("""USE LifeNetDW  DELETE FROM q1import
             DELETE FROM q2import""")
        print "Successfully deleted old import tables"
    except IOError as my_msg:
        print "Error deleting old import tables:", my_msg


def step_4_write_file_to_tmptable(myfile, mytable):
    """Open file, read dict matches with INSERT statement, then inserts"""
    print "Inserting data from file", myfile
    ins = mytable.insert()  # Create an Insert construct
    #print ins  # See Insert statement e.g. INSERT INTO q1import ([f1], [f2]..)

    input_file = csv.DictReader(open(myfile), delimiter=';', quotechar='"')
    for row in input_file:
        conn.execute(ins, **row)  # INSERT INTO table based on dict matches
    # Each iteration of the loop produces a dictionary of strings to write


def step_5_update_status():
    """ Update Abandon and Answer Status """
    print "Running Step 5"
    try:
        print "Updating Abandon and Answer Status"
        conn.execute("""USE LifeNetDW UPDATE
            q1import SET CALLKO_reason = 'Abandon'
            WHERE CALLKO_reason = 'A' """)
        conn.execute("""USE LifeNetDW UPDATE
            q2import SET CALLOK_reason = 'Answer'
            WHERE CALLOK_reason = 'A' """)
        conn.execute("""USE LifeNetDW UPDATE
            q2import SET CALLOK_reason = 'Answer'
            WHERE CALLOK_reason = 'C' """)
    except:
        print "Issue with updating Abandon and Answer Status"


def step_6_update_nulls():
    """Update from Nulls to 0's"""
    print "Running Step 6"
    try:
        print "Updating Nulls to 0's"
        conn.execute("""Update [LifeNetDW].[dbo].[q1import]
                     SET [CALLKO_from]= NULL
                     WHERE IsNumeric(CALLKO_from) = 0 """)
        conn.execute("""Update [LifeNetDW].[dbo].[q2import]
                     SET [CALLOK_from]= NULL
                     WHERE IsNumeric(CALLOK_from) = 0""")
    except:
        print "Issue with updating Nulls to 0's"


def step_7_drop_table():
    """Drop table - QueueMetricsImportNewCalls """
    print "Step 7"
    try:
        print "Dropping Table QueueMetricsImportNewCalls"
        conn.execute("""USE LifeNetDW
        DROP TABLE QueueMetricsImportNewCalls""")
    except:
        print "Issue with dropping table QueueMetricsImportNewCalls"


def step_8_convert_times():
    """ Convert times """
    print "Step 8"
    try:
        print "Executing union"
        conn.execute("""
        Use LifeNetDW
        SELECT dateadd(second,CALLKO_callid - 18000,'1970-1-1') as 'CallTime'
            ,Str(CALLKO_from,10,0) as 'Caller'
            ,CALLKO_waitLen AS 'Wait'
            ,NULL as 'Duration'
            ,CALLKO_reason as 'Disconnection'
            ,CALLko_ivr as 'IVRName'
            ,CALLKO_dnis as 'DNISNumber'
            ,NULL as 'DNISName'
            ,NULL as 'AgentID'
        INTO QueueMetricsImportNewCalls
        FROM [q1import]
        UNION
        SELECT dateadd(second,CALLOK_callid - 18000,'1970-1-1') as 'CallTime',
            Str(CALLOK_from,10,0) as 'Caller'
            ,CALLOK_waitLen AS 'Wait'
            ,CALLOK_callLen as 'Duration'
            ,CALLOK_reason as 'Disconnection'
            ,CALLOK_ivr as 'IVRName'
            ,CALLOK_dnis as 'DNISNumber'
            , NULL as 'DNISName'
            ,CALLOK_agent as 'AgentID'
        FROM [q2import]
            """)
    except:
        print "Error with union"


def step_9_write_qm_table():
    """ Copy QueueMetricsImportNewCalls to QueueMetrics Table """
    print "Step 9"
    try:
        print "Copying table from copy to QueueMetrics table"
        conn.execute("""INSERT INTO QueueMetrics
            SELECT * FROM QueueMetricsImportNewCalls
            """)
    except:
        print "Error copying data into QueueMetrics table"


if __name__ == "__main__":
    step_1_drop_copy_table()
    step_2_create_new_copy_table()
    step_3_delete_import_table()
    step_4_write_file_to_tmptable(CALLS_ABANDONED, q1import)
    step_4_write_file_to_tmptable(CALLS_ANSWERED, q2import)
    step_5_update_status()
    step_6_update_nulls()
    step_7_drop_table()
    step_8_convert_times()
    step_9_write_qm_table()
