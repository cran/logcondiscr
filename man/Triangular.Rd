\name{Triangular}
\alias{dTriangular}
\alias{rTriangular}
\title{Functions to compute a and simulate from a triangular probability mass function}
\description{In Balabdaoui et al (2012) the triangular density, defined as

\deqn{p_x^{a, b, c, d, e} = c(x - a) / (b - a)}

for \eqn{x \in \{a, \ldots, c\}} and 

\deqn{p_x^{a, b, c, d, e} = (e - c)(x - b) / (d - b) + c}

for \eqn{x \in \{c, \ldots, d\}}, was used to illustrate the limit process of the log-concave MLE. In order to provide the code to generate the limit process figure in Balabdaoui et al (2012, see the example in \code{\link{logConDiscrMLE}} for the code to generate that figure) the functions \code{dTriangular} and \code{rTriangular} are included in this package. Note that \code{rTriangular} uses the rejection sampling algorithm in Devroye (1987) which was specifically developed to generate random numbers from a log-concave PMF.}
\usage{
dTriangular(a, b, c, d, e)
rTriangular(n, a, b, c, d, e)
}
\arguments{
  \item{a}{Left endpoint of triangular pmf.}
  \item{b}{Mode of triangular pmf.}
  \item{c}{Height at mode.}
  \item{d}{Left endpoint.}
  \item{e}{Height at left endpoint.}
  \item{n}{Number of random numbers to generate.}
}
\value{
\code{dTriangular} returns a vector containing the value of the PMF at all values in \eqn{x \in \{a, \ldots, d\}}.
\code{rTriangular} returns a list containing the elements:
\item{rand}{Vector with generated random numbers of length \eqn{n}.}
\item{x}{Vector \eqn{(a, \ldots, d)}.}
\item{dens}{Value of the pmf at \eqn{x}.}
}
\references{
Balabdaoui, F., Jankowski, H., Rufibach, K., and Pavlides, M. (2013).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
\emph{J. R. Stat. Soc. Ser. B Stat. Methodol.}, \bold{75}(4), 769--790. 

Devroye, L. (1987). 
A simple generator for discrete log-concave distributions. 
\emph{Computing}, \bold{39}, 87-91.
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@gmail.com} \cr \url{http://www.kasparrufibach.ch} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann 
}
\note{This function is used to generate the plot of the limit process in the help file for the function \code{logConDiscrMLE}.}
\examples{

## -------------------------------------------------------------
## compute values of triangular density and simulate from it
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

## does the same as rTriangular()
rand2 <- sample(x = a:d, size = n, prob = dens, replace = TRUE)
}

\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}

