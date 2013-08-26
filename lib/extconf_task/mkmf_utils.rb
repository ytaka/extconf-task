require "mkmf"

# @param [String] header Header name
# @param [String] gem_name Name of target gem
# @param [Array] paths_from_gem_root Paths from gem root to search header. If paths_from_gem_root is empty, this method automatically search all subdirectories of target gem
def find_header_in_gem(header, gem_name, *paths_from_gem_root)
  header_dirs = nil
  begin
    require "rubygems"
    spec = Gem::Specification.find_by_name(gem_name)
    if paths_from_gem_root.empty?
      if header_path = Dir.glob(File.join(spec.full_gem_path, "**", header)).first
        header_dirs = [File.dirname(header_path)]
      else
        return false
      end
    else
      header_dirs = paths_from_gem_root.map do |path|
        File.join(spec.full_gem_path, path)
      end
    end
  rescue LoadError
  end
  find_header(header, *header_dirs)
end
