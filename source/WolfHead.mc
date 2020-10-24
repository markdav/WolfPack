using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi as Ui;

/**
/ The Wolfhead is a battery indicator and the images are dependant on the phone model
*/
class WolfHead {
  var greenBitmap;
  var whiteBitmap;
  var orangeBitmap;
  var redBitmap;
  
  // seems a bit overkill but making these vars to save on ops and battery
  var greenX;
  var whiteX;
  var orangeX;
  var redX;
  
  
  function initialize(cx){
     me.greenBitmap=Ui.loadResource(Rez.Drawables.wolfshead_green);
     me.whiteBitmap=Ui.loadResource(Rez.Drawables.wolfshead_white); 
     me.orangeBitmap=Ui.loadResource(Rez.Drawables.wolfshead_orange);
     me.redBitmap=Ui.loadResource(Rez.Drawables.wolfshead_red);
     
     // remembering the centres so we can give centered coords
     // most likely these are all the same vals but technically they might not be so might as well.     
     me.greenX=cx-me.greenBitmap.getWidth()/2;
     me.whiteX=cx-me.whiteBitmap.getWidth()/2;
     me.greenX=cx-me.greenBitmap.getWidth()/2;
     me.orangeX=cx-me.orangeBitmap.getWidth()/2;
     me.redX=cx-me.redBitmap.getWidth()/2;               
  }
  
  function draw(dc, yOff){     
  
      var battery=System.getSystemStats().battery;        
      if ( battery >= 90 ) {      	
           dc.drawBitmap(me.greenX, yOff, me.greenBitmap);
	  } else if ( battery >= 50 ) {
           dc.drawBitmap(me.whiteX, yOff, me.whiteBitmap);           
	  } else if ( battery >= 30 ) {
           dc.drawBitmap(me.orangeX, yOff, me.orangeBitmap);		
	  } else {
           dc.drawBitmap(me.redX, yOff, me.redBitmap);		
	  }
  }
  
}  
  
  