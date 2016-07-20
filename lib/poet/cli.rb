module Poet

  class CLI < Thor

    default_task :create
    class_option :dir,
        desc: 'Use specified directory to collect conf files',
        default: ENV['POET_GLOBDIR'] || File.expand_path('~/.ssh/config.d')
    class_option :output,
        desc: 'Generate output in specified file',
        aliases: '-o',
        default: ENV['POET_OUTPUT'] || File.expand_path('~/.ssh/config')
    class_option :with,
        desc: 'Include an otherwise disabled config file',
        aliases: '-w',
        default: ''
    class_option :verbose,
        desc: 'Be verbose',
        aliases: '-v',
        type: :boolean

    desc 'bootstrap [FILE]',
        'Move ~/.ssh/config (or whatever you specified) to ~/.ssh/config.d/ to help you get started'
    def bootstrap(file=nil)
      Poet::Runtime.new(dir: options[:dir]).bootstrap(File.expand_path(file || options[:output]))
      create
    rescue Poet::AlreadyBootstrapped
      $stderr.puts "You're already good to go."
      Process.exit!(3)
    end

    desc 'completeme', 'Install completion for Bash into ~/.bash_completion.d/'
    def completeme
      completion_dir = File.expand_path('~/.bash_completion.d/')
      FileUtils.mkdir_p(completion_dir)
      say "Copying completion file to #{completion_dir}"
      FileUtils.cp(File.expand_path('../../completion/poet.bash', __FILE__), completion_dir)
      say %Q(To use the completion, execute this command:\n
      echo 'source #{File.join(completion_dir, 'poet.bash')}' >> ~/.bashrc)
    end

    desc '', 'Concatenate all host stanzas under ~/.ssh/config.d/ into a single ~/.ssh/config'
    def create
      runtime_opts = { dir: options[:dir], force_include: options[:with], output: options[:output] }
      Poet::Runtime.new(runtime_opts).create do |file|
        $stdout.puts "Using #{file}" if options.verbose?
      end

    rescue Poet::NotBootstrapped
      $stderr.puts "#{options[:dir]} does not exist or is not a directory"
      Process.exit!(1)
    rescue Poet::HandCraftedConfigFound
      $stderr.puts "Found hand-crafted ssh_config under #{options[:output]}. Please move it out of the way or specify a different output file with the -o option."
      Process.exit!(2)
    end

    desc 'edit FILE', 'Open FILE under ~/.ssh/config.d/ in your favorite $EDITOR'
    def edit(file)
      Poet::Runtime.new(dir: options[:dir], output: options[:output]).edit(file)
    rescue Poet::EmptyEditorVar
      $stderr.puts '$EDITOR is empty. Could not determine your favorite editor.'
      Process.exit!(4)
    end

    desc 'ls', 'List all configuration files'
    option :tree, aliases: '-t', type: :boolean, desc: 'Print tree of config dir'
    def ls
      Poet::Runtime.new(dir: options[:dir]).ls(show_tree: options.tree?)
    end

  end

end
