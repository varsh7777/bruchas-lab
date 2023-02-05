from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import StandardScaler
from sklearn import metrics
# import numpy as np

# reading csv of state behavior in for analysis
data = pd.read_csv("all state behavior.csv")

# separating feature values from labels, displaying them
x = data.iloc[:, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]].values
print(x)
y = data.iloc[:, 1].values
print(y)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.5)

classifier = RandomForestClassifier(n_estimators=200)

classifier.fit(x_train, y_train)

y_pred = classifier.predict(x_test)

# accuracy of classifier
print("Accuracy:", metrics.accuracy_score(y_test, y_pred))

# importance of each feature
feature_imp = pd.Series(classifier.feature_importances_,
                        index=['Time on wheel',
                               'latency to run',
                               'Frequency',
                               '1hr food consumed',
                               'Total food eaten',
                               'Total distance travel',
                               'time spend in food zone',
                               'Frequency to zone',
                               'Total distance travel',
                               'Velocity',
                               'Time in light',
                               'Frequency to light zone',
                               'Time to flick',
                               'Von frey',
                               'Latency to lick',
                               'Number of USVs']).sort_values(ascending=False)

print(feature_imp)

"""
Accuracy: 0.6470588235294118

Feature importance:
Time on wheel              0.184683
1hr food consumed          0.118636
Latency to lick            0.109465
latency to run             0.083017
Frequency to zone          0.069827
Time to flick              0.061980
Total distance travel      0.054356
Von frey                   0.053583
Time in light              0.042146
Frequency to light zone    0.041263
Number of USVs             0.033195
time spend in food zone    0.031931
Total food eaten           0.030881
Total distance travel      0.029309
Velocity                   0.028548
Frequency                  0.027180
"""
