class Disc
  attr_reader :color, :parent, :directions

  DIRECTIONS = {
    horizontal: [[-1, 0], [0, 0], [1, 0]],
    vertical: [[0, 1], [0, 0], [0, -1]],
    ldiagonal: [[-1, 1], [0, 0], [1, -1]],
    rdiagonal: [[1, 1], [0, 0], [-1, -1]]
  }

  def initialize(color = nil, parent = nil, directions = nil)
    @color = color
    @parent = parent
    @directions = directions || {
      horizontal: [],
      vertical: [],
      ldiagonal: [],
      rdiagonal: []
    }
  end
  
  def disc_cycle(column, row)
    DIRECTIONS.each do |direction, pair_indices|
      pairs = get_pairs(column, row, pair_indices)
      discs = make_discs_array(pairs)

      discs.each do |disc|
        disc.directions[direction].each do |neighbour|
          discs << neighbour unless discs.include?(neighbour)
        end
      end

      discs.each do |disc|
        disc.set_direction(direction, discs)
      end
    end
  end

  def make_discs_array(pairs)
    discs = []
    pairs.each do |pair|
      disc = get_disc(pair[0], pair[1])
      discs << disc if disc
    end
    discs
  end

  def set_direction(direction, discs)
    directions[direction] = discs
  end

  def get_pairs(column, row, direction)
    #[[-1, 0], [0, 0], [1, 0]]
    disc_indices = []

    direction.each do |indices|
      next unless (column + indices[0]).between?(0, 6)
      next unless (row + indices[1]).between?(0, 5)
      disc_indices << [column + indices[0], row + indices[1]]
    end

    disc_indices
  end

  def get_disc(column, index)
    disc = @parent.columns[column][index]
    disc if verify_disc(disc)
  end

  def verify_disc(disc)
    disc.color == color ? true : false unless disc.nil?
  end
end