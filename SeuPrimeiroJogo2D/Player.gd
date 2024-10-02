extends Area2D
# Abaixo - This defines a custom signal called "hit" that we will have our player 
# emit (send out) when it collides with an enemy.
signal hit

# Using the export keyword on the first variable speed allows us to 
# set its value in the Inspector
export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() # esconde para o jogo não começar ja com ele sendo exibido

func _process(delta):
	#Player começa parado (0,0)
	var velocity = Vector2.ZERO # The player's movement vector.
	# Os inputs(teclas) são definidas em Projeto > Configurações do Projeto > Mapa de Entrada
	#(project > project config >  Input)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play() # get_node("AnimatedSprite").play()
	else:
		$AnimatedSprite.stop()
		
	# The delta
	# parameter in the _process() function refers to the frame length - 
	# the amount of time that the previous frame took to complete. Using 
	# this value ensures that your movement will remain consistent even
	# if the frame rate changes.
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		# Deixa sempre a sprite no estado original na vertical 
		# quando for pros lado
		$AnimatedSprite.flip_v = false
		# Se o vetor de velocidade x for negativo, ele inverte horizontalmente
		# a imagem 
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# apenas a func foi Adicionado pela tab Nó(Node) que tem no lado do inpetor após adicionar 
# hit
func _on_Player_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit") # quando algo entrar na colisionshaoe esse sinal vai ser emitido
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true) # evita multiplas emissao
	
## Colocar player no jogo
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
