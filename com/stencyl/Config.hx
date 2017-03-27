package com.stencyl;

import lime.utils.Bytes;
import haxe.Json;
import haxe.Resource;
import com.stencyl.Engine;
import com.stencyl.graphics.Scale;
import com.stencyl.graphics.ScaleMode;
import com.stencyl.utils.Utils;

class Config
{
	//Game
	public static var landscape:Bool;
	public static var autorotate:Bool;
	public static var scaleMode:ScaleMode;
	public static var stageWidth:Int;
	public static var stageHeight:Int;
	public static var initSceneID:Int;
	public static var physicsMode:Int;
	public static var gameScale:Float;
	public static var gameImageBase:String;
	public static var antialias:Bool;
	public static var pixelsnap:Bool;
	public static var startInFullScreen:Bool;
	public static var keys:Map<String,Array<String>>;
	public static var scales:Map<String,Array<Scale>>;

	public static var toolsetInterfaceHost:String;
	public static var toolsetInterfacePort:Null<Int>;
	public static var toolsetInterfaceClientID:Null<Int>;

	//Other
	public static var adPositionBottom:Bool;
	public static var testAds:Bool;
	public static var releaseMode:Bool;
	public static var showConsole:Bool;
	public static var debugDraw:Bool;
	public static var always1x:Bool;
	public static var maxScale:Float;
	public static var disableBackButton:Bool;
	
	private static var data:Dynamic;
	
	public static function load():Void
	{
		var text = Utils.getConfigText("config/game-config.json");
		loadFromString(text);
	}

	public static function loadFromString(text:String):Void
	{
		if(data == null)
		{
			data = Json.parse(text);
			setStaticFields();
		}
		else
		{
			var oldData = data;
			data = Json.parse(text);
			setStaticFields();

			for(key in Reflect.fields(oldData))
			{
				var oldValue = Reflect.field(oldData, key);
				var newValue = Reflect.field(data, key);
				
				if(oldValue != newValue)
				{
					trace('value of $key changed: $oldValue -> $newValue');

					switch(key)
					{
						/*case "scaleMode", "stageWidth", "stageHeight",
							"gameScale", "gameImageBase", "startInFullScreen",
							"always1x", "maxScale", "physicsMode", "antialias",
							"releaseMode":
							reloadGame();*/
						case "debugDraw": Engine.DEBUG_DRAW = debugDraw;
							if(!debugDraw)
								if(Engine.debugDrawer != null && Engine.debugDrawer.m_sprite != null)
									Engine.debugDrawer.m_sprite.graphics.clear();
					}
				}
			}
		}
	}
	
	private static function setStaticFields():Void
	{
		landscape = data.landscape;
		autorotate = data.autorotate;
		scaleMode = data.scaleMode;
		stageWidth = data.stageWidth;
		stageHeight = data.stageHeight;
		initSceneID = data.initSceneID;
		physicsMode = data.physicsMode;
		gameScale = data.gameScale;
		gameImageBase = data.gameImageBase;
		antialias = data.antialias;
		pixelsnap = data.pixelsnap;
		startInFullScreen = data.startInFullScreen;
		adPositionBottom = data.adPositionBottom;
		testAds = data.testAds;
		releaseMode = data.releaseMode;
		showConsole = data.showConsole;
		debugDraw = data.debugDraw;
		always1x = data.always1x;
		maxScale = data.maxScale;
		disableBackButton = data.disableBackButton;
		keys = asMap(data.keys);
		scales = asMap(data.scales);
		toolsetInterfaceHost = data.toolsetInterfaceHost;
		toolsetInterfacePort = data.toolsetInterfacePort;
		toolsetInterfaceClientID = data.toolsetInterfaceClientID;
	}

	private static function asMap<T>(anon:Dynamic):Map<String,T>
	{
		var map = new Map<String,T>();
		for(field in Reflect.fields(anon))
		{
			map.set(field, cast Reflect.field(anon, field));
		}
		return map;
	}
}