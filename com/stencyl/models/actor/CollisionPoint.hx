package com.stencyl.models.actor;

class CollisionPoint 
{
	public var x:Float;
	public var y:Float;
	public var normalX:Float;
	public var normalY:Float;
	
	public function new(x:Float, y:Float, normalX:Float, normalY:Float)
	{
		this.x = x;
		this.y = y;
		this.normalX = normalX;
		this.normalY = normalY;
	}
}
