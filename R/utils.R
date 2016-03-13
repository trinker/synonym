lookup_helper <- function(terms, key, ...) {

	x <- i.y <- NULL

    terms <- data.frame(x=terms, stringsAsFactors = FALSE)
    key <- data.table::data.table(key[c("x", "y")])
    data.table::setDT(terms)

    data.table::setkey(key, x)
    key[terms]

}
