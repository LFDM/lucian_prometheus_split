#!/usr/bin/env ruby

require 'nokogiri'

parts = [
  '1-5',
  '6-13',
  '14-20',
  '21-26',
  '27-35',
  '36-43',
  '44-45',
  '46-52',
  '53-58',
  '59-62',
  '63-73',
  '74-78',
  '79-88',
  '89-95',
  '96-105',
  '106-110',
  '111-133'
]

template = File.read('template.xml')
complete = Nokogiri::XML(File.read('complete.xml'))

parts.each do |part|
  treebank = Nokogiri::XML(template)
  Range.new(*part.split('-')).each do |id|
    sentence = complete.xpath(%{/treebank/sentence[@id="#{id}"]})
    treebank.root.add_child(sentence)
    File.write("#{part}.xml", treebank.to_xml)
  end
end
