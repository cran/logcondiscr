\name{internal}
\alias{Direction}
\alias{dMLE}
\alias{GradientL}
\alias{HesseL}
\alias{J00}
\alias{J10}
\alias{J11}
\alias{J20}
\alias{LikFunk}
\alias{LocalCoarsen}
\alias{LocalConcavity}
\alias{LocalExtend}
\alias{LocalMLE}
\alias{LocalNormalize}
\alias{StepSize}
\title{Functions for estimation of a log-concave probability mass function via maximum likelihood}
\description{Internal functions for the estimation of a log-concave probability mass function.
These functions are not intended to be called by the user directly. 

\code{\link{Direction}} Compute vector that points in direction of \eqn{\max L(\psi)} via Newton step.

\code{\link{dMLE}} Compute the vector \eqn{\psi} s.t. the log-likelihood function \eqn{L}, as implemented in \code{LikFunk}, is maximized
over all PMFs (under no additional restrictions, though).

\code{\link{GradientL}} Gradient of \code{LikFunk}.

\code{\link{HesseL}} Hesse matrix of \code{LikFunk}.

\code{\link{J00}} Function introduced in Section 2.3 in Weyermann (2007), defined as

\deqn{J^{\delta_k}(\psi_k, \psi_{k+1}) := \sum_{j=0}^{\delta_k} \exp \Bigl((1-j/\delta_k)\psi_k + (j/\delta_k) \psi_{k+1} \Bigr).}

This function is used to compute the value of the log-likelihood in \code{LikFunk}.

\code{\link{J10}} Derivative of \eqn{J^{\delta_k}(\psi_k, \psi_{k+1})} w.r.t to the first argument.

\code{\link{J11}} Derivative of \eqn{J^{\delta_k}(\psi_k, \psi_{k+1})} w.r.t to both arguments.

\code{\link{J20}} Second derivative of \eqn{J^{\delta_k}(\psi_k, \psi_{k+1})} w.r.t to the first argument.

\code{\link{LikFunk}} The log-likelihood function for the discrete log-concave MLE.

\code{\link{LocalCoarsen}} Auxiliary function.

\code{\link{LocalConcavity}} Auxiliary function.

\code{\link{LocalExtend}} Auxiliary function.

\code{\link{LocalMLE}} Auxiliary function.

\code{\link{LocalNormalize}} Auxiliary function.

\code{\link{StepSize}} Auxiliary function.
}
\author{
Kaspar Rufibach (maintainer) \email{kaspar.rufibach@gmail.com} \cr \url{http://www.kasparrufibach.ch} \cr
Fadoua Balabdaoui \email{fadoua@ceremade.dauphine.fr} \cr \url{http://www.ceremade.dauphine.fr/~fadoua}  \cr
Hanna Jankowski \email{hkj@mathstat.yorku.ca} \cr \url{http://www.math.yorku.ca/~hkj} \cr
Kathrin Weyermann
}
\references{
Balabdaoui, F., Jankowski, H., Rufibach, K., and Pavlides, M. (2013).
Maximum likelihood estimation and confidence bands for a discrete log-concave distribution.
\emph{J. R. Stat. Soc. Ser. B Stat. Methodol.}, \bold{75}(4), 769--790. 

Weyermann, K. (2007).
An Active Set Algorithm for Log-Concave Discrete Distributions.
\emph{MSc thesis, University of Bern} (Supervisor: Lutz Duembgen).
}
\seealso{All these functions are used by the function \code{\link{logConDiscrMLE}}.}
\keyword{distribtion}
\keyword{htest}
\keyword{nonparametric}

