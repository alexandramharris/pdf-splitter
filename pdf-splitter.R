# Tool to split individual PDFs from one large, combined PDF


# Load libraries
library(pdftools)
library(stringr)

# Define the path to your large, combined PDF file
pdf_path <- "Data/2023_incidents.pdf"

# Define path of folder where you want to export your results
output_dir <- "2023/"

# Read the PDF
text <- pdf_text(pdf_path)

# Identify start points of each report
start_pages <- which(str_detect(text, "Page 1 of"))

# Function to split and save each report as a separate PDF
split_pdf <- function(start_page, end_page, file_name) {
  pdf_subset(pdf_path, pages = start_page:end_page, output = file_name)
}

# Loop through the pages and create new individual PDFs
for (i in 1:length(start_pages)) {
  start_page <- start_pages[i]
  end_page <- ifelse(i < length(start_pages), start_pages[i + 1] - 1, length(text))
  
  file_name <- paste0(output_dir, "Report_", i, ".pdf")
  
  split_pdf(start_page, end_page, file_name)
}
