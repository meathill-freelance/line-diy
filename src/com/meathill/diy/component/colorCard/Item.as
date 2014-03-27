package com.meathill.diy.component.colorCard 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.BevelFilter;
	
	/**
   * ...
   * @author Meathill
   */
  public class Item extends Sprite 
  {
    public static var bevel:BevelFilter = new BevelFilter(2, 45, 0xFFFFFF, 0.25, 0, 0.25, 2, 2);
    private var _color:uint;
    private var tween:TweenLite;
    private var icon:Bitmap;
    
    public function Item(color:uint) {
      _color = color;
			
      buttonMode = useHandCursor = true;
      mouseChildren = false;
      filters = [bevel];
      draw();
    
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    public function get color():uint {
      return _color;
    }
    
    public function active():void {
      if (!icon) {
        icon = AssetsManager.instance.clone('check');
      }
      icon.x = - icon.width >> 1;
      icon.y = - icon.height >> 1;
      addChild(icon);
      name = 'active';
    }
    public function deactive():void {
      if (icon) {
        removeChild(icon);
      }
      name = 'deactive';
    }
    
    private function draw():void {
      graphics.beginFill(_color);
      graphics.drawRoundRect(-18, -18, 36, 36, 3, 3);
      graphics.endFill();
    }
    
    
    private function rollOverHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
      scaleX = scaleY = 1.2;
    }
    private function rollOutHandler(e:MouseEvent):void {
      tween = TweenLite.to(this, .3, {
        scaleX: 1,
        scaleY: 1
      });
    }
  }

}