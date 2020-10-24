/**
/ Reminders mainly for sessions
*/
class Reminder {
  var day;
  var hour;
  var message;
  var hoursBeforeReminder;
  
  public function initialize( day, hour, message, hoursBeforeReminder) {
	me.day = day;
	me.hour = hour;
	me.message = message;
	me.hoursBeforeReminder=hoursBeforeReminder;
  }
    
  public function isFiring(date) {
    return(date.day_of_week.equals(self.day) && date.hour >= self.hour-self.hoursBeforeReminder && date.hour<self.hour);   			     
  }
}