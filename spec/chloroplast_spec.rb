require 'chloroplast'

describe Chloroplast do
  it 'is empty when first initialized' do
    expect(Chloroplast.new.objects).to be_empty
  end

  it 'can be initialized' do
    table = Chloroplast.new
    table.add_headers  :name, :age, :sex
    table.append_cells 'John', 30, :male,
                       'Mary', 40, :female

    expect(table.objects.find {|person| person.name == 'John'}.age).to be == 30
  end

  it 'raises error when adding header after cells' do
    table = Chloroplast.new
    table.add_header :name
    table.append_cell 'John'
    expect {table.add_header :age}.to raise_error(/header/i)
  end

  it 'raises error when adding cells before any headers' do
    table = Chloroplast.new
    expect {table.add_cell 'John'}.to raise_error(/header/i)
  end

  it 'raises error when adding a duplicate header' do
    table = Chloroplast.new
    table.add_header :name
    expect {table.add_header :name}.to raise_error(/duplicate/i)
  end
end

