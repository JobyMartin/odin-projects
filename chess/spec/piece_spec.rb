require_relative '../piece'

describe Piece do
  it 'has name' do
    piece = Piece.new('Knight')
    expect(piece.name).to eq('Knight')
  end
end