package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.colorCard.ColorCard;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.text.TextField;
	
	/**
   * ...
   * @author Meathill
   */
  public class Options extends Sprite 
  {
    private var label:TextField;
    private var components:Vector.<Sprite>
    
    public function Options() {
      components = new Vector.<Sprite>();
      draw();
			createTextField();
    }
    
    public function set title(value:String):void {
      label.text = value;
    }
    
    public function show(type:String, config:SingleStepConfig):void {
      while (components.length) {
        removeChild(components.pop());
      }
      
      var all:Array = type.split('|');
      for (var i:uint = 0, len:uint = all.length; i < len; i++) {
        var component:Sprite = createComponent(all[i], config);
        component.y = this.height + 10;
        addChild(component);
        components.push(component);
      }
    }
    
    private function createComponent(type:String, config:SingleStepConfig):Sprite {
      switch(type) {
        case 'color':
          return new ColorCard(config);
          break;
          
        default:
          return null;
      }
    }
    private function createTextField():void {
      label = new TextField();
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, { color: 0xffffff } );
      label.x = 10;
      label.y = 10;
      label.width = 180;
      label.height = 20;
      label.mouseEnabled = false;
      addChild(label);
    }
    private function draw():void {
      graphics.beginFill(Colors.TURQUOISE);
      graphics.drawRoundRect(0, 0, 200, 40, 4, 4);
      graphics.endFill();
    }
  }

}