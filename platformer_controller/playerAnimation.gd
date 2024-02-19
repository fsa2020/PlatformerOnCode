extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var player = get_parent()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	setAnimation()

func setAnimation():
	if player == null:return

	if player.isGrabbing:
		# todo add grabbing animation
		play("grab")
		flip_h = signf(player.grabDirection)>0
		print(player.grabDirection)

	elif player.is_feet_on_ground():
		var v = player.velocity.x
		if abs(v) < 10:
			play("idle")
		else :
			play("run")
		
		if v != 0:
			flip_h = signf(v)<0
	else:
		play("idle")
