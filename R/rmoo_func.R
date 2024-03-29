#' R Multi-Objective Optimization Main Function
#'
#' Main function of rmoo, based on the parameters it will call the different
#' algorithms implemented in the package. Optimization algorithms will minimize
#' a fitness function. For more details of the algorithms
#' see [nsga()], [nsga2()], [nsga3()].
#'
#' Multi- and Many-Optimization of a fitness function using Non-dominated
#' Sorting Genetic Algorithms. The algorithms currently implemented by rmoo
#' are: NSGA-I, NSGA-II and NSGA-III
#'
#' The original Non-dominated Sorting Genetic Slgorithms (NSGA-I)is a
#' meta-heuristic proposed by N. Srinivas and K. Deb in 1994. The purpose of
#' the algorithms is to find an efficient way to optimize multi-objectives
#' functions (two or more).
#'
#' The Non-dominated genetic algorithms II (NSGA-II) is a meta-heuristic proposed by
#' K. Deb, A. Pratap, S. Agarwal and T. Meyarivan in 2002. The purpose of the
#' algorithms is to find an efficient way to optimize multi-objectives functions
#' (two or more).
#'
#' The Non-dominated genetic algorithms III (NSGA-III) is a meta-heuristic proposed by
#' K. Deb and H. Jain in 2013.
#' The purpose of the algorithms is to find an efficient way to optimize
#' multi-objectives functions (more than three).
#'
#' @name rmoo_func
#'
#' @param ... argument in which all the values necessary for the configuration
#' will be passed as parameters. The user is encouraged to see the documentations
#' of [nsga()], [nsga2()], [nsga3()] in which the necessary parameters for each
#' algorithm are cited, in addition, the chosen strategy to execute must be
#' passed as an argument. This can be seen more clearly in the examples.
#'
#' @author Francisco Benitez
#' \email{benitezfj94@gmail.com}
#'
#' @references Scrucca, L. (2017) On some extensions to 'GA' package: hybrid
#' optimisation, parallelisation and islands evolution. The R Journal, 9/1, 187-206.
#' doi: 10.32614/RJ-2017-008
#'
#' N. Srinivas and K. Deb, "Multiobjective Optimization Using
#' Nondominated Sorting in Genetic Algorithms, in Evolutionary Computation,
#' vol. 2, no. 3, pp. 221-248, Sept. 1994, doi: 10.1162/evco.1994.2.3.221.
#'
#' K. Deb, A. Pratap, S. Agarwal and T. Meyarivan, 'A fast and
#' elitist multiobjective genetic algorithm: NSGA-II,' in IEEE Transactions on
#' Evolutionary Computation, vol. 6, no. 2, pp. 182-197, April 2002,
#' doi: 10.1109/4235.996017.
#'
#' K. Deb and H. Jain, "An Evolutionary Many-Objective Optimization
#' Algorithm Using Reference-Point-Based Nondominated Sorting Approach, Part I:
#' Solving Problems With Box Constraints," in IEEE Transactions on Evolutionary
#' Computation, vol. 18, no. 4, pp. 577-601, Aug. 2014,
#' doi: 10.1109/TEVC.2013.2281535.
#'
#' @return Returns an object of class ga-class, nsga1-class, nsga2-class or
#' nsga3-class. See [nsga1-class], [nsga2-class], [nsga3-class] for a description of
#' available slots information.
#'
#' @seealso [nsga()], [nsga2()], [nsga3()]
#'
#' @examples
#' #Example 1
#' #Two Objectives - Real Valued
#' zdt1 <- function (x,...) {
#'  if (is.null(dim(x))) {
#'    x <- matrix(x, nrow = 1)
#'  }
#'  n <- ncol(x)
#'  g <- 1 + rowSums(x[, 2:n, drop = FALSE]) * 9/(n - 1)
#'  return(cbind(x[, 1], g * (1 - sqrt(x[, 1]/g))))
#' }
#'
#' #Not run:
#' \dontrun{
#' result <- rmoo(type = "real-valued",
#'                fitness = zdt1,
#'                strategy = "NSGA-I",
#'                lower = c(0,0),
#'                upper = c(1,1),
#'                popSize = 100,
#'                dshare = 1,
#'                monitor = FALSE,
#'                maxiter = 500)
#'
#' }
#'
#' #Example 2
#' #Three Objectives - Real Valued
#' dtlz1 <- function (x, nobj = 3, ...){
#'     if (is.null(dim(x))) {
#'         x <- matrix(x, 1)
#'     }
#'     n <- ncol(x)
#'     y <- matrix(x[, 1:(nobj - 1)], nrow(x))
#'     z <- matrix(x[, nobj:n], nrow(x))
#'     g <- 100 * (n - nobj + 1 + rowSums((z - 0.5)^2 - cos(20 * pi * (z - 0.5))))
#'     tmp <- t(apply(y, 1, cumprod))
#'     tmp <- cbind(t(apply(tmp, 1, rev)), 1)
#'     tmp2 <- cbind(1, t(apply(1 - y, 1, rev)))
#'     f <- tmp * tmp2 * 0.5 * (1 + g)
#'     return(f)
#' }
#'
#' #Not run:
#' \dontrun{
#' result <- rmoo(type = "real-valued",
#'                 fitness = dtlz1,
#'                 strategy = "NSGA-II",
#'                 lower = c(0,0,0),
#'                 upper = c(1,1,1),
#'                 popSize = 92,
#'                 monitor = FALSE,
#'                 maxiter = 500)
#' }
#' @examples
#' #Example 3
#' #Two Objectives - Real Valued
#' zdt1 <- function (x, ...) {
#'  if (is.null(dim(x))) {
#'    x <- matrix(x, nrow = 1)
#'  }
#'  n <- ncol(x)
#'  g <- 1 + rowSums(x[, 2:n, drop = FALSE]) * 9/(n - 1)
#'  return(cbind(x[, 1], g * (1 - sqrt(x[, 1]/g))))
#' }
#'
#' #Not run
#' \dontrun{
#' result <- rmoo(type = "real-valued",
#'                 fitness = zdt1,
#'                 strategy = "NSGA-III",
#'                 lower = c(0,0),
#'                 upper = c(1,1),
#'                 popSize = 100,
#'                 n_partitions = 100,
#'                 monitor = FALSE,
#'                 maxiter = 500)
#'
#' }
#'
#' #Example 4
#' #Three Objectives - Real Valued
#' dtlz1 <- function (x, nobj = 3, ...){
#'   if (is.null(dim(x))) {
#'     x <- matrix(x, 1)
#'   }
#'   n <- ncol(x)
#'   y <- matrix(x[, 1:(nobj - 1)], nrow(x))
#'   z <- matrix(x[, nobj:n], nrow(x))
#'   g <- 100 * (n - nobj + 1 + rowSums((z - 0.5)^2 - cos(20 * pi * (z - 0.5))))
#'   tmp <- t(apply(y, 1, cumprod))
#'   tmp <- cbind(t(apply(tmp, 1, rev)), 1)
#'   tmp2 <- cbind(1, t(apply(1 - y, 1, rev)))
#'   f <- tmp * tmp2 * 0.5 * (1 + g)
#'   return(f)
#' }
#'
#' #Not Run
#' \dontrun{
#' result <- rmoo(type = "real-valued",
#'                 fitness = dtlz1,
#'                 strategy = "NSGA-III",
#'                 lower = c(0,0,0),
#'                 upper = c(1,1,1),
#'                 popSize = 92,
#'                 n_partitions = 12,
#'                 monitor = FALSE,
#'                 maxiter = 500)
#' }
#'
#' #Example 5
#' #Single Objective - Real Valued
#' f <- function(x,  ...)  (x^2+x)*cos(x)
#'
#' #Not Run
#' \dontrun{
#' result <- rmoo(type = "real-valued",
#'                fitness = f,
#'                strategy = "GA",
#'                lower = -20,
#'                upper = 20,
#'                maxiter = 100)
#' }
#'
#' @export
#' @aliases rmoo-func,rmoo-function
rmoo <- function (...) {

  call <- match.call()

  callArgs <- list(...)

  rmoo.input.pars <- as.list(sys.call())[-1]

  algorithm <- match.arg(callArgs$strategy, choices = c('GA', 'NSGA-I', 'NSGA-II', 'NSGA-III'))

  if (!is.null(callArgs$summary)){
    if(is.null(callArgs$reference_dirs) && (callArgs$summary == TRUE)){
      if(!(algorithm %in% c("GA", "NSGA-III")) ) {
        #if(algorithm != "GA" |) {
          cat("Warning: reference points not provided:\n
              HV, GD and IGD will not be evaluated during execution.\n")
      }
    }
  }
  out <- getAlgorithm(rmoo.input.pars, algorithm)
  out@call <- match.call()
  return(out)
}

getAlgorithm <- function(rmoo.input.pars, algorithm, ...){
  if (algorithm == "NSGA-I") {
    do.call(rmoo::nsga,
            args = rmoo.input.pars)
  } else if (algorithm == "NSGA-II") {
    do.call(rmoo::nsga2,
            args = rmoo.input.pars)
  } else if (algorithm == "NSGA-III"){
    do.call(rmoo::nsga3,
            args = rmoo.input.pars)
  } else if (algorithm == "GA"){
    # requireNamespace("GA", quietly=TRUE) ||
    #   stop("GA package is not available. Please install it to run the Genetic Algorithm.")
    do.call(GA::ga,
            args = rmoo.input.pars)
  }
}

