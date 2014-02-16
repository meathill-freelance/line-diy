package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.filters.GlowFilter;
  import flash.text.TextField;
  import flash.text.TextFormat;
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
      _status = config.type === 'color' ? 1 : 0;
      
      draw();
      createTextField(index);
    }
    
    public function set status(value:uint):void {
      _status = value;
      draw();
      changeFontColor();
    }
    public function get status():uint {
      return _status;
    }
    
    private function createTextField(index:uint):void {
      label = new TextField();
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {align: TextFormatAlign.CENTER, bold: true, color: _status ? 0xFFFFFF : 0});
      label.y = 10;
      label.width = stepWidth;
      label.text = index.toString();
      addChild(label);
    }
    private function changeFontColor():void {
      var format:TextFormat = label.defaultTextFormat;
      format.color = _status ? 0xFFFFFF : 0;
      label.defaultTextFormat = format;
    }
    private function draw():void {
      graphics.beginFill(_status ? Colors.NEPHRITIS : Colors.SILVER);
      graphics.drawRect(0, 0, 1, 40);
      graphics.beginFill(_status ? Colors.EMERALD : Colors.CLOUDS);
      if (isLast) {
        graphics.drawRoundRectComplex(1, 0, stepWidth - 1, 40, 0, 4, 0, 4);
      } else {
        graphics.drawRect(1, 0, stepWidth - 1, 40);
      }
      graphics.endFill();
    }
    
    public function active():void {
      filters = [glow];
    }
    public function deactive():void {
      filters = null;
    }
  }

}