# run with ruby -I lib

require 'money-tree'
gem "colorize"
require 'colorize'

def show_node(node)
  puts "Index: #{node.index.to_s.light_blue}"
  puts "Depth: #{node.depth.to_s.light_blue}"
  puts "Identifier: #{node.to_identifier.light_blue}"
  puts "Fingerprint: #{node.to_fingerprint.light_blue}"
  puts "to_address: #{node.to_address.green}"
  puts "Pub (hex): #{node.public_key.to_hex.green}"
  puts "Priv (hex): #{node.private_key.to_hex.red}"
  puts "Priv (wif): #{node.private_key.to_wif.red}"
  puts "Chain Code (hex): #{node.chain_code_hex.light_blue}"
  puts "to_serialized_hex: #{node.to_serialized_hex.green}"
  puts "to_serialized_hex(:private): #{node.to_serialized_hex(:private).red}"
  puts "to_serialized_address(pub): #{node.to_serialized_address.green}"
  puts "to_serialized_address(:private): #{node.to_serialized_address(:private).red}"
end

HEX_SEED = '000102030405060708090a0b0c0d0e0f'
@master = MoneyTree::Master.new seed_hex: HEX_SEED
show_node(@master)
payments_node = @master.node_for_path "m/0"

N = 1000
counter = 0
(0...N).each do |i|
  pn = payments_node.subnode(i)

  if (pn.private_key.to_wif.start_with?('K') || pn.private_key.to_wif.start_with?('L'))
    #print '.'
  else
    puts "\nDepth:Index - #{pn.depth}:#{pn.index} #{pn.public_key.to_address.green}\t#{pn.private_key.to_wif.red}"
    counter += 1
  end
end
puts "\n#{counter} out of #{N} failed\n\n"

