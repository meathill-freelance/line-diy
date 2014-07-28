package com.meathill.diy.component.options 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.component.Tooltip;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.ColorTransform;
	
	/**
   * ...
   * @author Meathill
   */
  public class ColorCardItem extends Sprite 
  {
    private var _color:uint;
    private var tween:TweenLite;
    private var icon:Bitmap;
    private var label:String;
    
    public function ColorCardItem(color:uint, label:String = '') {
      this.label = label;
      _color = color;
			
      buttonMode = useHandCursor = true;
      mouseChildren = false;
      filters = [Filters.BEVEL];
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
      if (_color === 0xFFFFFF || _color === 0xFCFCFC) {
        icon.transform.colorTransform = new ColorTransform(0.8, 0.8, 0.8, 1);
      }
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
      if (label) {
        Tooltip.create(label, this, 0);
      }
    }
    private function rollOutHandler(e:MouseEvent):void {
      tween = TweenLite.to(this, .3, {
        scaleX: 1,
        scaleY: 1
      });
      if (label) {
        Tooltip.remove(this);
      }
    }
  }

}