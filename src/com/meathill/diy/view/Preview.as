package com.meathill.diy.view 
{
  import com.greensock.TweenMax;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.filters.ColorMatrixFilter;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite 
  {
    private var loader:Loader;
    private var cloth:Sprite;
    
    public function Preview() {
      useHandCursor = true;
			
    }
    
    public function show(mc:Sprite):void {
      if (numChildren > 0) {
        removeChildAt(0);
      }
      cloth = mc;
      cloth.mouseEnabled = cloth.useHandCursor = true;
      addChild(cloth);
    }
    public function setColor(color:Object, step:uint):void {
      var piece:DisplayObject = cloth.getChildAt(step),
          matrix:Array = [color.r, 0, 0, 0, 1];
      matrix = matrix.concat([0, color.g, 0, 0, 1]);
      matrix = matrix.concat([0, 0, color.b, 0, 1]);
      matrix = matrix.concat([0, 0, 0, 1, 0]);
      var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
      piece.filters = [filter];
    }
    public function setNumber(number:uint, asset:Sprite, step:uint):void {
      var piece:Sprite = Sprite(cloth.getChildAt(step));
      while (piece.numChildren) {
        piece.removeChildAt(0);
      }
      
    }
    public function highlight(step:uint):void {
      var tween:TweenMax = TweenMax.to(cloth.getChildAt(step), 0.3, {
        glowFilter: {
          color: 0xFFFFFF,
          alpha: 0.8,
          blurX: 16,
          blurY: 16,
          strength: 2,
          quality: 2
        },
        onComplete: function ():void {
          tween.reverse();
        }
      });
    }
    
    
  }

}