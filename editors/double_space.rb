#!/usr/bin/env ruby

double_spaced = File.readlines(ARGV.first).join("\n")
File.write(ARGV.first, double_spaced)