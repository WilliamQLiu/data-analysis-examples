""" Kaggle Avazu CTR

    Dataset: d41d8cd9 is NULL?  - Need confirmation / check
    * train - 10 days of click-through data, ordered chronologically
      non-clicks and clicks are subsampled according to different strategies
    * test - 1 day of ads for testing model predictions

    id: ad identifier
    click: 0/1 for non-click/click
    hour: format is YYMMDDHH, so 14091123 means 23:00 on Sept. 11, 2014 UTC.
    C1 -- anonymized categorical variable
    banner_pos
    site_id
    site_domain
    site_category
    app_id
    app_domain
    app_category
    device_id
    device_ip
    device_model
    device_type
    device_conn_type
    C14-C21 -- anonymized categorical variables

"""


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale, OneHotEncoder, LabelEncoder, StandardScaler
from sklearn.cluster import KMeans
from sklearn.feature_extraction import DictVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import metrics  # For stats like
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import SGDClassifier, LogisticRegression, LinearRegression
from sklearn.cross_validation import cross_val_score, train_test_split, KFold
from sklearn.naive_bayes import GaussianNB
import statsmodels.api as sm
#import pyprind as pp
#import time


### Get Path to files
print "Getting path to files..."
train_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/train'
test_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/test'
#small_train_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/small_train'
#sub_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/submission_scikitlearn'


def plt_corr_matrix(dataset, col_names):
    print "Creating correlation matrix"
    # Plot out correlation
    corr_matrix = np.corrcoef(dataset.T)

    #plt.tight_layout()

    sm.graphics.plot_corr(corr_matrix, xnames=col_names)
    #axes.get_xaxis().set_visible(False)
    plt.show()


def peak_data(dataset):
    """ Look at dataset """
    print "Looking at dataset"
    ### Look at data
    print dataset.info()
    print dataset.head()
    print dataset.describe()
    print dataset.dtypes


def convert_data(dataset):
    """
    # Converting data into categories
    print "Converting datatypes..."
    train["click"] = pd.Categorical(train["click"], ordered=False)
    train["C1"] = pd.Categorical(train["C1"], ordered=False)
    train["banner_pos"] = pd.Categorical(train["banner_pos"], ordered=False)
    train["site_id"] = pd.Categorical(train["site_id"], ordered=False)
    train["site_domain"] = pd.Categorical(train["site_domain"], ordered=False)
    train["site_category"] = pd.Categorical(train["site_category"], ordered=False)
    train["app_id"] = pd.Categorical(train["app_id"], ordered=False)
    train["app_domain"] = pd.Categorical(train["app_domain"], ordered=False)
    train["app_category"] = pd.Categorical(train["app_category"], ordered=False)
    train["device_id"] = pd.Categorical(train["device_id"], ordered=False)
    train["device_ip"] = pd.Categorical(train["device_ip"], ordered=False)
    train["device_model"] = pd.Categorical(train["device_model"], ordered=False)
    train["device_type"] = pd.Categorical(train["device_type"], ordered=False)
    train["device_conn_type"] = pd.Categorical(train["device_conn_type"], ordered=False)
    train["C14"] = pd.Categorical(train["C14"], ordered=False)
    train["C15"] = pd.Categorical(train["C15"], ordered=False)
    train["C16"] = pd.Categorical(train["C16"], ordered=False)
    train["C17"] = pd.Categorical(train["C17"], ordered=False)
    train["C18"] = pd.Categorical(train["C18"], ordered=False)
    train["C19"] = pd.Categorical(train["C19"], ordered=False)
    train["C20"] = pd.Categorical(train["C20"], ordered=False)
    train["C21"] = pd.Categorical(train["C21"], ordered=False)
    print train.dtypes

    #print "Looking at data after conversion..."
    #print train.dtypes
    print train["click"].head()  # 2  [0, 1]
    print train["C1"].head()  # 7, [1001, 1002, 1005, 1007, 1008, 1010, 1012]
    print train["banner_pos"].head()  # Solid 7  [0, 1, 2, 3, 4, 5, 7]
    print train["site_domain"].head()  # 7745  [000129ff, 0035f25a,]
    print train["site_category"].head()  # 26  [0569f928, 110ab22d,]
    print train["app_id"].head()  # 8552  [000d6291, 000f21f1,]
    print train["app_domain"].head()  # 559  [001b87ae, 002e4064,]
    print train["app_category"].head()  # 36  [07d7df22, 09481d60,]
    print train["device_id"].head()  # 2686408  [00000414, 00000715]
    print train["device_model"].head()  # 8251  [00097428, 0009f4d7]
    print train["device_type"].head()  # 5  [0, 1, 2, 4, 5]
    print train["device_conn_type"].head()  # Okay 4  [0, 2, 3, 5]
    print train["C14"].head()  # 2626  [375, 376, 377, 380,]
    print train["C15"].head()  # 8  [120, 216, 300, 320, 480, 728, 768, 1024]
    print train["C16"].head()  # 9  [20, 36, 50, 90, ..., 320, 480, 768, 1024]
    print train["C17"].head()  # 435  [112, 122, 153, 178,]
    print train["C18"].head()  # Solid 4  [0, 1, 2, 3]
    print train["C19"].head()  # 68  [33, 34, 35, 38,]
    print train["C20"].head()  # 172  [-1, 100000, 100001,]
    print train["C21"].head()  # 60  [1, 13, 15, 16,]
    """

def store_data(dataset, name):
    """ Store data as either HDF5 or CPickle """

    ### HDF5 - cannot store categoricals
    #my_store = pd.HDFStore('my_store.h5')  # File Path
    #my_store['train'] = train
    #my_store['test'] = test
    #print my_store
    #my_store.close()

    ### Setup CPickle
    #print "Converting to Pickles"
    #train.to_pickle('train.pk1')
    #test.to_pickle('test.pk1')
    #my_train = pd.read_pickle('train.pk1')


if __name__ == "__main__":

    ### LOADING DATA
    # Load files to dataframes
    print "Loading files into dataframes..."
    train = pd.read_csv(filepath_or_buffer=train_file,
            sep=",", parse_dates=True,
            infer_datetime_format=True,
            usecols=['click', 'banner_pos', 'C18'],
            dtype={'click':np.int32,
                   'banner_pos':pd.Categorical,
                   'C18':pd.Categorical}
            #converters={'id': str, 'click':pd.Categorical}
            #low_memory=False
            )
    test = pd.read_csv(filepath_or_buffer=test_file, sep=",")
    peak_data(train)  # Look at data types

    X_data = train[['click', 'banner_pos', 'C18']]
    Y_data = test[['banner_pos', 'C18']]

    ### PREPROCESSING DATA
    print "Preprocessing Data with LabelEncoder()"
    enc = LabelEncoder()
    X_data.banner_pos = enc.fit_transform(train[['banner_pos']])
    X_data.C18 = enc.fit_transform(train[['C18']])

    Y_data.banner_pos = enc.fit_transform(test[['banner_pos']])
    Y_data.C18 = enc.fit_transform(test[['C18']])

    # Preprocessing, how to handle missing values?

    ### Preprocess Data with One Hot Encoding and Standardization
    #print "Preprocessing with One-Hot-Encoder"
    #enc = OneHotEncoder()
    #enc.fit(X_data)
    #print enc.n_values_
    #print enc.feature_indices_

    print "Checking data after encoder transform"
    #print X_data
    #print Y_data
    #           click  banner_pos  C18
    #0             0           0    0  # X_data
    #4577461                   0    2  # Y_data (doesn't have click col)

    ### Create Train, Test Data
    print "Creating Train and Test Data"
    X_train, X_test, y_train, y_test = train_test_split(X_data[['banner_pos', 'C18']], X_data['click'], test_size=.4, random_state=1234)

    # Preprocess by Standardizing (data centered around 0 with a
    #    standard deviation of 1); this allows to compare different units (
    #    e.g. hours to miles), SGD is sensitive to feature scaling so its
    #    recommended to scale your data
    scaler = StandardScaler()
    scaler.fit(X_train)
    X_train = scaler.transform(X_train)
    X_test = scaler.transform(X_test)

    print "Checking Train and Test Data after Scaler"
    print X_train
    print X_test

    ### Creating Model
    print "Fitting Model..."

    ### SGD is:
    clf = SGDClassifier(loss='hinge', penalty='l2', random_state=1234, shuffle=True,
            n_jobs=5)
    clf.fit(X_train, y_train)
    clf.predict(Y_data)
    print "The score is: ", clf.score(X_test,y_test)
    print "The coef is: ", clf.coef_
    print "The intercept is: ", clf.intercept_


    ### Logistic Regression is: 0.830202327687
    '''clf = LogisticRegression()
    clf.fit(X_train, y_train)  # Fit/Train the model
    print "The score is: ", clf.score(X_test, y_test)'''


    """

    ### Transform
    print "Convert Text into vectors of numerical values so we can do statistical analysis"
    data_train = train[["click", "banner_pos", "C18"]]
    #print data.info()
    dv = DictVectorizer()
    cat_matrix = dv.fit_transform(data.T.to_dict().values())
    cat_matrix = scale(cat_matrix.todense())
    #col_names = dv.get_feature_names()
    #print col_names

    ### Plot Correlation Matrix
    #print "Printing Correlation Matrix..."
    #plt_corr_matrix(cat_matrix, col_names)

    ### Create Train, Test Data
    X_train, X_test, y_train, y_test = train_test_split(data[['banner_pos', 'C18']], data['click'], test_size=.6, random_state=0)

    ### Create model
    print "Creating model"
    clf = LogisticRegression()
    clf.fit(X_train, y_train)  # Train the model

    ## Print the score
    print "The score is: ", clf.score(X_test, y_test)
    #print "Cross Validing: ", np.mean(cross_val_score(clf, X_test, y_test, scoring='roc_auc', cv=3))
    """