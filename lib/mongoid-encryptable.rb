require 'gibberish'

module Mongoid
  module Document
    module Encryptable
      class NoKeyError < StandardError; end

      def self.included(base)
        base.class_eval do |basee|
          extend ClassMethods
        end
      end

      module ClassMethods
        def encrypted_field(field, opts = {})
          raise Mongoid::Document::Encryptable::NoKeyError, 'You must specify a key to encrypt/decrypt with' unless opts[:key]

          @@key = opts[:key]

          field "encrypted_#{field}".to_sym, :type => String

          before_validation "encrypt_#{field}".to_sym
          validate :field_has_data

          define_method(:field_has_data) do
            unencrypted = instance_variable_get("@unencypted_#{field}".to_sym)
            errors.add(field.to_sym, "#{field.to_s.capitalize} must have data") if unencrypted.nil? || unencrypted.blank?
          end

          define_method("#{field}=".to_sym) do |value|
            instance_variable_set("@unencypted_#{field}".to_sym, value)
          end

          define_method(field.to_sym) do
            encrypted = send("encrypted_#{field}".to_sym)
            if encrypted
              cipher = Gibberish::AES.new(@@key)
              cipher.dec(encrypted)
            else
              nil
            end
          end

          define_method("encrypt_#{field}".to_sym) do
            cipher = Gibberish::AES.new(@@key)
            unencrypted = instance_variable_get("@unencypted_#{field}".to_sym)

            send("encrypted_#{field}=".to_sym, cipher.enc(unencrypted)) unless unencrypted.blank?
          end
        end

      end

    end
  end
end
