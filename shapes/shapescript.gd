tool
extends Sprite


export(String, "Circle", "Square", "Polygon") var shape = "Circle"
export(int, 3, 10) var poly_count = 3
export(Color) var color = "ffffff";
export(float, 0, 1) var outline_width = 0.5
export(float, 0, 0.5) var shape_feather = 0.05
export(float, 0, 0.5) var outline_feather = 0.05

const shader = preload("res://addons/shapes/Shapes.shader")

func _enter_tree():
	self.texture = preload("res://addons/shapes/base_texture.png")
	self.material = ShaderMaterial.new()
	self.material.set_shader(shader)

func _process(delta):
	if shape == "Circle":
		self.material.set_shader_param("shape", 0)
	elif shape == "Square":
		self.material.set_shader_param("shape", 1)
	elif shape == "Polygon":
		self.material.set_shader_param("shape", 2)
		self.material.set_shader_param("poly_count", poly_count)
	
	self.material.set_shader_param("poly_count", poly_count)
	self.material.set_shader_param("chosen_color", color);
	self.material.set_shader_param("outline_width", outline_width)
	self.material.set_shader_param("shape_feather", shape_feather)
	self.material.set_shader_param("outline_feather", outline_feather)
