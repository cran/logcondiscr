\name{logcondiscr-package}
\alias{logcondiscr-package}
\alias{logcondiscr}
\docType{package}
\title{Compute a log-concave PMF from i.i.d. data}
\description{This package implements the maximum likelihood estimator (MLE) for a probability mass function (PMF) under the assumption of log-concavity from i.i.d. data.}
\details{
\tabular{ll}{
Package: \tab logcondiscr \cr
Type: \tab Package \cr
Version: \tab 1.0.2 \cr
Date: \tab 2012-01-24 \cr
License: \tab GPL (>=2) \cr
LazyLoad: \tab yes \cr
}

The main functions in the package are: 

\code{\link{logConDiscrMLE}}: Compute the maximum likelihood estimator (MLE) of a log-concave PMF from i.i.d. data. The constrained log-likelihood function is maximized using an active set algorithm as initially described in Weyermann (2007). 

\code{\link{logConDiscrCI}}: Compute the maximum likelihood estimator (MLE) of a log-concave PMF from i.i.d. data and corresponding, asymptotically valid, pointwise confidence bands as
developed in Balabdaoui et al (2012). 

\code{\link{kInflatedLogConDiscr}}: Compute an estimate of a mixture of a log-concave PMF that is inflated at \eqn{k}, from i.i.d. data, using an EM algorithm. 
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@gmail.com} \cr \url{http://www.kasparrufibach.ch} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann \email{kathrin.weyermann@bkw-fmb.ch}
}
\references{
Balabdaoui, F., Jankowski, H., Rufibach, K., and Pavlides, M. (2012).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
Preprint.

Weyermann, K. (2007).
An Active Set Algorithm for Log-Concave Discrete Distributions.
\emph{MSc thesis, University of Bern} (Supervisor: Lutz Duembgen).
}
\seealso{Functions to estimate the log-concave MLE for a univariate continuous distribution are provided in the package \pkg{logcondens} and
for observations in more than one dimension in \pkg{LogConDEAD}.}
\examples{## see the help files for the abovementioned functions for examples}
\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}




