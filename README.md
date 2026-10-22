# The Runner

Petit jeu de plateforme de type **runner** (inspiré de Temple Run) réalisé avec **Godot 4.7** pour le TP02 du cours *Programmation jeux et multimédias* (420-0SW, Cégep de Shawinigan).

Le personnage court tout seul vers la droite. Le joueur doit sauter par-dessus les obstacles et peut lancer des objets (3 munitions).

## Contrôles

| Action | Touches |
|---|---|
| Sauter (`jump`) | Espace ou W |
| Attaquer / lancer (`attack`) | J ou clic gauche |

Les touches sont définies dans l'**Input Map** (Projet > Paramètres du projet > Contrôles).

## Machine à états

Le joueur est contrôlé par une machine à états finis (`enum State` + `match` dans `scenes/playerv_1.gd`).

| État | Ce qu'il fait | Transitions |
|---|---|---|
| RUN | court tout seul, animation `run` | jump → JUMP, attack → ATTACK, plus de sol → FALL |
| JUMP | monte, animation `jump` | au sommet (`velocity.y >= 0`) → FALL |
| FALL | descend, animation `fall` | touche le sol → RUN |
| ATTACK | lance un objet (−1 munition), animation `attack` | animation terminée ou plus de munitions → RUN |

Il n'y a pas d'état IDLE : comme dans un runner, le personnage ne s'arrête jamais.

## Animations

`run`, `jump`, `fall`, `attack`, `death` (AnimatedSprite2D). `attack`, `jump` et `death` ne bouclent pas.

## Parallaxe

Décor en couches avec des nœuds `Parallax2D` : ciel (immobile), nuages (lents + défilement automatique), îles (plus rapides). Chaque couche se répète (`repeat_size`).

## Structure

- `scenes/world.tscn` : le niveau (parallaxe, sol en TileMapLayer, joueur)
- `scenes/playerv_1.tscn` / `scenes/playerv_1.gd` : le joueur et sa machine à états
- `art/` et `assets/` : images

## Crédits

- Personnage SteamMan : [CraftPix – Free 3 Character Sprite Sheets](https://craftpix.net/file-licenses/)
- Décor (Legacy Fantasy – Purple Bay) : Anokolisa (https://www.patreon.com/Anokolisa)
- Tuiles du sol : projet de base du cours (`c07_plateforme`)
- Police Pixellari : https://www.dafont.com/pixellari.font
