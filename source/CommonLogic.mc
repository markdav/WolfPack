using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian as Gre;
using Toybox.Time;


class CommonLogic {

	var wolf;        
    var cx;
    var cy;
    var reminderDisplay;
    
    function initialize() {

    }

    // load resources 
    function onLayout(dc) {
    	// set centervars
    	me.cx=dc.getWidth()/2;
    	me.cy=dc.getHeight()/2;
    	
    	me.wolf=new WolfHead(me.cx);
        me.reminderDisplay= new ReminderDisplay();                              
    }


    // Update the view
    function onUpdate(dc, timeSpacing, timeY, timeFont, wolfY, dateFont, dateY, reminderFont, reminderY) {
        // clear the screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // draw the wolfhead logo 
        me.wolf.draw(dc, wolfY);
        
        // draw connectivity icon
        if (PhoneConnected.isConnected()) {
            PhoneConnected.drawIcon(dc, me.cx, timeY, Graphics.COLOR_GREEN, 5, 1);
        }        

		// time
		TimeDisplay.drawTime(dc, me.cx, timeY, timeFont, timeSpacing);         
        
        // draw date
        var date = Gre.info(Time.now(), Time.FORMAT_MEDIUM);
		DateDisplay.drawDate(dc, date, dateFont, me.cx, dateY);
        
        // draw message on training days
        me.reminderDisplay.drawReminder(dc, date, me.cx, reminderY, reminderFont, Graphics.COLOR_WHITE);
    }

}
