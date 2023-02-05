from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import StandardScaler
from sklearn import metrics
# import numpy as np

# reading csv of state behavior in for analysis
data = pd.read_csv("C:/Users/sriva/Downloads/foraging.csv")

# separating feature values from labels, displaying them
x = data.iloc[:, [2, 3, 4, 5]].values
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
                        index=['Total food eaten',
                               'Total distance travel',
                               'time spend in food zone',
                               'Frequency to zone']).sort_values(ascending=False)

print(feature_imp)

"""
Accuracy: 0.5294117647058824

Feature importance:
time spend in food zone    0.358278
Total food eaten           0.224019
Frequency to zone          0.219292
Total distance travel      0.198411
"""
