class SpellworkCli::CLI

  def initialize
    @input = "menu!"
  end

  def start
    welcome
    build_encyclopedia
    while @input != "exit!"
      if @input == "menu!"
        self.menu
      elsif @input == "word"
        self.choose_keyword
      elsif @input == "type"
        self.choose_spell_type
      elsif @input == "search"
        self.choose_letter
      end
    end
    goodbye
  end

  def welcome
    puts Rainbow("                         *").orange + Rainbow("  *").limegreen
    puts Rainbow("          ..").dimgray + Rainbow("           *").violet + Rainbow("   *").peru + Rainbow(" *").royalblue
    puts Rainbow("       .       .       .").dimgray + Rainbow(" *").olive + Rainbow("  *").mediumorchid
    puts Rainbow("    _").saddlebrown + Rainbow(".            ..").dimgray + Rainbow("      *").cadetblue
    puts Rainbow("   //").saddlebrown
    puts Rainbow("  //").saddlebrown + "        Welcome to Spellwork!"
    puts Rainbow(" //").saddlebrown
    puts Rainbow("//").saddlebrown + " A collection of known Harry Potter spells."
    puts Rainbow("-").saddlebrown
    # puts <<~HEREDOC
    #                          *  *
    #           ..           *   * *
    #        .       .       . *  *
    #     _.            ..      *
    #    //
    #   //        Welcome to Spellwork!
    #  //
    # // A collection of known Harry Potter spells.
    # -
    # HEREDOC
  end

  def build_encyclopedia
    SpellworkCli::Scraper.scrape_fandom_wiki_index
  end

  def menu
    puts <<~HEREDOC
    \nHow would you like to select a spell to learn about?
      Enter "word" to use a keyword or name of a spell.
      Enter "type" to chose from a list of spell types.
      Enter "search" to look through the encyclopedia alphabetically.
    To leave the program at any time, type "exit!".
    HEREDOC
    while @input != "word" && @input != "type" && @input != "search" && @input != "exit!"
      @input = gets.chomp.downcase
      if @input != "word" && @input != "type" && @input != "search" && @input != "exit!"
        puts "\nI'm not sure what you mean. Please enter \"word\", \"type\", \"search\",or \"exit!\""
      end
    end
  end

  # If @input == "word"
  def choose_keyword
    while @input != "menu!" && @input != "exit!"
      puts "\nEnter a keyword and I'll search the encyclopedia for you:"
      puts "(Enter \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      @input = gets.chomp.downcase
      if  @input != "menu!" && @input != "exit!"
        self.search_by_keyword
      end
    end
  end

  def search_by_keyword
    if @input.match(/^[[:alpha:][:blank:]]+$/) == nil
      puts "\nPlease only use letters and try again."
    else
      @spells_by_keyword = SpellworkCli::Spell.search(@input)
      if @spells_by_keyword == []
        puts "\nThere are no spells that include \"#{@input}\"."
      elsif @spells_by_keyword.length == 1
        puts "\nI have found one entry:"
        SpellworkCli::Spell.request_info_by_spell(@spells_by_keyword[0])
      else
        self.choose_spell_from_keyword
      end
    end
  end

  def list_spells_by_keyword
    puts "\nMultiple spells matched your search!:"
    @spells_by_keyword.each.with_index(1) { |spell, i| puts "#{i}. #{spell.name} - #{spell.description}" }
  end

  def choose_spell_from_keyword
    self.list_spells_by_keyword
    while  @input != "menu!" && @input != "exit!"
      puts "\nEnter the number of a spell to get more information:"
      puts "(Enter \"list!\" to repeat the list, \"word!\" to search by another keyword, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      @input = gets.chomp.downcase
      if  @input != "menu!" && @input != "exit!"
        if @input.to_i > 0 && @input.to_i <= @spells_by_keyword.length
          SpellworkCli::Spell.request_info_by_spell(@spells_by_keyword[@input.to_i-1])
        elsif @input == "list!"
          self.list_spells_by_keyword
        elsif @input == "word!"
          self.choose_keyword
        else
          self.search_by_keyword
          self.choose_keyword
        end
      end
    end
  end

  # If @input == "type"
  def choose_spell_type
    self.list_spell_types unless @input == "exit!"
    while @input != "menu!" && @input != "exit!"
      puts "\nEnter a number to list spells of that kind:"
      puts "(Enter \"list\" for the list of spell types, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      @input = gets.chomp.downcase
      if @input != "menu!" && @input != "exit!"
        if @input.to_i > 0 && @input.to_i <= @types.length
          choose_spell_from_type("#{@types[@input.to_i-1]}")
        elsif @input == "list"
          self.list_spell_types
        else
          puts "\nI'm not sure what you mean. Please try again."
        end
      end
    end
  end

  def list_spell_types
    @types = SpellworkCli::Spell.types
    puts "\nTypes of spells:"
    @types.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
  end

  def list_spells_of_a_type(type)
    @spells_by_type = SpellworkCli::Spell.find_by_type(type)
    puts "\nAll #{type.downcase} spells:"
    @spells_by_type.each.with_index(1) { |spell, i| puts "#{i}. #{spell.name}" }
  end

  def choose_spell_from_type(type)
    self.list_spells_of_a_type(type) unless @input == "exit!"
    while  @input != "menu!" && @input != "exit!"
      puts "\nEnter the number of a spell to get more information:"
      puts "(Enter \"list\" for the list of #{type.downcase} spells, \"type\" for the list of spell types, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      @input = gets.chomp.downcase
      if  @input != "menu!" && @input != "exit!"
        if @input.to_i > 0 && @input.to_i <= @spells_by_type.length
          SpellworkCli::Spell.request_info_by_spell(@spells_by_type[@input.to_i-1])
        elsif @input == "list"
          self.list_spells_of_a_type(type)
        elsif @input == "type"
          self.choose_spell_type
        else
          puts "\nI'm not sure what you mean. Please try again."
        end
      end
    end
  end

  # If @input == "search"
  def choose_letter
    puts "\nEnter a letter to search spells that begin with that letter:" unless @input == "exit!" || @input == "menu!"
    puts "(Enter \"menu!\" for the main menu, or \"exit!\" to leave the program.)" unless @input == "exit!" || @input == "menu!"
    while @input != "menu!" && @input != "exit!"
      @input = gets.chomp.downcase
      self.search_by_letter
    end
  end

  def search_by_letter
    if  @input != "menu!" && @input != "exit!"
      if ("a".."z").include?(@input)
        @spells_by_letter = SpellworkCli::Spell.find_in_encyclopedia(@input)
        if @spells_by_letter == []
          puts "There are no spells that begin with the letter #{@input.upcase}.  Please choose another."
        else
          self.choose_spell_from_letter
        end
      else
        puts "\nI'm not sure what you mean. Please try again."
      end
    end
  end

  def list_spells_by_letter
    puts "\nAll spells that begin with the letter #{@input.upcase}:"
    @spells_by_letter.each.with_index(1) { |spell, i| puts "#{i}. #{spell.name}" }
  end

  def choose_spell_from_letter
    self.list_spells_by_letter
    while  @input != "menu!" && @input != "exit!"
      puts "\nEnter the number of a spell to get more information:"
      puts "(Enter \"list\" to repeat the list, \"search\" to search by another letter, \"menu!\" for the main menu, or \"exit!\" to leave the program.)"
      @input = gets.chomp.downcase
      if @input != "menu!" && @input != "exit!"
        if @input.to_i > 0 && @input.to_i <= @spells_by_letter.length
          SpellworkCli::Spell.request_info_by_spell(@spells_by_letter[@input.to_i-1])
        elsif ("a".."z").include?(@input)
          self.search_by_letter
          self.choose_letter
        elsif @input == "list"
          self.list_spells_by_letter
        elsif @input == "search"
          self.choose_letter
        else
          puts "\nI'm not sure what you mean. Please try again."
        end
      end
    end
  end

  def goodbye
    puts "\nThank you for visiting."
    puts "Nox!"
  end

end
