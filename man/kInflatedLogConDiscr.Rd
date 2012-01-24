\name{kInflatedLogConDiscr}
\alias{kInflatedLogConDiscr}
\title{Compute a mixture of a point mass at 0 and a log-concave probability mass function from i.i.d. data}
\description{Using an EM algorithm, compute an estimate of a mixture of a point mass at \eqn{k} and a 
log-concave probability mass function from discrete i.i.d. data.}
\usage{kInflatedLogConDiscr(x, k = 0, prec1 = 1e-10, prec2 = 1e-15, 
    itermax = 200, output = TRUE, theta0 = 0.5, p0 = NA)}
\arguments{
  \item{x}{Vector of observations.}
  \item{k}{Point at which inflation should be assumed. Must be in \eqn{x_1, x_1 + 1, \ldots, x_{n - 1}, x_n}.}
  \item{prec1}{Precision for stopping criterion.}
  \item{prec2}{Precision to remove ends of support in case weights \eqn{<}\code{prec2}.}
  \item{itermax}{Maximal number of iterations of EM algorithm.}
  \item{output}{Logical, if \code{TRUE}, progress of EM algorithm is shown.}
  \item{theta0}{Optional initialization for \eqn{\theta_0}, the point mass at \eqn{k}.}
  \item{p0}{Optional initialization for the PMF.}
}
\details{Given a vector of observations \eqn{{\bold{x}_n} = (x_1, \ldots, x_n)}{x_n = (x_1, \ldots, x_n)} from a discrete PMF with a (potential)
point mass at \eqn{k} (typically \eqn{k = 0}), \code{\link{kInflatedLogConDiscr}} computes a pmf that is a mixture between a point mass at \eqn{k} and a log-concave PMF on \eqn{x}. 
To accomplish this, an EM algorithm is used.}
\value{A list containing the following elementes:
\item{z}{The support.}
\item{f}{The estimated \eqn{k}-inflated log-concave PMF.}
\item{E(L)}{The value of the expected composite log-likelihood at the maximum.}
\item{loglik}{The value of the composite log-likelihood at the maximum.}
\item{theta}{The estimated weight at \eqn{k}.}
\item{logconc.pmf}{The log-concave part of the mixture.}
\item{logconc.z}{The support of \code{logconc.pmf}.}
}
\references{
Balabdaoui, F., Jankowski, H., Rufibach, K., and Pavlides, M. (2012).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
Preprint.

Weyermann, K. (2007).
An Active Set Algorithm for Log-Concave Discrete Distributions.
\emph{MSc thesis, University of Bern} (Supervisor: Lutz Duembgen).
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@gmail.com} \cr \url{http://www.kasparrufibach.ch} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann \email{kathrin.weyermann@bkw-fmb.ch}
}
\examples{

## -----------------------------------------------
## generate zero-inflated negative binomial sample
## -----------------------------------------------
set.seed(2011)
n <- 100
theta <- 0.05
r <- 6
p <- 0.3
x <- rnbinom(n, r, p)

## inflate at 0
x <- ifelse(runif(n) <= theta, 0, x)

## estimate log-concave MLE
fit1 <- logConDiscrMLE(x, w = NA, psi_o = NA, prec = 1e-05, output = TRUE)

## estimate zero-inflated log-concave MLE
fit2 <- kInflatedLogConDiscr(x, k = 0)

## plot the results
par(mfrow = c(1, 1), las = 1)
plot(fit1$x, exp(fit1$psi), type = "b", col = 2, xlim = range(x), xlab = "x", 
    ylim = c(0, max(exp(fit1$psi), fit2$f)), ylab = "PMF", 
    main = "Estimate MLE from a zero-inflated negative-binomial", pch = 19)
lines(fit2$z, fit2$f, type = "b", col = 4, pch = 15)

## add the true PMF we sampled from
z <- fit2$z
f.true <- theta * c(1, rep(0, length(z) - 1)) + (1 - theta) * dnbinom(z, r, p)
lines(z, f.true, col = 6, type = "b", pch = 17)

legend("topright", c("log-concave MLE", "zero-inflated log-concave MLE", 
    "true PMF"), col = c(2, 4, 6), lty = c(1, 1, 1), pch = c(19, 15, 17), 
    bty = "n")
    
\dontrun{
## -----------------------------------------------
## generate seven-inflated negative binomial sample
## -----------------------------------------------
theta <- 0.05
r <- 4
p <- 0.3
n <- 10000
x <- rnbinom(n, r, p)
x <- ifelse(runif(n) <= theta, 7, x)
x <- c(x, rep(7, 10))

## compute different estimates
zero.mle <- kInflatedLogConDiscr(x, k = 7)
mle <- logConDiscrMLE(x, output = FALSE)
f.mle <- exp(mle$psiSupp)
z<-	zero.mle$z
f1 <- theta * c(rep(0, 7 - min(x)), 1, rep(0, max(x) - 7))
f2 <- (1 - theta) * dnbinom(z, r, p)
f.true <- f1 + f2
true <- dnbinom(z, r, p)
f.fit <- zero.mle$f
xx <- sort(unique(x))
emp <- rep(0, length(z))
emp[xx - min(x) + 1] <- as.vector(table(x) / n)

## plot results
plot(z, f.true, type = "l", ylim = c(0, max(emp)), xlab = "x", 
    ylab = "PMF", main = "Illustration k-inflated estimator")
points(z, true, type = "l", lty = 2)
points(z, f.fit, type = "l", col = "red")
points(z, zero.mle$logconc.pmf, type = "l", col = "red", lty = 2)
points(min(x):max(x), f.mle, type = "l", col = "green")
points(z, emp, type = "l", col = "purple")
points(z, emp, col = "purple")
legend("topright", inset = 0.05, c("true", "true less seven", "seven-inflated", 
    "recovered", "logconc", "empirical"), lty=c(1, 2, 1, 2, 1, 1), col = c("black", 
    "black", "red", "red", "green", "purple"))

## zoom in near mode
subs <- 4:12
plot(z[subs], f.true[subs], type = "l", ylim = c(0, max(emp)), xlab = "x", 
    ylab = "PMF", main = "Illustration k-inflated estimator")
points(z[subs], true[subs], type = "l", lty = 2)
points(z[subs], f.fit[subs], type = "l", col = "red")
points(z[subs], zero.mle$logconc.pmf[subs], type = "l", col = "red", lty = 2)
points((min(x):max(x))[subs], f.mle[subs], type = "l", col = "green")
points(z[subs], emp[subs], type = "l", col = "purple")
points(z[subs], emp[subs], col = "purple")
}
}
\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}



