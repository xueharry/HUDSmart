# HUDSmart

Chris Chen, Eshaan Patheria, Harry Xue
CS50 Final Project: HUDSmart (iPhone app)


Nutrition tracking app for Harvard University Dining Services (HUDS) built with the bodybuilder/athlete in mind. CS50 Final Project.

Summary of features:
	HUDSmart allows a user to access the daily Harvard University Dining Services menus and view nutrition facts for each item. The user can input their meals throughout the course of an entire day and HUDSmart will generate a macronutrient report (listing of total grams protein, carbohydrates, fat, calories). The app also allows for customization through the input of individual macronutrient goals and tracking of how those needs are met percent-wise throughout the day.
	HUDSmart improves upon existing technology in that it brings meal tracking to the mobile platform, has individual customization and allows for tracking over the course of entire day, whereas the HUDS website itself only allows tracking for a single meal. In addition, HUDSmart emphasizes macronutrient totals, which may be of particular interest to the bodybuilder or fitness enthusiast.


Requirements:
Mac computer
Xcode 6.1.1 (Latest version of Xcode needed as previous versions may result in compiling errors)


Use:
Unzip HUDSmart.zip
Open the HUDSmart folder -> HUDSmart.xcodeproject file
In Xcode, navigate to the top left corner. To the right of the pause button click on HUDSmart and select the iPhone 6 (The layout is optimized for iPhone 6) option under iOS Simulator. Click the triangle button on the top left to start the Simulator.


Configuring iOS Simulator: In the toolbar, click Hardware->Keyboard and make sure only “iOS uses same Layout as OS X” is selected. (“Connect Hardware Keyboard” should NOT be selected!)


	Upon loading, the first screen in the app should have a Macronutrient Report (which is initially empty). The tab bar on the bottom contains 3 items. Clicking on menu brings up the HUDS menu for the current day in table form. Selecting breakfast, lunch or dinner on the top toggles between those respective menus. (Though sometimes a menu may be empty due to the HUDS website only displaying 2 meals for the day. This is a CS50 Food API issue, acknowledged by the staff.) Scroll through the menu to view more items. Select an item to view detailed nutrition facts and scroll down to view all nutrition facts. Click the stepper next to the item name on the nutrition facts page to update item quantity. Navigate over to the Home page to view an updated macro report reflecting the added item(s). 
	The My Macros page allows for the input of individual macronutrient settings. Click on the input fields and use the keypad that pops up to enter your macronutrient settings. Click save and the Macronutrient Report should now calculate percentages based on your settings. Click reset to erase those macro settings.
Lastly, our implementation allows for persistence even after app shutdown. Quit the iOS simulator and reload for a demonstration. To clear the macronutrient report from memory, click on Reset on the Home page.
