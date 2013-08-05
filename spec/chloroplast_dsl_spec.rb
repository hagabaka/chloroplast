require 'chloroplast/dsl'

describe Chloroplast do
  describe 'with DSL' do
    it 'can be initialized with DSL' do
      table = Chloroplast.new     \
        | :name  | :age | :sex    \
        | 'John' |   30 | :male   \
        | 'Mary' |   40 | :female \

      expect(table.objects[1].name).to be == 'Mary'
    end

    it 'raises NoMethodError when any missing method beside the separator is used' do
      table = Chloroplast.new  \
          | :foo | :bar | :baz \
          |    1 |    2 |    3 \

      expect {table.foo}.to raise_error(NoMethodError)
    end

    it 'raises error when header row is missing' do
      expect do
        Chloroplast.new        \
          |    1 |    2 |    3 \
          |    4 |    5 |    6 \
      end.to raise_error(/header/i)
    end

    it 'allows using other binary operator methods as table cell separator' do
      # it is necessary to write () after new when using [] as cell "separators"
      table = Chloroplast.new()       \
        [ :name  ][ :age ][ :sex    ] \
        [ 'John' ][   30 ][ :male   ] \
        [ 'Mary' ][   40 ][ :female ] \

      expect(table.objects[1].name).to be == 'Mary'
    end
  end
end
