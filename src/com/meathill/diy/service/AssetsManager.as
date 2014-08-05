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
    public static const HAIBAO:String = 'haibao';
    public static var instance:AssetsManager;
    
    private var queue:Array;
    private var count:uint = 0;
    private var assets:Object;
    
    private var _haibao:Vector.<Bitmap>;
    public function get haibao():Vector.<Bitmap> {
      return _haibao;
    }
    
    private var _templates:Vector.<Sprite>;
    public function get templates():Vector.<Sprite> {
      return _templates;
    }
    
    private var _welcome:Vector.<Bitmap>;
    public function get welcome():Vector.<Bitmap> {
      return _welcome;
    }
    
    public function AssetsManager() {
      if (instance) {
        throw new Error('already exist');
      }
      queue = [];
      _templates = new Vector.<Sprite>();
      _welcome = new Vector.<Bitmap>();
      _haibao = new Vector.<Bitmap>();
      assets = { };
      instance = this;
    }
    
    public function add(type:String, url:String):void {
      trace('add assets: ', type, url);
      queue.push({
        type: type,
        url: url,
        loader: createLoader()
      });
    }
    public function load():void {
      for (var i:uint = 0, len:uint = queue.length; i < len; i++) {
        var item:Object = queue[i];
        item.loader.load(new URLRequest(item.url));
        trace('load: ', item.url);
      }
    }
    public function getAsset(key:String):DisplayObject {
      return assets[key];
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
    
    private function createLoader():Loader {
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
      return loader;
    }
    private function mapContent():void {
      for (var i:uint = 0, len:uint = queue.length; i < len; i++) {
        var item:Object = queue[i];
        var mc:DisplayObject = item.loader.content;
        switch(item.type) {
          case TEMPLATE:
            var template:Sprite = Sprite(mc);
            for (var j:uint = 0, jlen:uint = template.numChildren; j < jlen; j++) {
              Sprite(template.getChildAt(j)).mouseChildren = false;
            }
            _templates.push(template);
            break;
            
          case WELCOME:
            _welcome.push(Bitmap(mc));
            break;
            
          case HAIBAO:
            _haibao.push(Bitmap(mc));
            break;
            
          default:
            assets[item.type] = mc;
            break;
        }
      }
      queue = [];
    }
    
    private function loader_completeHandler(e:Event):void {
      count++;
      if (queue.length === count) {
        count = 0;
        mapContent();
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }
    private function loader_progressHandler(e:ProgressEvent):void {
      dispatchEvent(e);
    }
    private function loader_errorHandler(e:IOErrorEvent):void {
      trace(e);
    }

  }

}