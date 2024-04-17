

## Code for Exploring Directory Full of PDFs

# Initial code from Chat GPT -----

# Load required libraries
library(pdftools)

# Set the directory path where your PDF documents are located
pdf_folder <- "path/to/your/pdf/folder"

# Get a list of PDF files in the folder
pdf_files <- list.files(pdf_folder, pattern = "\\.pdf$", full.names = TRUE)

# Function to extract text from PDF
extract_text <- function(file_path) {
  text <- pdf_text(file_path)
  return(text)
}

# Apply the function to extract text from all PDF files
pdf_texts <- lapply(pdf_files, extract_text)

# Function to calculate word frequency in a document
word_frequency <- function(text, target_words) {
  word_count <- sapply(target_words, function(word) sum(grepl(word, text, ignore.case = TRUE)))
  return(word_count)
}

# Define your list of words to look for
specific_words <- c("list", "of", "words", "to", "look", "for")

# Calculate word frequency for each document
word_freq_per_doc <- lapply(pdf_texts, word_frequency, target_words = specific_words)

# Calculate total frequency for each document
total_freq_per_doc <- sapply(word_freq_per_doc, sum)

# Identify the top documents
top_documents <- pdf_files[order(total_freq_per_doc, decreasing = TRUE)]

# Print top documents with their total frequency
for (i in seq_along(top_documents)) {
  cat("Document:", top_documents[i], "\tTotal Frequency:", total_freq_per_doc[i], "\n")
}
