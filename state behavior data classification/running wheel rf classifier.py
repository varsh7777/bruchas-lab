from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import StandardScaler
from sklearn import metrics
# import numpy as np

# reading csv of state behavior in for analysis
data = pd.read_csv("running wheel.csv")

# separating feature values from labels, displaying them
x = data.iloc[:, [2, 3, 4]].values
print(x)
y = data.iloc[:, 1].values
print(y)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.5,
                                                    random_state=0)

classifier = RandomForestClassifier(n_estimators=200)

classifier.fit(x_train, y_train)

y_pred = classifier.predict(x_test)

# accuracy of classifier
print("Accuracy:", metrics.accuracy_score(y_test, y_pred))

# importance of each feature
feature_imp = pd.Series(classifier.feature_importances_,
                        index=['Time on wheel', 'latency to run',
                               'Frequency']).sort_values(ascending=False)

print(feature_imp)

"""
Accuracy: 0.4117647058823529

Feature importance:
Time on wheel     0.391670
latency to run    0.311077
Frequency         0.297252
"""
