using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian as Gre;
using Toybox.Time;


class WolfPackView extends WatchUi.WatchFace {

	var wolf;        
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
    	
    	wolf=new WolfHead(cx);
        
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
    
		// device specific vars - to be extracted to layout?
		
		// 235
//        var yTimePad=15; 
//        var xTimePad=15; 
//        var yWolfFromTop=0; 
//        var timeFont=Graphics.FONT_NUMBER_THAI_HOT;
//        var dateFont=Graphics.FONT_SYSTEM_MEDIUM;
//        var yDatePad=yTimePad+Graphics.getFontHeight(timeFont)/2; 
        
        // 245
        var yTimePad=5; 
        var xTimePad=15; 
        var yWolfFromTop=15; 
        var timeFont=Graphics.FONT_NUMBER_THAI_HOT;
        var dateFont=Graphics.FONT_SYSTEM_SMALL;
        var yDatePad=yTimePad+Graphics.getFontHeight(timeFont)/2;
    
        // clear the screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // draw the wolfhead logo 
        wolf.draw(dc, yWolfFromTop);
        
        // draw connectivity icon
        if (PhoneConnected.isConnected()) {
            PhoneConnected.drawIcon(dc, cx, cy+yTimePad, Graphics.COLOR_GREEN, 5, 1);
        }        

		// time
		TimeDisplay.drawTime(dc, cx, cy, timeFont, xTimePad, yTimePad);         
        
        // draw date
        var date = Gre.info(Time.now(), Time.FORMAT_MEDIUM);
		DateDisplay.drawDate(dc, date, dateFont, cx, cy+yDatePad);
        
        // draw message on training days
        for(var i=0; i< reminderArray.size(); i++){
           var rem = reminderArray[i];
           if(rem.isFiring(date)){
		     dc.setColor(rem.colour, Graphics.COLOR_TRANSPARENT);
			 dc.drawText(cx, dc.getHeight()-Graphics.getFontHeight(Graphics.FONT_SYSTEM_TINY)*0.8, Graphics.FONT_SYSTEM_TINY, rem.message, Graphics.TEXT_JUSTIFY_CENTER);             
           }
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

}
