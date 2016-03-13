#' Drop Zero Count Elements
#'
#' The \code{\link[synonym]{get_synonym}} terms that are found in the key but
#' that do not match the relevant distance return an \code{NA}.  This function
#' conveniently drops these elements.
#'
#' @param x A \code{\link[synonym]{get_synonym}} object.
#' @param \ldots ignored.
#' @return Returns a list with \code{NA} elements removed.
#' @export
#' @examples
#' get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))
#'
#' drop_zero(
#'     get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))
#' )
drop_zero <- function(x, ...){
    UseMethod('drop_zero')
}


#' @export
#' @method drop_zero get_synonym
drop_zero.get_synonym <- function(x, ...){
    lens <- sapply(x, function(y) length(y) == 1 && is.na(y))
    if (any(lens)) x[lens] <- NULL
    if (length(x) == 0) return(NULL)
    x
}



