require "rails/generators"
require "rails/generators/rails/resource/resource_generator"

module Jimothy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def scaffold_users
        %x(rails g scaffold user name email image)
        %x(rails db:migrate)
      end
      def add_image_tag
        gsub_file 'app/views/users/_user.html.erb',/<%= user.image %>/,'<%= image_tag user.image %>'
      end
      def empty_seed_file
        gsub_file 'db/seeds.rb',/# This file should contain all the record creation needed to seed the database with its default values.\n# The data can then be loaded with the bin\/rails db:seed command \(or created alongside the database with db:setup\).\n#\n# Examples:\n#\n#   movies = Movie.create\(\[\{ name: \"Star Wars\" \}, \{ name: \"Lord of the Rings\" \}\]\)\n#   Character.create\(name: \"Luke\", movie: movies.first\)\n/,'.'
      end
      def add_jimothy_call
        gsub_file 'db/seeds.rb',/./,"require \"jimothy\"\nJimothy::seed_users"
      end
      def seed_users
        %x(rails db:seed)
      end
    end
  end
end