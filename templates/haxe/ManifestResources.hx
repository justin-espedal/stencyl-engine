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

#end //end (!disable_preloader_assets)
