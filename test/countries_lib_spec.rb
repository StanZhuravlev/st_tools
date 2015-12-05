require 'rspec'
require 'st_tools'


describe 'Проверка методов StTool::Countries.*' do

  #-----------------------------------------------------
  #
  # Тесты проверки страны
  #
  #-----------------------------------------------------
  it '.country? success' do
    test = ::StTools::Countries.country?('e6a4a903-01e6-43f0-9bad-e57c2eb4a9c7')
    expect(test).to eq true
  end

  it '.country? fail' do
    test = ::StTools::Countries.country?('0c5b2444-70a0-4932-980c-b4dc0d3f02b5')
    expect(test).to eq false
  end

  #-----------------------------------------------------
  #
  # Тесты получения информации о стране
  #
  #-----------------------------------------------------
  it 'country success by aoguid' do
    test = ::StTools::Countries.country('e6a4a903-01e6-43f0-9bad-e57c2eb4a9c7')
    expect(test[:code]).to eq 'ua'
  end

  it 'country success by code :ru' do
    test = ::StTools::Countries.country(:ru)
    expect(test[:code]).to eq 'ru'
    expect(test[:aoguid]).to eq 'ea70abb2-ccc2-46c8-9b15-d42cac1ecd7f'
  end

  it 'country success by code ru' do
    test = ::StTools::Countries.country('kz')
    expect(test[:code]).to eq 'kz'
  end

  it 'country success by code ru' do
    test = ::StTools::Countries.country('us')
    expect(test[:code]).to eq ''
  end


end