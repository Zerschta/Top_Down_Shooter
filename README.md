# Top_Down_Shooter
Overview

A 2D top-down roguelike shooter built in Processing (Java) as a learning project. The focus is on understanding core game architecture — entities, composition, data-driven design — from scratch, without external libraries or a full game engine.

Tech stack


Language: Java
Framework: Processing
Dependencies: none — everything built from scratch


Current features


Player movement, health, XP and leveling
Enemy AI with chase behavior and separation (avoids enemies stacking on top of each other)
Bullet system with trigonometry-based aiming (atan2, cos / sin)
Weapon system:

WeaponData — pure stats (damage, cooldown, spread, speed, bullet count, size, type)
WeaponObject — the world entity used for picking weapons up off the ground
Pickup / drop logic that preserves the actual carried weapon instance, not a fresh default copy



Multiple weapon types: Pistol, Shotgun (spread shot), Rocket Launcher (360° explosion on impact)
Basic UI: health bar


Controls

InputAction WASD / Arrow keysMoveLeft clickShootRight clickin progressShiftin progress

Architecture notes


Composition over inheritance — WeaponObject holds a reference to WeaponData instead of inheriting it, so weapon stats survive independently of the world object. This matters for pickup/drop and for future upgrades (modifying a held weapon's stats persists across drop/pickup, since the same instance is reused).
Data-driven weapons — new weapon types are just new value sets (damage, spread, count, etc.), not new subclasses.
Known issue / in progress: Player, Enemy, and the main sketch are currently tightly coupled (talk to each other directly via global variables). A shared Entity base class is planned but not yet implemented.


Roadmap


 WaveManager — states: SPAWNING → FIGHTING → CLEAR → NEXT, exponential difficulty scaling per wave
 Perk system (in-run upgrades)
 Game state system (menu / playing / dead / win)
 Score tracking + expanded UI (XP bar, active weapon slot, wave counter)
 Boss fights
 Meta-progression + save/load (saveStrings / loadStrings)


Why Processing?

Used intentionally as a learning environment to nail down game architecture fundamentals — entities, state, decoupling — before eventually moving to Godot.
