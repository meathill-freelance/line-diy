package com.meathill.diy.view 
{
  import flash.display.DisplayObject;
  import flash.display.Loader;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.ColorTransform;
  import flash.net.URLRequest;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite 
  {
    private var loader:Loader;
    private var cloth:Sprite;
    
    public function Preview() {
      super();
			
    }
    
    public function show(url:String):void {
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
      loader.load(new URLRequest(url));
    }
    public function setColor(color:uint, step:uint):void {
      var piece:DisplayObject = cloth.getChildAt(step),
          ct:ColorTransform = new ColorTransform(.33, .33, .33, 1);
      ct.redOffset = .66 * ((color >> 16) & 0xFF);
      ct.greenOffset = ((color >> 8) & 0xFF) * .66;
      ct.blueOffset = (color & 0xFF) * .66;
      ct.alphaOffset = 0;
      piece.transform.colorTransform = ct;
    }
    
    private function loader_completeHandler(e:Event):void {
      if (cloth && contains(cloth)) {
        removeChild(cloth);
      }
      cloth = Sprite(e.currentTarget.content);
      addChild(cloth);
    }
    
  }

}