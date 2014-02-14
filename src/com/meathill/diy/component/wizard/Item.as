package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.filters.GlowFilter;
	
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
    
    private var _status:uint = 0;
    private var config:SingleStepConfig;
    
    public function Item(config:SingleStepConfig) {
			this.config = config;
      draw();
    }
    
    private function draw():void {
      
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