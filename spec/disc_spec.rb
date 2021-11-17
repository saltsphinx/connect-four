require_relative '../lib/disc'

describe Disc do
  describe '#get_pairs' do
    #Query method, test that return value is right patterns
    context 'when column is 0 and row is 1 and direction is horizontal' do
      subject(:disc_pairs) { described_class.new }

      it 'returns an array of two index pairs' do
        column = 0
        row = 1
        horizontal_direction = [[-1, 0], [0, 0], [1, 0]]

        result = disc_pairs.get_pairs(column, row, horizontal_direction)

        expect(result).to contain_exactly([0, 1], [1, 1])
      end
    end

    context 'when column is 4 and row is 5 and direction is vertical' do
      subject(:disc_pairs) { described_class.new }

      it 'returns an array of three index pairs' do
        column = 4
        row = 5
        horizontal_direction = [[0, 1], [0, 0], [0, -1]]

        result = disc_pairs.get_pairs(column, row, horizontal_direction)

        expect(result).to contain_exactly([4, 5], [4, 4])
      end
    end
  end

  describe '#get_disc' do
    #Query method, check that return value is a disc of the same color| one paramater, (column)
    context 'when disc color is yellow, and provided column/row is 1/2' do
      let(:yellow_double) { instance_double(Disc, color: 'yellow') }
      let(:red_double) { instance_double(Disc, color: 'red') }
      let(:board_double) { double('board', columns: [[],[red_double, red_double, yellow_double]]) }
      subject(:yellow_disc) { described_class.new('yellow', board_double) }

      it 'returns yellow double' do
        column_index = 1
        row_index = 2
        result = yellow_disc.get_disc(column_index, row_index)
        expect(result).to eql(yellow_double)
      end
    end

    context 'when disc color is red, and provided column/row is 0/1' do
      let(:yellow_double) { instance_double(Disc, color: 'yellow') }
      let(:red_double) { instance_double(Disc, color: 'red') }
      let(:board_double) { double('board', columns: [[red_double, red_double, yellow_double],[]]) }
      subject(:yellow_disc) { described_class.new('yellow', board_double) }

      it 'returns nil' do
        column_index = 0
        row_index = 1
        result = yellow_disc.get_disc(column_index, row_index)
        expect(result).to be_nil
      end
    end
  end

  describe '#verify_disc' do
    #Query method, check that provided disc's color is same as current disc| one paramater (disc)
    context 'when both discs are yellow' do
      subject(:yellow_disc) { described_class.new('yellow') }
      let(:yellow_double) { instance_double(Disc, color: 'yellow') }

      it 'returns true' do
        result = yellow_disc.verify_disc(yellow_double)
        expect(result).to be(true)
      end
    end

    context 'when both discs are red' do
      subject(:red_disc) { described_class.new('red') }
      let(:red_double) { instance_double(Disc, color: 'red') }

      it 'returns true' do
        result = red_disc.verify_disc(red_double)
        expect(result).to be(true)
      end
    end

    context 'when one disc is red and other\'s yellow' do
      subject(:red_disc) { described_class.new('red') }
      let(:yellow_double) { instance_double(Disc, color: 'yellow') }

      it 'returns false' do
        result = red_disc.verify_disc(yellow_double)
        expect(result).to be(false)
      end
    end
  end

  describe '#set_direction' do
    #Command method, check that the direction instance hash has correct values| two parameters(direction, discs)
    context 'when discs colors are yellow horizontally' do
      let(:yellow_double) { instance_double(Disc, color: 'yellow') }
      subject(:yellow_disc) { described_class.new('yellow') }

      it 'sets horizontial direction to disc and two doubles' do
        expect { yellow_disc.set_direction(:horizontial, [yellow_disc, yellow_double, yellow_double]) }.to change { yellow_disc.directions[:horizontial] }.to contain_exactly(yellow_disc, yellow_double, yellow_double)
      end
    end
  end
end
