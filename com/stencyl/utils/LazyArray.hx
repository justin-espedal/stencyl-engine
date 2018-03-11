package com.stencyl.utils;

import haxe.ds.Vector;

@:generic
class LazyArray<V>
{
	private var arr:Vector<V>;
	private var initializer:Int->V;

	public function new(initializer:Int->V, length:Int)
	{
		this.arr = new Vector<V>(length);
		this.initializer = initializer;
	}

	public function get(key:Int):V
	{
		var obj:V = arr[key];
		
		if(obj == null)
		{
			obj = initializer(key);
			arr[key] = obj;
		}

		return obj;
	}
	
	public inline function set(key:Int, value:V) arr[key] = value;
	public inline function isLoaded(key:Int) return arr[key] != null;
}