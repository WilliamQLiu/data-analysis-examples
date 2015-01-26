""" Looking at Lifeline Chats over time, interested because we went live 
    24/7.  Want to look at which centers are taking chats, answered, waittime,
    surveys filled out """


import matplotlib.pyplot as plt
import pandas.tools.rplot as rplot  # Sepcific for trellis plots
import numpy as np
import pandas as pd
#import pylab


loc = r'C:\Users\wliu\Documents\GitHub\data-analysis-examples\Python\LifelineChatVolByTime\jan_chats.csv'


def trellis_plot_histogram(data):
    """ Trellis Plot """
    plt.figure()
    plot = rplot.RPlot(data, x='TotalTimeInQ', y='WaitTimeSeconds')
    plot.add(rplot.TrellisGrid(['Account', '.']))
    plot.add(rplot.GeomHistogram())
    plot.render(plt.gcf())
    plt.show()


if __name__ == '__main__':

    data = pd.read_csv(filepath_or_buffer=loc, sep=',')

    ### Format and Filter Data
    data['StartTime'] = pd.to_datetime(data['StartTime'])
    data['EndTime'] = pd.to_datetime(data['EndTime'])
    data['count'] = 1  # Use for counting
    data = data.set_index('StartTime')  # Set Index
    data = data['20150101':'20150120']  # Filter daterange

    #print data.head()
    #ChatName, Queue, Account, Operator, Accepted, WaitTimeSeconds, PreChatSurveySkipped, TotalTimeInQ, CrisisCenterKey, count
    #print data.info()


    """
    ### Resample
    df = data.resample('D', how='sum')
    print df
    x = df.index
    y = df.Accepted
    """

    # Setup plot
    #plt.figure(figsize=(8,6), dpi=80)  # Create 8*6 inch figure
    data.plot(kind='line', x=data.index, y='count')

    plt.figure()
    plt.show()
    #mydf = data[['WaitTimeSeconds', 'TotalTimeInQ', 'count']]
    #df = mydf.cumsum()
    #plt.figure()
    #df.plot()

    
    #plt.figure()

    #fig = plt.figure()
    #plt.show()
    #plt.show()
    #df.plot()

    """

    ### Format Text
    plt.figure(figsize=(8,6), dpi=80)  # Create 8*6 inch figure
    plt.title("Lifeline Chats")  # Create a title
    plt.grid()  # Display grid
    plt.xlabel("Date")  # Create text for X-axis
    plt.ylabel("Chats")  # Create text for Y-axis
    plt.axes()
    plt.plot(df.index, df.count, color='blue', linewidth=2.5, linestyle='-', label='count')
    plt.show()
    """
