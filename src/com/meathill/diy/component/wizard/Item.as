package com.meathill.diy.component.wizard {
  import com.greensock.TweenLite;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.utils.ColorMaker;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Meathill
	 */
	public class Item extends Sprite {
		public static const STATUS_NORMAL:uint = 0;
		public static const STATUS_SUCCESS:uint = 10;
		public static const STATUS_ERROR:uint = 20;
		public static const STATUS_DISABLED:uint = 30;
		
		public static var stepWidth:uint = 0;
		
		private var config:SingleStepConfig;
		private var label:TextField;
    private var bg:Shape;
    private var tween:TweenLite;
    private var isActivated:Boolean;
		
		public function Item(config:SingleStepConfig, index:uint) {
			this.config = config;
			buttonMode = useHandCursor = true;
			mouseChildren = false;
			
      bg = new Shape();
      bg.alpha = 0;
      addChild(bg);
			draw();
			createTextField(index);
			
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
    
		public function active():void {
      isActivated = true;
      draw(0);
      bg.alpha = 0.5;
			bg.filters = [Filters.SUNKEN];
		}
		public function deactive():void {
      isActivated = false;
      draw();
      bg.alpha = 0;
			bg.filters = null;
		}
		
		private function createTextField(index:uint):void {
			label = new TextField();
			label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {
        align: TextFormatAlign.CENTER,
        bold: true,
        color: 0xFFFFFF,
        font: 'Arial',
        size: 18
      });
			label.y = 8;
			label.width = stepWidth;
			label.height = 24;
			label.text = index.toString();
			label.mouseEnabled = false;
			addChild(label);
		}
		private function changeFontColor():void {
			var format:TextFormat = label.defaultTextFormat;
			format.color = 0xFFFFFF;
			label.defaultTextFormat = format;
		}
		private function draw(color:uint = 0xFFFFFF):void {
			bg.graphics.clear();
			bg.graphics.beginFill(color);
			bg.graphics.drawRect(0, 0, stepWidth, 40);
			bg.graphics.endFill();
		}
		
		private function rollOutHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
			tween = TweenLite.to(bg, 0.3, { alpha: isActivated ? 0.5 : 0 } );
		}
		private function rollOverHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
			tween = TweenLite.to(bg, 0.3, { alpha: isActivated ? 0.5 : 0.3 } );
		}
	}

}