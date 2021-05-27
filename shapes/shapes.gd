tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("ShapeSprite", "Sprite", preload("res://addons/shapes/shapescript.gd"), preload("res://addons/shapes/square_icon.png"))

func _exit_tree():
	remove_custom_type("ShapeSprite")
