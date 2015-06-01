module Talia
  module World
    module Item

      class Stack
        attr_accessor :id, :bag, :quantity, :item

        def initialize(bag, item, quantity = 1)
          @bag = bag
          @item = item
          @quantity = quantity
        end

        def save()

        end
      end

    end
  end
end
