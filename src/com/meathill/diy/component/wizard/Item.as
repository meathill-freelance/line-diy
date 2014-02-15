package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.filters.GlowFilter;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Item extends Sprite 
  {
    public static const STATUS_NORMAL:uint = 0;
    public static const STATUS_SUCCESS:uint = 10;
    public static const STATUS_ERROR:uint = 20;
    public static const STATUS_DISABLED:uint = 30;
    
    public static var glow:GlowFilter = new GlowFilter(0xffffff, 0.125, 4, 4);
    public static var stepWidth:uint = 0;
    
    private var _status:uint = 0;
    private var config:SingleStepConfig;
    private var isLast:Boolean;
    private var label:TextField;
    
    public function Item(config:SingleStepConfig, index:uint, isLast:Boolean = false) {
			this.isLast = isLast;
      this.config = config;
      buttonMode = useHandCursor = true;
      mouseChildren = false;
      
      draw();
      createTextField(index);
    }
    
    private function createTextField(index:uint):void {
      label = new TextField();
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {align: TextFormatAlign.CENTER, bold: true});
      label.y = 10;
      label.width = stepWidth;
      label.text = index.toString();
      addChild(label);
    }
    private function draw():void {
      graphics.beginFill(Colors.SILVER);
      graphics.drawRect(0, 0, 1, 40);
      graphics.beginFill(Colors.CLOUDS);
      if (isLast) {
        graphics.drawRoundRectComplex(1, 0, stepWidth - 1, 40, 0, 4, 0, 4);
      } else {
        graphics.drawRect(1, 0, stepWidth - 1, 40);
      }
      graphics.endFill();
    }
    
    public function set status(value:int):void {
      _status = value;
      draw();
    }
    
    public function active():void {
      filters = [glow];
    }
    public function deactive():void {
      filters = null;
    }
  }

}