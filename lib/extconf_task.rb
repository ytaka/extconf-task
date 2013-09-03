require "rake/tasklib"
require "extconf_task/version"

# @note ExtconfTask search files by the pattern "**/extconf.rb"
# and create tasks for the found 'extconf.rb'.
# 
# @example If you want to change the pattern, we write code as below.
# ExtconfTask.new do |et|
#   et.extconf_pattern = "pattern/extconf.rb"
# end
# 
# @example If you want to specify paths of extconf.rb, we write code as below. At this time, extconf_pattern are ignored.
# ExtconfTask.new do |et|
#   et.extconf_paths << "path1/extconf.rb"
#   et.extconf_paths << "path2/extconf.rb"
# end
class ExtconfTask < Rake::TaskLib
  VERSION = ExtconfTaskVersion::VERSION

  attr_accessor :extconf_pattern
  attr_reader :extconf_paths
  attr_accessor :command_ruby
  attr_accessor :command_make

  DEFAULT_COMMAND_MAKE = "make"
  DEFAULT_COMMAND_RUBY = "ruby"

  def initialize(&block)
    @extconf_pattern = "**/extconf.rb"
    @extconf_paths = []
    @command_ruby = nil
    @command_make = nil
    yield(self) if block_given?
    define
  end

  def each_extconf_directory(&block)
    paths = @extconf_paths
    if paths.empty?
      paths = Dir.glob(@extconf_pattern)
    end

    paths.each do |path|
      unless File.exist?(path)
        raise "File does not exist: #{path}"
      end
      dir = File.dirname(path)
      cd(dir) do
        yield(File.basename(path))
      end
    end
  end
  private :each_extconf_directory

  def makefile_exist?
    File.exist?("Makefile")
  end
  private :makefile_exist?

  def make(task = nil)
    cmd = [@command_make || DEFAULT_COMMAND_MAKE]
    cmd << task if task
    sh(*cmd)
  end
  private :make

  def create_makefile(path)
    ruby = @command_ruby || DEFAULT_COMMAND_RUBY
    sh "#{ruby} #{path}" unless makefile_exist?
  end
  private :create_makefile

  def compile_according_to_makefile
    make
  end
  private :compile_according_to_makefile

  def define
    desc "Create Makefile from extconf.rb"
    task "extconf:makefile" do |t|
      each_extconf_directory do |extconf|
        create_makefile(extconf)
      end
    end

    desc "Compile according to Makefile"
    task "extconf:compile" do |t|
      each_extconf_directory do |extconf|
        create_makefile(extconf)
        compile_according_to_makefile
      end
    end

    desc "Clean generated files (exclude Makefile)"
    task "extconf:clean" do |t|
      each_extconf_directory do |extconf|
        if makefile_exist?
          make("clean")
        end
      end
    end

    desc "Clean generated files (include Makefile)"
    task "extconf:distclean" do |t|
      each_extconf_directory do |extconf|
        if makefile_exist?
          make("distclean")
        end
      end
    end
  end
end
