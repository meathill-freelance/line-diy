package com.meathill.diy.component.wizard {
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.utils.ColorMaker;
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
		
		private var _status:uint = 0;
		private var config:SingleStepConfig;
		private var isLast:Boolean;
		private var label:TextField;
		
		public function Item(config:SingleStepConfig, index:uint, isLast:Boolean = false) {
			this.isLast = isLast;
			this.config = config;
			buttonMode = useHandCursor = true;
			mouseChildren = false;
			_status = 1;
			
			draw();
			createTextField(index);
			
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
		
		public function set status(value:uint):void {
			_status = value;
			draw();
			changeFontColor();
		}
		
		public function get status():uint {
			return _status;
		}
		public function get bgColor():uint {
			return _status ? Colors.EMERALD : 0xFFFFFF
		}
		public function get bgAlpha():Number {
			return _status ? 1 : 0;
		}
    
		public function active():void {
			filters = [Filters.SUNKEN];
		}
		public function deactive():void {
			filters = null;
		}
		
		private function createTextField(index:uint):void {
			label = new TextField();
			label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {align: TextFormatAlign.CENTER, bold: true, color: _status ? 0xFFFFFF : 0});
			label.y = 10;
			label.width = stepWidth;
			label.height = 20;
			label.text = index.toString();
			label.mouseEnabled = false;
			addChild(label);
		}
		private function changeFontColor():void {
			var format:TextFormat = label.defaultTextFormat;
			format.color = _status ? 0xFFFFFF : 0;
			label.defaultTextFormat = format;
		}
		private function draw(bg:uint = 0):void {
			bg = bg || bgColor;
			graphics.clear();
			graphics.beginFill(bg, bgAlpha);
			graphics.drawRect(1, 0, stepWidth - 1, 40);
			graphics.endFill();
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			draw();
		}
		private function rollOverHandler(e:MouseEvent):void {
			draw(ColorMaker.lighten(bgColor, 10));
		}
	}

}