% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/niching.R
\name{niching}
\alias{niching}
\title{Niche-Preservation Operation}
\usage{
niching(pop, n_remaining, niche_count, niche_of_individuals, dist_to_niche)
}
\arguments{
\item{pop}{Last Front Population}

\item{n_remaining}{Number of points to choose}

\item{niche_count}{Niche count of individuals with the reference point}

\item{niche_of_individuals}{Count of the closest reference point to the last
front objective values}

\item{dist_to_niche}{Distance between closest reference point to last front
objective values}
}
\value{
Returns the association of reference points to each individual in the population.
}
\description{
Generation of niche, by associating reference points to population members
}
\details{
Niching procesure is a algorithms proposed by K. Deb and H. Jain in 2013.
}
\references{
K. Deb and H. Jain, 'An Evolutionary Many-Objective Optimization
Algorithm Using Reference-Point-Based Nondominated Sorting Approach, Part I:
Solving Problems With Box Constraints,' in IEEE Transactions on Evolutionary
Computation, vol. 18, no. 4, pp. 577-601, Aug. 2014,
doi: 10.1109/TEVC.2013.2281535.

Scrucca, L. (2017) On some extensions to 'GA' package: hybrid optimisation,
parallelisation and islands evolution. The R Journal, 9/1, 187-206.
doi: 10.32614/RJ-2017-008

Felix-Antoine Fortin, Francois-Michel De Rainville, Marc-André Gardner
Gardner, Marc Parizeau, and Christian Gagne. 2012. DEAP: evolutionary
algorithms made easy. J. Mach. Learn. Res. 13, 1 (January 2012), 2171–2175.
}
\seealso{
\code{\link[=associate_to_niches]{associate_to_niches()}}, \code{\link[=PerformScalarizing]{PerformScalarizing()}}
}
\author{
Francisco Benitez
\email{benitezfj94@gmail.com}
}
