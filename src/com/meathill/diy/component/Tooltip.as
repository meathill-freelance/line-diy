package com.meathill.diy.component 
{
  import com.meathill.diy.config.Typography;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
  import flash.display.Stage;
  import flash.geom.Rectangle;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.utils.Dictionary;
	
	/**
   * ...
   * @author Meathill
   */
  public class Tooltip extends Sprite {
    public static const TOP:uint = 0;
    public static const LEFT:uint = 1;
    public static const RIGHT:uint = 2;
    public static const BOTTOM:uint = 3;
    private static var record:Dictionary = new Dictionary(true);
    
    private var text:TextField;
    
    public static function create(label:String, target:DisplayObject, dir:int = 2):void {
      var tooltip:Tooltip = new Tooltip(label, target, dir);
      record[target] = tooltip;
      target.stage.addChild(tooltip);
    }
    public static function remove(target:DisplayObject):void {
      target.stage.removeChild(record[target]);
    }
    
    public function Tooltip(label:String, target:DisplayObject, dir:uint = 2) {
      mouseEnabled = mouseChildren = false;
      
      text = new TextField();
      text.defaultTextFormat = Typography.getTextFormat(Typography.BODY, { color: 0xFFFFFF } );
      text.x = 4;
      text.y = 3;
      text.height = 18;
      text.autoSize = TextFieldAutoSize.LEFT;
			text.text = label;
      addChild(text);
      
      draw(dir);
      layout(target, dir);
    }
    private function draw(dir:uint):void {
      var w:uint = text.width + 8;
      var h:uint = 24;
      graphics.beginFill(0x222222);
      graphics.drawRoundRect(0, 0, w, h, 6, 6);
      switch(dir) {
        case TOP:
          graphics.moveTo(w - 12 >> 1, h);
          graphics.lineTo(w >> 1, h + 5);
          graphics.lineTo(w + 12 >> 1, h);
          graphics.lineTo(w -12 >> 1, h);
          break;
      }
      graphics.endFill();
    }
    private function layout(target:DisplayObject, dir:uint):void {
      var rect:Rectangle = target.getRect(target);
      var _x:int = rect.x + rect.width * .5 + target.x, _y:int = rect.y + rect.height * .5 + target.y;
      var parent:DisplayObjectContainer = target.parent;
      while (!(parent is Stage)) {
        _x += parent.x;
        _y += parent.y;
        parent = parent.parent;
      }
      if (dir === 0 || dir === 3) {
        x = _x - width * .5;
        if (dir === 0) {
          y = _y - height - 4 + rect.y;
        } else {
          y = target.height + _y + 4 + rect.y;
        }
      } else {
        y = _y - height * .5;
        if (dir === 2) {
          x = _x - width - 5 + rect.x;
        } else {
          x = _x + target.width + 5 + rect.x;
        }
      }
    }
    
  }

}