package;

import nme.Lib;
import nme.display.Sprite;
import nme.events.Event;
import nme.display.StageAlign;
import nme.display.StageScaleMode;

class Universal extends Sprite 
{
	public function new() 
	{
		super();
		
		#if flash
		com.nmefermmmtools.debug.Console.create(true, 192, false);
		
		//MochiServices.connect("60347b2977273733", root);
		//MochiAd.showPreGameAd( { id:"60347b2977273733", res:"640x580", clip: root});
		#end
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(event:Event):Void 
	{
		init();	
	}
	
	public function init()
	{
		com.stencyl.Engine.stage = Lib.current.stage;
		
		mouseChildren = false;
		mouseEnabled = false;
		stage.mouseChildren = false;
		
		new com.stencyl.Engine(this);
	}
	
	public static function main() 
	{
		var stage = Lib.current.stage;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		Lib.current.addChild(new Universal());	
	}	
}
