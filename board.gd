extends Node2D

@onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_screen_wrap_area_entered(area):
	if area.get_parent().position.x > screen_size.x:
		area.get_parent().position.x = 0
	if area.get_parent().position.x < 0:
		area.get_parent().position.x = screen_size.x
