using Toybox.System;
using Toybox.Graphics;

module TimeDisplay {
	function drawTime(dc, cx, cy, font, xPad, yPad){
        var clockTime = System.getClockTime();
        var hourString = clockTime.hour.format("%02d");
        var minString = clockTime.min.format("%02d");
               
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(cx-xPad, cy+yPad, font, hourString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT);        
        dc.drawText(cx+xPad, cy+yPad, font, minString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);	
	}
    
}