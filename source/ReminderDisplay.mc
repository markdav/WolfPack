using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class ReminderDisplay {
    const MAX_NUM_REMINDERS=4;
    const HOURS_BEFORE_REMINDER=2;    
    var reminderArray=[];   

	public function initialize(){
	 setupReminders();
	}
	
    function setupReminders(){
        for(var i=1; i<=MAX_NUM_REMINDERS; i++){
        	var dayTime=Application.getApp().getProperty("Session" + i + "DayTime");

        	if(dayTime.length()>0){
        		var day=dayTime.substring(0, dayTime.find(";"));
        		var hour=dayTime.substring(dayTime.find(";")+1, dayTime.length()).toNumber();
        		var message = Application.getApp().getProperty("Session" + i + "Message");
        		me.reminderArray.add(new Reminder(day, hour, message, HOURS_BEFORE_REMINDER));
        	}
        }       
    }
    
	function drawReminder(dc, date, x, y, font, color){
        for(var i=0; i< reminderArray.size(); i++){
           var rem = reminderArray[i];
           if(rem.isFiring(date)){
		     dc.setColor(color, Graphics.COLOR_TRANSPARENT);
			 dc.drawText(x, y, font, rem.message, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);             
           }
        }	
	}    	
}