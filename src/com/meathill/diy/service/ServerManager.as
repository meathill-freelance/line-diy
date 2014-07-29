package com.meathill.diy.service 
{
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.net.URLVariables;
  import flash.utils.ByteArray;
	/**
   * ...
   * @author Meathill
   */
  public class ServerManager extends EventDispatcher
  {
    public static const API:String = 'http://www.xline.com.cn/wp-admin/admin-ajax.php';
    static public const INIT:String = "init.json";
    static public const CLOTH:String = 'cloth-';
    
    public static const COMPLETE:String = 'complete';
    public static const COMPLETE_ALL:String = 'complete_all';
    
    private var loader:URLLoader;
    private var queue:Vector.<CallVO>;
    private var isLoading:Boolean = false;
    
    public function ServerManager() {
      queue = new Vector.<CallVO>;
      
      loader = new URLLoader();
      loader.dataFormat = URLLoaderDataFormat.TEXT;
      loader.addEventListener(Event.COMPLETE, loader_completeHandler);
      loader.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
      loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
    }
    
    public function add(url:String, data:Object, success:Function = null, progress:Function = null, error:Function = null):void {
      var req:URLRequest = new URLRequest(url),
          param:URLVariables = new URLVariables();
      for (var prop:String in data) {
        param[prop] = data[prop];
      }
      req.method = URLRequestMethod.POST;
      req.data = param;
      queue.push(new CallVO(req, success, progress, error));
      call();
    }
    public function call():void {
      if (isLoading) {
        return;
      }
      if (queue[0].req.contentType === 'binary/octet-stream') {
        loader.dataFormat = URLLoaderDataFormat.BINARY;
      } else {
        loader.dataFormat = URLLoaderDataFormat.TEXT;
      }
      loader.load(queue[0].req);
      isLoading = true;
    }
    public function upload(url:String, data:Object, contents:ByteArray, success:Function, progress:Function = null, error:Function = null):void {
      var req:URLRequest = new URLRequest();
      var param:URLVariables = new URLVariables();
      for (var prop:String in data) {
        param[prop] = data[prop];
      }
      req.url = url + '?' + param.toString();
      req.method = URLRequestMethod.POST;
      req.contentType = "binary/octet-stream";
      req.data = contents;
      queue.push(new CallVO(req, success, progress, error));
      call();
    }
    
    public function isLogin(success:Function, fail:Function):void {
      add(API, {
        action: 'line_is_login'
      }, function (response:Object):void {
        if (response.is_login) {
          success();
        } else {
          fail();
        }
      }, null, fail);
    }
    
    
    private function loader_completeHandler(e:Event):void {
      var response:Object;
      try {
        response = JSON.parse(loader.data);
      } catch (e:Error) {
        trace('something wrong');
        response = loader.data;
      }
      var vo:CallVO = queue.shift();
      vo.success(response);
      isLoading = false;
      if (queue.length === 0) {
        dispatchEvent(new Event(COMPLETE_ALL));
      } else {
        dispatchEvent(new Event(COMPLETE));
        call();
      }
    }
    private function loader_progressHandler(e:ProgressEvent):void {
      if (queue[0].progress !== null) {
        queue[0].progress(e);
      }
    }
    private function loader_errorHandler(e:IOErrorEvent):void {
      trace('load error');
      if (queue[0].error !== null) {
        queue[0].error(e);
      }
    }
  }

}