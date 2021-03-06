\name{logConDiscrMLE}
\alias{logConDiscrMLE}
\title{Compute log-concave probability mass function from i.i.d. data}
\description{Compute the maximum likelihood estimate of a log-concave probability mass function from discrete i.i.d. data.}
\usage{logConDiscrMLE(x, w = NA, psi_o = NA, prec = 1e-05, output = TRUE)}
\arguments{
  \item{x}{Vector of observations. If \code{w = NA}, then weights will be generated for each non-unique observation of \code{x}.}
  \item{w}{If \code{w = NA}, weights will be generated from \code{x}. If \code{w != NA}, then it is assumed that \code{x} and \code{w} are of equal length and 
  the elements in \code{w} correspond to the weights in \code{x}.}
  \item{psi_o}{Optional start vector.}
  \item{prec}{Precision for stopping criterion.}
  \item{output}{Logical, if \code{TRUE}, progress of the active set algorithm is shown.}
}
\details{Given a vector of observations \eqn{{\bold{x}_n} = (x_1, \ldots, x_n)}{x_n = (x_1, \ldots, x_n)} from a discrete PMF,
\code{\link{logConDiscrMLE}} computes a function \eqn{\widehat p_k}{\widehat p_k} on \eqn{\{x_1, \ldots, x_n\}} with knots only 
in \eqn{\{x_1, \ldots, x_n\}}{\{x_1, \ldots, x_n\}} such that 
  
  \deqn{L(\bold{p}) = \sum_{i=1}^n w_i \log(p_i)}
  
  is maximal over all log-concave PMFs \eqn{\{p_k\}, k=1, \ldots, n}, where \eqn{w_i} is the frequency of the observation \eqn{x_i}. 
  To accomplish this, an active set algorithm is used.}
\value{A list containing the following elementes:
\item{x}{Vector of unique observations, sorted.}
\item{w}{Generated weights.}
\item{psi}{The estimated log-density on the grid of unique, sorted observations.}
\item{L}{The value of the log-likelihood at the maximum.}
\item{IsKnot}{Binary vector where \code{isKnot_k = 1} if \eqn{\psi} has a knot at \eqn{x_k}.}
\item{xSupp}{The full support \eqn{\{x_1, x_1 + 1, \ldots, x_m - 1, x_m\}}.}
\item{psiSupp}{\eqn{\psi} interpolated on \code{xSupp}.}
}
\references{
Balabdaoui, F., Jankowski, H., Rufibach, K., and Pavlides, M. (2013).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
\emph{J. R. Stat. Soc. Ser. B Stat. Methodol.}, \bold{75}(4), 769--790. 

Weyermann, K. (2007).
An Active Set Algorithm for Log-Concave Discrete Distributions.
\emph{MSc thesis, University of Bern} (Supervisor: Lutz Duembgen).
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@gmail.com} \cr \url{http://www.kasparrufibach.ch} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann 
}
\examples{

# -------------------------------------------------------------
# compute MLE for a random sample from a Poisson distribution
# -------------------------------------------------------------
x <- sort(rpois(n = 100, lambda = 2))
mle <- logConDiscrMLE(x)
psi <- mle$psi

# plot estimated PMF and log of estimate
par(mfrow = c(1, 2), las = 1)
true <- dpois(0:20, lambda = 2)
plot(mle$x, exp(psi), type = "p", col = 2, xlim = range(x), xlab = "x", 
    ylim = c(0, max(exp(psi), true)), ylab = "PMF", 
    main = "Estimate MLE from a Poisson", pch = 19)
legend("topright", c("truth", "MLE"), col = c(4, 2), lty = c(1, 0), 
    pch = c(0, 19), bty = "n")

# add true PMF
lines(0:20, true, type = "l", col = 4)

# log-density
plot(mle$x, psi, type = "p", col = 2, xlim = range(x), xlab = "x", 
    ylab = "PMF", main = "Estimate MLE from a Poisson", pch = 19)
lines(0:20, log(true), type = "l", col = 4)

# use a priori specified weights: mle = mle2
mle2 <- logConDiscrMLE(x = unique(x), w = table(x))


## -------------------------------------------------------------
## Illustrate the limit process: the code below can be used to
## to reproduce the limit process figure in Balabdaoui et al (2011)
## -------------------------------------------------------------
a <- 1
b <- 7
c <- 8
d <- 11
e <- 2
n <- 10 ^ 2

## support
x <- seq(a, d, by = 1)

## true density
dens <- dTriangular(a, b, c, d, e)
logdens <- log(dens)
rand <- rTriangular(n, a, b, c, d, e)$rand

## empirical
emp <- table(rand) / n
x.emp <- names(table(rand))

## log-concave MLE
mle <- logConDiscrMLE(rand, output = FALSE)

## plot log PMF and PMF
par(mfrow = c(1, 2))
plot(x, logdens, type = "l", col = 1, pch = 19, main = "log-density", 
    xlim = c(a, d), ylim = range(range(log(emp), logdens)))
lines(x, logdens, type = "l", col = 1, lwd = 0.1)
points(x.emp, log(emp), col = 4, pch = 19)
points(mle$x, mle$psi, col = 6, pch = 19)
abline(v = mle$x[mle$isKnot == 1], lty = 3, col = 3)

plot(x, dens, type = "l", col = 1, pch = 19, main = "density", 
    xlim = c(a, d), ylim = c(0, max(dens, emp)))
lines(x, dens, type = "l", col = 1, lwd = 0.1)
points(x.emp, emp, col = 4, pch = 19)
points(mle$x, exp(mle$psi), col = 6, pch = 19)
legend("topleft", c("truth", "MLE", "knots of the MLE", "empirical"), 
    col = c(1, 6, 3, 4), pch = c(NA, 19, NA, 19), lty = c(1, NA, 3, NA), 
    bg = "white", bty = "n")
abline(v = mle$x[mle$isKnot == 1], lty = 3, col = 3)


## -------------------------------------------------------------
## Now compute and plot Y(x) and H(x)
## -------------------------------------------------------------
xla <- paste("x = {r = ", a, ", ..., s - 1 = ", b - 1, "}", sep = "")
par(mfcol = c(2, 2), oma = rep(0, 4), mar = c(4.5, 4.5, 2, 1), las = 1)
plot(x, logdens, type = "b", col = 2, pch = 19, main = "log of 
    normalized triangular pmf", xlim = c(a, d), xaxt = "n", xlab = "x", 
    ylab = "log of normalized pmf")
axis(1, at = c(a, b, d), labels = paste(c("a = ", "b = ", "d = "), 
    c(a, b, d), sep = ""))

## compute H(x)
r <- a
s <- b
ind <- r:(s - 1)
px <- dens
p_rs <- px[ind]
m <- s - r

## -------------------------------------------------------------
## generate one observation from the distribution of U(F(x)) - U(F(x - 1))
## -------------------------------------------------------------
sigma <- diag(m) * 0
for (i in 1:m){
    for (j in 1:m){
        sigma[i, j] <- p_rs[i] * (i == j) - p_rs[i] * p_rs[j]
    }
}

set.seed(23041977)
cx <- rep(NA, d - a + 1)
cx[ind] <- rmvnorm(1, mean = rep(0, m), sigma = sigma, method = 
    c("eigen", "svd", "chol")[3])
Ux <- rep(NA, length(x))
Ux[ind] <- cx[ind]

X <- x[ind]
Y <- Ux[ind] / p_rs
W <- p_rs

## concave regression using 'cobs'
Res <- conreg(x = X, y = Y, w = W, verbose = TRUE)
g <- Res$yf
gKnots <- Res$iKnots
plot(X, Y, main = expression("The concave function g* that 
    minimizes "*Phi*"(g)"), xaxt = "n", ylab = "g*", ylim = 
    range(c(Y, g)), xlab = xla, type = "n")
axis(1, at = 0:100, labels = 0:100); abline(v = x[gKnots], 
    lty = 2, col = grey(0.75))
lines(X, g, lwd = 2, col = 3, type = "b", pch = 1)
lines(X, Y, lwd = 1, col = 2, type = "p", pch = 19)
legend("bottomright", c("values of cx / px", "minimizer g*"), 
    lty = c(NA, 1), pch = c(19, 1), col = 2:3, bty = "n", 
    lwd = c(NA, 2))

## compute H(x) for x = r, ..., s - 1 and plot it
gstar <- rep(NA, length(x))
gstar[ind] <- g
xs <- r:(s - 1)
Hs <- rep(0, length(xs))
for (i in 2:length(xs)){
    for (ks in r:(xs[i] - 1)){
        js <- r:ks
        Hs[i] <- Hs[i] + sum(gstar[js] * px[js])
    }
}

## check
(Hs[3:length(Hs)] - 2 * Hs[2:(length(Hs) - 1)] + Hs[1:(length(Hs) - 2)]) / p_rs[2:(length(Hs) - 1)]
gstar

## -------------------------------------------------------------
## plot the product of g* and px (the limit of the PMF)
## -------------------------------------------------------------
plot(x[ind], gstar[ind] * p_rs, main = expression("g"^"*"* " * p"), 
    xaxt = "n", pch = 19, col = 2, ylab = "g*", type = "b", xlab = xla)
axis(1, at = 0:100, labels = 0:100); abline(v = x[gKnots], lty = 2, 
    col = grey(0.75))

## compute Y(x) for x = r, ..., s - 1 and plot it
Ys <- rep(0, length(xs))
for (i in 2:length(xs)){
    for (ks in r:(xs[i] - 1)){
        js <- r:ks
        Ys[i] <- Ys[i] + sum(cx[js])
    }
}

## plot the two processes
plot(xs, Ys, type = "n", col = 2, xaxt = "n", lwd = 2, main = "The 
    processes H(x) and Y(x)", ylab = "H and Y", xlab = xla)
axis(1, at = 0:100, labels = 0:100); abline(v = x[gKnots], lty = 2, 
    col = grey(0.75))
lines(xs, Hs, col = 2, lwd = 1, type = "b")
lines(xs, Ys, col = 3, lwd = 2, type = "l", lty = 2)
legend("topleft", c("H(x)", "Y(x)"), col = 2:3, lty = c(1, 2), pch = 1, 
    bty = "n", lwd = c(1, 2))
}
\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}



