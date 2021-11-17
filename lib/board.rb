require_relative './disc'

class Board
  attr_accessor :columns, :winner
  def initialize
    @columns = [[], [], [], [], [], [], []]
  end

  def insert(column, color)
    disc = Disc.new(color, self)
    columns[column] << disc
    disc.disc_cycle(column, columns[column].size - 1)

    if disc.directions.map { |_, direction| direction.length }.any? { |size| size >= 4 }
      @winner = disc.color
    end
  end

  def game_end?
    @winner.nil? ? false : true
  end

  def display_board
    [*0..5].reverse.each do |index|
      columns.each_with_index do |column, c_index|
        disc = column[index]

        print "|" if c_index == 0
        if disc.nil?
          print " \u26ab |".encode('utf-8')
        else
          disc.color == 'Yellow' ? print(" \u26a1 |".encode('utf-8')) : print(" \u26d4 |".encode('utf-8'))
        end
        puts "\n" if c_index == 6
      end
    end
  end
end