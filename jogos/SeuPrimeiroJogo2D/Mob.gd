extends RigidBody2D
# Objetos do mundo, voice não controla voce aplica forças físicas(gravidade,impulsos)

func _ready():
	$AnimatedSprite.playing = true #Sempre roda animação
	var mob_types = $AnimatedSprite.frames.get_animation_names() #pegas o nomes das animações existentes e coloca numa lista
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # pega uma animação aleatoria da lista

# Função adiciocionado clicando no node VisibilityNotifier2d, indo
# na aba no e dando duplo click no sinal "screen+exited"
# e conectando ao mob
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # Apaga mob ao sair da tela
