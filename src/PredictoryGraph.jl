module PredictoryGraph

using Plots
using CSV
using TypedTables

dataset = Table(CSV.File("CompanyABCProfit.csv"))
year = dataset.Year
profit = sort(dataset.Profit)

plot(year, profit)
histogram(profit, normalize=:pdf, label="experimental")

function mean(population)
    sum(population)/length(population)
end

function deviation(population)
    m = mean(population)
    sqrt(sum((population .- m).^2))/sqrt(length(population))
end

m = mean(profit)
σ = deviation(profit)

f(x) = exp(-(x - m)^2 / (2*σ^2))/(sqrt(2*pi)*σ)
plot!(f, linewidth = 3, label="normal distr.")

ϕ(x) = σ * f(x)

Δx = 12000
n = f.(profit)
t = (profit.-m)./σ
n′ =(Δx .* n.*ϕ.(t))./σ
plot!(profit, n′,linewidth = 3 ,label="hypothese")

end
