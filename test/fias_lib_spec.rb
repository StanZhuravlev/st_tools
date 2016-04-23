require 'rspec'
require 'st_tools'


describe 'Проверка методов StTool::Fias.*' do

  #-----------------------------------------------------
  #
  # Тесты получения aoguid
  #
  #-----------------------------------------------------
  it '.uuid? success' do
     test = ::StTools::Fias.uuid?('0c5b2444-70a0-4932-980c-b4dc0d3f02b5')
     expect(test).to eq true
  end

  it '.uuid? fail' do
    test = ::StTools::Fias.uuid?('0c5b2444-70a0-4932-980c')
    expect(test).to eq false
  end

  it '.postalcode?("111558") success' do
    test = ::StTools::Fias.postalcode?('111558')
    expect(test).to eq true
  end

  it '.postalcode?("111") fail' do
    test = ::StTools::Fias.postalcode?('111')
    expect(test).to eq false
  end

  #-----------------------------------------------------
  #
  # Тесты получения aoguid
  #
  #-----------------------------------------------------
  it 'moscow_aoguid' do
    test = ::StTools::Fias.moscow_aoguid
    expect(test).to eq '0c5b2444-70a0-4932-980c-b4dc0d3f02b5'
  end

  it 'spb_aoguid' do
    test = ::StTools::Fias.spb_aoguid
    expect(test).to eq 'c2deb16a-0330-4f05-821f-1d09c93331e6'
  end

  it 'sevastopol_aoguid' do
    test = ::StTools::Fias.sevastopol_aoguid
    expect(test).to eq '6fdecb78-893a-4e3f-a5ba-aa062459463b'
  end

  it 'baikonur_aoguid' do
    test = ::StTools::Fias.baikonur_aoguid
    expect(test).to eq '63ed1a35-4be6-4564-a1ec-0c51f7383314'
  end

  it 'other_aoguid' do
    test = ::StTools::Fias.other_aoguid
    expect(test).to eq 'a074418e-41da-49dd-ad44-9f7909e91675'
  end

  #-----------------------------------------------------
  #
  # Тесты проверки aoguid
  #
  #-----------------------------------------------------
  it 'moscow? success' do
    test = ::StTools::Fias.moscow?('0c5b2444-70a0-4932-980c-b4dc0d3f02b5')
    expect(test).to eq true
  end

  it 'spb? success' do
    test = ::StTools::Fias.spb?('c2deb16a-0330-4f05-821f-1d09c93331e6')
    expect(test).to eq true
  end

  it 'sevastopol? success' do
    test = ::StTools::Fias.sevastopol?('6fdecb78-893a-4e3f-a5ba-aa062459463b')
    expect(test).to eq true
  end

  it 'baikonur? success' do
    test = ::StTools::Fias.baikonur?('63ed1a35-4be6-4564-a1ec-0c51f7383314')
    expect(test).to eq true
  end

  it 'moscow? fail' do
    test = ::StTools::Fias.moscow?('c2deb16a-0330-4f05-821f-1d09c93331e6')
    expect(test).to be false
  end

  it 'spb? fail' do
    test = ::StTools::Fias.spb?('63ed1a35-4be6-4564-a1ec-0c51f7383314')
    expect(test).to eq false
  end

  it 'sevastopol? fail' do
    test = ::StTools::Fias.sevastopol?('6fdecb78-893a-4e3f-ffff-aa062459463b')
    expect(test).to eq false
  end

  it 'baikonur? fail' do
    test = ::StTools::Fias.baikonur?('c2deb16a-0330-ffff-821f-1d09c93331e6')
    expect(test).to eq false
  end

  it 'federal? success' do
    test = ::StTools::Fias.federal?('0c5b2444-70a0-4932-980c-b4dc0d3f02b5')
    expect(test).to eq true
  end

  it 'federal? fail' do
    test = ::StTools::Fias.federal?('0c5b2444-70a0-4932-980c-b4dc053f02b5')
    expect(test).to eq false
  end

  it 'other? success' do
    test = ::StTools::Fias.other?('a074418e-41da-49dd-ad44-9f7909e91675')
    expect(test).to eq true
  end

  it 'other? fail' do
    test = ::StTools::Fias.other?('a074418e-41da-49dd-ffff-9f7909e91675')
    expect(test).to eq false
  end

  #--------------------------------------------------------
  #
  # Тесты расчета расстояния между точками
  #
  #--------------------------------------------------------
  it 'Москва - Санкт-Петербург' do
    test = ::StTools::Fias.distance(55.75583, 37.61778, 59.95000, 30.31667)
    expect(test).to be > 634000
    expect(test).to be < 635000
  end

  it 'Москва - Киев' do
    test = ::StTools::Fias.distance(55.75583, 37.61778, 50.450500, 30.523000)
    expect(test).to be > 755000
    expect(test).to be < 757000
  end

  it 'Москва - Пермь' do
    test = ::StTools::Fias.distance(55.75583, 37.61778, 58.01389, 56.24889)
    expect(test).to be > 1150000
    expect(test).to be < 1160000
  end

  it 'Москва - Сан-Франциско' do
    test = ::StTools::Fias.distance(55.75583, 37.61778, 37.76667, -122.43333)
    expect(test).to be > 9440000
    expect(test).to be < 9480000
  end

end