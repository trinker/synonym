#' Get Synonyms
#'
#' Look up synonyms for term(s) with relevant distance filtering.
#'
#' @param x A character vector of terms to find synonyms for.
#' @param distance A relevance distance 1-most relevant, 2-mid relevancy, &
#' 3-furthest relevance.  This value can be given as a single integer element
#' or as a vector of integers.
#' @param key A synonym key consisting of a \code{term} column and a \code{json}
#' column.  The \code{\link[synonym]{synonym_key}} is used by default.
#' @param \ldots Currently ignored.
#' @return Returns a \code{\link[base]{list}} of \code{\link[base]{vector}}s of
#' relevant synonyms.  The \code{\link[base]{list}} is equal or less than the
#' length of \code{x}.
#' @note \code{x} terms not found in \code{key} are not included in the output.
#' \code{x} terms found in \code{key} but not meeting the distance criteria
#' return as \code{NA}.
#' @keywords synonym
#' @export
#' @examples
#' get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))
#'
#' get_synonym('cat', 1)
#' get_synonym('cat', 2)
#' get_synonym('cat', 3)
#' get_synonym('cat', 2:3)
#'
#' drop_zero(
#'     get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))
#' )
get_synonym <- function(x, distance = 1, key = synonym::synonym_key, ...) {

    synonym_key <- term <- relevance <- NULL

    if (!all(distance %in% 1:3)) stop('`distance` must be a vector consisting of only 1, 2, and/or 3')

    syn_key <- data.table::copy(key)
    hits <- syn_key[term %in% x,]
    out <- stats::setNames(lapply(hits[['json']], function(x) {
        trimws(data.table::as.data.table(jsonlite::fromJSON(x))[relevance %in% distance, ][['synonym']])
    }), hits[['term']])

    if (length(out) == 0) {warning('No relevant matches found'); return(invisible(NULL))}
    lens <- sapply(out, length) == 0
    if (any(lens)) out[lens] <- NA

    class(out) <- c('get_synonym', class(out))
    attributes(out)[['terms']] <- x
    out
}

#' Prints a get_synonym Object
#'
#' Prints a get_synonym object
#'
#' @param x A get_synonym object.
#' @param \ldots ignored.
#' @method print get_synonym
#' @export
print.get_synonym <- function(x, ...){
    class(x) <- 'list'
    attributes(x)[['terms']] <- NULL
    print(x)
}

