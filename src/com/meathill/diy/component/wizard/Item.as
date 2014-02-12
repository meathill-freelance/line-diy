package com.meathill.diy.component.wizard 
{
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
    
    private var status:uint = 0;
    
    public function Item() 
    {
      super();
			draw();
    }
    
    private function draw():void {
      
    }
    
    public function set status(value:int):void {
      status = value;
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