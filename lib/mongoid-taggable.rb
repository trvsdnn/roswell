module Mongoid
  module Document
    module Taggable
      def self.included(base)
        base.class_eval do |basee|
          basee.field :tags, :type => Array, :default => []
          basee.index :tags

          include InstanceMethods
          extend ClassMethods
        end
      end

      module InstanceMethods
        def tag_list=(tags)
          self.tags = tags.split(',').collect{ |t| t.strip }.delete_if{ |t| t.blank? }
        end

        def tag_list
          self.tags.join(', ') if tags
        end
      end

      module ClassMethods
        def tags
          all.only(:tags).collect{ |ms| ms.tags }.flatten.uniq.compact
        end

        def tagged_with(_tags)
          _tags = Array(_tags)
          criteria.in(:tags => _tags).to_a
        end
      end

    end
  end
end
