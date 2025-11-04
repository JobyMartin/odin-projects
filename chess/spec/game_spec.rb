require_relative '../game'

describe Game do
  it "has 2 players" do
    game = Game.new
    expect(game.players).to eq([])
  end
end