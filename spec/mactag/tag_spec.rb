describe 'Tag' do
  it 'does not pollute the global namespace' do
    Object.const_defined?(:Tag).should be_false
  end 
end
