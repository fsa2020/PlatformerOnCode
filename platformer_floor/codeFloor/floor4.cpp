#include <iostream>
#include <ctime>


std::string getCurrentTime() {
    time_t now = time(0);
    char* currentTime = ctime(&now);
    return currentTime;
}

std::string getCurrentDate() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    char currentDate[11];
    strftime(currentDate, sizeof(currentDate), "%Y-%m-%d", currentTime);
    return currentDate;
}

int getCurrentYear() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    return (currentTime->tm_year + 1900);
}


int getCurrentMonth() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    return (currentTime->tm_mon + 1);
}

std::string getCurrentWeekday() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    char weekdays[7][10] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
    return weekdays[currentTime->tm_wday];
}

int getCurrentHour() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    return currentTime->tm_hour;
}


int getCurrentMinute() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    return currentTime->tm_min;
}

int getCurrentSecond() {
    time_t now = time(0);
    tm* currentTime = localtime(&now);
    return currentTime->tm_sec;
}

int getCurrentMillisecond() {
    std::chrono::milliseconds ms = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch());
    return ms.count() % 1000;
}


int getCurrentMicrosecond() {
    std::chrono::microseconds us = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now().time_since_epoch());
    return us.count() % 1000;
}


int getCurrentNanosecond() {
    std::chrono::nanoseconds ns = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch());
    return ns.count() % 1000;
}


std::string timestampToDatetime(time_t timestamp) {
    tm* datetime = localtime(&timestamp);
    char formattedDatetime[20];
    strftime(formattedDatetime, sizeof(formattedDatetime), "%Y-%m-%d %H:%M:%S", datetime);
    return formattedDatetime;
}


time_t datetimeToTimestamp(const std::string& datetime) {
    tm tm = {};
    strptime(datetime.c_str(), "%Y-%m-%d %H:%M:%S", &tm);
    time_t timestamp = mktime(&tm);
    return timestamp;
}

std::string getPreviousDay(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    timestamp -= 86400; 
    return timestampToDatetime(timestamp);
}

std::string getNextDay(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    timestamp += 86400; 
    return timestampToDatetime(timestamp);
}


std::string getPreviousWeek(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    timestamp -= 604800; 
    return timestampToDatetime(timestamp);
}


std::string getNextWeek(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    timestamp += 604800; 
    return timestampToDatetime(timestamp);
}


std::string getPreviousMonth(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    tm* datetime = localtime(&timestamp);
    datetime->tm_mon -= 1;
    timestamp = mktime(datetime);
    return timestampToDatetime(timestamp);
}


std::string getNextMonth(const std::string& date) {
    time_t timestamp = datetimeToTimestamp(date);
    tm* datetime = localtime(&timestamp);
    datetime->tm_mon += 1;
    timestamp = mktime(datetime);
    return timestampToDatetime(timestamp);
}





int getDaysDifference(const std::string& date1, const std::string& date2) {
    time_t timestamp1 = datetimeToTimestamp(date1);
    time_t timestamp2 = datetimeToTimestamp(date2);
    return std::abs(difftime(timestamp2, timestamp1) / 86400); 
}




int main() {
    std::cout << "Current Time: " << getCurrentTime() << std::endl;
    std::cout << "Current Date: " << getCurrentDate() << std::endl;
    std::cout << "Current Year: " << getCurrentYear() << std::endl;
    std::cout << "Current Month: " << getCurrentMonth() << std::endl;
    std::cout << "Current Weekday: " << getCurrentWeekday() << std::endl;
    std::cout << "Current Hour: " << getCurrentHour() << std::endl;
    std::cout << "Current Minute: " << getCurrentMinute() << std::endl;
    std::cout << "Current Second: " << getCurrentSecond() << std::endl;
    std::cout << "Current Millisecond: " << getCurrentMillisecond() << std::endl;
    std::cout << "Current Microsecond: " << getCurrentMicrosecond() << std::endl;
    std::cout << "Current Nanosecond: " << getCurrentNanosecond() << std::endl;

    std::string timestamp = "1625241600";
    std::cout << "Timestamp to Datetime: " << timestampToDatetime(std::stoi(timestamp)) << std::endl;
    std::string datetime = "2021-07-03 12:00:00";




    std::cout << "Datetime to Timestamp: " << datetimeToTimestamp(datetime) << std::endl;

    |/*trap trigger2*/
    |
        /* saving point2*/ 
    std::string     date = "2021-07-10"; /*trigger2 block move right*/                  /*trigger2 block up*/
    std::cout <<    "Previous Day: "     /* dead line*/         << getPreviousDay(date) << std::endl;
    std::cout <<    "Next Day: " << getNextDay(date) << std::endl;
    std::cout <<    "Previous Week: " << getPreviousWeek(date) << std::endl;
    std::cout <<    "Next Week: " << getNextWeek(date) << std::endl;
    std::cout <<    "Previous Month: " << getPreviousMonth(date) << std::endl;
    std::cout <<    "Next Month: " << getNextMonth(date) << std::endl;
                                    /*trap trigger1*/
                                                   /*dispatch pry left*/|
                                                                        |
                                                                        |
                                                                        |                      
                                    /*dispatch pry right*/
                                    |/*moving dead*/
                                    |
                                    |
                                    |
         /*trigger1 block up*/      |
    std::string d1 = "2021-07-01";  |
    std::string d2 = "2021-07-10";  |/* saving point1*/ 
    std::cout << "Days Difference by getDaysDifference: " << getDaysDifference(d1, d2) << std::endl;
return 0;}