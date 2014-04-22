package com.meathill.diy.filter 
{
  import com.meathill.diy.config.Colors;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.BlurFilter;
  import flash.filters.ColorMatrixFilter;
  import flash.filters.DropShadowFilter;
  import flash.filters.GlowFilter;
	/**
   * ...
   * @author Meathill
   */
  public class Filters 
  {
    public static const INPUT:DropShadowFilter = new DropShadowFilter(2, 45, 0, 0.15, 2, 2, 1, 1, true);
    public static const INPUT_FOCUS_IN:DropShadowFilter = new DropShadowFilter(2, 45, 0, 0.25, 4, 4, 1, 1, true);
    public static const INPUT_GLOW:GlowFilter = new GlowFilter(Colors.PETER_RIVER, 0.6, 8, 8);
    
    public static const TUQI:DropShadowFilter = new DropShadowFilter(1, 45, 0xFFFFFF, 0.4, 2, 2, 1, 1, true);
    
    public static const SUNKEN:DropShadowFilter = new DropShadowFilter(2, 45, 0, 0.4, 2, 2, 2, 1, true);
    
    public static const BLACK_WHITE:ColorMatrixFilter = new ColorMatrixFilter([  
      0.8,0,0,0,0,  
      0.8,0,0,0,0,  
      0.8,0,0,0,0,  
      0,0,0,1,0  
    ]);
    
    public static const BLUR:BlurFilter = new BlurFilter();
    static public const GLOW_RED:GlowFilter = new GlowFilter(Colors.ALIZARIN, 0.5, 16, 16, 4, BitmapFilterQuality.MEDIUM);
  }

}