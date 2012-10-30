# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'securerandom'

Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

100.times do |i|
  GenericAccount.create(
    :title => Faker::Lorem.words,
    :username => Faker::Internet.user_name,
    :password => SecureRandom.hex(3),
    :comments => [ Faker::Lorem.sentences(3), '' ].sample,
    :updated_by_ip => Faker::Internet.ip_v4_address
  )
  Note.create(
    :title => Faker::Lorem.words.join(' '),
    :body => Faker::Lorem.sentences(3),
    :updated_by_ip => Faker::Internet.ip_v4_address
  )
  SoftwareLicense.create(
    :title => Faker::Lorem.word,
    :license_key => SecureRandom.hex,
    :license_to => [ Faker::Name.name, Faker::Internet.email ].sample,
    :comments => [ Faker::Lorem.sentences(3), '' ].sample,
    :updated_by_ip => Faker::Internet.ip_v4_address
  )
end
