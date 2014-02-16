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
    private var _items:Vector.<Item>;
    private var count:TextField;
    
    public function Wizard() 
    {
      super();
			_items = new Vector.<Item>();
    }
    
    public function get items():Vector.<Item> {
      return _items;
    }
    public function set ok(value:uint):void {
      count.text = value + '/' +items.length;
    }
    
    public function draw(steps:Vector.<SingleStepConfig>):void {
      var stepWidth:uint = Item.stepWidth = (stage.stageWidth - 20) / (steps.length + 1);
      
      // 计数
      graphics.beginFill(Colors.TURQUOISE);
      graphics.drawRoundRectComplex(0, 0, stepWidth, 40, 4, 0, 4, 0);
      graphics.endFill();
      count = new TextField();
      count.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {align: TextFormatAlign.CENTER, color: 0xFFFFFF, bold: true});
      count.y = 10;
      count.width = stepWidth;
      count.text = 0 + '/' + steps.length;
      addChild(count);
      
      // 计步器
      var okCount:uint = 0;
      for (var i:uint = 0; i < steps.length; i++) {
        var item:Item = new Item(steps[i], i + 1, i === steps.length - 1);
        item.x = stepWidth * (i + 1);
        addChild(item);
        _items.push(item);
        okCount += item.status;
      }
      ok = okCount;
    }
  }

}