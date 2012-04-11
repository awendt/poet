ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
ENV['POET_OUTPUT'] = 'ssh_config'
ENV['POET_GLOBDIR'] = '.'

require 'aruba/cucumber'
