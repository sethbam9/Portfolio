
# Function to quickly initialize a dictionary.
# Use: dict := makeDict(list(key, value, key, value, ...)))
makeDict := method(items,
    dict := Map clone;
    key := 0;
    value := 0;
    for(i, 0, items size - 1,
        if(i isEven,
            key = items at(i),
            value = items at(i);
            dict atPut(key, value)
        )
    )
    return dict
)


# Function to generate a formatting string for a given length.
# makeSeq("*", 3) --> "***"
makeSeq := method(char, len,
    seq := char;
    i := 1;
    while (len > i, 
        seq = seq .. char;
        i = i + 1
    )
    return seq
)


Animal := Object clone
Animal name := ""
Animal description := ""
Animal full_health := 0
Animal health := 0
Animal health_bar := makeSeq("#", 25)
Animal full_energy := 100
Animal energy := Animal full_energy
Animal stealth := 0
Animal full_accuracy := 0
Animal accuracy := 100
Animal damage := 0
Animal attacks := Map clone

# Data assignments
rank := makeDict(
  list(
    "A", makeDict(
      list(
        "health", 100,
        "damage", 100,
        "energy", 100)),
    "B", makeDict(
      list(
        "health", 200,
        "damage", 150,
        "energy", 125)),
    "C", makeDict(
      list(
        "health", 300,
        "damage", 200,
        "energy", 150))
  )
)

stats := makeDict(
  list(
    "damage", makeDict(
      list(
        "lion", rank at("A") at("damage"),
        "monkey", rank at("A") at("damage"),
        "hippo", rank at("A") at("damage"),
        "wolf", rank at("A") at("damage"),
        "rhino", rank at("A") at("damage"),
        "grizzly", rank at("A") at("damage"),
        "elephant", rank at("A") at("damage"),
        "eagle", rank at("A") at("damage"),
        "ostrich", rank at("A") at("damage"),
        "cobra", rank at("A") at("damage"),
        "crocodile", rank at("A") at("damage"),
        "python", rank at("A") at("damage"))),
    "health", makeDict(
      list(
        "lion", (rank at("A") at("health") / 2) ceil,
        "monkey", (rank at("A") at("health") / 2) ceil,
        "hippo", (rank at("A") at("health") / 2) ceil,
        "wolf", (rank at("A") at("health") / 2) ceil,
        "rhino", (rank at("A") at("health") / 2) ceil,
        "grizzly", (rank at("A") at("health") / 2) ceil,
        "elephant", (rank at("A") at("health") / 2) ceil,
        "eagle", (rank at("A") at("health") / 2) ceil,
        "ostrich", (rank at("A") at("health") / 2) ceil,
        "cobra", (rank at("A") at("health") / 2) ceil,
        "crocodile", (rank at("A") at("health") / 2) ceil,
        "python", (rank at("A") at("health") / 2) ceil)),
    "stealth", makeDict(
      list(
        "lion", 15,
        "monkey", 2,
        "hippo", 30,
        "wolf", 10,
        "rhino", 25,
        "grizzly", 20,
        "elephant", 30,
        "eagle", 8,
        "ostrich", 20,
        "cobra", 10,
        "crocodile", 25,
        "python", 15)),
    "accuracy", makeDict(
      list(
        "lion", 90,
        "monkey", 95,
        "hippo", 75,
        "wolf", 85,
        "rhino", 80,
        "grizzly", 80,
        "elephant", 75,
        "eagle", 95,
        "ostrich", 85,
        "cobra", 90,
        "crocodile", 75,
        "python", 85))
  )
)
        

Mammal := Animal clone
Mammal description = "Warm blooded animal that has hair or fur."

Bird := Animal clone

Reptile := Animal clone

lion := Mammal clone
lion name = "lion"
lion description = "A large cat with deadly claws and teeth."
lion full_health = stats at("health") at("lion")
lion health = lion full_health
lion damage = stats at("damage") at("lion")
lion full_accuracy = stats at("accuracy") at("lion")
lion accuracy = lion full_accuracy
lion stealth = stats at("stealth") at("lion")
lion attacks = makeDict(
  list(
    "bite", makeDict(list("damage", (lion damage / 5) ceil, "energy", 30)),
    "shred", makeDict(list("damage", (lion damage / 3) ceil, "energy", 50)),
    "roar", makeDict(list("damage", (lion damage / 10) ceil, "energy", 10)),
    "rest", makeDict(list("heal", (lion full_health / 7) ceil, "energy", (lion full_energy / 3) ceil))
  )
)

monkey := Mammal clone
monkey name = "monkey"
monkey description = "A small and quick primate that can dodge larger prey."
monkey full_health = stats at("health") at("monkey")
monkey health = monkey full_health
monkey damage = stats at("damage") at("monkey")
monkey full_accuracy = stats at("accuracy") at("monkey")
monkey accuracy = monkey full_accuracy
monkey stealth = stats at("stealth") at("monkey")
monkey attacks = makeDict(
  list(
    "choke", makeDict(list("damage", (monkey damage / 2) ceil, "energy", 50)),
    "gouge eyes", makeDict(list("damage", (monkey damage / 4) ceil, "energy", 40)),
    "bite", makeDict(list("damage", (monkey damage / 5) ceil, "energy", 10)),
    "rest", makeDict(list("heal", (monkey full_health / 7) ceil, "energy", (monkey full_energy / 3) ceil))
  )
)

hippo := Mammal clone
hippo name = "hippo"
hippo description = "A heafty water-loving animal. Don't get caught underneath of it."
hippo full_health = stats at("health") at("hippo")
hippo health = hippo full_health
hippo damage = stats at("damage") at("hippo")
hippo full_accuracy = stats at("accuracy") at("hippo")
hippo accuracy = hippo full_accuracy
hippo stealth = stats at("stealth") at("hippo")
hippo attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (hippo damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (hippo damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (hippo damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (hippo full_health / 7) ceil, "energy", (hippo full_energy / 3) ceil))
  )
)

wolf := Mammal clone
wolf name = "wolf"
wolf description = "A large dog-like animal whose fangs can tear apart flesh."
wolf full_health = stats at("health") at("wolf")
wolf health = wolf full_health
wolf damage = stats at("damage") at("wolf")
wolf full_accuracy = stats at("accuracy") at("wolf")
wolf accuracy = wolf full_accuracy
wolf stealth = stats at("stealth") at("wolf")
wolf attacks = makeDict(
  list(
    "bite", makeDict(list("damage", (wolf damage / 5) ceil, "energy", 20)),
    "pounce", makeDict(list("damage", (wolf damage / 4) ceil, "energy", 40)),
    "tear", makeDict(list("damage", (wolf damage / 4.5) ceil, "energy", 25)),
    "furry of the pack", makeDict(list("damage", (wolf damage / 1.5) ceil, "energy", 100)),
    "rest", makeDict(list("heal", (wolf full_health / 7) ceil, "energy", (wolf full_energy / 3) ceil))
  )
)

rhino := Mammal clone
rhino name = "rhino"
rhino description = "A heafty water-loving animal. Don't get caught underneath of it."
rhino full_health = stats at("health") at("rhino")
rhino health = hippo full_health
rhino damage = stats at("damage") at("rhino")
rhino full_accuracy = stats at("accuracy") at("rhino")
rhino accuracy = hippo full_accuracy
rhino stealth = stats at("stealth") at("rhino")
rhino attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (rhino damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (rhino damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (rhino damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (rhino full_health / 7) ceil, "energy", (rhino full_energy / 3) ceil))
  )
)

grizzly := Mammal clone
grizzly name = "grizzly"
grizzly description = "A heafty water-loving animal. Don't get caught underneath of it."
grizzly full_health = stats at("health") at("grizzly")
grizzly health = grizzly full_health
grizzly damage = stats at("damage") at("grizzly")
grizzly full_accuracy = stats at("accuracy") at("grizzly")
grizzly accuracy = grizzly full_accuracy
grizzly stealth = stats at("stealth") at("grizzly")
grizzly attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (grizzly damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (grizzly damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (grizzly damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (grizzly full_health / 7) ceil, "energy", (grizzly full_energy / 3) ceil))
  )
)

elephant := Mammal clone
elephant name = "elephant"
elephant description = "A heafty water-loving animal. Don't get caught underneath of it."
elephant full_health = stats at("health") at("elephant")
elephant health = elephant full_health
elephant damage = stats at("damage") at("elephant")
elephant full_accuracy = stats at("accuracy") at("elephant")
elephant accuracy = elephant full_accuracy
elephant stealth = stats at("stealth") at("elephant")
elephant attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (elephant damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (elephant damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (elephant damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (elephant full_health / 7) ceil, "energy", (elephant full_energy / 3) ceil))
  )
)

eagle := Bird clone
eagle name = "eagle"
eagle description = "A heafty water-loving animal. Don't get caught underneath of it."
eagle full_health = stats at("health") at("eagle")
eagle health = eagle full_health
eagle damage = stats at("damage") at("eagle")
eagle full_accuracy = stats at("accuracy") at("eagle")
eagle accuracy = eagle full_accuracy
eagle stealth = stats at("stealth") at("eagle")
eagle attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (eagle damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (eagle damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (eagle damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (eagle full_health / 7) ceil, "energy", (eagle full_energy / 3) ceil))
  )
)

ostrich := Bird clone
ostrich name = "ostrich"
ostrich description = "A heafty water-loving animal. Don't get caught underneath of it."
ostrich full_health = stats at("health") at("ostrich")
ostrich health = ostrich full_health
ostrich damage = stats at("damage") at("ostrich")
ostrich full_accuracy = stats at("accuracy") at("ostrich")
ostrich accuracy = ostrich full_accuracy
ostrich stealth = stats at("stealth") at("ostrich")
ostrich attacks = makeDict(
  list(
    "chomp", makeDict(list("damage", (ostrich damage / 5) ceil, "energy", 20)),
    "trample", makeDict(list("damage", (ostrich damage / 3.5) ceil, "energy", 40)),
    "drown", makeDict(list("damage", (ostrich damage / 2) ceil, "energy", 70)),
    "rest", makeDict(list("heal", (ostrich full_health / 7) ceil, "energy", (ostrich full_energy / 3) ceil))
  )
)

all_animals := makeDict(
  list(
    "lion", lion,
    "monkey", monkey,
    "hippo", hippo,
    "wolf", wolf,
    "rhino", rhino,
    "grizzly bear", grizzly,
    "elephant", elephant,
    "eagle", eagle,
    "ostrich", ostrich
    # "cobra", cobra,
    # "crocodile", crocodile,
    # "python", python)
))


