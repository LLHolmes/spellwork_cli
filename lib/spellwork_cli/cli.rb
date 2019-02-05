class SpellworkCli::CLI

def start
  puts "Welcome to Spellwork, where you can learn to cast known Harry Potter spells!"
  puts "Types of spells:"
  # list_spell_types
  choose_spell_type
  goodbye
end

def list_spell_types#(spell_types)
  # spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
  # @spell.types = SpellworkCli::Spell.types
  SpellworkCli::Spell.types.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
end

def choose_spell_type
  # spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
  # @spell.types = SpellworkCli::Spell.types
  list_spell_types#(spell_types)
  input = nil
  while input != "exit"
    puts "Enter the number for a selection of specific spells of that kind, \"list\" for the list of types, or \"exit\":"
    input = gets.chomp.downcase
    if input != "exit"
      if input.to_i > 0 && input.to_i <= SpellworkCli::Spell.types.length
        choose_spell("#{SpellworkCli::Spell.types[input.to_i-1]}")
  # DON'T WANT THIS IN A WHILE LOOP????
      elsif input == "list"
        list_spell_types#(spell_types)
      # elsif input == "all"
      #   puts 'There are x known spells.  Would you still like a list of them all? y/n'
      #   choice = gets.chomp.downcase
      #     if choice == "y"
      #       puts 'LIST OF ALL SPELLS'
      else
        puts "I'm not sure what you mean. Please try again."
      end
    end
  end
end

def list_spells_of_a_type(type)
  # spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
  # @spells_of_type = SpellworkCli::Spell.list_by_type(type)
  SpellworkCli::Spell.list_by_type(type).each.with_index(1) { |spell, i| puts "#{i}. #{spell}" }
  # spells_of_type.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
end

def choose_spell(type)
  puts type
  # spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
  # @spells_of_type = SpellworkCli::Spell.list_by_type(type)
  list_spells_of_a_type(type)
  # list objects of a specific type
  # accept user input
  input = nil
  while input != "exit"
    puts "Enter the number for more information on a spell, \"list\" for the list of #{type.downcase} spells, or \"exit\":"
    input = gets.chomp.downcase
    if input != "exit"
      if input.to_i > 0 && input.to_i <= SpellworkCli::Spell.list_by_type(type).length
        puts "more on #{SpellworkCli::Spell.list_by_type(type)[input.to_i-1]}"
  # DON'T WANT THIS IN A WHILE LOOP????
      elsif input == "list"
        list_spells_of_a_type(type)
      else
        puts "I'm not sure what you mean. Please try again."
      end
    end
  end
end

def goodbye
  puts "Goodbye."
end

end
