/**
/ Reminders mainly for sessions
*/
class Reminder {
  var day;
  var hour;
  var message;
  var colour;
  var hoursBeforeReminder;
  
  public function initialize( day, hour, message, colour, hoursBeforeReminder) {
	me.day = day;
	me.hour = hour;
	me.message = message;
	me.colour = colour;
	me.hoursBeforeReminder=hoursBeforeReminder;
  }
    
  public function isFiring(date) {
    return(date.day_of_week.equals(self.day) && date.hour >= self.hour-self.hoursBeforeReminder && date.hour<self.hour);   			     
  }
}