
load("model.rda")

backoff_history <- function(history) {
        history_words <- strsplit(history, split = " |'")
        ifelse(
                length(history_words[[1]]) > 1,
                trimws(paste(backoff_history_words <- history_words[[1]][2:length(history_words[[1]])], collapse = " ")),
                ""
        )
}

extract_words_from_history <- function(model) unique(
        unname(
                unlist(
                        sapply(rownames(model), function(x) ifelse(x == "", x, strsplit(x, split = " ")))
                )
        )
)

build_top_suggestions <- function(model, history, word_row, n) {
        word_row["<unknown>"] <- NA
        top_suggestions_indexes <- head(order(word_row, decreasing = TRUE), n = n)
        top_suggestions <- colnames(model)[top_suggestions_indexes]
        names(top_suggestions) <- model[history, top_suggestions_indexes]
        top_suggestions
}

replace_unknown_words <-function(history, model) {
        words <- extract_words_from_history(model)
        if(history == "") return(history)
        history_words <- strsplit(history, split = " ")
        history_words <- sapply(history_words, function(x) ifelse(x %in% words, x, "<unknown>"))
        paste(history_words, collapse = " ")
}

suggestions <- function(history) {
        n=5
        model <- model
        history <- replace_unknown_words(history, model)
        history <- ifelse(history == "", 1, history)
        word_row <- try_default(model[history, ], c(), quiet = TRUE)
        if(length(word_row) > 0)build_top_suggestions(model, history, word_row, n)
        else suggestions(model, backoff_history(history), n = n)
}
