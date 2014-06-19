package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.Preview;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class PreviewMediator extends Mediator 
  {
    [Inject]
    public var view:Preview;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function initialize():void {
      if (cloth.numParts > 1) {
        view.show(assets.templates[cloth.template], assets.templates[cloth.template + cloth.sights], cloth.seperator);
      } else {
        view.show(assets.templates[cloth.template], null, cloth.seperator);
      }
      useUserDesign();
      
      addViewListener(MouseEvent.CLICK, view_clickHanaler);
      
      addContextListener(DesignEvent.SELECT_COLOR, color_changeHandler, DesignEvent);
      addContextListener(DesignEvent.SET_SQUAD_NUMBER, squadNumber_changeHandler, DesignEvent);
      addContextListener(DesignEvent.SET_TEAM_NAME, teamName_changeHandler, DesignEvent);
      addContextListener(UserEvent.GO_TO_STEP, user_gotoStepHandler);
      addContextListener(UserEvent.SELECT_TPL, user_selectTemplateHandler);
      addContextListener(UserEvent.SHOW_TOP, user_showTopHandler);
      addContextListener(UserEvent.SHOW_PANTS, user_showPantsHandler);
    }
    
    
    
    private function useUserDesign():void {
      // 是否需要设置号码
      view.isReady = false;
      for (var i:uint = 0, steps:Vector.<SingleStepConfig> = cloth.steps, len:uint = steps.length; i < len; i++) {
        var config:SingleStepConfig = steps[i];
        if (config.type === 'color') {
          trace('use color: ', config.color.toString(16));
          view.setColor(config.color, i);
          continue;
        }
        if (config.type === 'number') {
          view.setNumber(config.number, config.style, i, config.length, Sprite(assets.getAsset(config.asset)));
        }
        if (config.type === 'teamname') {
          view.setTeamName(config.teamname, config.font, config.color, i);
        }
      }
      view.isReady = true;
    }
    
    // View Event
    private function view_clickHanaler(e:MouseEvent):void {
      var index:uint = Sprite(e.target).parent.getChildIndex(Sprite(e.target)),
          event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      event.step = index;
      dispatch(event);
    }
    // UserEvent
    private function user_gotoStepHandler(e:UserEvent):void {
      if (cloth.steps[e.step] !== undefined) {
        if (cloth.numParts > 1) {
          view.show(assets.templates[cloth.steps[e.step].sight], assets.templates[cloth.steps[e.step].sight + cloth.sights], cloth.seperator);
        } else {
          view.show(assets.templates[cloth.steps[e.step].sight], null, cloth.seperator);
        }
        useUserDesign();
      }
      view.highlight(e.step);
    }
    private function user_selectTemplateHandler(e:UserEvent):void {
      if (cloth.numParts > 1) {
        view.show(assets.templates[e.template], assets.templates[e.template + cloth.sights], cloth.seperator);
      } else {
        view.show(assets.templates[e.template], null, cloth.seperator);
      }
      useUserDesign();
    }
    private function user_showPantsHandler(e:UserEvent):void {
      view.scrollToPart(1);
    }
    private function user_showTopHandler(e:UserEvent):void {
      view.scrollToPart(0);
    }
    // DesignEvent
    private function color_changeHandler(e:DesignEvent):void {
      view.setColor(e.color, cloth.step);
    }
    private function squadNumber_changeHandler(e:DesignEvent):void {
      var config:SingleStepConfig = cloth.steps[cloth.step];
      view.setNumber(e.number, e.style, cloth.step, config.length, Sprite(assets.getAsset(config.asset)));
    }
    private function teamName_changeHandler(e:DesignEvent):void {
      view.setTeamName(e.teamname, e.font, e.color, cloth.step);
    }
  }

}