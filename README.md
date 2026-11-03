# The Runner

Petit jeu de plateforme de type **runner** (inspiré de Temple Run) réalisé avec **Godot 4.7** pour le TP02 du cours *Programmation jeux et multimédias* (420-0SW, Cégep de Shawinigan).

Le personnage court tout seul vers la droite. Le joueur doit sauter par-dessus les obstacles et peut lancer des objets (3 munitions).

## Contrôles

| Action | Touches |
|---|---|
| Sauter (`jump`) | Espace ou W |
| Attaquer / lancer (`attack`) | J ou clic gauche |

Les touches sont définies dans l'**Input Map** (Projet > Paramètres du projet > Contrôles).

## Machine à états (patron de conception État)

Le joueur est contrôlé par une machine à états finis construite avec le **patron de conception État** (cours 08) :

```
Playerv1 (CharacterBody2D)      (contexte : gravité + move_and_slide)
└── StateMachine (Node)         (scripts/states/state_machine.gd : garde l'état actif)
    ├── Run     (player_run.gd)
    ├── Jump    (player_jump.gd)
    ├── Fall    (player_fall.gd)
    └── Attack  (player_attack.gd)
```

Chaque état hérite de `BaseState` (`scripts/states/base_state.gd`) et a ses fonctions `enter()` (une fois en entrant), `physics_update()` (à chaque image) et `exit()`. Un état demande un changement avec le signal `Transitioned`.

| État | Ce qu'il fait | Transitions |
|---|---|---|
| Run | court tout seul, animation `run` | jump (au sol) → Jump, attack (s'il reste des munitions) → Attack, plus de sol → Fall |
| Jump | `enter()` : poussée du saut ; monte, animation `jump` | au sommet (`velocity.y >= 0`) → Fall |
| Fall | descend, animation `fall` | touche le sol → Run |
| Attack | `enter()` : −1 munition et animation `attack` | animation terminée → Run |

Il n'y a pas d'état Idle : comme dans un runner, le personnage ne s'arrête jamais.

## Animations

`run`, `jump`, `fall`, `attack`, `death` (AnimatedSprite2D). `attack`, `jump` et `death` ne bouclent pas.

## Parallaxe

Décor en couches avec des nœuds `Parallax2D` : ciel (immobile), nuages (lents + défilement automatique), îles (plus rapides). Chaque couche se répète (`repeat_size`).

## Structure

- `scenes/world.tscn` : le niveau (parallaxe, sol en TileMapLayer, joueur)
- `scenes/playerv_1.tscn` / `scenes/playerv_1.gd` : le joueur (contexte)
- `scripts/states/` : la machine à états et les 4 états
- `art/` et `assets/` : images

## Crédits

- Personnage SteamMan : [CraftPix – Free 3 Character Sprite Sheets](https://craftpix.net/file-licenses/)
- Décor (Legacy Fantasy – Purple Bay) : Anokolisa (https://www.patreon.com/Anokolisa)
- Tuiles du sol : projet de base du cours (`c07_plateforme`)
- Police Pixellari : https://www.dafont.com/pixellari.font
