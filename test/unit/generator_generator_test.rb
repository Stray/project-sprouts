require File.join(File.dirname(__FILE__), "test_helper")

require 'sprout/generators/generator/generator_generator'

class GeneratorGeneratorTest < Test::Unit::TestCase
  include SproutTestCase

  context "A new generator generator" do

    setup do
      @temp             = File.join(fixtures, 'generators', 'tmp')
      FileUtils.mkdir_p @temp
      @generator        = Sprout::GeneratorGenerator.new
      @generator.path   = @temp
      @generator.logger = StringIO.new
    end

    teardown do
      remove_file @temp
    end

    should "generate a new generator" do
      @generator.input = 'fwee'
      @generator.execute

      lib_dir = File.join(@temp, 'lib')
      assert_directory lib_dir
      
      test_dir = File.join(@temp, 'test')
      assert_directory test_dir
      
      #TODO: This should be generated by the library creator
      # vendor_dir = File.join(@temp, 'vendor')
      # assert_directory vendor_dir
      
      fixtures_dir = File.join(test_dir, 'fixtures', 'generators')
      assert_directory fixtures_dir
      
      test_file = File.join(test_dir, 'unit', 'fwee_generator_test.rb')
      assert_file test_file do |content|
        assert_matches /FweeGeneratorTest/, content
      end
      
      test_helper_file = File.join(test_dir, 'unit', 'test_helper.rb')
      assert_file test_helper_file
      
      generators_dir = File.join(lib_dir, 'generators')
      assert_directory generators_dir
      
      generator_file = File.join(generators_dir, 'fwee_generator.rb')
      assert_file generator_file
      
      templates_dir = File.join(generators_dir, 'templates')
      assert_directory templates_dir
      
      template_file = File.join(templates_dir, 'fwee.as')
      assert_file template_file
      
      bin_dir = File.join(@temp, 'bin')
      assert_directory bin_dir
      
      executable_file = File.join(bin_dir, 'fwee')
      assert_file executable_file
    
    end
    
    should  'generate a new generator in a namespaced directory' do
      @generator.input = 'fwi'
      @generator.namespace = 'sigmund'
      @generator.execute

      lib_dir = File.join(@temp, 'lib')
      assert_directory lib_dir
      
      namespace_dir = File.join(lib_dir, 'sigmund')
      assert_directory namespace_dir
      
      generator_dir = File.join(namespace_dir, 'generators')
      assert_directory generator_dir
      
    end

  end
end

