const std = @import("std");
const Allocator = std.mem.Allocator;
const sign = std.math.sign;

const main = @import("root");
const random = main.random;
const JsonElement = main.JsonElement;
const terrain = main.server.terrain;
const CaveMapFragment = terrain.CaveMap.CaveMapFragment;
const SurfaceMap = terrain.SurfaceMap;
const MapFragment = SurfaceMap.MapFragment;
const vec = main.vec;
const Vec3d = vec.Vec3d;
const Vec3f = vec.Vec3f;
const Vec3i = vec.Vec3i;

pub const id = "cubyz:surface";

pub const priority = 1024;

pub const generatorSeed = 0x7658930674389;

pub fn init(parameters: JsonElement) void {
	_ = parameters;
}

pub fn deinit() void {

}

pub fn generate(map: *CaveMapFragment, worldSeed: u64) Allocator.Error!void {
	_ = worldSeed;
	const mapFragment = try SurfaceMap.getOrGenerateFragment(map.pos.wx, map.pos.wz, map.pos.voxelSize);
	defer mapFragment.deinit();
	var x: u31 = 0;
	while(x < CaveMapFragment.width*map.pos.voxelSize) : (x += map.pos.voxelSize) {
		var z: u31 = 0;
		while(z < CaveMapFragment.width*map.pos.voxelSize) : (z += map.pos.voxelSize) {
			map.addRange(x, z, 0, @as(i32, @intFromFloat(mapFragment.getHeight(map.pos.wx + x, map.pos.wz + z))) - map.pos.wy);
		}
	}
}
