package com.meathill.diy.view 
{
  import com.greensock.TweenMax;
  import flash.display.DisplayObject;
  import flash.display.Loader;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.ColorTransform;
  import flash.net.URLRequest;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite 
  {
    private var loader:Loader;
    private var cloth:Sprite;
    
    public function Preview() {
      useHandCursor = true;
			
    }
    
    public function show(mc:Sprite):void {
      if (numChildren > 0) {
        removeChildAt(0);
      }
      cloth = mc;
      addChild(cloth);
    }
    public function setColor(color:uint, step:uint):void {
      var piece:DisplayObject = cloth.getChildAt(step),
          ct:ColorTransform = new ColorTransform(.33, .33, .33, 1);
      ct.redOffset = .66 * ((color >> 16) & 0xFF);
      ct.greenOffset = ((color >> 8) & 0xFF) * .66;
      ct.blueOffset = (color & 0xFF) * .66;
      ct.alphaOffset = 0;
      piece.transform.colorTransform = ct;
    }
    public function highlight(step:uint):void {
      var tween:TweenMax = TweenMax.to(cloth.getChildAt(step), 0.3, {
        glowFilter: {
          color: 0xFFFFFF,
          alpha: 0.8,
          blurX: 16,
          blurY: 16,
          strength: 2,
          quality: 2
        },
        onComplete: function ():void {
          tween.reverse();
        }
      });
    }
    
  }

}