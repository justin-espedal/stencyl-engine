#if !disable_preloader_assets
package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (!flash && !display)
		::if (assets != null)::
			::foreach assets::
				::if (type == "font")::
					openfl.text.Font.registerFont (__ASSET__OPENFL__::flatName::);
				::end::
			::end::
		::end::
		#end

		var data, manifest, library, bundle;

		::if (assets != null)::
			::foreach assets::
				::if (type == "manifest")::
					Assets.libraryPaths["::library::"] = rootPath + "::resourceName::";
				::end::
				::if (type == "bundle")::
					Assets.bundlePaths["::library::"] = rootPath + "::resourceName::";
				::end::
			::end::
		::end::

		::foreach libraries::
			::if (preload)::
				library = Assets.getLibrary ("::name::");
				if (library != null) preloadLibraries.push (library);
				else preloadLibraryNames.push ("::name::");
			::end::
		::end::

	}


}


#if !display
#if flash

#elseif (desktop || cpp) //end (flash)

::if (assets != null)::
	::foreach assets::
		::if (type == "font")::
			::if (!embed)::
				@:keep
				@:noCompletion
				class __ASSET__::flatName:: extends lime.text.Font
				{
					public function new ()
					{
						::if (targetPath != null)::
							__fontPath = ManifestResources.rootPath + "::targetPath::";
						::else::
							::if (library != null)::
								__fontID = "::library:: : ::id::";
							::else::
								__fontID = "::id::";
							::end::
						::end::
						::if (fontName)::
							name = "::fontName::";
						::end::
						super ();
					}
				}
			::end::

			@:keep
			@:expose('__ASSET__OPENFL__::flatName::')
			@:noCompletion
			class __ASSET__OPENFL__::flatName:: extends openfl.text.Font
			{
				public function new ()
				{
					::if (targetPath != null)::
						__fontPath = ManifestResources.rootPath + "::targetPath::";
					::else::
						::if (library != null)::
							__fontID = "::library:: : ::id::";
						::else::
							__fontID = "::id::";
						::end::
					::end::
					::if (fontName)::
						name = "::fontName::";
					::end::
					super ();
				}
			}
		::end::
	::end::
::end::

#elseif html5 //end (flash || desktop || cpp)

::if (assets != null)::
	::foreach assets::
		::if (type == "font")::
			@:keep
			@:expose('__ASSET__::flatName::')
			@:noCompletion
			class __ASSET__::flatName:: extends lime.text.Font
			{
				public function new ()
				{
					#if !html5
					__fontPath = "::targetPath::";
					#else
					ascender = ::ascender::;
					descender = ::descender::;
					height = ::height::;
					numGlyphs = ::numGlyphs::;
					underlinePosition = ::underlinePosition::;
					underlineThickness = ::underlineThickness::;
					unitsPerEM = ::unitsPerEM::;
					#end
					::if (fontName)::
						name = "::fontName::";
					::end::
					super ();
				}
			}

			@:keep
			@:expose('__ASSET__OPENFL__::flatName::')
			@:noCompletion
			class __ASSET__OPENFL__::flatName:: extends openfl.text.Font
			{
				public function new ()
				{
					::if (fontName)::
						name = "::fontName::";
					::end::
					super ();
				}
			}
		::end::
	::end::
::end::
#end //end (flash || desktop || cpp || html5)

#end //end (!display)

#end //end (!disable_preloader_assets)
