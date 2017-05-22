# frozen_string_literal: true

require 'awesome_print'
require 'json'
require 'net/http'
require 'trollop'
require 'uri'

# Allows you to easily add/ban/connect/disconnect nodes
# based on User Agent.
class Pickynode
  VERSION = '0.1.1'

  def initialize(opts = {})
    @opts = opts
  end

  def add(filter)
    return unless filter
    bitnode_addr_types.each do |k, v|
      run_cmd(%(bitcoin-cli addnode "#{k}" "add")) if v.include?(filter)
    end
  end

  def ban(filter)
    return unless filter
    addr_types.each do |k, v|
      if v.include?(filter)
        u = URI.parse("https://#{k}")
        run_cmd(%(bitcoin-cli setban "#{u.host}" "add"))
      end
    end
  end

  def connect(filter)
    return unless filter
    bitnode_addr_types.each do |k, v|
      run_cmd(%(bitcoin-cli addnode "#{k}" "onetry")) if v.include?(filter)
    end
  end

  def disconnect(filter)
    return unless filter
    addr_types.each do |k, v|
      run_cmd(%(bitcoin-cli disconnectnode "#{k}")) if v.include?(filter)
    end
  end

  def display
    ap addr_types
  end

  def run
    add(@opts[:add])
    connect(@opts[:connect])

    ban(@opts[:ban])
    disconnect(@opts[:disconnect])

    return unless @opts.values.select { |v| v }.empty?

    display
  end

  def clear_cache
    @addr_types = nil
    @bitnode_addr_types = nil
  end

  private

  def run_cmd(cmd)
    puts "Running #{cmd}" if @opts[:output] || @opts[:debug]
    `#{cmd}` unless @opts[:debug]
  end

  def addr_types
    return @addr_types if @addr_types
    nodes = getpeerinfo
    parsed_nodes = JSON.parse(nodes)
    @addr_types = parsed_nodes.map do |n|
      [n['addr'], n['subver']]
    end.to_h
  rescue JSON::ParserError
    {}
  end

  def bitnode_addr_types
    return @bitnode_addr_types if @bitnode_addr_types
    parsed_nodelist = JSON.parse(bitnodes_snapshot)
    @bitnode_addr_types = parsed_nodelist['nodes'].map do |k, v|
      [k, v[1]]
    end.to_h
  rescue JSON::ParserError
    {}
  end

  def bitnodes_snapshot
    Net::HTTP.get(URI.parse('https://bitnodes.21.co/api/v1/snapshots/latest/'))
  end

  def getpeerinfo
    `bitcoin-cli getpeerinfo`
  end
end
