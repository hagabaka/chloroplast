# Chloroplast allows creating objects using a tabular format.
# The table's headers become objects' attribute names, and each row
# of the table defines one object's attribute values. Usually, you
# will want to use the DSL to create tables.
class Chloroplast

  # Array of objects defined by the table
  attr_reader :objects

  # Create an empty table
  def initialize
    @cell_separator = nil
    @headers = []
    @struct = nil
    @objects = []
    @current_row = []
  end

  # Returns true iff the table contains no cells other than headers
  def cells_empty?
    @objects.empty? && @current_row.empty?
  end

  # Add a table header
  def add_header(header)
    unless cells_empty?
      raise RuntimeError, 'Headers cannot be added after adding cells'
    end

    if @headers.include? header
      raise ArgumentError, 'There cannot be duplicate headers'
    end

    @headers.push header
  end

  # Add multiple table headers
  def add_headers(*headers)
    headers.each &method(:add_header)
  end

  # Add a table cell, and starting a new row and creating an object if appropriate
  def append_cell(value)
    if @headers.empty?
      raise RuntimeError, 'Headers must be defined before adding cells'

    else
      @struct ||= Struct.new(*@headers)
      @current_row.push value
      if @current_row.length == @headers.length
        @objects.push @struct.new(*@current_row)
        @current_row = []
      end
    end
  end

  # Add multiple table cells
  def append_cells(*values)
    values.each &method(:append_cell)
  end
end

