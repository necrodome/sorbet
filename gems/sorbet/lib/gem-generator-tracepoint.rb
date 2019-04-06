#!/usr/bin/env ruby

# frozen_string_literal: true
# typed: true

class Sorbet; end
module Sorbet::Private; end

require_relative './sorbet'
require_relative './require_everything'
require_relative './gem-generator-tracepoint/tracer'
require_relative './gem-generator-tracepoint/tracepoint_serializer'

require 'set'

# TODO switch the Struct handling to:
#
# class Subclass < Struct(:key1, :key2)
# end
#
# generating:
#
# TemporaryStruct = Struct(:key1, :key2)
# class Subclass < TemporaryStruct
# end
#
# instead of manually defining every getter/setter

module Sorbet::Private
  module GemGeneratorTracepoint
    OUTPUT = './sorbet/rbi/gems/'
    Sorbet.sig {params(output_dir: String).void}
    def self.main(output_dir = OUTPUT)
      trace_results = Tracer.trace do
        Sorbet::Private::RequireEverything.require_everything
      end

      FileUtils.rm_r(output_dir) if Dir.exist?(output_dir)
      TracepointSerializer.new(trace_results).serialize(output_dir)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Sorbet::Private::GemGeneratorTracepoint.main
end