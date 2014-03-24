package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Wizard extends Sprite 
  {
    private static const MAX_WIDTH:uint = 180;
    private var _items:Vector.<Item>;
    private var count:TextField;
    
    public function Wizard() {
      _items = new Vector.<Item>();
    }
    
    public function draw(steps:Vector.<SingleStepConfig>):void {
      var stepWidth:uint = stage.stageWidth / (steps.length + 1);
      stepWidth = stepWidth < MAX_WIDTH ? stepWidth : MAX_WIDTH;
      Item.stepWidth = stepWidth;
      
      // 背景
      graphics.beginFill(Colors.HEADER_BG);
      graphics.drawRect(0, 0, stage.stageWidth, 60);
      graphics.endFill();
      
      // 计步器
      for (var i:uint = 0; i < steps.length; i++) {
        var item:Item = new Item(steps[i], i + 1, i === steps.length - 1);
        item.x = stepWidth * i;
        addChild(item);
        _items.push(item);
      }
    }
    public function highhight(step:uint):void {
      for (var i:uint = 0, len:uint = _items.length; i < len; i++) {
        _items[i].deactive();
      }
      _items[step].active();
    }
  }

}