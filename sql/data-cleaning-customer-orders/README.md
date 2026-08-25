# SQL Data Cleaning — Customer Orders

## Overview

This project demonstrates an end-to-end data cleaning workflow using SQL
and Google BigQuery.

The dataset contains customer order records with intentional data quality
issues, including inconsistent formatting, missing values, invalid data
types, duplicated records and inconsistent categorical values.

## Dataset

The dataset contains information about:

- Order ID
- Customer name
- Email
- Order date
- Product
- Quantity
- Price
- Country
- Order status
- Notes

## Data Quality Issues

The dataset contains several common real-world data quality problems:

- Inconsistent capitalization
- Different date formats
- Text values in numeric fields
- Missing values
- Invalid email formats
- Inconsistent product names
- Inconsistent order status values
- Potential duplicate orders

## Cleaning Process

The SQL workflow includes:

1. Data quality assessment
2. Order status standardization
3. Product name standardization
4. Quantity type conversion
5. Customer name standardization
6. Date standardization
7. Duplicate detection and removal
8. Creation of a final cleaned dataset

## Tools

- SQL
- Google BigQuery

## Key SQL Techniques

- `CASE WHEN`
- `LOWER()`
- `INITCAP()`
- `SAFE_CAST()`
- `SAFE.PARSE_DATE()`
- `COALESCE()`
- `REGEXP_CONTAINS()`
- `ROW_NUMBER()`
- Common Table Expressions (CTEs)

## Key Takeaways

This project demonstrates how SQL can be used not only to query
data, but also to investigate, validate and transform messy datasets
into a more consistent analytical structure.

## Next Steps

Possible extensions include:

- Standardizing country names
- Cleaning and converting the price field
- Validating order IDs
- Creating data quality metrics
- Comparing the raw and cleaned datasets


## Reference

This project was inspired by the following tutorial:

**[Watch me Cleaning Data in minutes with SQL — Lore So What](https://www.youtube.com/watch?v=eOlHqTfWi6k)**

The project follows the data cleaning workflow presented in the tutorial,
with adaptations and additional data quality checks applied as part of
my SQL practice.