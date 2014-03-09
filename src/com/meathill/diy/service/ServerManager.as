package com.meathill.diy.service 
{
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.net.URLVariables;
	/**
   * ...
   * @author Meathill
   */
  public class ServerManager extends EventDispatcher
  {
    public static const API:String = '../mocks/api.html';
    static public const INIT:String = "'../mocks/init.json'";
    
    public static const COMPLETE:String = 'complete';
    public static const COMPLETE_ALL:String = 'complete_all';
    
    private var loader:URLLoader;
    private var queue:Vector.<CallVO>;
    private var isLoading:Boolean = false;
    
    public function ServerManager()
    {
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
      req.method = 'post';
      req.data = data;
      queue.push(new CallVO(req, success, progress, error));
      call();
    }
    public function call():void {
      if (isLoading) {
        return;
      }
      loader.load(queue[0].req);
      isLoading = true;
    }
    
    private function loader_completeHandler(e:Event):void {
      queue[0].success(loader.data);
      queue.shift();
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