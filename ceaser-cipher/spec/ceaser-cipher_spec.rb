require './lib/ceaser-cipher.rb'

describe 'ceaser_cipher' do
  it 'return the cipher of "Anderson"' do 
    expect(ceaser_cipher("Anderson", 3)).to eql("Dqghuvrq")
  end

  it 'return the cipher of "Fui no mercado"' do 
    expect(ceaser_cipher("Fui no mercado", 8)).to eql("Ncq vw umzkilw")
  end

  it 'return the cipher of "O AlMoço Estava otimo."' do
    expect(ceaser_cipher("O AlMoço Estava otimo.", 5)).to eql("T FqRtçt Jxyfaf tynrt.")
  end

  it 'return the cipher of "3-- Iniciando teste! 2-- Processando... 1-- #CONCLUido com Sucesso#"' do
    expect(ceaser_cipher("3-- Iniciando teste! 2-- Processando... 1-- #CONCLUido com Sucesso#", 25)).to eql("3-- Hmhbhzmcn sdrsd! 2-- Oqnbdrrzmcn... 1-- #BNMBKThcn bnl Rtbdrrn#")
  end
end