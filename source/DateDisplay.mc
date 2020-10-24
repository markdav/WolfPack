using Toybox.System;
using Toybox.Graphics;
using Toybox.Lang;

module DateDisplay {
	function drawDate(dc, date, font, x, y){
        var dateStr = Lang.format("$1$ $2$", [date.day_of_week, date.day]);
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);        
        dc.drawText(x, y, font, dateStr, Graphics.TEXT_JUSTIFY_CENTER);	
	} 
    
}