require "rails/generators"
require "rails/generators/rails/resource/resource_generator"

module Jimothy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def install_jimothy
        # only run if User model doesn't exist yet
        if !Dir[Rails.root + 'app/models/*.rb'].map { |path| path.split('/')[-1] }.include? 'user.rb'
          # scaffold users
          %x(rails g scaffold user name email image)
          %x(rails db:migrate)
        
          # add image tag
          gsub_file 'app/views/users/_user.html.erb',/<%= user.image %>/,'<%= image_tag user.image %>'
        
          # empty seed file
          gsub_file 'db/seeds.rb',/# This file should contain all the record creation needed to seed the database with its default values.\n# The data can then be loaded with the bin\/rails db:seed command \(or created alongside the database with db:setup\).\n#\n# Examples:\n#\n#   movies = Movie.create\(\[\{ name: \"Star Wars\" \}, \{ name: \"Lord of the Rings\" \}\]\)\n#   Character.create\(name: \"Luke\", movie: movies.first\)\n/,'.'
        
          # add jimothy call
          seeds_file = File.read('db/seeds.rb')
          if seeds_file == '.' # only paste in this Jimothy::seed_users if the previous empty_seed_file was successful (ie, don't add it again if it's already there)
            gsub_file 'db/seeds.rb',/./,"require \"jimothy\"\nJimothy::seed_users"
          end
        
          # seed_users
          %x(rails db:seed)
        else 
          puts "Error: user model already exists. Skipping jimothy install."
        end
      end
    end
  end
end