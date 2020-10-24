using Toybox.System;
using Toybox.Graphics;

module TimeDisplay {
	function drawTime(dc, x, y, font, xPad){
        var clockTime = System.getClockTime();
        var hourString = clockTime.hour.format("%02d");
        var minString = clockTime.min.format("%02d");
               
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(x-xPad, y, font, hourString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT);        
        dc.drawText(y+xPad, y, font, minString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);	
	}
    
}