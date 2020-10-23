using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian as Gre;
using Toybox.Time;


class WolfPackView extends WatchUi.WatchFace {
    var wolfshead_white;
    var wolfshead_green;
    var wolfshead_orange;    
    var wolfshead_red;        
    var cx;
    var cy;
    const MAX_NUM_REMINDERS=4;
    const HOURS_BEFORE_REMINDER=2;    
    var reminderArray=[];

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	// set centervars
    	cx=dc.getWidth()/2;
    	cy=dc.getHeight()/2;
        
    	// load logo
        wolfshead_green = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wolfshead_green,
            :locX=>cx-36,
            :locY=>cy-90
        });
        wolfshead_white = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wolfshead_white,
            :locX=>cx-36,
            :locY=>cy-90
        });
        wolfshead_orange = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wolfshead_orange,
            :locX=>cx-36,
            :locY=>cy-90
        });
        wolfshead_red = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wolfshead_red,
            :locX=>cx-36,
            :locY=>cy-90            
        });
        
        // TODO: Factor into setting property
        setupReminders();                              
    }
    
    function setupReminders(){
        for(var i=1; i<=MAX_NUM_REMINDERS; i++){
        	var dayTime=Application.getApp().getProperty("Session" + i + "DayTime");

        	if(dayTime.length()>0){
        		var day=dayTime.substring(0, dayTime.find(";"));
        		var hour=dayTime.substring(dayTime.find(";")+1, dayTime.length()).toNumber();
        		var message = Application.getApp().getProperty("Session" + i + "Message");
        		var colour = Graphics.COLOR_PINK; 
        		reminderArray.add(new Reminder(day, hour, message, colour, HOURS_BEFORE_REMINDER));
        	}
        }
       
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // clear the screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // pick the wolf color based on the battery
        var battery=System.getSystemStats().battery;        
        if ( battery >= 90 ) {
           wolfshead_green.draw(dc);
		} else if ( battery >= 50 ) {
           wolfshead_white.draw(dc);
		} else if ( battery >= 30 ) {
           wolfshead_orange.draw(dc);		
		} else {
           wolfshead_red.draw(dc);		
		}
        
        // draw time
        var xPad=0;
        var yPad=15;        

        var clockTime = System.getClockTime();
        var hourString = clockTime.hour.format("%02d");
        var minString = clockTime.min.format("%02d");
               
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx/2-xPad, cy+yPad, Graphics.FONT_NUMBER_THAI_HOT, hourString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(cx + cx/2+xPad, cy+yPad, Graphics.FONT_NUMBER_THAI_HOT, minString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);         
        
        // draw date
        var moment = Time.now();

        var date = Gre.info(moment, Time.FORMAT_MEDIUM);
        var dateStr = Lang.format("$1$ $2$", [date.day_of_week, date.day]);

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);        
        dc.drawText(cx, dc.getHeight()-Graphics.getFontHeight(Graphics.FONT_SYSTEM_MEDIUM)*1.6, Graphics.FONT_SYSTEM_MEDIUM, dateStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        // draw message on training days
        for(var i=0; i< reminderArray.size(); i++){
           var rem = reminderArray[i];
           if(rem.isFiring(date)){
		     dc.setColor(rem.colour, Graphics.COLOR_TRANSPARENT);
			 dc.drawText(cx, dc.getHeight()-Graphics.getFontHeight(Graphics.FONT_SYSTEM_TINY)*0.8, Graphics.FONT_SYSTEM_TINY, rem.message, Graphics.TEXT_JUSTIFY_CENTER);             
           }
        }
        
//        for(var i=1; i<=4; i++){
//        	var dayTime=Application.getApp().getProperty("Session" + i + "DayTime");
//
//        	if(dayTime.length()>0){
//        		var day=dayTime.substring(0, dayTime.find(";"));
//        		var hour=dayTime.substring(dayTime.find(";")+1, dayTime.length()).toNumber();
//        		var message = Application.getApp().getProperty("Session" + i + "Message");
//        		if(date.day_of_week.equals(day) && date.hour >= hour-hoursBeforeReminder && date.hour<hour+2) {  		
//        		     dc.setColor(Graphics.COLOR_PINK, Graphics.COLOR_TRANSPARENT);
//        			 dc.drawText(cx, dc.getHeight()-Graphics.getFontHeight(Graphics.FONT_SYSTEM_TINY)*0.8, Graphics.FONT_SYSTEM_TINY, message, Graphics.TEXT_JUSTIFY_CENTER);	     
//        		}        		        		     		        		
//        	}
//        }
        
        // draw connectivity icon
        if (isConnected()) {
            drawIcon(dc, cx, cy+yPad, Graphics.COLOR_GREEN);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
	function drawIcon(dc, x, y, color){
		var size = 5;
		var width = 1 ;

		dc.setPenWidth(2);
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);

        // from https://github.com/ravenfeld/Connect-IQ-WatchFace.git
        // TODO: use a bitmap (!?)
    	dc.fillPolygon([[x-size,y-size], [x-size+width,y-size-width],[x+size+width,y+size-width],[x+size,y+size]]);
		dc.fillPolygon([[x+size,y+size],[x+size-width,y+size-width],[x-width+1,y+size*2-width],[x,y+size*2]]);
		dc.fillPolygon([[x+2,y+size*2-2],[x+2-width-1,y+size*2+width-2],[x+2-width-1,y-size*2-width+2],[x+2,y-size*2+2]]);
		dc.fillPolygon([[x,y-size*2],[x-width+1,y-size*2+width],[x+size-width,y-size+width],[x+size,y-size]]);
		dc.fillPolygon([[x+size,y-size],[x+size+width,y-size+width],[x-size+width,y+size+width],[x-size,y+size]]);
	}
    
    function isConnected() {
        return System.getDeviceSettings().phoneConnected;
    }    

}
