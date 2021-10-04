require 'rails_helper'

RSpec.describe Property, type: :model do

  subject { build(:property) }

  context 'with valid data' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is valid with bathrooms with decimals' do
      subject.bathrooms = 1.5
      expect(subject).to be_valid
    end
    it 'is valid without internal number when house' do
      subject.property_type = 'house'
      subject.internal_number = nil
      expect(subject).to be_valid
    end
  end

  context 'with invalid data' do
    it 'is invalid without a name' do
      subject.name = nil
      subject.validate
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a type' do
      subject.property_type = nil
      subject.validate
      expect(subject.errors[:property_type]).to include("can't be blank")
    end

    it 'is throws an ArgumentError without a valid type' do
      expect { build(:property, property_type: 'asd') }.to raise_error(ArgumentError)
    end

    it 'is invalid without a street' do
      subject.street = nil
      subject.validate
      expect(subject.errors[:street]).to include("can't be blank")
    end

    it 'is invalid without an external number' do
      subject.external_number = nil
      subject.validate
      expect(subject.errors[:external_number]).to include("can't be blank")
    end

    it 'is invalid with an invalid external number' do
      subject.external_number = 'asd &ad'
      subject.validate
      expect(subject.errors[:external_number]).to include('is invalid')
    end

    it 'is invalid without an internal number if type is department' do
      subject.internal_number = nil
      subject.validate
      expect(subject.errors[:internal_number]).to include("Deparmets and comercial grounds must have an internal number")
    end

    it 'is invalid with an invalid internal number' do
      subject.internal_number = 'asd ad$'
      subject.validate
      expect(subject.errors[:internal_number]).to include('must be a valid number')
    end

    it 'is invalid without a neighborhood' do
      subject.neighborhood = nil
      subject.validate
      expect(subject.errors[:neighborhood]).to include("can't be blank")
    end

    it 'is invalid without a city' do
      subject.city = nil
      subject.validate
      expect(subject.errors[:city]).to include("can't be blank")
    end

    it 'is invalid without a country' do
      subject.country = nil
      subject.validate
      expect(subject.errors[:country]).to include("can't be blank")
    end

    it 'is invalid with an invalid country' do
      subject.country = 'der'
      subject.validate
      expect(subject.errors[:country]).to include('is invalid')
    end

    it 'is invalid without rooms' do
      subject.rooms = nil
      subject.validate
      expect(subject.errors[:rooms]).to include("can't be blank")
    end

    it 'is invalid with 0 bathrooms when department' do
      subject.bathrooms = 0
      subject.validate
      expect(subject.errors[:bathrooms]).to include('The property must have at least 1 bathroom')
    end

    it 'is invalid with 0 bathrooms when house' do
      subject.property_type = 'house'
      subject.bathrooms = 0
      subject.validate
      expect(subject.errors[:bathrooms]).to include('The property must have at least 1 bathroom')
    end
    # TODO: Add more invalid data
  end
end
