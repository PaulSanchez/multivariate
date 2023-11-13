# TODO: Write documentation for `Multivariate`
require "linalg"

module Multivariate
  VERSION = "0.1.0"

  include LA

  @[AlwaysInline]
  private def sqr(x)
    x * x
  end

  private def sample_stats(ary)
    inv_n = 1.0 / ary.size
    avg = ary.sum * inv_n
    std_dev = Math.sqrt(ary.map { |x| sqr(x) }.reduce { |x, m| m + x } * inv_n - sqr(avg))
    {avg, std_dev}
  end

  private def center(ary) : Array(Float64)
    x_bar, _ = sample_stats(ary)
    ary.map { |x| x - x_bar }
  end

  private def normalize(ary) : Array(Float64)
    x_bar, s = sample_stats ary
    s_inv = 1.0 / s
    ary.map { |x| (x - x_bar) * s_inv }
  end

  def noninvertible?(mat)
    mat.rank < {mat.nrows, mat.ncolumns}.min
  end

  def cov(ary : Array(Array(Float64)), round = 8)
    centered = if ary.size > ary[0].size
                 ary.transpose.map { |vec| center(vec) }
               else
                 ary.map { |vec| center(vec) }
               end
    n = centered[0].size
    analysismatrix = GMat.new(centered.transpose)
    xtx = analysismatrix.transpose * analysismatrix
    xtx.map_with_index do |elt, row, col|
      ((elt / Math.sqrt(xtx[row, row] * xtx[col, col])) / n).round(round)
    end
  end

  def covariance(ary : Array(Array(Float64)), round = 8)
    cov(ary, round)
  end

  def corr(ary : Array(Array(Float64)), round = 8)
    normalized = if ary.size > ary[0].size
                   ary.transpose.map { |vec| normalize(vec) }
                 else
                   ary.map { |vec| normalize(vec) }
                 end
    n = normalized[0].size
    analysismatrix = GMat.new(normalized.transpose)
    (analysismatrix.transpose * analysismatrix).map_with_index do |elt, row, col|
      (elt / n).round(round)
    end
  end

  def correlation(ary : Array(Array(Float64)), round = 8)
    corr(ary, round)
  end
end
