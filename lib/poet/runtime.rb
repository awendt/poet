module Poet

  class AlreadyBootstrapped < StandardError; end
  class EmptyEditorVar < StandardError; end
  class HandCraftedConfigFound < StandardError; end
  class NotBootstrapped < StandardError; end

  class Runtime

    MAGIC_LINE = '# Generated by poet'.freeze

    def initialize(options = {})
      @dir = options.delete(:dir)
      @force_include = options.delete(:force_include)
      @output = options.delete(:output)
    end

    def bootstrap(file)
      raise Poet::AlreadyBootstrapped if source_dir_exists?

      FileUtils.mkdir_p(@dir)
      FileUtils.mv(file, @dir) if File.file?(file)
    end

    def create(files_to_include = nil, &block)
      raise Poet::NotBootstrapped unless source_dir_exists?
      raise Poet::HandCraftedConfigFound if hand_crafted_config?
      puts "Found generated ssh_config under #{@output}. Overwriting..." if config_exists?

      # build content from list of files
      new_config = files(files_to_include).sort.map do |file|
        yield(file.gsub(/^\.\//, '')) if block_given?
        ["\n# Located in #{file}", File.read(file)]
      end.flatten

      write_to_ssh_config(new_config)
    end

    def edit(file)
      raise Poet::EmptyEditorVar if ENV['EDITOR'].to_s.empty?

      filepath = File.join(@dir, file)
      checksum_before = Digest::MD5.file(filepath) rescue '0' * 16
      system("#{ENV['EDITOR']} #{filepath}")
      needs_update = File.exist?(filepath) && checksum_before != Digest::MD5.file(filepath)
      create([file]) if needs_update
    end

    def ls(show_tree: false)
      if show_tree
        print_tree(@dir)
      else
        files = Dir["#{@dir}/**/*"].sort.reject { |file| File.directory?(file) }
        puts files.map { |filename| filename[@dir.size + 1..-1] }.join("\n")
      end
    end

    private

    def source_dir_exists?
      File.directory?(@dir)
    end

    def hand_crafted_config?
      config_exists? && !has_magic_line?
    end

    def config_exists?
      File.exist?(@output)
    end

    def has_magic_line?
      File.new(@output).gets == "#{MAGIC_LINE}\n"
    end

    def print_tree(dir = '.', nesting = 0)
      Dir.entries(dir).sort.each do |entry|
        next if entry =~ /^\.{1,2}/ # Ignore ".", "..", or hidden files
        puts '|   ' * nesting + '|-- #{entry}'
        if File.stat(d = "#{dir}#{File::SEPARATOR}#{entry}").directory?
          print_tree(d, nesting + 1)
        end
      end
    end

    def files(files_to_include = nil)
      whitelist = files_to_include || @force_include.split(',').map { |file| "#{file}.disabled" }
      files = Dir["#{@dir}/**/*"].reject do |file|
        File.directory?(file) || \
          file =~ /\.disabled$/ && !whitelist.include?(File.basename(file))
      end

      files - [@output]
    end

    def write_to_ssh_config(entries = [])
      File.open(@output, 'w', 0600) do |ssh_config|
        ssh_config.puts(MAGIC_LINE)
        ssh_config.puts('# DO NOT EDIT THIS FILE')
        ssh_config.puts("# Create or modify files under #{@dir} instead")
        ssh_config.puts(entries.join("\n"))
      end
    end
  end

end
