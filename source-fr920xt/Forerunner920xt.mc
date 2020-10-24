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
        // 245 specific vars
        var timeSpacing=30; 
        var timeY=100;         
        var timeFont=Graphics.FONT_SYSTEM_NUMBER_THAI_HOT;
        
        var wolfY=0; 

        var dateFont=Graphics.FONT_SYSTEM_XTINY;
        var dateY=120;

        var reminderFont=Graphics.FONT_SYSTEM_XTINY;
        var reminderY=140;
        
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
