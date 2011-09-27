# vi: set fileencoding=utf-8 :
require 'citrus'

Citrus.load('key_value')

describe KeyValue do
  it 'recognises positive integers correctly' do
    match = KeyValue.parse('27', :root => :integer)
    match.should == '27'
    match.value.should == 27
  end
end
