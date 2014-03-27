package com.meathill.diy.component 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.DisplayObject;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * ...
   * @author Meathill
   */
  public class ChevronButton extends Sprite {
    private var bg:Shape;
    private var tween:TweenLite;
    public static const WIDTH:uint = 30;
    public static const HEIGHT:uint = 30;
    
    public function ChevronButton(isNext:Boolean = true) {
      draw(isNext);
      buttonMode = useHandCursor = true;
      mouseChildren = false;
			
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    private function draw(isNext:Boolean):void {
      bg = new Shape()
      bg.alpha = 0;
      bg.graphics.beginFill(0xFFFFFF);
      bg.graphics.drawRect(0, 0, WIDTH, HEIGHT);
      bg.graphics.endFill();
      addChild(bg);
      
      var iconName:String = 'chevron' + (isNext ? 'Right' : 'Left');
      var icon:DisplayObject = Sprite(AssetsManager.instance.getAsset('assets')).getChildByName(iconName);
      icon.x = (WIDTH - icon.width >> 1) + (isNext ? 1 : 0);
      icon.y = HEIGHT - icon.height >> 1;
      addChild(icon);
    }
    
    private function rollOutHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
      tween = TweenLite.to(bg, 0.3, { alpha: 0 } );
    }
    private function rollOverHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
      tween = TweenLite.to(bg, 0.3, { alpha: 0.3 } );
    }
    
  }

}