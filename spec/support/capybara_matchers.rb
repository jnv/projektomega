module Capybara
  module RSpecMatchers

    class HaveFieldWithAttribute
      def initialize(name, attribute=nil, should = true)
        @name = name
        @attribute = attribute
        @should_have_attribute = should
      end

      def attribute_exists?(field, attribute)
        val = field[attribute]

        !val.nil?
      end

      def matches?(node)
        @node = node
        begin
          field = node.find_field(@name)
        rescue Capybara::ElementNotFound
          return false
        end
        return false if field.nil?

        @found = true
        has_attribute = attribute_exists?(field, @attribute)

        has_attribute == @should_have_attribute

      end

      def failure_message_for_should
        if @found
          if @should_have_attribute
            "field '#{@name}' doesn't have an attribute '#{@attribute}'"
          else
            "field '#{@name}' has an attribute '#{@attribute}'"
          end
        else
          "field '#{@name}' not found"
        end
      end
    end

    #TODO: Make some neat metaprogramming stuff to automatically match attributes from method name

    def have_required_field(name)
      HaveFieldWithAttribute.new(name, 'required', true)
    end

    def have_not_required_field(name)
      HaveFieldWithAttribute.new(name, 'required', false)
    end

    def have_readonly_field(name)
      HaveFieldWithAttribute.new(name, 'readonly', true)
    end

    def have_not_readonly_field(name)
      HaveFieldWithAttribute.new(name, 'readonly', false)
    end

  end
end
