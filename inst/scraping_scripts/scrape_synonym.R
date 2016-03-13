pacman::p_load(qdapDictionaries, rvest, dplyr, textshape, XML,  parallel, jsonlite, data.table)

convert_non_ascii <- function(x) {
    x <- iconv(x, "", "ASCII", "byte") 
    sentimentr:::.mgsub(
        pattern = c('<c2><a0>', '<e2><80><9c>', '<e2><80><9d>', '<e2><80><99>', '<e2><80><94>', '<e2><80><98>'),
        replacement = c(' ', '"', '"', "'", "-", "'"),
        x
    ) %>%
    trimws() %>% 
    c()
}



scrape_synonym <- function(x){

    page <- try(suppressWarnings(readLines(sprintf('http://www.thesaurus.com/browse/%s', x))), silent = TRUE)
    if (inherits(page, "try-error")) return(NA)

    page %>%
        htmlTreeParse(useInternalNodes = TRUE) %>%
        getNodeSet('//div[@class="relevancy-list"]//ul//li//a') %>%
        lapply(xmlAttrs) %>%
        lapply(`[`, c('href', 'data-category', 'data-complexity', 'data-length')) %>%
        lapply(function(x) as.data.frame(as.list(x), stringsAsFactors = FALSE)) %>%
        bind_rows() %>%
        mutate(
            term = tolower(sapply(basename(href), URLdecode)),
            relevance = gsub("(^.+relevant-)([1-3])(.+$)", "\\2", data.category) %>% as_numeric2()
        ) %>%
        select(term, relevance, data.complexity, data.length) %>%
        setNames(c('term', 'relevance', 'complexity', 'length')) %>%
        mutate(
            complexity = complexity %>% as_numeric2(),
            length = length %>% as_numeric2()
        )
}

scrape_synonym('cat')

scrape_synonym_l <- function(y){
    lapply(y, function(x) { try(scrape_synonym(x)) })
}


len <- length(GradyAugmented)



grady_list <- split_index(GradyAugmented, seq(100, to = len, by = 100))
#grady_list <- split_index(GradyAugmented, seq(5, to = len, by = 5))

ends <- c(seq(100, to = length(grady_list), by = 100), length(grady_list))
starts <- c(1, head(ends + 1,  -1))


for (i in tail(seq_along(ends), -1)){

    #parallel processing the scrape
    cl <- makeCluster(mc <- getOption("cl.cores", detectCores()))
    clusterExport(cl=cl, varlist=c("grady_list", "scrape_synonym", "scrape_synonym_l", "htmlTreeParse", "getNodeSet",
        "xmlAttrs", "as_numeric2", 'URLdecode', 'mutate', 'bind_rows', 'bind_list', 'select', '%>%'), envir=environment())
    
    
    tic()
    L1 <- parLapply(cl, grady_list[starts[i]:ends[i]], function(x) {
        Sys.sleep(.05)
        setNames(scrape_synonym_l(x), x)
    })
    toc()
    
    
    stopCluster(cl) #stop the cluster
    
    #L2 <- L1
    gc()
    
    L1 <- L1 %>%
        lapply(function(x){
            x[sapply(x, is.data.frame)] %>%
                lapply(rename, synonym = term)
        }) %>%
        unlist(recursive = FALSE) %>% 
        bind_list('term') %>%
        tbl_df() %>%
        filter(synonym != "na") %>%
        mutate(synonym = gsub('%20', " ", synonym))
    
    print(L1)
    
    saveRDS(L1, file=sprintf("synonyms/synonym%s.rds", i))

}


synonym_key <- lapply(dir('synonyms', full.names = TRUE), function(x){
    data.table::data.table(readRDS(file=x))[, 
        relevance := 4 - relevance][, 
        .(json = convert_non_ascii(as.character(toJSON(.SD)))), by = term][]
}) %>%
    bind_rows() %>%
    as.data.table() 


setkey(synonym_key, 'term')

pack.skel(synonym_key)
