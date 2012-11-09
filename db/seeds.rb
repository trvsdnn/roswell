# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'securerandom'

Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

group_ids = %w[foo bar buck yee deer monk chuck wulf].map do |name|
  Group.create!(:name => name).id
end

user = User.create!(:username => 'admin', :password => 'asdfasdf')

100.times do |i|
  GenericAccount.create!(
    :title => Faker::Lorem.words.join(' '),
    :username => Faker::Internet.user_name,
    :password => 'secret',
    :comments => [ Faker::Lorem.sentences(3), '' ].sample,
    :last_updated_by_ip => Faker::Internet.ip_v4_address,
    :current_user => user,
    :group_ids => (rand(5).zero? ? group_ids.sample(rand(group_ids.size)) : [])
  )
  Note.create!(
    :title => Faker::Lorem.words.join(' '),
    :body => Faker::Lorem.sentences(3).join(' '),
    :last_updated_by_ip => Faker::Internet.ip_v4_address,
    :current_user => user,
    :group_ids => (rand(5).zero? ? group_ids.sample(rand(group_ids.size)) : [])
  )
  SoftwareLicense.create!(
    :title => Faker::Lorem.word,
    :license_key => SecureRandom.hex,
    :licensed_to => [ Faker::Name.name, Faker::Internet.email ].sample,
    :comments => [ Faker::Lorem.sentences(3), '' ].sample,
    :last_updated_by_ip => Faker::Internet.ip_v4_address,
    :current_user => user,
    :group_ids => (rand(5).zero? ? group_ids.sample(rand(group_ids.size)) : [])
  )
end
