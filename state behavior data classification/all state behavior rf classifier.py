from sklearn.ensemble import RandomForestClassifier
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.preprocessing import StandardScaler
from sklearn import metrics
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# reading csv of state behavior in for analysis
data = pd.read_csv("C:/Users/sriva/Downloads/all state behavior.csv")

# separating feature values from labels, displaying them
x = data.iloc[:, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]].values
print(x)
y = data.iloc[:, 1].values
print(y)

x = StandardScaler().fit_transform(x)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.5,
                                                    stratify=y)


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
                               'Total distance travel (foraging)',
                               'time spend in food zone',
                               'Frequency to zone',
                               'Total distance travel (light box)',
                               'Velocity',
                               'Time in light',
                               'Frequency to light zone',
                               'Time to flick',
                               'Von frey',
                               'Latency to lick',
                               'Number of USVs']).sort_values(ascending=False)

print(feature_imp)

matrix = confusion_matrix(y_test, y_pred)

print(matrix)

# confusion matrix visualization pulled from:
# https://medium.com/analytics-vidhya/evaluating-a-random-forest-model-9d165595ad56

matrix = matrix.astype('float') / matrix.sum(axis=1)[:, np.newaxis]

# Build the plot
plt.figure(figsize=(16, 7))
sns.set(font_scale=1.4)
sns.heatmap(matrix, annot=True, annot_kws={'size': 10},
            cmap=plt.cm.Greens, linewidths=0.2)

# Add labels to the plot
class_names = ['Control', 'Exercise', 'Isolation']
tick_marks = np.arange(len(class_names))
tick_marks2 = tick_marks + 0.5
plt.xticks(tick_marks, class_names, rotation=25)
plt.yticks(tick_marks2, class_names, rotation=0)
plt.xlabel('Predicted label')
plt.ylabel('True label')
plt.title('Confusion Matrix for Random Forest Model')
plt.show()

"""
Accuracy: 0.6470588235294118

Feature importance:
Time on wheel                        0.140167
1hr food consumed                    0.123356
Number of USVs                       0.069465
Time to flick                        0.068875
Total distance travel (foraging)     0.064132
Time in light                        0.063876
Total distance travel (light box)    0.063837
latency to run                       0.057798
Frequency                            0.056063
Frequency to light zone              0.054742
time spend in food zone              0.050904
Frequency to zone                    0.042827
Total food eaten                     0.041394
Von frey                             0.038792
Velocity                             0.034445
Latency to lick                      0.029327
"""
