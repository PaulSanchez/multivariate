require "./spec_helper"

# describe Multivariate do
#   # TODO: Write tests
# 
#   it "works" do
#     false.should eq(true)
#   end
# end

include Multivariate

pp cov_matrix = cov([[1.0, 2.0, 4.0, 3.0], [10.0, -11.0, 14.0, -13.0]])
pp corr_matrix = corr([[1.0, 2.0, 4.0, 3.0], [10.0, -11.0, 14.0, -13.0]])
pp cov_matrix.det
pp corr_matrix.det unless noninvertible?(corr_matrix)
pp cov_matrix = cov([[1.0, 2.0, 3.0], [10.0, 11.0, 12.0]])
pp corr_matrix = corr([[1.0, 2.0, 3.0], [10.0, 11.0, 12.0]])

result_ok = noninvertible?(corr_matrix)
puts "noninvertible?: #{result_ok}"
pp corr_matrix.det unless result_ok
