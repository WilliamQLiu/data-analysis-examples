import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale, OneHotEncoder, LabelEncoder
from sklearn.cluster import KMeans
from sklearn.feature_extraction import DictVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import metrics  # For stats like
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import SGDClassifier, LogisticRegression, LinearRegression
from sklearn.cross_validation import cross_val_score, train_test_split, KFold
from sklearn.naive_bayes import GaussianNB
import statsmodels.api as sm


def plt_corr_matrix(dataset, col_names):
    # Plot out correlation
    corr_matrix = np.corrcoef(dataset.T)

    #plt.tight_layout()

    sm.graphics.plot_corr(corr_matrix, xnames=col_names)
    #axes.get_xaxis().set_visible(False)
    plt.show()


if __name__ == "__main__":

    ### Get Path to files
    print "Getting path to files..."
    train_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/train.csv'
    small_train_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/small_train.csv'
    test_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/test.csv'
    submission_file = r'/Users/williamliu/Desktop/Kaggle_Avazu/submission_scikitlearn.csv'

    # Load files to dataframes
    print "Loading files into dataframes..."
    #train_file = pd.DataFrame.from_csv(train_file)
    train = pd.DataFrame.from_csv(path=train_file,
            sep=",", parse_dates=True, infer_datetime_format=True)
    test = pd.DataFrame.from_csv(test_file)

    # Look at data
    #print "Looking at data before conversion..."
    #print train.info()
    #print train.head()
    #print train.describe()

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

    # Transform
    print "Convert Text into vectors of numerical values so we can do statistical analysis"
    data = train[["click", "banner_pos",
            "C18"]]
    #print data.info()
    dv = DictVectorizer()
    cat_matrix = dv.fit_transform(data.T.to_dict().values())
    cat_matrix = scale(cat_matrix.todense())
    col_names = dv.get_feature_names()
    #print col_names

    ### Plot Correlation Matrix
    print "Printing Correlation Matrix..."
    plt_corr_matrix(cat_matrix, col_names)

    ### Create Train, Test Data
    X_train, X_test, y_train, y_test = train_test_split(data[['banner_pos', 'C18']], data['click'], test_size=.4, random_state=0)

    ### Create model
    print "Creating model"
    clf = LogisticRegression()
    clf.fit(X_train, y_train)  # Train the model

    ## Print the score
    print "The score is: ", clf.score(X_test, y_test)
    #print "Cross Validing: ", np.mean(cross_val_score(clf, X_test, y_test, scoring='roc_auc', cv=3))

