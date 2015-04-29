require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::System.*' do
  it '.memory' do
    test = ::StTools::System.memory
    expect(test).to be > 0
  end

  it '.screen(:width)' do
    test = ::StTools::System.screen(:width)
    expect(test).to be > 90
  end

  it '.screen(:width)' do
    test = ::StTools::System.screen(:height)
    expect(test).to be > 10
  end

  it '.exename' do
    test = ::StTools::System.exename
    expect(test).to_not be_nil
  end

end