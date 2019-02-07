class SpellworkCli::CLI

  attr_accessor :input

  def initialize
    @input = "menu!"
  end

  def start
    welcome
    build_encyclopedia
    run_program
    # menu
    # choose_spell_type
    # goodbye
  end

  def welcome
    puts <<~HEREDOC
                             *  *
              ..           *   * *
           .       .       . *  *
        _.            ..      *
       //
      //        Welcome to Spellwork!
     //
    // A collection of known Harry Potter spells.
    -

    HEREDOC
  end

  def build_encyclopedia
    SpellworkCli::Scraper.scrape_fandom_wiki_index
  end

  def run_program
    while @input != "exit!"
      if @input == "menu!"
        menu
      elsif @input == "word"

      elsif @input == "type"
        choose_spell_type
      elsif @input == "search"
        search_by_letter
      end
    end
    goodbye
  end

  def menu
    input = nil
    puts <<~HEREDOC
    How would you like to select a spell to learn about?
    Enter "word" to use a keyword or name of a spell.
    Enter "type" to chose from a list of spell types.
    Enter "search" to look through the encyclopedia alphabetically.
    To leave the program at any time, type "exit!".
    HEREDOC
    while input != "word" && input != "type" && input != "search" && input != "exit!"
      input = gets.chomp.downcase
      if input != "word" && input != "type" && input != "search" && input != "exit!"
        puts "I'm not sure what you mean. Please enter \"word\", \"type\", \"search\",or \"exit!\""
      else
        @input = input
      end
    end
  end



  def choose_spell_type
    self.list_spell_types
    input = nil
    while input != "menu!" && input != "exit!"
      puts "Enter a number to list spells of that kind:"
      puts "(Enter \"list\" for the list of spell types, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      input = gets.chomp.downcase
      if input != "menu!" && input != "exit!"
        if input.to_i > 0 && input.to_i <= @types.length
          choose_spell_from_type("#{@types[input.to_i-1]}")
        elsif input == "list"
          self.list_spell_types
        else
          puts "I'm not sure what you mean. Please try again."
        end
      else
        @input = input
      end
    end
  end

  def list_spell_types
    @types = SpellworkCli::Spell.types
    puts "Types of spells:"
    @types.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
    puts ""
  end

  def list_spells_of_a_type(type)
    @spells_by_type = SpellworkCli::Spell.find_by_type(type)
    puts "All #{type.downcase} spells:"
    @spells_by_type.each.with_index(1) { |spell, i| puts "#{i}. #{spell.name}" }
    puts ""
  end

  def choose_spell_from_type(type)
    self.list_spells_of_a_type(type)
    input = nil
    while  input != "menu!" && input != "exit!"
      puts "Enter the number of a spell to get more information:"
      puts "(Enter \"list\" for the list of #{type.downcase} spells, \"type\" for the list of spell types, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      input = gets.chomp.downcase
      if  input != "menu!" && input != "exit!"
        if input.to_i > 0 && input.to_i <= @spells_by_type.length
          SpellworkCli::Spell.request_info_by_spell(@spells_by_type[input.to_i-1])
        elsif input == "list"
          self.list_spells_of_a_type(type)
        elsif input == "type"
          self.choose_spell_type
        else
          puts "I'm not sure what you mean. Please try again."
        end
      else
        @input = input
      end
    end
  end

  def search_by_letter
    input = nil
    puts "Enter a letter to search spells that begin with that letter:"
    puts "(Enter \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
    while input != "menu!" || input != "exit!"
      input = gets.chomp.downcase
      if  input != "menu!" && input != "exit!"
        if ("a".."z").include?(input)
          puts "list of spells beginning with #{input}"
          # SpellworkCli::Spell.request_info_by_spell(@spells_by_type[input.to_i-1])
        else
          puts "I'm not sure what you mean. Please try again."
        end
      else
        @input = input
      end
    end
  end

  def list_spells_by_letter(letter)
    @spells_by_letter = SpellworkCli::Spell.find_in_encyclopedia(letter)
    if @spells_by_letter == []
      puts "There are no spells that begin with the letter #{letter.upcase}."
    else
      puts "All #{type.downcase} spells:"
      @spells_by_letter.each.with_index(1) { |spell, i| puts "#{i}. #{spell.name}" }
      puts ""
    end
  end

  def choose_spell_from_type(type)
    self.list_spells_of_a_type(type)
    input = nil
    while  input != "menu!" && input != "exit!"
      puts "Enter the number of a spell to get more information:"
      puts "(Enter \"list\" for the list of #{type.downcase} spells, \"type\" for the list of spell types, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      input = gets.chomp.downcase
      if  input != "menu!" && input != "exit!"
        if input.to_i > 0 && input.to_i <= @spells_by_type.length
          SpellworkCli::Spell.request_info_by_spell(@spells_by_type[input.to_i-1])
        elsif input == "list"
          self.list_spells_of_a_type(type)
        elsif input == "type"
          self.choose_spell_type
        else
          puts "I'm not sure what you mean. Please try again."
        end
      else
        @input = input
      end
    end
  end

  def goodbye
    puts "Thank you for visiting!"
    puts "Nox!"
  end

end
