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
    private var items:Vector.<Item>;
    private var count:TextField;
    
    public function Wizard() 
    {
      super();
			items = new Vector.<Item>();
    }
    
    public function draw(steps:Vector.<SingleStepConfig>):void {
      var stepWidth:uint = stage.stageWidth / (steps.length + 1);
      
      // 计数
      graphics.beginFill(Colors.TURQUOISE);
      graphics.drawRoundRectComplex(0, 0, stepWidth, 40, 4, 0, 4, 0);
      graphics.endFill();
      count = new TextField();
      count.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {align: TextFormatAlign.CENTER, color: 0xFFFFFF});
      count.y = 10;
      count.width = stepWidth;
      count.text = 0 + '/' + steps.length;
      addChild(count);
      
      // 计步器
      for (var i:uint = 0; i < steps.length; i++) {
        var item:Item = new Item(steps[i]);
        item.x = stepWidth * (i + 1);
        addChild(item);
        items.push(item);
      }
    }
  }

}