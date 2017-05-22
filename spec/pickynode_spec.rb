# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'mocks'

describe Pickynode do
  # Debug mode makes sure we don't execute real commands.
  let(:opts) do
    { debug: true }
  end

  # IPv6 addresses are long, easier to refer by let.
  let(:ipv6_ip) { '[2a01:e34:ee3a:5730:21f:5bff:fec5:e356]:8333' }
  let(:ipv6_ip_no_port) { '[2a01:e34:ee3a:5730:21f:5bff:fec5:e356]' }

  # The currently connected nodes for the specs.
  let(:node_hash) do
    { '131.114.88.218:33422' => '/FirstClient/',
      ipv6_ip => '/SecondClient/' }
  end

  subject { Pickynode.new(opts) }

  describe '.add' do
    it 'should add nodes based on user agent' do
      expect(subject).to receive(:bitnodes_snapshot).once
        .and_return(BITNODES_SNAPSHOT)
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli addnode "#{ipv6_ip}" "add"))
      subject.add('Satoshi')
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli addnode "88.99.199.87:8333" "add"')
      subject.add('Unlimited')
    end

    it 'should return if the filter is falsy' do
      expect(subject).to_not receive(:bitnodes_snapshot)
      expect(subject).to_not receive(:run_cmd)
      subject.add(false)
      subject.add(nil)
    end
  end

  describe '.ban' do
    it 'should ban nodes based on user agent' do
      expect(subject).to receive(:getpeerinfo).once
        .and_return(PEER_INFO)
      expect(URI).to receive(:parse).with('https://131.114.88.218:33422')
        .and_call_original
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli setban "131.114.88.218" "add"')
      subject.ban('FirstClient')
      expect(URI).to receive(:parse).with("https://#{ipv6_ip}")
        .and_call_original
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli setban "#{ipv6_ip_no_port}" "add"))
      subject.ban('SecondClient')
    end

    it 'should return if the filter is falsy' do
      expect(subject).to_not receive(:getpeerinfo)
      expect(URI).to_not receive(:parse)
      expect(subject).to_not receive(:run_cmd)
      subject.ban(false)
      subject.ban(nil)
    end
  end

  describe '.connect' do
    it 'should connect to nodes based on user agent' do
      expect(subject).to receive(:bitnodes_snapshot).once
        .and_return(BITNODES_SNAPSHOT)
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli addnode "88.99.199.87:8333" "onetry"')
      subject.connect('Unlimited')
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli addnode "#{ipv6_ip}" "onetry"))
      subject.connect('Satoshi')
    end

    it 'should return if the filter is falsy' do
      expect(subject).to_not receive(:bitnodes_snapshot)
      expect(subject).to_not receive(:run_cmd)
      subject.connect(false)
      subject.connect(nil)
    end
  end

  describe '.disconnect' do
    it 'should disconnect nodes based on user agent' do
      expect(subject).to receive(:getpeerinfo).once
        .and_return(PEER_INFO)
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli disconnectnode "#{ipv6_ip}"))
      subject.disconnect('SecondClient')
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli disconnectnode "131.114.88.218:33422"')
      subject.disconnect('FirstClient')
    end

    it 'should return if the filter is falsy' do
      expect(subject).to_not receive(:getpeerinfo)
      expect(subject).to_not receive(:run_cmd)
      subject.disconnect(false)
      subject.disconnect(nil)
    end
  end

  describe '.display' do
    it 'should display connected nodes' do
      expect(subject).to receive(:getpeerinfo).and_return(PEER_INFO)
      expect(subject).to receive(:ap).with(node_hash).and_return(node_hash)
      expect(subject.display).to eq(node_hash)
    end
  end

  describe '.run' do
    context 'with opts' do
      let(:opts) do
        {
          debug: true,
          add: 'Wanted',
          connect: 'Now',
          ban: 'Nefarious',
          disconnect: 'Fools'
        }
      end

      it 'should call add, connect, ban and disconnect' do
        expect(subject).to receive(:bitnodes_snapshot).once
          .and_return(BITNODES_SNAPSHOT)
        expect(subject).to receive(:getpeerinfo).and_return(PEER_INFO)
        expect(subject).to receive(:add).with(opts[:add])
          .and_call_original
        expect(subject).to receive(:connect).with(opts[:connect])
          .and_call_original
        expect(subject).to receive(:ban).with(opts[:ban])
          .and_call_original
        expect(subject).to receive(:disconnect).with(opts[:disconnect])
          .and_call_original
        expect(subject).to_not receive(:display)
        subject.run
      end
    end

    context 'without opts' do
      let(:opts) do
        {}
      end

      it 'should call display' do
        expect(subject).to receive(:getpeerinfo).once
          .and_return(PEER_INFO)
        expect(subject).to receive(:ap).with(node_hash).and_return(node_hash)
        expect(subject).to receive(:display).and_call_original
        subject.run
      end
    end
  end

  describe 'clear_cache' do
    it 'should clear the bitnodes cache' do
      expect(subject).to receive(:bitnodes_snapshot).once
        .and_return(BITNODES_SNAPSHOT)
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli addnode "#{ipv6_ip}" "add"))
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli addnode "88.99.199.87:8333" "add"')
      subject.add('Satoshi')
      subject.add('Unlimited')
      subject.clear_cache
      expect(subject).to receive(:bitnodes_snapshot).once
        .and_return(BITNODES_SNAPSHOT)
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli addnode "#{ipv6_ip}" "add"))
      subject.add('Satoshi')
    end

    it 'should clear the getpeerinfo cache' do
      expect(subject).to receive(:getpeerinfo).once
        .and_return(PEER_INFO)
      expect(URI).to receive(:parse).with('https://131.114.88.218:33422')
        .and_call_original
      expect(URI).to receive(:parse).with(%(https://#{ipv6_ip}))
        .and_call_original
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli setban "131.114.88.218" "add"')
      expect(subject).to receive(:run_cmd)
        .with(%(bitcoin-cli setban "#{ipv6_ip_no_port}" "add"))
      subject.ban('FirstClient')
      subject.ban('SecondClient')
      subject.clear_cache
      expect(subject).to receive(:getpeerinfo).once
        .and_return(PEER_INFO)
      expect(URI).to receive(:parse).with('https://131.114.88.218:33422')
        .and_call_original
      expect(subject).to receive(:run_cmd)
        .with('bitcoin-cli setban "131.114.88.218" "add"')
      subject.ban('FirstClient')
    end
  end
end
