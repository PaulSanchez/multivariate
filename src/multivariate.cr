# TODO: Write documentation for `Multivariate`
require "linalg"

module Multivariate
  VERSION = "0.1.0"

  include LA

  # TWO_PI = 2.0 * Math::PI

  def self.sample_mean(ary : Array(Float64)) : Float64
    ary.sum / ary.size
  end

  def self.center(ary : Array(Float64)) : Array(Float64)
    x_bar = sample_mean ary
    ary.map { |x| x - x_bar }
  end

  def self.corr(ary : Array(Array(Float64)))
    centered = if ary.size > ary[0].size
                 ary.transpose.map { |vec| center(vec) }
               else
                 ary.map { |vec| center(vec) }
               end
    analysismatrix = GMat.new(centered.transpose)
    xtx = analysismatrix.transpose * analysismatrix
    xtx.map_with_index do |elt, row, col|
      (elt / Math.sqrt(xtx[row, row] * xtx[col, col]))
    end.map { |x| x.round(8) }
  end
end
