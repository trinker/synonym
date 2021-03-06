#' Find Relevant Synonyms
#'
#' Fast \pkg{data.table} lookups of relevant synonyms.
#' @docType package
#' @name synonym
#' @aliases synonym package-synonym
NULL

#' Synonym Hash Table
#'
#' A dataset containing a \pkg{data.table} hash table. The terms act as a key
#' returning a \href{https://en.wikipedia.org/wiki/JSON}{JSON} vector which can
#' then in turn be converted to a \code{\link[base]{data.frame}} via the
#' \pkg{jsonlite} package.  This data has been scraped from
#' \url{http://www.thesaurus.com}.
#'
#' @details
#' \itemize{
#'   \item term. A character column of potential terms.  This acts as the key column.
#'   \item json. A JSON string that is converted to a data.frame of \code{synonym}s and \url{http://www.thesaurus.com} \code{relevance}, \code{complexity}, & \code{length} scores (\code{relevance} has been reverse scored).
#' }
#'
#' @docType data
#' @keywords datasets
#' @name synonym_key
#' @usage data(synonym_key)
#' @format A data frame with 62076 rows and 2 variables
#' @references \url{http://www.thesaurus.com}
NULL
