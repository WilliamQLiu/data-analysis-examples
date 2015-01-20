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
import datetime as dt
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale, OneHotEncoder, LabelEncoder, StandardScaler
from sklearn.cluster import KMeans
from sklearn.feature_extraction import DictVectorizer, FeatureHasher
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
    train["hour"] = pd.DateTime(train["hour"])
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


def make_date(text):
    """ Convert text format; e.g. from YYMMDDHH shows as 14091123, which
    means 23:00 on Sept. 11, 2014 UTC.
    """
    return dt.datetime.strptime(text, "%y%m%d%H")


def set_print_options():
    pd.set_option('display.mpl_style', 'default')
    pd.set_option('display.width', 2000)
    pd.set_option('display.max_columns', 200)


if __name__ == "__main__":
    set_print_options()
    ### LOADING DATA - Load files to dataframes and do feature extraction
    # Note: I selected specific features based on correlation matrix for speed
    print "Loading files into dataframes..."
    train = pd.read_csv(filepath_or_buffer=train_file,
            sep=",",
            #usecols=['click', 'hour', 'banner_pos', 'C18'],  # Feature Extraction
            dtype={
                   'click':np.int32,
                   'banner_pos':pd.Categorical,
                   'hour':np.str,
                   'C18':pd.Categorical},
            #converters={'hour':make_date},
            #parse_dates=['hour']
            #low_memory=False
            )
    test = pd.read_csv(filepath_or_buffer=test_file,
            sep=",",
            #usecols=['hour', 'banner_pos', 'C18'],
            dtype={
                   'banner_pos':pd.Categorical,
                   'hour':np.str,
                   'C18':pd.Categorical},
            #converters={'hour':make_date},
            #parse_dates=['hour']
            )
    #peak_data(train)  # basically print everything about data

    print "Training"
    peak_data(train)

    print "Test"
    peak_data(test)
    ### Plot Correlation Matrix
    #print "Printing Correlation Matrix..."
    #plt_corr_matrix(train, ['banner_pos', 'C18'])

    train['time_day'] = train['hour'].str[4:6]  # Days: 22-31
    train['time_hour'] = train['hour'].str[6:8]  # Hours: 00-23

    print train['time_day'].value_counts()
    print train['time_hour'].value_counts()

    print train.describe()

    ### Defining Training Model
    print "Training Model"
    X_data = train[['time_day', 'time_hour', 'banner_pos', 'C1',
                    'site_category', 'app_domain', 'app_category',
                    'device_type', 'device_conn_type', 'C15', 'C16', 'C18']]
    y_data = train['click'].values
    print X_data
    print y_data
    print type(X_data)
    print type(y_data)

    ### PREPROCESSING DATA
    print "Preprocessing Data with OneHotEncoder()"
    enc = OneHotEncoder()
    X_data = enc.fit_transform(train[['time_day', 'time_hour', 'banner_pos', 'C1',
                    'site_category', 'app_domain', 'app_category',
                    'device_type', 'device_conn_type', 'C15', 'C16', 'C18']])
    print "X_data is: "
    print X_data

    #print "Preprocessing Data with LabelEncoder()"
    #enc = LabelEncoder()
    #label_encoder = enc.fit(X_data)
    #X_data = label_encoder.transform(X_data)
    #X_data.banner_pos = enc.fit_transform(train[['banner_pos']])
    #X_data.C18 = enc.fit_transform(train[['C18']])

    #Y_data.banner_pos = enc.fit_transform(test[['banner_pos']])
    #Y_data.C18 = enc.fit_transform(test[['C18']])

    ### Create Train, Test Data
    print "Creating Train and Test Data"
    X_train, X_test, y_train, y_test = train_test_split(X_data, y_data, test_size=.4, random_state=1234)
    print "X train shape is: ", X_train.shape, "  ", "X test shape is: ", X_test.shape
    print "y train shape is: ", y_train.shape, "  ", "y test shape is: ", y_test.shape

    print "Showing Training Data"
    print X_train
    print y_train

    #print "Showing Test Data"
    #print X_test
    #print y_test

    ### Preprocess Data with One Hot Encoding and Standardization
    #print "Preprocessing with One-Hot-Encoder"
    #enc = OneHotEncoder()
    #enc.fit(X_train)
    #print enc.n_values_
    #print enc.feature_indices_

    print "Checking data after encoder transform"
    print X_train
    print y_train
    #           click  banner_pos  C18
    #0             0           0    0  # X_train
    #4577461                   0    2  # Y_train (doesn't have click col)
    print type(X_train)  #<class 'scipy.sparse.csr.csr_matrix'>
    print type(y_train)  #<type 'numpy.ndarray'>


    # Preprocess by Standardizing (data centered around 0 with a
    #    standard deviation of 1); this allows to compare different units (
    #    e.g. hours to miles), SGD is sensitive to feature scaling so its
    #    recommended to scale your data
    #scaler = StandardScaler()
    #scaler.fit(X_train)
    #X_train = scaler.transform(X_train)
    #X_test = scaler.transform(X_test)

    #print "Checking Train and Test Data after Scaler"
    #print X_train
    #print X_test

    ### Creating Model
    print "Fitting Model..."

    ### SGD is:
    print "SGD Classifier"
    clf = SGDClassifier(loss='log', penalty='l2', n_iter=10,
            random_state=1234, shuffle=True,
            n_jobs=4)
    clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    print "The score is: ", clf.score(X_test, y_test)  #SCORE  0.830162741604
    print "The coef is: ", clf.coef_
    print "The intercept is: ", clf.intercept_

    ### Logistic Regression is: 0.830156310571
    print "Logistic Regression"
    clf = LogisticRegression()
    clf.fit(X_train, y_train)  # Fit/Train the model
    y_pred = clf.predict(X_test)
    print "The score is: ", clf.score(X_test, y_test)


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

    print "Cross validating ROC score:", np.mean(
    #cross_val_score(clf, X_test, y_test, scoring='roc_auc', cv=10))
    cross_val_score(clf, X_test, y_test, scoring='accuracy', cv=10))


    Hour
    0   845178
    1   984784
    2   1222672
    3   1399001
    4   1913348
    5   1982179
    6   1762743
    7   1857712
    8   2096264
    9   2276401
    10  2149763
    11  2052023
    12  2216583
    13  2388730
    14  2203519
    15  2081422
    16  2050425
    17  2029527
    18  1758382
    19  1318225
    20  1120647
    21  992963
    22  907705
    23  818771

    Day
    Monday      21    4122995
    Tuesday     22    5337126
    Wednesday   23    3870752
    Thursday    24    3335302
    Friday      25    3363122
    Saturday    26    3835892
    Sunday      27    3225010
    Monday      28    5287222
    Tuesday     29    3832608
    Wednesday   30    4218938

"""
