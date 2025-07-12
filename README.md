# Loot-Master
 
This project is meant to be the Personal Project 1 - Portfolio Project for the Boot.dev course. It's a simple game based on the loot drop mechanics in various ARPGs such as Path of Exile, Diablo and many others. Whilst making a whole game with combat and loot is much too grand a scope for this project, a simulator for the loot dropping seems more within reach! 

## Table of contents
1. [[#Game engine and programming language]]
2. [[#Overview]]
3. [[#Expected duration]]
4. [[#Actual duration]]
### Game engine and programming language
The project is built in Godot, a fantastic open source game engine with very powerful 2D features. Whilst there are other engines, such as Unreal, which excel at 3D, graphics pipe-lining and many other wonders, Godot's functionality and Object-Oriented approach to building a game provide a low threshold for beginners. 

The Godot engine supports both their built-in GDScript language, which has a lot of similarities with Python, as well as C++. In this project I will be utilising the GDScript language, as well as the built-in *node* system. Nodes can be seen as a combination of objects and classes. They are built-in to the engine and come with various method functions already attached to them, as well as the ability to interact with each other in easy ways.

### Overview
The game will be mostly UI elements, with very little to no sprites, models or sound effects, though this is subject to change depending on the complexity of implementing the features.

The core concept is trying to simulate the loot drops in various ARPGs. In these games, when an item is dropped, a random number generator determines which item drops, as well as the values on said item. For example if a monster has a 10% chance to drop an item, first it's determined by the game wether or not an item is dropped. After this, this process repeats many times. Instead of actually slaying a monster, this will be simulated by clicking a button, exciting stuff, I know.

The item's type will be picked at random from a list of available types, after which the damage types and special bonuses will be determined in a similar fashion. 

### Expected duration
The project guideline on Boot.dev states approximately 20-40 hours should be spend on this project, so that's the goal. 

### Actual duration
This will be updated once the project is finished.
