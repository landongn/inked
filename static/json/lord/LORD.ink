// character data
VAR character_name = ""
VAR class = ""
VAR weapon_name = "Stick"
VAR armor_name = "Coat"
VAR experience_points = 0
VAR gold = 0
VAR reputation = 0
VAR charm = 0
VAR skill_uses = 0
VAR rank = 1
VAR strength = 1
VAR defense = 1
VAR hitpoints = 30
VAR hitpoints_max = 30
VAR gems = 0
VAR is_alive = true
VAR forest_fights = 100
VAR last_location = ""
VAR player_fights = 10

// equipment vars
VAR weapon_attack_power = 0
VAR total_defense = 0

// Trainer data
VAR current_trainer = ""
VAR experience_to_next_rank = 0
VAR trainer_strength = 0
VAR trainer_defense = 0
VAR trainer_hitpoints = 0
VAR trainer_battle_available = true

// world vars
VAR player_count = 0
VAR violet_romance_rank = 0
VAR heard_bard_song = false
VAR has_horse = false
VAR has_fairy = false
VAR spirits = ""

// forest fight vars
VAR forest_encounter_mob_name = ""
VAR forest_encounter_hitpoints = 0
VAR forest_encounter_strength = 0
VAR forest_encounter_defense = 0
VAR forest_encounter_gold = 0
VAR forest_encounter_experience_points = 0
VAR forest_encounter_death_rattle = ""




-> connect 

=== connect ===
# {"location": "connecting..."}
Legend of the Red Dragon. V1. 

<Connect>

+ [Enter the Realm] -> enter_realm
+ [What is this?] -> instructions
+ [List Warriors] -> player_list

== instructions 
Legend of the Red Dragon is an old Bulletin Board System game.  Back in the late 80s to early 90s, it was one of the first forms of online asynchronous multiplayer games that were easily accessible and (mostly) free to play. 
The goal of LORD is to defeat the eponymous Red Dragon, however that is no easy feat.  The Red Dragon is supremely powerful, and it will require you to level up, upgrade your equipment, and defeat every trainer in the game before you can even attempt to fight the dragon. 

Most of the game takes place on a 24 hour real-world game clock.  Each day, you are granted enough energy to fight in the forest against the forces of evil, which is the primary way to level up. Once you run out of energy for the day, you can no longer search for battles-- however the fun does not stop there.
LORD is a PVP game.  You are able to hunt down and murder other players through various mechanics in the game - some are easy, some not so much - and upon defeating them you gain their gold and a large portion of experience, not to mention reputation and fame among the villagers.

Characters that have not been played for more than 30 days are deleted from the system, so check back daily to keep the game going. 

I don't own the copywrite for this title, that belongs to Metropolis Gameport.  Legend of the Red Dragon was created by Seth Robinson. 

+ [Understood] -> connect

== enter_realm
# {"location": "character_select"}
<EnterRealm>

{
    - character_name:
    + [Connect as {character_name}] -> start_the_day
    - else:
    + [Create a Character] -> character_create
} 


== player_list
# {"location": "player_list"}
There are {player_count} subjects of the realm. 

<PlayerTable>

+ [Continue] -> connect

=== character_create === 
# {"location": "character_create"}
-> alias

== alias
What would you like as an alias? 

<PlayerAlias>

+ [Finished] -> alias_confirm

== alias_confirm
That's {character_name}, is that right? 

+ [Correct] -> character_select_class
+ [No, that's wrong] -> alias 

== character_select_class 

As you remember your childhood, you recall...

+ [Killing a lot of woodland creatures] -> character_warrior_select
+ [Dabbling in the mystical arts] -> character_mage_select
+ [Lying, Cheating, And stealing from the blind] -> character_thief_select

== character_warrior_select
Now that you've grown up, you have decided to study the ways of the Death Knights. All beginners want the power to use their body and weapon as one. To inflict twice the damage with the finess only a warrior of perfect mind can do. 
~ class = "Death Knight"

+ [MORE] -> start_the_day

== character_mage_select
You have always wanted to explain the unexplainable. To understand the powerful forces that rule the earth. To tame the beast that oversees all things. Of course, having the power to burn someone by making a gesture wouldn't hurt...
~ class = "Mystical Arts"

+ [MORE] -> start_the_day

== character_thief_select
You have always wanted one thing, and one thing alone: filthy lucre, by any means necessary.  A good blade settles all debts, and the quicker you make an escape the longer you live. 
~ class = "Thievery"

+ [MORE] -> start_the_day 


=== start_the_day === 
# {"location": "start_the_day"}
For being a {class} student, you receive an extra skill usage for today!

You are in {spirits} spirits today. 

You wake up early, strap your {weapon_name} to your back, put on your {armor_name} and head out to the town square, seeking adventure, fame, and honor.

// note -- figure out how to handle if a character is dead or not when they log in. 

+ [MORE] -> start_the_day.character_info

= character_info
# {"location": "character_info"}
<CharacterSheet>
+ [MORE] -> start_the_day.news_today

= news_today 
# {"location": "news_today"}
<DailyNews> 

+ [MORE] -> town_square.index

=== town_square ===
# {"location": "town_square"}
-> town_square.index

= index 
<TownSquare>
+ [Forest] -> forest.index
+ [King Arthur's Weapons] -> weapon_shop.index
+ [Healer's Hut] -> healer.index
+ [Inn] -> inn.index
+ [Ye Olde Bank] -> bank.index
+ [People Online] -> online_players
+ [Slaughter Other Players] -> slaughter.index
+ [Abduls Armor] -> armor_shop.index
+ [View your status] -> character_sheet
+ [Turgeons Warrior Training] -> trainer.index
+ [Daily News] -> daily_news
+ [Quit to Fields] -> fields.index

=== forest === 
# {"location": "forest"}

-> forest.index 
= index 
<ForestIndex>
You enter the murky dark wood outside of town. A giant maw of gloomy darkness ever beckoning. 

What do you want to do?

+ [Look for something to kill] -> forest.search_for_encounter
+ [Healer's Hut] -> healer.index
+ [Return to Town] -> town_square.index


= search_for_encounter
{ 
    - forest_fights == 0: Your bones ache and your muscles are sore. Perhaps tomorrow. 
    + [Continue] -> forest.index
}
~ temp dice_roll = RANDOM(1, 100)
{ 
    - dice_roll >= 95: -> fairy
    - dice_roll >= 90: -> bag_of_gold
    - dice_roll >= 85: -> free_gem
    - dice_roll >= 80: -> ugly_stick
    - dice_roll >= 75: -> old_hag
    - dice_roll >= 70: -> rescue
    - else: -> fight
}


= free_gem
# {"encounter": "free_gem"}
::THUD::

You stumble upon a stone and land face first into the muck. 
As you begin to lift yourself from the forest floor, you see a glint of light coming from the base of a nearby tree. 
~ gems = gems + 1
+ [More] Upon closer inspection, it's a Gem! Score!
++ [Continue] -> forest.index
    

= fairy
# {"encounter": "fairy"}
You feel as though the forest has decided to cease the endless racket of rustling and noises as you come to a particularly thick wall of trees.
~ temp dice_roll = RANDOM(0, 100)
+ [Approach the Thicket] You approach, your {weapon_name} at the ready, prepared to battle whatever lies beyond 
    ++ [Enter the Thicket] You move eyond the threshold of the thicket where you find a group of Fairies bathing in a small pond! 
        {
        - has_fairy: + [Leave them be] As you enter the Thicket, the fairy in your pocket begins to buzz. Better leave them be. 
            ++ [Continue] -> forest.index
        }
        +++ [Attempt to catch one] 
        
        {
            - dice_roll >= 80: You snatch an empty canteen from your pack and lurk up behind one of the Fairies.
                + [Steady...] With a swift swipe you CAPTURE one of the fairies and quickly cork the bottle. Ha! Got 'em!
                ~ has_fairy = true
                    ++ [Continue] -> forest.index
            - else: You snatch an empty canteen from your pack and lurk up behind one of the Fairies. 
                + [Continue] They immediately notice you! The group scatters as you swipe to capture one and instead grab a spiked vine, which rips open a tear in your hand. 
                    Your health is reduced to 1!
                    ~ hitpoints = 1
                    ++ [Continue] -> forest.index
        }
        +++ [Ask for a blessing] You startle them when you say "Hi. Sorry to interrupt--" the fairies cut you off. You feel a tingle course through your body as they flutter off into the woods. 
            ~ spirits = "high"
            You feel as if you could take on the world!
            ~gems = gems + 10
            YOU GAIN 10 GEMS!
            ++++ [Continue] -> forest.index
            
        +++ [Leave them be] -> forest.index

= bag_of_gold
# {"encounter": "bag_of_gold"}
~ temp dice_roll = RANDOM((100 / rank*2), (1000 / rank * rank))
~ gold = gold + dice_roll
You come upon a clearing in the forest. 
+ [Look around the clearing] You notice a small mound of dirt. Digging into it, you find a bag of gold containing {dice_roll} gold pieces! 
    ++ [Well that's lucky. Continue] -> forest.index


= ugly_stick
# {"encounter": "ugly_stick"}
As you cross a path with an old man, you exchange a polite node. As he passes beyond you, he whacks you with a stick! 
~ temp dice_roll = RANDOM(0, 1)
{ 
    - dice_roll == 1: 
        + [Ow!] You feel less like yourself. 
        ~ charm = charm - 1
        ++ [Continue] -> forest.index
    - else: 
        + [What the...] You feel cute, for some reason?
        ~ charm = charm + 1
            ++ [Continue] -> forest.index
}


= old_hag
# {"encounter": "old_hag"}
You arrive at a fork in the road -- an old woman catches your attention as you approach. 
"If you give me a Gem, i'll grant you one wish!" she says. 

What do you do?
+ [Give her a Gem] You give her a Gem.  "Well well, this will do nicely!"
    ~ hitpoints_max = hitpoints_max + 1
    ~ hitpoints = hitpoints_max
    ~ gems = gems - 1
    ++ [Continue] Your muscles bulge! You feel vigorous and healthy. Increased total hit points by 1!
        +++ [Continue] -> forest.index
+ [No way!] You decide to leave the old woman behind, refusing her offer. "You'll regret this!" she screams.
    ++ [Continue] -> forest.index


= rescue
# {"encounter": "rescue"}
You stumble.

This would normally not be notable, since this happens to you quite often - but what is interesting is WHAT you stumbled over.
The object in question is a large dead bird. 
+ [Investigate the dead bird] The bird has a small scroll carefully tied to one leg. 
    ++ [Continue] The scroll reads: 
    To whom it may concern: 
    
    Geez, I am bored. I've been locked in the highest peak of this castle for as long as I can remember. Crikey, I would explain why, but I'm running out of ink.  You see, I've been up here for such a long time, it's drying up. Well, what do you know? I guess i have enough to explain after all! Isn't that a lucky break? Okay, I'm up here because I wa--
    
    The note trails off. It isn't signed. 
    +++ [Continue] You quickly wipe a singular tear from your cheek as you put down the note. 
        ++++ [Save Her] -> attempt_to_save
        ++++ [Ignore them] You decide it's better off to let -- erm -- sleeping birds lay. 
            +++++ [Continue] -> forest.index
        
= attempt_to_save
# {"encounter": "rescue"}
You're quite the hero! Unfortunately, You have no idea where the woman could be. You'll have to make a guess. Where to?
~ temp actual_location = "{~castle|fortress|keep|lair}"
+ (castle) [Castle Coldrake] -> save_resolve(castle, actual_location)
+ (fortress) [Fortress Liddux] -> save_resolve(fortress, actual_location)
+ (keep) [Gannon Keep] -> save_resolve(keep, actual_location)
+ (lair) [Dema's Lair] -> save_resolve(lair, actual_location)

= save_resolve(location, actual_location)
# {"encounter": "rescue"}
{ 
 - location == actual_location: You head resolutely toward {location}. 
    + [Continue] You arrive at {location}, brandishing {weapon_name} at anyone who looks at you the wrong way. 
        ++ [Search the Castle] You hack and slash your way through the guards up and through the {location} until you come upon a locked door.  Smashing it with your shoulder, a maiden awaits!
            +++ [Offer your hand] "Come with me!" you say, reaching out a hand to the fair maiden. She looks at you and squeals "You found my note!"
            ++++ [Escape the {location}] As you make your escape, the maiden offers you a reward
                    YOU RECEIVE 10 GEMS!
                    ~ gems = gems + 10
                    +++++ [Continue] -> forest.index 
                    
 - else: You head resolutely for {location}.  When you arrive, you grip your {weapon_name} with fortitude as you hack and slash your way through the {location}. 
    + [Continue] As you make your way up to the tallest spire, you smash open the door and look inside. 
        ++ [Continue] A confused monk stares back at you, oblivious the violence outside.  "Can I help you?" they ask, confounded by the interruption. 
        +++ [Continue] Meekly, you look around at the havoc you have caused and attempt to escape before reinforcements arrive. 
        ++++ [Continue] -> forest.index
    
}


= fight
# {"encounter": "forest_fight"}
<ForestFight>

+ [Your Command?] -> fight


= fight_resolution
{forest_encounter_death_rattle}
You gain {forest_encounter_experience_points}! 
~ experience_points = experience_points + forest_encounter_experience_points
You collect {forest_encounter_gold} from {forest_encounter_mob_name}'s corpse.
~ gold = gold + forest_encounter_gold
~ temp gemRoll = RANDOM(1, 10)
{
    - gemRoll > 80: 
    ~ temp found_gems = (gemRoll * rank / 10)
    ~ gems = gems + found_gems
    You find {found_gems}!
}

+ [Continue] -> forest.index

=== trainer === 
# location: trainer
-> index

= index 
You enter the mighty Training Center. Hundreds of warriors, young, as well as old, are sparring. Every few seconds you hear someone shriek in pain. Obviously some novice who let his guard down. 

+ [Question Trainer] -> question 
+ [Challenge Trainer] -> challenge
+ [Return to town] -> town_square

= challenge 
You challenge your trainer to a duel. 

They laugh. "You stand no chance, you fool. Come back when you are stronger."

+ [Continue] -> index

= question
// which trainer for which rank? 

Your trainer looks at you carefully. 
"You need about 100 experience before you will be as good as I am."
+ [MORE] -> index 


=== weapon_shop === 
= index 
You walk into the well known weapons shop, you pause to look around at all of the many implements of destruction. A fat man woddles into the room, and asks "Wadaya want, kid?" 

+ [Buy Weapon] -> buy_new_weapon
+ [Sell Weapon] -> sell_current_weapon
+ [Return to Town] -> town_square

= buy_new_weapon 
+ [Continue] -> index

= sell_current_weapon
+ [Continue] -> index

=== armor_shop ===
-> index
= index 
Behind the desk of the armor shop is a bright and cheerful clerk. As you walk forward, they ask "How may I be of service?" 

+ [View available armor] -> buy_new_armor
+ [Sell your armor] -> sell_current_armor
+ [Return to Town] -> town_square

= buy_new_armor
+ [Continue] -> index

= sell_current_armor
+ [Continue] -> index

=== healer ===
-> index 
= index
"Welcome" shouts the healer, surrounded by myriad charms, herbs, and potions. 

+ [Heal your wounds] -> heal_all
+ [Return to Town] -> town_square

= heal_all 
Your wounds are healed! The healer accepts a donation of 10 gold peices. 
+ [Continue] -> index

=== inn ===
-> index

= index 
You enter the inn and are immediately hailed by several of the patrons. You respond with a wave and scan the room. It is filled with smoke from the torches that line the walls. Oaken tables and chairs are scattered across the room. You smile as Violet brushes by you... 

+ [Converse with the patrons] -> converse
+ [Flirt With Violet] -> flirt_with_violet
+ [Get a room] -> get_room
+ [Listen to the Bard] -> hear_bard
+ [Talk to the Bartender] -> bartender
+ [Return to Town] -> town_square 

= converse
+ [Continue] -> index

= flirt_with_violet
+ [Continue] -> index

= get_room
+ [Continue] -> index

= hear_bard
Seth Able eyes you as you sit down next to him. 
+ [Ask Seth Able to Sing] (Seth clears his throat) {character_name} was a {class}, yadda yadda, my throat hurts. -> index

+ [Return to the bar] -> index 


= bartender
// check reputation level on if the tender will chat 

I don't recall ever hearing the name {character_name} before! get outta my face! 
+ [Continue] -> index
// bribe, gems, violet, name change, return to bar 

=== bank ===
-> index 
= index
A polite clerk approaches. "Can I help you?"

+ [Deposit Gold] -> deposit
+ [Withdraw Gold] -> withdraw
+ [Transfer Gold] -> transfer
+ [Return to Town] -> town_square 

= deposit 
How much gold would you like to deposit?
<DepositGold>

+ [Continue] -> index

= withdraw 
How much gold would you like to withdraw?
<WithdrawGold> 

+ [Continue] -> index

= transfer
Who should we send the gold to? 
<TransferGold> 

+ [Continue] -> index

=== online_players === 
<PlayerList> 
+ [MORE] -> town_square

=== slaughter === 
-> index
= index 
You scan the war field for potential victims.  
+ [List Warriors in the Fields] -> list_warriors
+ [Slaughter someone] -> slaughter_someone
+ [Return to Town] -> town_square 

= list_warriors
<AttackablePlayers>

+ [Slaughter someone] -> slaughter_someone
+ [Return to Town] -> town_square 

= slaughter_someone 
<SlaughterSearch>
+ [Continue] -> index
+ [Return to Town] -> town_square 

= slaughter_fight
<PlayerFight> 

+ [Continue] -> slaughter.index
=== character_sheet ===
<CharacterSheet> 

+ [Continue] -> town_square

=== daily_news === 
<DailyNews> 

+ [Continue] -> town_square

=== fields === 
-> index
= index
You find a shady spot to rest your weapons, and drift off to sleep. 
<Disconnect>
-> END 


