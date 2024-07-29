import 'dart:core';
import 'dart:developer';
import 'package:intl/intl.dart';







String getTimeDurationString({required String startTime, required String stopTime}) {
  DateFormat dateFormat = DateFormat.jm(); // Format for parsing times like '10:30 AM'

  // Parse the start and stop times
  DateTime startDateTime = dateFormat.parse(startTime).toLocal();
  DateTime stopDateTime = dateFormat.parse(stopTime).toLocal();

  // Check if stopTime is earlier than startTime, adjust the stopDateTime to the next day
  if (stopDateTime.isBefore(startDateTime)) {
    stopDateTime = stopDateTime.add(Duration(days: 1));
  }

  // Calculate the difference
  Duration duration = stopDateTime.difference(startDateTime);

  // Get hours and minutes
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;

  // Build the formatted string
  String hoursString;
  if (hours == 1) {
    hoursString = '1 hour';
  } else if (hours > 1) {
    hoursString = '$hours hours';
  } else {
    hoursString = '';
  }

  String minutesString;
  if (minutes == 1) {
    minutesString = '1 minute';
  } else if (minutes > 1) {
    minutesString = '$minutes minutes';
  } else {
    minutesString = '';
  }

  if (hoursString.isNotEmpty && minutesString.isNotEmpty) {
    log("$hoursString and $minutesString");
    return '$hoursString and $minutesString';
  } else if (hoursString.isNotEmpty) {
    log(hoursString);
    return hoursString;
  } else {
    log(minutesString);
    return minutesString;
  }
}








String formatDate(DateTime date) {
  // Create a DateFormat instance with the desired format
  final DateFormat formatter = DateFormat('d MMMM, yyyy');
  // Use the formatter to format the DateTime object
  return formatter.format(date);
}


DateTime parseDateTime({required String dateString, required String timeString}) {
  // Parse date string
  DateTime date = DateFormat("yyyy-MM-dd").parse(dateString);

  // Parse time string
  DateFormat timeFormat = DateFormat("h:mm a");
  DateTime time = timeFormat.parse(timeString);

  // Combine date and time
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

DateTime convertNodeJSServerTimestampToDateObject({
  required String serverTimestampStr
  }) {
  try {
    DateTime dateTime = DateTime.parse(serverTimestampStr).toLocal();
    return dateTime;
  } 
  catch (e) {
    throw Exception("error: $e");
  }
}



//converts a date string of time "2022:03:21:TZ" to 'January 13, 2023'
String transformDateString(String dateString) {
  // Parse the original date string to a DateTime object
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  
  // Define the desired output format
  DateFormat outputFormat = DateFormat.yMMMMd();
  
  // Format the DateTime object to the desired output format
  String formattedDate = outputFormat.format(dateTime);
  
  return formattedDate;
}



// Function 1: Convert string to DateTime
DateTime convertStringToDateTime(String dateString) {
  try {
    // Assuming the input string is in the format yyyy-mm-dd
    List<String> dateParts = dateString.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    
    return DateTime(year, month, day);
  } catch (e) {
    // Handle parsing errors, e.g., invalid format
    print('Error converting string to DateTime: $e');
    throw Exception("$e");
  }
}

// Function 2: Display today's date as a DateTime object
DateTime getTodayDateTime() {
  return DateTime.now().toLocal();
}

// Function 3: Check how close a DateTime is to today's date
String checkDateProximity(DateTime otherDate) {
  DateTime today = getTodayDateTime();
  Duration difference = today.difference(otherDate).abs();
  
  if (difference.inDays == 0) {
    return 'The date is today!';
  } else {
    String proximity = (today.isBefore(otherDate)) ? 'future' : 'past';
    String unit = (difference.inDays == 1) ? 'day' : 'days';
    
    return 'The date is ${difference.inDays} $unit in the $proximity.';
  }
}

// Function 4: Check how far a DateTime is from today's date
String checkDateDistance(DateTime otherDate) {
  DateTime today = getTodayDateTime();
  Duration difference = today.difference(otherDate).abs();
  
  if (difference.inDays == 0) {
    return 'The date is today!';
  } else {
    String proximity = (today.isBefore(otherDate)) ? 'future' : 'past';
    String unit = (difference.inDays == 1) ? 'day' : 'days';
    
    return 'The date is ${difference.inDays} $unit ${proximity == 'future' ? 'ahead of' : 'ago from'} today.';
  }
}

// Function to check if a date is in the past
bool isDateInPast(DateTime date) {
  DateTime today = getTodayDateTime();
  return date.isBefore(today);
}

// Function to check if a date is in the future
bool isDateInFuture(DateTime date) {
  DateTime today = getTodayDateTime();
  return date.isAfter(today);
}

String convertUTCTimestampToDate(int timestamp) {
  // Convert timestamp to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true).toLocal();

  // Define month names
  List<String> months = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"
  ];

  // Extract components
  int year = dateTime.year;
  String month = months[dateTime.month - 1]; // Month index starts from 1
  int day = dateTime.day;

  // Construct date string
  String dateString = "$month $day, $year";

  return dateString;
}

String convertServerTimeToDate(int timestamp) {
  // Convert timestamp to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toLocal();

  // Define month names
  List<String> months = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"
  ];

  // Extract components
  int year = dateTime.year;
  String month = months[dateTime.month - 1]; // Month index starts from 1
  int day = dateTime.day;

  // Construct date string
  String dateString = "$month $day, $year";

  return dateString;
}

//use well
String convertDateStringToDate(String dateString) {
  // Parse the date string
  List<String> dateComponents = dateString.split('-');
  int year = int.parse(dateComponents[0]);
  int month = int.parse(dateComponents[1]);
  int day = int.parse(dateComponents[2]);

  // Convert to DateTime
  DateTime dateTime = DateTime(year, month, day);

  // Define month names
  List<String> months = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"
  ];

  // Extract components
  String monthName = months[dateTime.month - 1]; // Month index starts from 1

  // Construct date string
  String formattedDate = "$monthName ${dateTime.day}, ${dateTime.year}";

  return formattedDate;
}

String convertStringServerTimeToDate(String timestamp){

  // Convert the timestamp to a DateTime object
  DateTime dateTime = DateTime.parse(timestamp);

  // Use the toString method
  String formattedDate = dateTime.toString();
  //String finalResult = formattedDate.substring(0, 10);

  print(formattedDate); // Output: 2023-01-27 20:48:47.960
  return formattedDate;
}


DateTime convertStringToDateTimeTimeAgo(String timestamp){

  // Convert the timestamp to a DateTime object
  DateTime dateTime = DateTime.parse(timestamp).toLocal();

  print("$dateTime"); // Output: 2023-01-27 20:48:47.960
  return dateTime;
}


/*String convertServerTimeToDate(int timestamp) {
  // Convert the timestamp to a DateTime object
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // Use the toString method
  String formattedDate = dateTime.toString();
  String finalResult = formattedDate.substring(0, 10);

  print(finalResult); // Output: 2023-01-27 20:48:47.960
  return finalResult;
}*/


String convertServerTimeToTime(int timestamp) {
  // Convert the timestamp to a DateTime object
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();

  // Use the intl package to format the time
  String formattedTime = DateFormat('HH:mm a').format(dateTime);

  print(formattedTime); // Output: 20:48:47
  return formattedTime;
}