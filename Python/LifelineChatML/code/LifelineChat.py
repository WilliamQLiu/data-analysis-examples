
# coding: utf-8

# In[88]:

from dateutil.parser import parse # Allows automatic parsing of dates
from ggplot import *
import pandas as pd
import numpy as np
import pandas.tools.rplot as rplot
from pandas.tools.plotting import scatter_matrix
import matplotlib.pyplot as plt
import re
import matplotlib
import pylab
from numpy.random import randn
get_ipython().magic(u'matplotlib inline')


# In[89]:

pd.set_option('expand_frame_repr', True) # expand text on build
pd.set_option('display.max_columns', 0) # Display any number of columns
pd.set_option('display.max_rows', 0) # Display any number of rows


# In[90]:

survey = pd.read_csv(
    r'/Users/williamliu/GitHub/MHAPython/Lifeline/Chats/final_clean.csv'
    #dtype={'Did you find this chat service helpful?':}, parse_dates=True
    )
survey['counter'] = 1


# In[91]:

#Pre-Chat: Age
survey['Age'].replace(to_replace='[\D].+', value=np.nan, regex=True, inplace=True)
survey = survey.convert_objects(convert_numeric=True)
#print survey['Age'].describe()
survey.Age[survey.Age > 117] = 0
grouped = survey.groupby('Age')
grouped['counter'].sum().head()#.plot(kind='barh')
#plt.show()


# In[92]:

#print type(survey['StartTime']) # <class 'pandas.core.series.Series'>
#survey = survey.set_index(pd.to_datetime(survey.StartTime))
#print type(survey.index) # <class 'pandas.tseries.index.DatetimeIndex'>
#survey.head()

# X-Axis for time calculations
ts = pd.date_range(start='3/1/2013', end='3/31/2014', freq='D')

#mod_starttime = pd.to_datetime(survey.StartTime)
#print type(mod_starttime)
#grouped = survey.groupby(pd.to_datetime(survey.StartTime), coerce=True)
#print grouped.head()


# In[93]:

#print survey.head()


# In[8]:

#survey.describe()
#survey.count()

#ts = pd.to_datetime(survey.StartTime)
#survey = survey.set_index(ts)
#print type(survey.index)
#print survey.index
#survey.head()


# In[94]:

#Pre-Chat: What are you concerned about today?
survey['What are you concerned about today?'].replace(to_replace='[Bullying]{8}.*', value="Bullying/Problems in School", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Family]{5}.*', value="Family Issues", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Financial]{9}.*', value="Financial Issues", regex=True, inplace=True)
#survey['What are you concerned about today?'].replace(to_replace='[Other]{5}.*', value="Other/Prefer not to comment", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Relationship issues]{19}.*', value="Relationship Issues/Violence", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Self\-| Harm]{8}.*', value="Self-harm", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Sexuality]{9}.*', value="Sexuality", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Physical H|health]{14}.*', value="Physical Health", regex=True, inplace=True)
survey['What are you concerned about today?'].replace(to_replace='[Physical, Sexual, and/or Emotional Abuse]{24}.*', value="Physical, Sexual, and/or Emotional Abuse", regex=True, inplace=True)
survey['What are you concerned about today?'] = survey['What are you concerned about today?'].replace('Other', '') #Data Cleaning

grouped = survey.groupby('What are you concerned about today?')
grouped['counter'].sum()#.plot(kind='barh')
#plt.show()
print grouped


# In[95]:

#Pre-Chat: Gender
survey.Gender = survey.Gender.replace('Transgendered', 'Transgender') #Data Cleaning
grouped = survey.groupby('Gender')
grouped['counter'].sum()#.plot(kind='bar')
#plt.show()


# In[96]:

#Pre-Chat: Do you have thoughts of suicide?
survey['Do you have thoughts of suicide?'] = survey['Do you have thoughts of suicide?'].replace(      {'Yes - Current (within the past 24 hours)':'Yes - Current (within the past 24 hours)',
      'Yes � Current (within the past 24 hours)':'Yes - Current (within the past 24 hours)',
      'Yes- Current (within the past 24 hours)':'Yes - Current (within the past 24 hours)',
      'Yes � Recent Past (within the past few days)':'Yes - Recent Past (within the past few days)',
      'Yes - currently':'Yes - Current (within the past 24 hours)',
      'Yes - recent past':'Yes - Recent Past (within the past few days)',
      'Yes - within the past 48 hours': 'Yes - Recent Past (within the past few days)',
      'Yes- Recent (withing the past few days)':'Yes - Recent Past (within the past few days)',
      'Yes- Recent Past (within the past few days)':'Yes - Recent Past (within the past few days)',
      'No ':'No' 
      }) #Data Cleaning
survey['Do you have thoughts of suicide?'].replace(to_replace='[Yes].*[Current (within the past 24 hours)]{33}', value="Yes - Current (within the past 24 hours)", regex=True, inplace=True)
survey['Do you have thoughts of suicide?'].replace(to_replace='[Yes].*[Recent Past (within the past few days)]{33}', value="Yes - Recent Past (within the past few days)", regex=True, inplace=True)

grouped = survey.groupby('Do you have thoughts of suicide?')
grouped['counter'].sum()


# In[124]:

#Pre-Chat: How upset are you?
survey['On a scale of 1-5, how upset are you?'].replace(to_replace='[1].*', value="1 - I'm doing okay", regex=True, inplace=True)
survey['On a scale of 1-5, how upset are you?'].replace(to_replace='[2].*', value="2 - A little upset", regex=True, inplace=True)
survey['On a scale of 1-5, how upset are you?'].replace(to_replace='[3].*', value="3 - Moderately upset", regex=True, inplace=True)
survey['On a scale of 1-5, how upset are you?'].replace(to_replace='[4].*', value="4 - Very upset", regex=True, inplace=True)
survey['On a scale of 1-5, how upset are you?'].replace(to_replace='[5].*', value="5 - Extremely upset", regex=True, inplace=True)

grouped = survey.groupby('On a scale of 1-5, how upset are you?')
grouped['counter'].sum()#.plot(kind='barh')
#plt.show()

dummies = pd.get_dummies(survey['On a scale of 1-5, how upset are you?'])
print dummies.head()


# In[98]:

#Post-Chat: How upset are you?
survey['Now that you have finished your chat session, how upset are you?'].replace(to_replace='[1].*', value="1 - I'm doing okay", regex=True, inplace=True)
survey['Now that you have finished your chat session, how upset are you?'].replace(to_replace='[2].*', value="2 - A little upset", regex=True, inplace=True)
survey['Now that you have finished your chat session, how upset are you?'].replace(to_replace='[3].*', value="3 - Moderately upset", regex=True, inplace=True)
survey['Now that you have finished your chat session, how upset are you?'].replace(to_replace='[4].*', value="4 - Very upset", regex=True, inplace=True)
survey['Now that you have finished your chat session, how upset are you?'].replace(to_replace='[5].*', value="5 - Extremely upset", regex=True, inplace=True)

grouped = survey.groupby('Now that you have finished your chat session, how upset are you?')
grouped['counter'].sum()#.plot(kind='barh')
#plt.show()


# In[99]:

#Pre-Chat: State
survey['State'].replace(to_replace='[^a-zA-Z]', value=np.nan, regex=True, inplace=True) # Clean State (was seeing numbers, etc)

grouped = survey.groupby('State')
grouped['counter'].sum()


# In[100]:

#Post-Chat: Is Service Helpful?
grouped = survey.groupby('Did you find this chat service helpful?')
grouped['counter'].sum()


# In[122]:

# Create dummies for Chat Service Helpful
dummies = pd.get_dummies(survey['Did you find this chat service helpful?'])
print dummies.head()


# In[101]:

grouped = survey.groupby('CrisisCenter')
grouped['counter'].sum()


# In[107]:

# iCarol Only
grouped = survey.groupby('Suicide Risk Screening - Was user at imminent risk for suicide?')
grouped['counter'].sum()


# In[121]:

# Create dummies for Suicidal Risk Screening
dummies = pd.get_dummies(survey['Suicide Risk Screening - Was user at imminent risk for suicide?'])
print dummies.head()
dummies.describe()


# In[102]:

#test = survey.groupby(['On a scale of 1-5, how upset are you?',
#                       'Now that you have finished your chat session, how upset are you?'])
#test['counter'].sum()


# In[105]:

#explore = survey.groupby(['Gender', 
#                          'On a scale of 1-5, how upset are you?',
#                          'Now that you have finished your chat session, how upset are you?',
#                          'Do you have thoughts of suicide?'])
#data = explore['counter'].sum().reset_index()
#print data.head()


# In[9]:

#TO-DO Try out Trellis Plot for demographics
#plot = rplot.RPlot(survey, x='', y='')
#plot.add(rplot.TrellisGrid(['Gender','Do you have thoughts of suicide?']))
#plot.add(rplot.GeomHistogram())
#plot.render(plt.gcf())
#plt.show()


# In[ ]:

#survey.groupby([survey.index.date, 'CallReportNum']).count().plot(kind='line')


# In[ ]:

# Plot Chats by Time
# Resample the time-series index
survey = survey.set_index(pd.to_datetime(survey.StartTime, coerce=True))
resampled_ts = survey.StartTime.resample('MS', how='sum') #D for Days, H for Hours, MS for MonthBegin

#print type(resampled) # <class 'pandas.core.series.Series'>
mydict = {
           'ChatsPerDay': resampled
        }
mydf = pd.DataFrame(mydict)

mydf.plot(kind='bar')
plt.show()


# In[135]:

myctab = pd.crosstab(survey['Gender'], survey['Suicide Risk Screening - Was user at imminent risk for suicide?'], rownames=['Gender'])
print myctab


# In[134]:




# In[ ]:



