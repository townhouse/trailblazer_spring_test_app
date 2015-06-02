require 'test_helper'

class ThingCrudTest < MiniTest::Spec
  describe 'Create' do
    it 'persists valid' do
      thing = Thing::Create[thing: { name: 'Acme Inc' }].model

      thing.persisted?.must_equal true
      thing.name.must_equal 'Acme Inc'
    end
  end
end
