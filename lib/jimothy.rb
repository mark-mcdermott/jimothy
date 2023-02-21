require "jimothy/version"
require "jimothy/engine"
require "json"

GEM_ROOT = File.expand_path("../..", __FILE__)
JSON_PATH = "#{GEM_ROOT}/lib/jimothy/the-office-characters.json"
GEM_IMAGE_PATH = "#{GEM_ROOT}/lib/jimothy/images/"
RAILS_IMAGE_PATH = "/app/assets/images/"

module Jimothy
  def self.get_users
    users = JSON.parse(IO.read("#{JSON_PATH}"))['users']
  end

  def self.seed_users
    create_users
    import_images
  end

  def self.create_users
    get_users.each do |user|
      User.create(name: user['firstname'] + " " + user['lastname'], email: user['email'], image: user['image'])
    end
  end

  def self.import_images
    images = Dir["#{GEM_IMAGE_PATH}" + "*.png"]
    images.each do |path|
      image = path.split('/')[-1]
      source = "#{GEM_IMAGE_PATH}" + image 
      target = "#{Rails.root}#{RAILS_IMAGE_PATH}" + image
      FileUtils.cp(source, target)
    end
  end
end