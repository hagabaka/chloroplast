require 'chloroplast'

# Chloroplast DSL allows creating a table using a binary operator as table
# separator. For example,
#
#   table = Chloroplast.new     \
#     | :name  | :age | :sex    \
#     | 'John' |   30 | :male   \
#     | 'Mary' |   40 | :female \
#
# This code uses formatting and backslashes to show the row boundaries, but
# the DSL is not aware of them. Instead, the DSL requires table headers
# to be of the class Symbol, and assumes all symbols at the beginning of
# the table to be the header row. Then it places subsequent cells into
# rows based on the header row length.
class Chloroplast

  # Allows using a binary operator as table cell separator
  def method_missing(name, *arguments, &block)
    if @cell_separator
      super

    else
      if arguments.length != 1 || block
        raise SyntaxError, 'Cell separator must be binary operator'
      end

      value = arguments.first
      singleton_class.send :alias_method, name, :cell_separator
      @cell_separator = name
      cell_separator value
    end
  end

  # Handling of the cell separator
  def cell_separator(value)
    possibly_header = value.is_a? Symbol

    if @headers.empty?
      unless possibly_header
        raise SyntaxError, 'The table must start with a header row of symbols'
      end
      add_header value

    elsif cells_empty?
      if possibly_header
        add_header value
      else
        append_cell value
      end
    else
      append_cell value
    end

    self
  end
end

