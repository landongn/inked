VAR character_name = ""
VAR class = ""
VAR player_count = 0
VAR weapon_name = "Stick"
VAR armor_name = "Coat"
VAR spirits = ""
VAR experience_points = 0
VAR gold = 0
VAR reputation = 0
VAR beauty = 0
VAR skill_uses = 0
VAR rank = 0
VAR attack_power = 1
VAR armor_class = 1
VAR hitpoints = 30
VAR hitpoints_max = 30
VAR gems = 0
VAR master = ""
VAR is_alive = true
VAR forest_fights = 100
VAR last_location = ""



-> connect 

=== connect ===
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
<EnterRealm>

{
    - character_name && character_class:
    + [Connect as {character_name}] -> start_the_day
    - else:
    + [Create a Character] -> character_create
} 


== player_list
There are {player_count} subjects of the realm. 

<PlayerTable>

+ [Continue] -> connect

=== character_create === 

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
For being a {class} student, you receive an extra skill usage for today!

You are in {spirits} spirits today. 

You wake up early, strap your {weapon_name} to your back, put on your {armor_name} and head out to the town square, seeking adventure, fame, and honor.

+ [MORE] -> start_the_day.character_info

= character_info
<CharacterSheet>
+ [MORE] -> start_the_day.news_today

= news_today 
The Daily Happenings... 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
<DailyNews> 

+ [MORE] -> town_square.index

=== town_square ===
-> town_square.index

= index 

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
-> forest.index 
= index 
You enter the murky dark wood outside of town. A giant maw of gloomy darkness ever beckoning. 

What do you want to do?
+ [Look for something to kill] -> forest.search_for_encounter
+ [Healer's Hut] -> healer.index
+ [Return to Town] -> town_square.index


= search_for_encounter
// randomize somehow? 
-> forest.index

= fight
<ForestFight>

+ [Continue] -> forest.index


=== trainer === 
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


