#' Produce a subset of data following predefined criteria
#'
#' After running the \code{prepare_ENCODEDb} function, this function will allow 
#' you to extract a subset of data encording to the following criteria : 
#' accession, assay name, biosample, dataset accession, file accession, 
#' file format, laboratory, donor organism, target and treatment.
#' 
#' By default, the query can be made on an exact match term. This behaviour can 
#' be modified by setting the \code{fixed} argument at \code{TRUE}
#' 
#' @param    df \code{data.frame} containing ENCODE 
#' experiment and dataset metadata 
#' @param    set_accession character string to select the accession
#' @param    assay character string to select the assay type
#' @param    biosample_name character string to select the biosample name
#' @param    dataset_accession character string to select the dataset accession
#' @param    file_accession character string to select the file accesion
#' @param    file_format character string to select the file format
#' @param    lab character string to select the laboratory 
#' @param    organism character string to select the donor organism
#' @param    target character string to select the experimental target
#' @param    treatment character string to select the treatment
#' @param    project character string to select the project
#' @param    biosample_type character string to select the biosample type
#' @param    file_status character string to select the file status 
#' ("released", "revoked", "all"). Default "released"
#' @param    status character string to select the dataset/experiment status
#' @param    fixed logical. If TRUE, pattern is a string to be matched as it is.
#' @param    quiet logical enables to switch off the result summary information 
#' when setting at TRUE.
#'
#' @return a \code{data.frame}s containing data about ENCODE 
#' experiments and datasets
#'
#' @examples
#'     \dontrun{
#'     queryEncode(biosample_name = "A549", file_format = "bam")
#'     }
#' @import data.table
#' @export
queryEncode <- function(df = NULL, set_accession = NULL, assay = NULL, 
                        biosample_name = NULL, dataset_accession = NULL, 
                        file_accession = NULL, file_format = NULL, 
                        lab = NULL, organism = NULL, target = NULL, 
                        treatment = NULL, project = NULL, biosample_type = NULL,
                        file_status = "released", status = "released", 
                        fixed = TRUE, quiet = FALSE) {
  
  if(is.null(df)) {
      data(encode_df, envir = environment())
  }
  
  if(is.null(set_accession) && is.null(assay) && is.null(biosample_name) && 
     is.null(dataset_accession) && is.null(file_accession) && 
     is.null(file_format) && is.null(lab) && is.null(organism) &&
     is.null(target) && is.null(treatment) && is.null(project) &&
     is.null(biosample_type))
  {
    warning("Please provide at least one valid criteria", call. = FALSE)
    NULL
    
  } else {
    s = encode_df
    
    ac = set_accession
    as = assay
    bn = biosample_name
    bt = biosample_type
    da = dataset_accession
    fa = file_accession
    ff = file_format
    lb = lab
    og = organism
    tg = target
    tr = treatment
    es = status
    fs = file_status
    pr = project
    
    if(fixed) {
      
      if(!is.null(ac)) {
        s <- subset(s, s$accession == ac)
      }
      
      if(!is.null(as)){
        s <- subset(s, s$assay == as)
      }
      
      if(!is.null(bn)){
        s <- subset(s, s$biosample_name == bn)
      }
      if(!is.null(bt)){
        s <-subset(s, s$biosample_type == bt)
      }
      if(!is.null(da)) {
        s <- subset(s, s$dataset_accession == da)
      }
      
      if(!is.null(fa)) {
        s <- subset(s, s$file_accession == fa)
      }
      
      if(!is.null(ff)){
        s <- subset(s, s$file_format == ff)
      }
      
      if(!is.null(lb)) {
        s <- subset(s, s$lab == lb)
      }
      
      if(!is.null(og)) {
        s <- subset(s, s$organism == og)
      }
      
      if(!is.null(tg)) {
        s <- subset(s, s$target == tg)
      }
      
      if(!is.null(tr)) {
        s <- subset(s, s$treatment == tr)
      }
      
      if(fs != "all") {
        s <- subset(s, s$file_status == fs)
      }
      
      if(es != "all") {
        s <- subset(s, s$status == es)
      }
      
      if(!is.null(pr)) {
        s <- subset(s, s$project == pr)
      }
      
    } else { #fixed is false
      # Removing and ignoring space and hyphen
      # m cf 7 = MCf7 = mcf-7 = MCF-7 ... etc
      
      if(!is.null(ac)) {
        query.transfo = query_transform(ac)
        select.entries = grepl(x = s$accession, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(as)) {
        query.transfo = query_transform(as)
        select.entries = grepl(x = s$assay, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]

      }
      
      if(!is.null(bn)) {
        query.transfo = query_transform(bn)
        select.entries = grepl(x = s$biosample_name, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      if(!is.null(bt)) {
        query.transfo = query_transform(bt)
        select.entries = grepl(x = s$biosample_type, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(da)) {
        query.transfo = query_transform(da)
        select.entries = grepl(x = s$dataset_accession, pattern =query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(fa)) {
        query.transfo = query_transform(fa)
        select.entries = grepl(x = s$file_accession, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(ff)) {
        query.transfo = query_transform(ff)
        select.entries = grepl(x = s$file_format, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(lb)) {
        query.transfo = query_transform(lb)
        select.entries = grepl(x = s$lab, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(og)) {
        query.transfo = query_transform(og)
        select.entries = grepl(x = s$organism, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(tg)) {
        query.transfo = query_transform(tg)
        select.entries = grepl(x = s$target, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(tr)) {
        query.transfo = query_transform(tr)
        select.entries = grepl(x = s$treatment, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(fs != "all") {
        query.transfo = query_transform(fs)
        select.entries = grepl(x = s$file_status, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(es != "all") {
        query.transfo = query_transform(es)
        select.entries = grepl(x = s$status, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
      
      if(!is.null(pr)){
        query.transfo = query_transform(pr)
        select.entries = grepl(x = s$project, pattern = query.transfo, 
                               ignore.case =TRUE, perl =TRUE)
        s = s[select.entries,]
      }
    }
    
    
    
    if(nrow(s) == 0) {
      warning_message <- "No result found in encode_df. 
      You can try the <searchEncode> function or set the fixed option to FALSE."
      
      return(s)
    }
    else
    {
      query_results = s
      if(!quiet) 
        cat(paste0("Results : ",
                   nrow(query_results),
                   " files, ",length(unique(query_results$accession))," datasets","\n"))
      query_results
    }
    
  }
}

query_transform <- function(my.term) {
  my.term = gsub(my.term, pattern = " ", replacement = "", fixed =TRUE)
  my.term = gsub(my.term, pattern = "-", replacement = "", fixed =TRUE)
  my.term = gsub(my.term, pattern = ",", replacement = "", fixed =TRUE)
  my.term = strsplit(my.term, split = "")[[1]]
  my.term.4.grep = paste0("^",paste(my.term, collapse = "[ ,-]?"))
  
  my.term.4.grep
}


#' Convert searchEncode output in queryEncode output.
#'
#' After processing to a basic search with the \code{searchEncode} function 
#' you can convert your result in a queryEncode output. Thus you can benefit 
#' from the collected metadata. 
#' 
#' The output is compatible with the dowload function.
#' 
#' @param    df \code{list} of two \code{data.frame} containing ENCODE 
#' experiment and dataset metadata.
#' @param searchResults the results set generated from \code{searchEncode}
#' @param    quiet logical enables to switch off the result summary information 
#' when setting at TRUE.
#'
#' @return a \code{list} of two \code{data.frame}s containing data about ENCODE 
#' experiments and datasets
#' 
#' @examples
#' search_res <- searchEncode(searchTerm = "switchgear elavl1", limit = "1")
#' res <- searchToquery(searchResults = search_res, quiet = TRUE)
#' 
#' @export
searchToquery <- function(df = NULL, searchResults, quiet = TRUE){
  
  if(is.null(df)) {data(encode_df, envir = environment())} else {encode_df = df}
  
  res = data.frame()
  
  if(nrow(searchResults) > 0){
    ids <- as.character(searchResults$id)
    ids <- ids[grepl(x = ids, pattern = '/experiments/')]
    accessions <- gsub(x = ids, pattern = '/experiments/([A-Z0-9]+)/',
                       replacement = "\\1")
    accessions <-unique(accessions)
        
    for(i in seq_along(accessions)){
      
      accession <- accessions[i]
      
      r <- queryEncode(df = encode_df, set_accession = accession, fixed = TRUE, 
                       quiet = quiet)
      if(!is.null(r)){
        res <- rbind(res,r)
        
      }
    }
  }
  
  if(!quiet){
    cat(paste0("Results : ", nrow(res)," files , ",
               length(unique(res$accession)), " datasets", "\n"))
  }
  return(res)
}
