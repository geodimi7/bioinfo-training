# simple_analysis.R
# Μικρό demo R script για gene expression-style δεδομένα

# Φορτώνουμε τα βασικά πακέτα
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
})

# Δημιουργούμε ένα μικρό "fake" dataset
expr <- data.frame(
  gene   = rep(c("GeneA", "GeneB", "GeneC", "GeneD"), times = 2),
  sample = rep(c("Control", "Treated"), each = 4),
  count  = c(100, 50, 10, 5,
             130, 40, 20, 3)
)

# Εκτυπώνουμε τον πίνακα
print("Expression table:")
print(expr)

# Υπολογίζουμε μέσο count ανά συνθήκη
summary_tbl <- expr |>
  group_by(sample) |>
  summarise(
    mean_count = mean(count),
    sd_count   = sd(count)
  )

print("Summary per sample:")
print(summary_tbl)

# Φτιάχνουμε ένα barplot
p <- ggplot(expr, aes(x = gene, y = count, fill = sample)) +
  geom_col(position = "dodge") +
  labs(
    title = "Fake gene expression",
    x = "Gene",
    y = "Counts"
  ) +
  theme_minimal()

# Αποθήκευση plot σε αρχείο
ggsave("results_expression_plot.png", plot = p, width = 6, height = 4, dpi = 300)

cat("Analysis finished. Plot saved as 'results_expression_plot.png'\n")
