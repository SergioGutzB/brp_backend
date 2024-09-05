# frozen_string_literal: true

namespace :db do
  desc 'Populate form types A and B'
  task populate_form_types: :environment do
    # Define the form types to create
    form_types = ['A', 'B']

    # Iterate over form types and create them if they do not exist
    form_types.each do |type|
      FormType.find_or_create_by!(name: type)
    end

    puts 'Form types populated successfully!'
  end
end
