package com.meathill.diy.service 
{
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
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
    public static const WELCOME:String = 'welcome';
    public static var instance:AssetsManager;
    
    private var _templates:Vector.<Sprite>;
    private var _welcome:Vector.<Bitmap>;
    private var queue:Array;
    private var isLoading:Boolean = false;
    private var assets:Object;
    
    public function AssetsManager() {
      if (instance) {
        throw new Error('already exist');
      }
      queue = [];
      _templates = new Vector.<Sprite>();
      _welcome = new Vector.<Bitmap>();
      assets = { };
      instance = this;
    }
    
    public function get templates():Vector.<Sprite> {
      return _templates;
    }
    public function get welcome():Vector.<Bitmap> {
      return _welcome;
    }
    
    public function add(type:String, url:String):void {
      trace('add assets: ', type, url);
      queue.push({
        type: type,
        url: url
      });
    }
    public function getAsset(key:String):DisplayObject {
      return assets[key];
    }
    public function load():void {
      if (isLoading) {
        return;
      }
      next();
    }
    public function clone(string:String, width:uint = 0, height:uint = 0):Bitmap {
      var asset:Sprite = Sprite(getAsset('assets'));
      var target:DisplayObject = asset.getChildByName(string);
      if (width !== 0 && height !== 0) {
        Scaler.resize(target, width, height);
      }
      var bmpd:BitmapData = new BitmapData(target.width, target.height, true, 0);
      bmpd.draw(target);
      var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
      return bmp;
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
      var mc:DisplayObject = LoaderInfo(e.target).content;
      switch(queue[0].type) {
        case TEMPLATE:
          var template:Sprite = Sprite(mc);
          for (var i:uint = 0, len:uint = template.numChildren; i < len; i++) {
            Sprite(template.getChildAt(i)).mouseChildren = false;
          }
          _templates.push(template);
          break;
          
        case WELCOME:
          _welcome.push(Bitmap(mc));
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