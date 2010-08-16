require 'spec_helper'

describe Mactag::Tag::App do
  describe '#initialize' do
    before do
      @tag = 'app/**/*.rb'
      @app = Mactag::Tag::App.new(@tag)
    end

    it 'should set the tag' do
      @app.tag.should == @tag
    end
  end
end
