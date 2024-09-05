# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormType, type: :model do
  it "is valid with a name of 'A'" do
    form_type = FormType.new(name: 'A')
    expect(form_type).to be_valid
  end

  it "is valid with a name of 'B'" do
    form_type = FormType.new(name: 'B')
    expect(form_type).to be_valid
  end

  it "is not valid with a name other than 'A' or 'B'" do
    form_type = FormType.new(name: 'C')
    expect(form_type).not_to be_valid
  end

  it 'is not valid without a name' do
    form_type = FormType.new(name: nil)
    expect(form_type).not_to be_valid
  end
end
