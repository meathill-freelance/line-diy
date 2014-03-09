package com.meathill.diy.popup 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import robotlegs.bender.extensions.contextView.ContextView;
	/**
   * ...
   * @author Meathill
   */
  public class PopupManager 
  {
    [Inject]
    public var contextView:ContextView;
    
    private var cover:Sprite;
    private var curr:AbstractPopup;
    
    public function PopupManager() {
      cover = new Sprite();
      cover.mouseEnabled = false;
      cover.addEventListener(Event.ADDED_TO_STAGE, cover_addedHandler);
    }
    
    public function popup(popup:AbstractPopup):void {
      if (curr) {
        contextView.view.removeChild(curr);
        curr.afterHide();
      }
      curr = popup;
      curr.beforeShow();
      curr.addEventListener(Event.REMOVED_FROM_STAGE, popup_removedHandler);
      contextView.view.addChild(cover);
      contextView.view.addChild(popup);
    }
    
    private function popup_removedHandler(e:Event):void {
      curr.removeEventListener(Event.REMOVED_FROM_STAGE, popup_removedHandler);
      curr = null;
      contextView.view.removeChild(cover);
    }
    
    private function cover_addedHandler(e:Event):void {
      if (cover.width === cover.stage.stageWidth && cover.height === cover.stage.stageHeight) {
        return;
      }
      cover.graphics.clear();
      cover.graphics.beginFill(0, .6);
      cover.graphics.drawRect(0, 0, cover.stage.stageWidth, cover.stage.stageHeight);
      cover.graphics.endFill();
    }
  }

}