module Capybara
  module RSpecMatchers

    class HaveRequiredField
      def initialize(name)
        @name = name
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


        if field.nil?
          false
        else
          @found = true
          attribute_exists?(field, 'required')
        end

      end

      def failure_message_for_should
        if @found
          "field '#{@name}' found, but doesn't have an attribute 'required'"
        else
          "field '#{@name}' not found"
        end
      end
    end

    class HaveNotRequiredField < HaveRequiredField

      def matches?(node)
        ret = super(node)
        if @found
          !ret
        else
          false
        end
      end

      def failure_message_for_should
        if @found
          "field '#{@name}' found, but has an attribute 'required'"
        else
          super
        end
      end

    end

    def have_required_field(name)
      HaveRequiredField.new(name)
    end

    def have_not_required_field(name)
      HaveNotRequiredField.new(name)
    end

  end
end
