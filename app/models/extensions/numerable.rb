#TODO: Use this. Figure out how to inject abbr_letter
module Extensions
  module Numerable
    extend ActiveSupport::Concern

    included do |klass|
      validates_presence_of :number, :name
      validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

      alias_method :abbr, :code

    end

    module ClassMethods

    end

    module InstanceMethods
      def code
        "#{self.abbr_letter}#{number}"
      end

      def to_s
        name
      end

      def full_name
        "#{abbr} #{name}"
      end
    end


  end

end