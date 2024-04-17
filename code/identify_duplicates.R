

## Code to Look for Duplicates

## Notes -----

# will need to use 'fuzzy' searches
# can you identify level of similarity?

## Initial code from Chat GPT -----

# Load required libraries
library(stringdist)

# Create an example dataframe
df <- data.frame(
  ID = 1:5,
  Text1 = c("The quick brown fox jumps over the lazy dog", 
            "The quick brown fox jumps over the lazy dog",
            "The quick brown fox jumps over the lazy dog",
            "A quick brown fox jumps over the lazy dog",
            "The quick brown fox jumps over the lazy cat"),
  Text2 = c("This is a sample text.",
            "This is a similar text.",
            "This is a completely different text.",
            "This is a sample text.",
            "This is a similar text.")
)

# Function to identify potential duplicates between rows
find_duplicates <- function(row1, row2, threshold = 0.8) {
  similarity <- stringdist::stringdist(row1, row2, method = "jaccard")
  if (similarity > threshold) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Check for duplicates between rows of the dataframe
n_rows <- nrow(df)
duplicate_matrix <- matrix(NA, nrow = n_rows, ncol = n_rows)

for (i in 1:n_rows) {
  for (j in 1:n_rows) {
    if (i != j) {
      duplicate_matrix[i, j] <- find_duplicates(df[i, -1], df[j, -1])
    } else {
      duplicate_matrix[i, j] <- NA
    }
  }
}

# Convert the matrix to a dataframe for better visualization
duplicate_df <- as.data.frame(duplicate_matrix)
rownames(duplicate_df) <- df$ID
colnames(duplicate_df) <- df$ID

# Print the duplicate dataframe
print(duplicate_df)
