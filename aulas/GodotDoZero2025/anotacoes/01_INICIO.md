# Anotações 1

Anotações das Aulas: 
- **#1**: Instalação e criação do projeto 

- **#2**: Colisão entre 2 corpos e movimentação padrão


## Criando projeto

Ao criar projeto selecionar `mobile`
- 2D
- serve para  PC
- 3D simples

## Dentro do editor

Tab superior alterna entre vcisão 2D e 3D
- na 2D o retangulo azul é camera

Aba direita é a propriedade dos `nós` selecionas

A aba esquerda vai ter a hierarquia de `Nós` e `Cenas`

Uma cena contem `nós`(`nodes`) e `nós` são as entidades das cenas

botão Criar cena 2D e renomear `Nó` para `Game`

Na parte  inferior esquerda tem os arquivos disponieis para o projeto dentro do diretorio `res`
- nele se pode criar pastas
  - Criar pasta `scene`

`Nós` criados precisam ser salvos, 

## Player simples

Na cena 2D, botão direito e adiciona nó
- CharacterBody2D
  - De inicio vai ter um warn dizendo para adicionar um outro nó importante para esse tipo de nó

No CharacterBody2D,  botão direito e adiciona nó
- CollisionShape2D
  - Permite escolher fomra, serve para definir area de colisão

> abaixo da aba de nós selecionados tem um "+" que permite mover o ``nó`` pela camera, se deve selecionar o nó pai

> Na opção de ``depuração`` é possivel selecionar uma opção para deixar as caixas de colisão visiveis("Formas de colisão visiveis"), se não habilitar sera necessario colocar no characterbody algo para ser denhado na tela

F5 para rodar

> Vai aparecer a cena com somente a colisão

## Adicionando script

Botão direito no CharacterBody e adicionar script

Vai abrir uma tela com informações de herança 

Por padrão o script vai implementar uma movimentação basica, por causa do modelo selecionado

criaremos uma pasta `scripts` para todos os `scripts` e chamaremos esse primeiro de ``player.gd``

rodando novamente a caixa de colisão vai aparecer caindo

```gdscript
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
```

## Adicionando Chão

Dentro da cena Game adicionar nó ``StaticBody2D`` e dentro desse nó adicionar um `CollisionShape2D`

Posicionar ``StaticBody2D`` no lugar correto. Para aumentar a largura basta selecionar o ``CollisionShape2D`` e no mesmo modo de movimento permite aumentar largura e altura.

> Pode se mudar as cores de colisão para nessa primeiro momemnto em depuração variar as cores