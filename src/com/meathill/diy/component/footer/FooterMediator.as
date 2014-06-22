package com.meathill.diy.component.footer 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ConfigModel;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.popup.view.HaibaoPopup;
  import com.meathill.diy.popup.view.SharePopup;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.net.navigateToURL;
  import flash.net.URLRequest;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class FooterMediator extends Mediator {
    [Inject]
    public var popupManager:PopupManager;
    
    [Inject]
    public var config:ConfigModel;
    
    [Inject]
    public var view:Footer;
    
    override public function initialize():void {
      view.addText(config.more);
      
      addViewListener(MouseEvent.CLICK, view_clickHandler);
      addViewListener(UserEvent.HAIBAO, user_haibaoHandler);
      addViewListener(UserEvent.CONTRIBUTE, user_contributeHandler);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      var target:String = Sprite(e.target).name;
      var url:String = encodeURIComponent(config.baseURL);
      var content:String = encodeURIComponent(config.shareText);
      var result:String = '';
      if (target !== '') {
        switch (target) {
          case 'weibo':
            var base:String = 'http://v.t.sina.com.cn/share/share.php?appkey=',
                param:String = '&url=' +  url + '&title=' + content + '&source=&sourceUrl=&content=UTF-8&pic=';
            go(url + param);
            break;
            
          case 'renren':
            result = 'http://widget.renren.com/dialog/share?resourceUrl=' + url + '&srcUrl=' + url + '&title=&pic=&description=' + content;
            go(result);
            break;
            
          case 'douban':
            result = 'http://www.douban.com/recommend/?url=' + url + '&title=' + content + '&sel=&v=1';
            go(result);
            break;
            
          case 'tweibo':
            var _assname:String = encodeURI("qqdigi");//你注册的帐号，不是昵称
            var _appkey:String = encodeURI("100678265");//你从腾讯获得的appkey
            result = 'http://share.v.t.qq.com/index.php?c=share&a=index&url=' + url + '&appkey=' + _appkey + '&pic=&assname=' + _assname+'&title=' + content;
            go(result);
            break;
            
          case 'wechat':
            break;
        }
      }
    }
    private function go(url:String):void {
      var req:URLRequest = new URLRequest(url);
      navigateToURL(req, "_blank");
    };
    
    private function user_contributeHandler(e:UserEvent):void {
      popupManager.popup(new SharePopup());
    }
    private function user_haibaoHandler(e:UserEvent):void {
      popupManager.popup(new HaibaoPopup());
    }
    
  }

}