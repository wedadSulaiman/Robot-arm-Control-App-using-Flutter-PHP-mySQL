## Project Title  
Robot Arm Control App using Flutter, PHP, and MySQL

## Description  
This project is a mobile application built with Flutter that allows users to control a robotic arm by adjusting four motor angles. Users can save these motor positions (called poses) to a MySQL database using PHP scripts running on a local server (XAMPP). The app can display the saved poses and execute the latest one.

## Features  
- Four motor sliders to adjust motor angles  
- Save pose to database  
- View all saved poses  
- Run the latest pose  
- Reset all sliders to default values  

## Requirements  
- Flutter SDK  
- Android Studio or Visual Studio Code  
- XAMPP (Apache and MySQL)  
- MySQL database  
- PHP files (save_pose.php, get_poses.php, run_pose.php)  

## How to Run  

1. **Set up XAMPP**  
   - Start Apache and MySQL from the XAMPP control panel  
   - Create a folder named my_project inside the htdocs directory  
   - Place your PHP files (save_pose.php, get_poses.php, etc.) inside that folder  

2. **Create the MySQL Database**  
   - Open phpMyAdmin  
   - Create a new database named robot_arm_db  
   - Create a table named poses with the following columns:  
     - id (INT, AUTO_INCREMENT, PRIMARY KEY)  
     - motor1 (INT)  
     - motor2 (INT)  
     - motor3 (INT)  
     - motor4 (INT)  

3. **Edit Flutter App Settings**  
   - Set the server URL in the app to one of the following based on your device:  
     - For Android emulator: http://10.0.2.2/my_project  
     - For physical device: http://your_local_ip/my_project  

4. **Run the Flutter App**  
   - Navigate to the Flutter project root folder  
   - Run the command: flutter run  

## Notes  
- Pressing the Save Pose button sends motor data to the PHP server to be stored in the database  
- Saved poses are loaded when the app starts and displayed at the bottom of the screen  
- Reset button resets all slider values but does not delete saved poses from the database  
- Make sure your device and your server (computer running XAMPP) are on the same Wi-Fi network  
- If no data is saved or retrieved, try accessing the PHP file directly from the browser to test

**when we press save pose:**
  <img width="2227" height="1331" alt="Screenshot 2025-08-01 231610" src="https://github.com/user-attachments/assets/f5908484-2e4c-4f87-91a8-f9b878e91207" />
  <img width="2237" height="1307" alt="Screenshot 2025-08-01 231626" src="https://github.com/user-attachments/assets/f679e6c9-fab1-495b-887b-993bab656f78" />

**when we press reset:**
<img width="2235" height="1335" alt="Screenshot 2025-08-01 231648" src="https://github.com/user-attachments/assets/3e0d8459-2a68-470b-87bc-347f1ee27bfa" />

**poses table**
<img width="882" height="335" alt="Screenshot 2025-08-01 231718" src="https://github.com/user-attachments/assets/b671f528-eef6-4ee7-9355-51a213f68cd2" />





## Screenshots  
Include screenshots of the mobile app interface and the MySQL database in phpMyAdmin showing saved poses
