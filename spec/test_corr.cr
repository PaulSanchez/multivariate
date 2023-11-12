require "../src/using_matrix"
include Multivariate

pp cov_matrix = Multivariate.cov([[1.0, 2.0, 4.0, 3.0], [10.0, -11.0, 14.0, -13.0]])
pp corr_matrix = Multivariate.corr([[1.0, 2.0, 4.0, 3.0], [10.0, -11.0, 14.0, -13.0]])
pp cov_matrix.determinant
pp corr_matrix.determinant
pp cov_matrix = Multivariate.cov([[1.0, 2.0, 3.0], [10.0, 11.0, 12.0]])
pp corr_matrix = Multivariate.corr([[1.0, 2.0, 3.0], [10.0, 11.0, 12.0]])
pp cov_matrix.determinant
pp corr_matrix.determinant
