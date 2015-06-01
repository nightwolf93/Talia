module Talia
  module World
    module Engine

      class Pathfinding
        attr_accessor :map

        def initialize(map)
          @map = map
          puts self.get_estimated_distance_between(196, 255)
        end

        def get_cell_num(cell_str)
          hash = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
          num_1 = hash.index(cell_str[0]) * hash.length
          num_2 = hash.index(cell_str[1])
          return num_1 + num_2
        end

        def get_cell_chars(cell_num)
          hash = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
          num_1 = cell_num % hash.length
          num_2 = (cell_num - num_1) / hash.length
          return hash[num_2].to_s + hash[num_1].to_s
        end

        def get_dir_char(dir_num)
          hash = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
          if dir_num >= hash.length
            return ''
          end
          return hash[dir_num].to_s
        end

        def get_dir_num(dir_char)
          hash = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
          return hash.index(dir_char).to_s
        end

        def get_cell_x(cell_id, width)
          return ((cell_id - (width - 1) * self.get_cell_y(cell_id, width)) / width)
        end

        def get_cell_y(cell_id, width)
          loc_5 = (cell_id / ((width * 2) - 1)).to_i
          loc_6 = cell_id - loc_5 *((width * 2) - 1)
          loc_7 = loc_6 % width
          return (loc_5 - loc_7)
        end

        def get_estimated_distance_between(cell_1, cell_2)
          diff_x = (get_cell_x(cell_1, @map.width) - get_cell_x(cell_2, @map.width)).abs
          diff_y = (get_cell_y(cell_1, @map.width) - get_cell_y(cell_2, @map.width)).abs
          return ((Math.sqrt(((diff_x ** 2) + (diff_y ** 2)))).truncate).to_i
        end

        def inline(cell_1, cell_2)
          is_x = self.get_cell_x(cell_1, @map.width) == self.get_cell_x(cell_2, @map.width)
          is_y = self.get_cell_y(cell_1, @map.width) == self.get_cell_y(cell_2, @map.width)
          return is_x || is_y
        end

        def remake_line(last_cell, cell, final_cell)
          direction = self.get_dir_num(cell[0])
          to_cell = self.get_cell_num(cell[1..cell.length - 1])
          length = 0
          if self.inline(last_cell, to_cell)
            length = self.get_estimated_distance_between(last_cell, to_cell)
          else
            length = (((self.get_estimated_distance_between(last_cell, to_cell) / 1.4).truncate).to_s).to_i
          end
          back_cell = last_cell
          actual_cell = last_cell
          for $i in [0..length - 1]
            actual_cell = self.next_cell(actual_cell, direction)
            back_cell = actual_cell
          end
          return cell + ",1"
        end

        def remake_path(start_cell, path)
          new_path = ''
          new_cell = self.get_cell_num(path[path.length - 3..path.length - 1])
          last_cell = start_cell
          $i = 0
          while $i <= path.length - 1
            actual_cell = path[$i, $i + 3]
            line_data = self.remake_line(last_cell, actual_cell, new_cell).split(',')
            new_path += line_data[0]
            if(line_data[1] == nil)
              return new_path
            end
            last_cell = self.get_cell_num(actualCell[1..actual_cell.length - 1])
            $i += 3
          end
          destination = get_cell_num(path[path.length - 3..path.length - 1])
          new_direction = get_dir_num(path[path.length - 4..path.length - 3])
          return new_path
        end

        def next_cell(cell, dir)
          case dir
            case 0
              return cell + 1
            case 1
              return cell + @map.width
            case 2
              return cell +(@map.width * 2) - 1
            case 3
              return cell + @map.width - 1
            case 4
              return cell -1
            case 5
              return cell - @map.width
            case 6
              return cell - (@map.width * 2) + 1
            case 7
              return cell - @map.width + 1
          end
          return -1
        end
      end

    end
  end
end
