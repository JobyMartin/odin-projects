require './lib/player.rb'

describe Player do
  it "has name and symbol" do
    player = Player.new('Joby', 'X')
    expect(player.name).to eql('Joby')
    expect(player.symbol).to eql('X')
  end
end  
