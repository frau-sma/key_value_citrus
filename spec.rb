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
end
