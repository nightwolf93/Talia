module Talia
  module World
    module Item

      class Bag
        attr_accessor :id, :name, :stacks, :money

        def initialize()

        end

        def save()

        end

        def on_item_added(item)
          raise "Method need to be implemented"
        end

        def on_item_updated(item)
          raise "Method need to be implemented"
        end

        def on_item_deleted(item)
          raise "Method need to be implemented"
        end
      end

    end
  end
end
