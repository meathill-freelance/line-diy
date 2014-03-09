package com.meathill.diy.service 
{
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.net.URLRequest;
	/**
   * ...
   * @author Meathill
   */
  public class AssetsManager extends EventDispatcher
  {
    public static const TEMPLATE:String = 'template';
    
    private var _templates:Vector.<Sprite>;
    private var queue:Array;
    private var isLoading:Boolean = false;
    private var assets:Object;
    
    public function AssetsManager() 
    {
      queue = [];
      _templates = new Vector.<Sprite>();
      assets = { };
    }
    
    public function get templates():Vector.<Sprite> {
      return _templates;
    }
    
    public function add(type:String, url:String):void {
      queue.push({
        type: type,
        url: url
      });
    }
    public function getAsset(key:String):Sprite {
      return assets[key];
    }
    public function load():void {
      if (isLoading) {
        return;
      }
      next();
    }
    
    private function next():void {
      isLoading = true;
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
      loader.load(new URLRequest(queue[0].url));
      trace('load: ', queue[0].url);
    }
    
    
    private function loader_completeHandler(e:Event):void {
      var mc:Sprite = Sprite(e.target.content);
      switch(queue[0].type) {
        case TEMPLATE:
          _templates.push(mc);
          break;
          
        default:
          assets[queue[0].type] = mc;
          break;
      }
      queue.shift();
      if (queue.length) {
        next();
      } else {
        isLoading = false;
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }
    private function loader_progressHandler(e:ProgressEvent):void {
      dispatchEvent(e.clone());
    }
    private function loader_errorHandler(e:IOErrorEvent):void {
      trace(e);
    }

  }

}