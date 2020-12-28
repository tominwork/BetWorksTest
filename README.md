BetWorksTest documentation
======================
# Steps to simulate the App

1. Open the project in XCode and Run the application.

2. Enter values for Username and Password in the Login screen shown.
    a. Make sure that the credentials contain at least a letter and a number.
    b. You will see an alert if the above criteria is not satisfied.
    
3. Tap the Login button to go to the Welcome screen showing the Username.

4. You can close the Welcome page by tapping the Close button.

-------------------------------------------------------------------

# Design Decisions Made

1.  Implementation is done using Swift 5.0+ with UIKit (MVVM).

2. Used a mock network layer and mock struct for network calls.

3. Used protocols and extensions for mocking purpose.

4. The Username received after a sucessful login is stored in a Singleton class.

5. Included both XCUI-Test and Unit tests. 

