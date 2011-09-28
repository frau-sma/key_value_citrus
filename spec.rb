# vi: set fileencoding=utf-8 :
require 'citrus'

Citrus.load('key_value')

describe KeyValue do
  describe 'the integer rule' do
    it 'recognises positive integers correctly' do
      match = KeyValue.parse('27', :root => :integer)
      match.should == '27'
      match.value.should == 27
    end

    it 'recognises zero correctly' do
      match = KeyValue.parse('0', :root => :integer)
      match.should == '0'
      match.value.should == 0
    end

    it 'recognises negative integers correctly' do
      match = KeyValue.parse('-4985', :root => :integer)
      match.should == '-4985'
      match.value.should == -4985
    end

    it 'recognises positive integers prefixed with a plus sign' do
      match = KeyValue.parse('+100', :root => :integer)
      match.should == '+100'
      match.value.should == 100
    end

    it 'rejects integers with leading zeros' do
      expect { KeyValue.parse('0043', :root => :integer) }.to raise_error (Citrus::ParseError)
    end
  end

  describe 'the float rule' do
    it 'recognises positive floating-point numbers correctly' do
      match = KeyValue.parse('14.021', :root => :float)
      match.should == '14.021'
      match.value.should == 14.021
    end

    it 'recognises zero correctly' do
      match = KeyValue.parse('0.0', :root => :float)
      match.should == '0.0'
      match.value.should == 0.0
    end

    it 'recognises negative floating-point numbers correctly' do
      match = KeyValue.parse('-88.73', :root => :float)
      match.should == '-88.73'
      match.value.should == -88.73
    end

    it 'recognises positive floating-point numbers prefixed with a plus sign' do
      match = KeyValue.parse('+5.5', :root => :float)
      match.should == '+5.5'
      match.value.should == 5.5
    end

    it 'rejects floating-point numbers with leading zeros' do
      expect { KeyValue.parse('-0006.7', :root => :float) }.to raise_error (Citrus::ParseError)
    end
  end

  describe 'the string rule' do
    it 'accepts a simple double-quoted string' do
      match = KeyValue.parse('"foobar"', :root => :string)
      match.should == '"foobar"'
      match.value.should == 'foobar'
    end

    it 'accepts a double-quoted string containing spaces' do
      match = KeyValue.parse('"foo bar baz quux"', :root => :string)
      match.should == '"foo bar baz quux"'
      match.value.should == 'foo bar baz quux'
    end

    it 'accepts a double-quoted string containing single quotes' do
      match = KeyValue.parse('"This is a \'test\', they say."', :root => :string)
      match.should == '"This is a \'test\', they say."'
      match.value.should == "This is a 'test', they say."
    end

    it 'rejects an empty string' do
      expect { KeyValue.parse('""', :root => :string) }.to raise_error (Citrus::ParseError)
    end
  end

  describe 'the val rule' do
    it 'accepts an integer' do
      match = KeyValue.parse('-401', :root => :val)
      match.should == '-401'
      match.value.should == -401
    end

    it 'accepts a floating-point number' do
      match = KeyValue.parse('0.7', :root => :val)
      match.should == '0.7'
      match.value.should == 0.7
    end

    it 'accepts a double-quoted string' do
      match = KeyValue.parse('"This is a simple test."', :root => :val)
      match.should == '"This is a simple test."'
      match.value.should == 'This is a simple test.'
    end
  end

  describe 'the key rule' do
    it 'accepts a simple identifier that only contains lower-case letters' do
      match = KeyValue.parse('foobar', :root => :key)
      match.should == 'foobar'
      match.value.should == :foobar
    end

    it 'accepts a more complex identifier' do
      match = KeyValue.parse('Foo_Bar_73A', :root => :key)
      match.should == 'Foo_Bar_73A'
      match.value.should == :Foo_Bar_73A
    end

    it 'rejects an identifier that starts with a digit' do
      expect { KeyValue.parse('5foobar', :root => :key) }.to raise_error(Citrus::ParseError)
    end
  end

  describe 'the option rule' do
    it 'accepts a pair with an integer value' do
      match = KeyValue.parse('foo = 17', :root => :option)
      match.should == 'foo = 17'
      match.value.should == {:foo => 17}
    end

    it 'accepts a pair with a floating-point value' do
      match = KeyValue.parse('bar = -421.17', :root => :option)
      match.should == 'bar = -421.17'
      match.value.should == {:bar => -421.17}
    end

    it 'accepts a pair with a string value' do
      match = KeyValue.parse('baz="quux"', :root => :option)
      match.should == 'baz="quux"'
      match.value.should == {:baz => 'quux'}
    end
  end
end
