package com.meathill.diy.view.welcome 
{
  import com.greensock.TweenLite;
  import flash.display.DisplayObject;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * ...
   * @author Meathill
   */
  public class WelcomePane extends Sprite {
    
    public function get value():String {
      return WelcomeItem(getChildByName('active')).id;
    }
    
    public function WelcomePane() {
      alpha = 0;
      
      addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    public function show(delay:uint = 0):void {
      var _y:int = y;
      TweenLite.to(this, 0.3, { alpha: 1, y: 0, delay: delay / 1000 } );
    }
    public function hide(delay:uint = 0):void {
      TweenLite.to(this, 0.3, { alpha: 0, y: 30, delay: delay / 1000, onComplete: removeSelf});
    }
    
    private function removeSelf():void {
      if (this.parent) {
        this.parent.removeChild(this);
      }
    }
    
    private function clickHandler(e:MouseEvent):void {
      var item:WelcomeItem = WelcomeItem(e.target);
      var curr:WelcomeItem = WelcomeItem(getChildByName('active'));
      if (item === curr) {
        return;
      }
      if (curr) {
        curr.selected = false;
      }
      item.selected = true;
    }
  }

}