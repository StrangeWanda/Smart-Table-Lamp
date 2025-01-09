import pandas as pd

# Load the dataset
data = pd.read_csv('data.csv')

# Calculate the average lux for each entry (target variable)
data['Lux'] = data[['Lux_Min', 'Lux_Max']].mean(axis=1)

# Drop columns no longer needed
data = data.drop(['Lux_Min', 'Lux_Max'], axis=1)
# One-hot encode Visual_Acuity and Room_Type
data = pd.get_dummies(data, columns=['Visual_Acuity', 'Room_Type'], drop_first=True,dtype=float)

# See the Thingy
print("Sample data:")
print(data.head())
data.to_csv("ModData.csv")

'''
data = pd.read_csv('ModData.csv')

# Mean Data Value...
MDV = data.mean()
print(MDV)
# Data Standard Deviation
DSD = data.std()
data = (data-MDV)/DSD
from sklearn.model_selection import train_test_split

# Define the features (X) and target (y)
X = data.drop('Lux', axis=1)
y = data['Lux']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
from sklearn.ensemble import RandomForestRegressor

# Initialize the model
model = RandomForestRegressor(n_estimators=100, random_state=42)

# Train the model
model.fit(X_train, y_train)
#######################################################
from sklearn.metrics import mean_squared_error, r2_score

# Make predictions on the test set
y_pred = model.predict(X_test)

# Evaluate
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print("Mean Squared Error:", mse)
print("R^2 Score:", r2)
'''