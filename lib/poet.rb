require "poet/version"

module Poet

  MAGIC_LINE = "# Generated by #{File.basename(__FILE__)}"

  class << self

    def application
      @application ||= Poet::Application.new
    end
        
  end

  class Application

    def run(options={})
      if !File.directory?(options[:dir])
        $stderr.puts "#{options[:dir]} does not exist or is not a directory"
        Process.exit!(1)
      end

      if File.exists?(options[:ssh_config]) && File.new(options[:ssh_config]).gets == "#{MAGIC_LINE}\n"
        puts "Found generated ssh_config under #{options[:ssh_config]}. Overwriting..."
      elsif File.exists?(options[:ssh_config])
        $stderr.puts "Found hand-crafted ssh_config under #{options[:ssh_config]}. Please move it out of the way or specify a different output file with the -o option."
        Process.exit!(2)
      end

      files = Dir["#{options[:dir]}/**"].reject do |file|
        file =~ /\.disabled$/ && !options[:with].include?("#{File.basename(file, '.disabled')}")
      end

      files -= [options[:ssh_config]]

      entries = []

      files.sort.each do |file|
        entries << File.read(file)
      end

      File.open(options[:ssh_config], 'w', 0600) do |ssh_config|
        ssh_config.puts(MAGIC_LINE)
        ssh_config.puts("# DO NOT EDIT THIS FILE")
        ssh_config.puts("# Create or modify files under #{options[:dir]} instead")
        ssh_config.puts(entries.join("\n"))
      end
    end
 
  end

end