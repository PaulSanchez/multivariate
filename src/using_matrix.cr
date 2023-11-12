# TODO: Write documentation for `Multivariate`
require "matrix"

module Multivariate
  VERSION = "0.1.0"

  @[AlwaysInline]
  private def self.sqr(x)
    x * x
  end

  def self.sample_stats(ary)
    inv_n = 1.0 / ary.size
    avg = ary.sum.to_f * inv_n
    std_dev = Math.sqrt(ary.map { |x| sqr(x) }.reduce { |x, m| m + x } * inv_n - sqr(avg))
    {avg, std_dev}
  end

  def self.center(ary) : Array(Float64)
    x_bar, _ = sample_stats(ary)
    ary.map { |x| x - x_bar }
  end

  def self.normalize(ary) : Array(Float64)
    x_bar, s = sample_stats ary
    s_inv = 1.0 / s
    ary.map { |x| (x - x_bar) * s_inv }
  end

  def self.cov(ary : Array(Array(Float64)), round = 8)
    centered = if ary.size > ary[0].size
                 ary.transpose.map { |vec| center(vec) }
               else
                 ary.map { |vec| center(vec) }
               end
    n = centered[0].size
    analysismatrix = Matrix.rows(centered.transpose)
    xtx = (analysismatrix.transpose * analysismatrix)
    (analysismatrix.transpose * analysismatrix).map { |x| (x / n).round(round) }
  end

  def self.corr(ary : Array(Array(Float64)), round = 8)
    normalized = if ary.size > ary[0].size
                   ary.transpose.map { |vec| normalize(vec) }
                 else
                   ary.map { |vec| normalize(vec) }
                 end
    n = normalized[0].size
    analysismatrix = Matrix.rows(normalized.transpose)
    ((analysismatrix.transpose * analysismatrix) / n).map { |x| x.round(round) }
  end
end
