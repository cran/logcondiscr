\name{logConDiscrCI}
\alias{logConDiscrCI}
\title{Compute pointwise confidence bands for the log-concave MLE of a PMF}
\description{Compute pointwise confidence bands for the log-concave maximum likelihood estimate of a log-concave probability mass function based on the limiting
theory developed in Balabdaoui et al (2011).}
\usage{logConDiscrCI(dat, conf.level = 0.95, type = c("MLE", "all")[1], 
    B = 1000, output = TRUE, seed = 2011)}
\arguments{
  \item{dat}{Data to compute MLE and confidence band for.}
  \item{conf.level}{The confidence level to be used.}
  \item{type}{To compute confidence bands one theoretically needs to know the knots of the true PMF. For type \code{MLE} the knots of the MLE will be used instead
  and for type \code{all} all observations will be considered knots. The latter is conservative and gives pointwise confidence intervals that are based on standard 
  errors from a Normal approximation (the latter comes from the asymptotic theory in Balabdaoui et al, 2011).}
  \item{B}{Number of samples to be drawn to compute resampling quantiles.}
  \item{output}{If \code{TRUE}, progress of computations is output.}
  \item{seed}{Optional seed.}
}
\details{The pointwise confidence bands are based on the limiting theory in Balabdaoui et al (2011).}
\value{A list with the following components:
  \item{MLE}{The estimated MLE (simply the output list of the function \code{logConDiscrMLE} applied to \code{dat}).}
  \item{emp}{A dataframe containing two columns: the unique sorted observations and the empirical PMF.}
  \item{CIs}{The computed confidence intervals for each \eqn{x \in \{}\code{min(dat), ..., max(dat)}\eqn{\}}.}
}
\references{
Balabdaoui, F., Jankowski, H., and Rufibach, K. (2011).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
Preprint.

Weyermann, K. (2007).
An Active Set Algorithm for Log-Concave Discrete Distributions.
\emph{MSc thesis, University of Bern} (Supervisor: Lutz Duembgen).
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@ifspm.uzh.ch} \cr \url{http://www.biostat.uzh.ch/aboutus/people/rufibach.html} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann \email{kathrin.weyermann@bkw-fmb.ch}
}
\note{Values outside \eqn{[0, 1]} will be clipped. As a consequence, coverage may be higher than \eqn{1 - \alpha}.}
\examples{
# -------------------------------------------------------------
# compute MLE and confidence bands for a random sample from a 
# Poisson distribution
# -------------------------------------------------------------
set.seed(2011)
x <- sort(rpois(n = 100, lambda = 2))
mle <- logConDiscrMLE(x)
psi <- mle$psi

# compute confidence bands
CIs <- logConDiscrCI(x, type = "MLE", output = TRUE, seed = 20062011)$CIs

# plot estimated PMF and log of estimate
par(mfrow = c(1, 2), las = 1)
true <- dpois(0:20, lambda = 2)
plot(mle$x, exp(psi), type = "b", col = 2, xlim = c(min(x), max(x) + 1), 
    xlab = "x", ylim = c(0, max(exp(psi), true, CIs[, 3])), ylab = "PMF", 
    main = "Estimate MLE from a Poisson", pch = 19)
legend("topright", c("truth", "MLE", "confidence bands"), col = c(4, 2, 2), 
    lty = c(1, 1, 2), pch = c(0, 19, NA), bty = "n")

# add true PMF
lines(0:20, true, type = "l", col = 4)

# add confidence bands
matlines(CIs[, 1], CIs[, 2:3], type = "l", lty = 2, col = 2)

# log-density
plot(mle$x, psi, type = "p", col = 2, xlim = c(min(x), max(x) + 1), 
    xlab = "x", ylab = "PMF", main = "Estimate MLE from a Poisson", 
    pch = 19, ylim = c(-6, log(max(exp(psi), true, CIs[, 3]))))
lines(0:20, log(true), type = "l", col = 4)

# add confidence bands
matlines(CIs[, 1], log(CIs[, 2:3]), type = "l", lty = 2, col = 2)


# -------------------------------------------------------------
# compute confidence bands when only estimate (not original data)
# are available (as a an example we simply use the estimator from
# above)
# -------------------------------------------------------------
x.est <- 0:6
est <- c(0.09, 0.30, 0.30, 0.19, 0.09, 0.02, 0.01)

# generate original data (up to given precision)
x <- rep(0:6, times = 100 * est)
}
\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}

