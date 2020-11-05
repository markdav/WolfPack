using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;


class DeviceView extends WatchUi.WatchFace {

	var commonLogic;

    function initialize() {
		WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {    
    	commonLogic = new CommonLogic();
    	commonLogic.onLayout(dc);                              
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {    
        // 235 specific vars
        var timeSpacing=15; 
        var timeY=105;         
        var timeFont=Graphics.FONT_NUMBER_THAI_HOT;
        
        var wolfY=0; 

        var dateFont=Graphics.FONT_SYSTEM_MEDIUM;
        var dateY=140;

        var reminderFont=Graphics.FONT_SYSTEM_MEDIUM;
        var reminderY=170;   
		commonLogic.onUpdate(dc, timeSpacing, timeY, timeFont, wolfY, dateFont, dateY, reminderFont, reminderY);        
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
