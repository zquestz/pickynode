# frozen_string_literal: true

require 'awesome_print'
require 'json'
require 'net/http'
require 'optimist'
require 'uri'

# Allows you to easily add/ban/connect/disconnect nodes
# based on User Agent.
class Pickynode
  VERSION = '0.2.2'

  def initialize(opts = {})
    @opts = opts
  end

  def add(filter, limit = nil)
    return unless filter

    validate_limit(limit)

    blockchair_addr_types
      .select { |_, v| v.include?(filter) }
      .each_with_index do |(k, _), i|
        break if limit == i

        run_cmd(%(bitcoin-cli addnode "#{k}" "add"))
      end
  end

  def ban(filter)
    return unless filter

    addr_types
      .select { |_, v| v.include?(filter) }
      .each do |k, _|
        u = URI.parse("https://#{k}")
        run_cmd(%(bitcoin-cli setban "#{u.host}" "add"))
      end
  end

  def connect(filter, limit = nil)
    return unless filter

    validate_limit(limit)

    blockchair_addr_types
      .select { |_, v| v.include?(filter) }
      .each_with_index do |(k, _), i|
        break if limit == i

        run_cmd(%(bitcoin-cli addnode "#{k}" "onetry"))
      end
  end

  def disconnect(filter)
    return unless filter

    addr_types
      .select { |_, v| v.include?(filter) }
      .each do |k, _|
        run_cmd(%(bitcoin-cli disconnectnode "#{k}"))
      end
  end

  def display
    ap addr_types
  end

  def info
    ap getinfo
  end

  def run
    add(@opts[:add], @opts[:limit])
    connect(@opts[:connect], @opts[:limit])

    ban(@opts[:ban])
    disconnect(@opts[:disconnect])

    display_info
  end

  def clear_cache
    @addr_types = nil
    @blockchair_addr_types = nil
  end

  private

  def display_info
    info if @opts[:info]

    # Remove default ticker value. Not applicable.
    @opts.delete(:ticker)

    display if @opts.values.select { |v| v }.empty?
  end

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

  def blockchair_addr_types
    return @blockchair_addr_types if @blockchair_addr_types

    parsed_nodelist = JSON.parse(blockchair_snapshot)
    @blockchair_addr_types = parsed_nodelist['data']['nodes'].transform_values do |v|
      v['version']
    end
  rescue JSON::ParserError
    {}
  end

  def blockchair_snapshot
    chain = case @opts[:ticker]
            when 'BCH'
              'bitcoin-cash'
            when 'BTC'
              'bitcoin'
            end

    Net::HTTP.get(URI.parse("https://api.blockchair.com/#{chain}/nodes"))
  end

  def getinfo
    getblockchaininfo.merge(getnetworkinfo)
  rescue JSON::ParserError
    {}
  end

  def getblockchaininfo
    JSON.parse(`bitcoin-cli getblockchaininfo`)
  rescue JSON::ParserError
    {}
  end

  def getnetworkinfo
    JSON.parse(`bitcoin-cli getnetworkinfo`)
  rescue JSON::ParserError
    {}
  end

  def getpeerinfo
    `bitcoin-cli getpeerinfo`
  end

  def validate_limit(limit)
    return unless limit
    raise 'Limit must be greater than 0' unless limit > 0
  end
end
