# Run in the terminal:
# io "C:\Users\sethb\OneDrive\Desktop\Sattler College\6. Spring 2021\CS 303 Programming Languages\Io language\animals.io"

Random #include lib to use List anyOne

file := "Dekstop/io/animals.io"
doFile(file)

# Variables
wtime := 0.5
round := 1
oppoonent_n := 1 #opponent number
sp := " " # space to go before print statements for formatting. 
clear_page := makeSeq("\n", 30)


# METHODS

# Regenerate the animal's health by a_added.
regenH := method(animal, h_added,
    animal health = (animal health + h_added) ceil;
    if (animal health > animal full_health,
        animal health = animal full_health
    )
)


# Regenerate the animal's energy by e_added.
regenE := method(animal, e_added,
    regen := (animal energy + e_added) ceil;
    animal energy = regen;
    if (animal energy > animal full_energy,
        animal energy = animal full_energy
    )
    return regen
)


# Subtract the attack cost from the attacker's energy.
useEnergy := method(attacker, attack_type,
    attacker energy = attacker energy - attacker attacks at(attack_type) at("energy")
)


# Update the animal's HP bar.
hpBar := method(animal,
    hp_size := ((animal health / animal full_health) * Animal health_bar size) ceil;
    animal health_bar = Animal health_bar inclusiveSlice(0, hp_size - 1);
    return animal health_bar
)


# Update the player's energy levels and the attacked animal's health.
# the 'player' arg is used as an id.
attack := method(attacker, attacked, player, attack_type,
    # Dynamic print values.
    name := "You";
    the_attacker := "your";
    # The attacked animal has a (1 / stealth) chance of dodging the attack.
    dodge := Random value(0, attacked stealth * (attacker accuracy / 100)) ceil;
    rest := false; # By default the attack_type is not rest.
    if (attack_type == "rest", rest = true);

    # Update the print values according to who is attacking. 
    if (attacker name != player name, 
      name = "The " .. attacker name;
      the_attacker = "the " .. attacker name .. "'s"
    )

    if (attack_type == false, #(A)
       
        # Then (A): 
        # the attacker forfeits its turn and regains energy.
        e_pre := attacker energy;
        regen := regenE(attacker, attacker full_energy / 3);
        if (regen > attacker full_energy, regen = attacker full_energy - e_pre);
        writeln("\n", sp, "#{name} regained #{regen} energy." interpolate),
       
        # Else (A): 
        # the attacker performs its attack.
        if (dodge == 1 and rest == false, #(B)
            
            # Then (B):
            # if the attack was dodged, print accordingly and update attacker energy.
            if (attacked name == player name, #(C1)
                # Then (C1):
                writeln(sp, name, " chose ", attack_type, "...");
                name = "You",
                # Else (C1): 
                name = "The " .. attacked name;
            )
            writeln("\n", sp, "#{name} dodged #{the_attacker} attack!" interpolate);
            useEnergy(attacker, attack_type), 
           
            # Else (B): 
            # if the attack wasn't dodged:
            if (rest == false, #(C2)
                
                # Then (C2): 
                # update the attacked animal's health and the attacker's energy.
                attacked health = attacked health - attacker attacks at(attack_type) at("damage");
                # Print the attack results.
                if (name == "You", #(D1)
                    # Then (D1):
                    writeln("\n", sp, "You have dealt the ", attacked name, " ", attacker attacks at(attack_type) at("damage"), " damage."),
                    # Else (D1):
                    writeln(sp, name, " chose ", attack_type, ", dealing ", attacker attacks at(attack_type) at("damage"), " damage.")
                )
                # If the attack was gouge eyes then blind the attacked. 
                if (attack_type == "gouge eyes", wait(1); writeln("\n", sp, "The ", attacked name, " has been blinded!"); attacked accuracy = 55);
                useEnergy(attacker, attack_type),
                
                # Else (C2):
                # if attack_type == rest, regenerate the attacker's health and energy.
                h_plus := attacker attacks at("rest") at("heal");
                h_pre := attacker health;
                e_plus := attacker attacks at("rest") at("energy");
                e_pre := attacker energy;
                regenH(attacker, h_plus);
                if (h_plus + h_pre > attacker full_health, h_plus = attacker full_health - h_pre);
                regenE(attacker, e_plus);
                if(e_plus + e_pre > attacker full_energy, e_plus = attacker full_energy - e_pre);
                # Print the rest results.
                if (name == "You", 
                    # Then (D2):
                    writeln("\n", sp, "You have rested, gaining ", h_plus, " health and ", e_plus, " energy."),
                    # Else (D2):
                    writeln(sp, name, " has rested, gaining ", h_plus, " health and ", e_plus, " energy.")
                )
            )
        )
    )

    if (attacked health < 0, attacked health = 0);
    if (rest == false, regenE(attacker, attacker energy / 10))
)


# Returns a list of the attacks that the animal has enough energy for,
# otherwise returns false.
enoughEnergy := method(animal, player, 
    # Initiate lists of sequences containing only attacks.
    attacks := animal attacks keys remove("rest");
    temp_list := animal attacks keys remove("rest");
    # Check if animal is the opponent.
    opponent := false;
    if (animal name != player name, opponent = true);

    # Remove attacks that cost more energy than the animal currently has.
    temp_list foreach(attack,
        if (animal attacks at(attack) at("energy") > animal energy,
          attacks remove(attack);
        )
    )
    # If the list isn't empty, re-add rest as one of the animal's options.
    if (attacks size == 0, 
        # Then:
        return false, 
        # Else: 
        # Don't return rest if the animal is at full health/energy.
        if (opponent == true and animal health == animal full_health and animal energy == animal full_energy,
            return attacks;
        )
        return attacks push("rest")
    )
)



# Print out data for the player's animal and the opponent animal
displayData := method(animalA, animalB,
    id_A := "Player";
    id_B := "Opponent";

    line_A := makeSeq("-", id_A size);
    line_B := makeSeq("-", id_B size);

    w := "|"; # Wall tipe
    e := "_"; # Edge type

    box_S := Animal health_bar size + 3; # Size
    box_L := w .. " "; # Left
    box_M := w .. " "; # Middle
    box_R := w .. "\n"; # Right
    box_T := " " .. makeSeq(e, (box_S * 2) - 1); # Top
    box_PT := w .. makeSeq(" ", box_S - 1) .. w .. makeSeq(" ", box_S - 1) .. w; # Padding top
    box_B := w .. makeSeq(e, box_S - 1) .. w .. makeSeq(e, box_S - 1) .. w; # Bbottom.
    
    # A function to calculate the space between Animal content and the right edge.
    get_spacing := method(sequence,
        return makeSeq(" ", box_S - sequence size)
    )

    # Display formatting, a dictionary where each key is a row in the data table.
    df := makeDict(
        list(
          "id", makeDict(
            list(
              "l", box_L .. id_A,
              "r", box_M .. id_B)),
          "line", makeDict(
            list(
              "l", box_L .. line_A,
              "r", box_M .. line_B)),
          "name", makeDict(
            list(
              "l", box_L .. animalA name asCapitalized,
              "r", box_M .. animalB name asCapitalized)),
          "energy", makeDict(
            list(
              "l", box_L .. "Energy: " .. animalA energy,
              "r", box_M .. "Energy: " .. animalB energy)),
          "health", makeDict(
            list(
              "l", box_L .. "Health: " .. animalA health,
              "r", box_M .. "Health: " .. animalB health)),
          "hbar", makeDict(
            list(
              "l", box_L .. hpBar(animalA),
              "r", box_M .. hpBar(animalB)))
        )
    )

    # Output a box with data about the two animals doing battle.
    n := "\n";
    writeln(
        # Upper edge.
        box_T, n,
        # Blank line.
        box_PT, n,
        # Animal IDs (player and opponent).
        df at("id") at("l"), get_spacing(df at("id") at("l")), 
            df at("id") at("r"), get_spacing(df at("id") at("r")), box_R,
        # Line underneath the ID.
        df at("line") at("l"), get_spacing(df at("line") at("l")), 
            df at("line") at("r"), get_spacing(df at("line") at("r")), box_R,
        # Animal names.
        df at("name") at("l"), get_spacing(df at("name") at("l")), 
            df at("name") at("r"), get_spacing(df at("name") at("r")), box_R,
        # Animal energy level.
        df at("energy") at("l"), get_spacing(df at("energy") at("l")), 
            df at("energy") at("r"), get_spacing(df at("energy") at("r")), box_R,
        # Aninaml health level.
        df at("health") at("l"), get_spacing(df at("health") at("l")), 
            df at("health") at("r"), get_spacing(df at("health") at("r")), box_R,
        # Animal health level as hashtag bar.
        df at("hbar") at("l"), get_spacing(df at("hbar") at("l")), 
            df at("hbar") at("r"), get_spacing(df at("hbar") at("r")), box_R,
        # Lower edge.
        box_B, n
    )
)


# Allow the player to choose an attack, 
# return false if the player doesn't have enough energy.
chooseAttack := method(animal, 
    # Attacks box formatting content
    title := "Attacks";
    line := makeSeq("-", title size);
    s := 18; # local space

    writeln(sp, title, "\n", sp, line);

    attacks := animal attacks keys remove("rest");

    # Print out a box that contains each attack with its damage and energy cost
    attacks foreach(attack,
        # Spacing after the attack name
        spaceA := makeSeq(" ", s - attack size);
        spaceB := makeSeq(" ", 4 - animal attacks at(attack) at("damage") asString size);
        writeln(
            # Left: the attack name
            sp, attack asCapitalized, spaceA,
            # Center: the attack damage
            "| ", animal attacks at(attack) at("damage"), " damage", spaceB,
            # Right: the attack energy cost
            " | - ", animal attacks at(attack) at("energy"), " energy" 
        )
    )
    # Print out a final line with the 'rest' data.
    spaceA := makeSeq(" ", s - "rest" size);
    spaceB := makeSeq(" ", 4 - animal attacks at("rest") at("heal") asString size);
    writeln(
        sp, "Rest", spaceA,
        "| ", animal attacks at("rest") at("heal"), " health", spaceB,
        " | + ", animal attacks at("rest") at("energy"), " energy" 
    )

    # Return false if the animal doesn't have enough energy to attack.
    if (enoughEnergy(animal, animal) == false, 
        writeln("\n", sp, "You do not have enough energy to attack.\n\n", sp, "Turn end.");
        wait(wtime + 1);
        return false
    )

    # Get user input as 'player_attack'
    while(true, 
        # Ask the player for his/her attack
        player_attack := File standardInput readLine("\n" .. sp .. "Your attack: ") lowercase;
        # Ensure that the input matches the available attacks list.
        if (animal attacks keys contains(player_attack) == false, #(A)
            # Then (A):
            writeln(sp, "Not a valid input."),
            # Else (A):
            # check if the player has enough energy for their attack choice.
            if (animal attacks at(player_attack) at("energy") > animal energy and player_attack != "rest", #(B)
                # Then (B):
                # if player_attack energy cost > the animal's current energy, return to the while
                writeln("\n", sp, "You do not have enough energy to #{player_attack}." interpolate),
                # Else (B):
                break
            )
        )
    )

  return player_attack
)


# battle consists of 1 round of the game where the player,
  # attacks and then the opponent attacks.
# The round ends if the player defeats the opponent. 
battle := method(player, opponent,
    id := player;

    # Print out the box with both animals data.
    displayData(player, opponent)
    
    # Have the player choose their attack and perform it.
    attack(player, opponent, id, chooseAttack(player));  
    wait(wtime + 1);

    # Make sure the opponent isn't dead before proceeding:
    if (opponent health == 0, 
        # Then: return 'W', the player has won this round.
        break("W"),
        # Else: move on the the opponent's attack.
        writeln(sp, "#{clear_page .. sp}The #{opponent name}'s attack." interpolate)
    )
    
    displayData(player, opponent);
    wait(wtime);

    # Ensure that the opponent has enough energy to attack.
    if (enoughEnergy(opponent, id) == false,
       
        # Then:
        # if it doesn't have enough energy, inform the player and pass in: attack = false
        writeln(sp, "The #{opponent name} does not have enough energy to attack." interpolate);
        attack(opponent, player, id, false);
        wait(wtime + 3),
       
        # Else:
        # The opponent attacks the player with a random attack.
        attack(opponent, player, id, enoughEnergy(opponent, id) anyOne);
        wait(wtime + 3);
    )

    writeln(clear_page);
    # Return 'L' for loss if the player has no more health.
    if (player health == 0, break("L"))
)


# A function to see if the player wants to play again.
newGame := method(
    while (true,
        new_game := File standardInput readLine(sp .. "Play again: ") lowercase;
        # Ensure the player's input is valid:
        if (list("yes", "no") contains(new_game) == false,
            # Then:
            writeln(sp, "Not a valid input."),
            # Else:
            # If yes, run the main function from scratch.
            if (new_game == "yes", return main(), return false);
        )
    )
)


# Reset all of the values when the player starts a new game.
resetVals := method(
    round = 1;
    oppoonent_n = 1;

    all_animals keys foreach(animal, 
        species_proto := all_animals at(animal);
        species_proto accuracy = species_proto full_accuracy;
        species_proto health = species_proto full_health;
        species_proto health_bar = Animal health_bar;
        species_proto energy = species_proto full_energy;
        species_proto accuracy = species_proto full_accuracy;
    )
)


# The main function to play the game.
main := method(
    score := 0;
    all_species := all_animals;

    # Welcome the player
    writeln(clear_page, sp, "Welcome to Clash of the Species!\n");
    writeln(sp, "Choose your species:\n");

    # Reset object values when starting a new game. 
    resetVals();

    # Print out all of the species.
    all_species keys foreach(species, 
        writeln(sp, species asCapitalized)
    )
    writeln("");

    # Allow the player to choose their species.
    while (true,
        species_input := File standardInput readLine(sp .. "Your species: ") lowercase;
        # Ensure that the player's input is in the all_species list.
        if (all_species keys contains(species_input) == false,
            # Then:
            writeln(sp, "Not a valid input."),
            # Else:
            break
        )
    )
    writeln("");

    # Assign the player their species and update the list.
    player := all_species at(species_input);
    all_species removeAt(player name);

    # Randomly choose the player's first opponent.
    opponent := all_species values anyOne;

    wait(wtime + 1);
    writeln(clear_page);

    # Battle rounds continue until the player is dead or defeated all opponents.
    while(player health > 0 and all_species size > 0,
        writeln(sp, "Round #{round}: Attack the #{opponent name}." interpolate);
        round = round + 1;

        # Run the battle function and see if the player wins.
        battle_results := battle(player, opponent);

        if (battle_results == "W", 
            
            # Then:
            # Update the player's score and remove the defeated species from the list.
            score = score + 1;
            all_species removeAt(opponent name);
            wait(1);
            # Print the results and assign a new opponent.
            writeln("\n", sp, "You have defeated the ", opponent name, "!\n");
            opponent = all_species values anyOne;
            wait(3);
            writeln(clear_page),

            # Else:
            # If the player lost the battle the game is over.
            if (battle_results == "L",
                writeln("\n\n", sp, "Game Over :(\n");
                wait(1);
                writeln(sp, "You were defeated by the #{opponent name}.\n#{sp}Your final score is #{score}.\n\n" interpolate);
                wait(1);
                writeln(sp, "Enter 'yes' to play again.\n"); 
                # Check if the player would like to play again.
                if (newGame == false, return false)
            )
        )
    )

    # If while loop is over, then the player has won.
    # Print results
    writeln(sp, "Congratulations, you have won the game!\n", sp, "Your final score is ", score, ".\n\n");
    wait(1);
    writeln(sp, "Enter 'yes' to play again.\n");
    if (newGame == false, return false);
)

# Try fullscreen terminal with 36 font. 
main()