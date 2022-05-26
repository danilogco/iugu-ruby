# frozen_string_literal: true

require "set"

module Iugu
  class Object
    attr_accessor :errors

    undef :id if method_defined?(:id)

    def initialize(attributes = {})
      @unsaved_attributes = Set.new
      set_attributes attributes
    end

    def add_accessor(name)
      singleton_class.class_eval do
        define_method(name.to_s) { attributes[name.to_s] }
        unless name.to_s == "id"
          define_method("#{name}=") do |value|
            attributes[name.to_s] = value
            unsaved_attributes.add name.to_s
          end
        end
      end
    end

    def method_missing(name, *args)
      return super unless name.to_s.end_with? "="
      return super if name.to_s.start_with? "id"

      add_accessor(name.to_s[0...-1])
      send(name, args[0])
    end

    attr_reader :unsaved_attributes, :attributes

    def modified_attributes
      Iugu::Utils.intersect @unsaved_attributes, @attributes
    end

    def copy(object)
      @unsaved_attributes = Set.new
      @attributes = {}
      set_attributes object.attributes
    end

    def set_attributes(attributes, unsaved = false)
      @attributes = Iugu::Utils.stringify_keys(attributes)
      @attributes.each do |k, _v|
        add_accessor(k)
      end
      @unsaved_attributes = @attributes.keys.to_set if unsaved
    end

    protected
      def metaclass
        class << self; self; end
      end
  end
end
