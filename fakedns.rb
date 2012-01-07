#!/usr/bin/env ruby

require 'rubygems'
require 'rubydns'

$R = Resolv::DNS.new(:nameserver =>"GET YOUR NAMESERVER HERE")
Name = Resolv::DNS::Name

RubyDNS::run_server(:listen => [[:udp, "0.0.0.0", 53]]) do
    # For this exact address record, return an IP address
    match("guzzoni.apple.com", :A) do |transaction|
        transaction.respond!("GET YOUR IP HERE")
    end

    # Default DNS handler
    otherwise do |transaction|
        transaction.passthrough!($R)
    end
end

