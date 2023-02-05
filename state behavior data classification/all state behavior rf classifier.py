from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import StandardScaler
from sklearn import metrics
# import numpy as np

# reading csv of state behavior in for analysis
data = pd.read_csv("C:/Users/sriva/Downloads/all state behavior.csv")

# separating feature values from labels, displaying them
x = data.iloc[:, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]].values
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
latency to run             0.136387
Time on wheel              0.110417
Frequency to light zone    0.091203
1hr food consumed          0.085330
1hr food consumed          0.085076
Latency to lick            0.080952
Number of USVs             0.066780
Von frey                   0.053942
Time to flick              0.050988
Total distance travel      0.047832
time spend in food zone    0.038627
Frequency to zone          0.037343
Total distance travel      0.031416
Frequency                  0.029338
Total food eaten           0.022422
Velocity                   0.019741
Time in light              0.012206
"""
