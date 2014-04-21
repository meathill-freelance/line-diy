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
  import flash.geom.Rectangle;
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
    public static const HEIGHT:uint = 40;
		
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
    
    public function set scroll(num:Number):void {
      var rect:Rectangle = this.scrollRect;
      rect.y = num;
      this.scrollRect = rect;
    }
    public function get scroll():Number {
      return this.scrollRect.y; 
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
        font: 'Arial 宋体',
        size: 18
      });
			label.y = 8;
			label.width = stepWidth;
			label.height = 24;
			label.text = index.toString();
			addChild(label);
      
      var title:TextField = new TextField();
      title.defaultTextFormat = label.defaultTextFormat;
      title.y = HEIGHT + 8;
      title.width = stepWidth;
      title.height = 24;
      title.text = config.title;
      addChild(title);
		}
		private function changeFontColor():void {
			var format:TextFormat = label.defaultTextFormat;
			format.color = 0xFFFFFF;
			label.defaultTextFormat = format;
		}
		private function draw(color:uint = 0xFFFFFF):void {
			bg.graphics.clear();
			bg.graphics.beginFill(color);
			bg.graphics.drawRect(0, 0, stepWidth, HEIGHT << 1);
			bg.graphics.endFill();
      
      var rect:Rectangle = new Rectangle(0, 0, stepWidth, HEIGHT);
      this.scrollRect = rect;
		}
		
		private function rollOutHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
			tween = TweenLite.to(this, 0.3, { scroll: 0 } );
		}
		private function rollOverHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
			tween = TweenLite.to(this, 0.3, { scroll: HEIGHT } );
		}
	}

}