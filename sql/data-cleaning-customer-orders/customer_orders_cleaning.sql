-- ============================================================
-- DATA CLEANING WITH SQL
-- Dataset: Customer Orders
-- Platform: Google BigQuery
-- ============================================================


-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================

-- Inspect the raw dataset
SELECT * FROM `sql-data-cleaning-506612.sql_practice.customer_order`;


-- ============================================================
-- 1.2. DATA QUALITY ASSESSMENT
-- ============================================================

-- Check missing values
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(customer_name IS NULL) AS missing_customer_name,
  COUNTIF(email IS NULL) AS missing_email,
  COUNTIF(product_name IS NULL) AS missing_product,
  COUNTIF(quantity IS NULL) AS missing_quantity,
  COUNTIF(price IS NULL) AS missing_price
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;

-- ============================================================
-- 2. ORDER STATUS STANDARDIZATION
-- ============================================================

-- Inspect unique values before cleaning
SELECT order_status 
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;

-- Standardize the order_status column
SELECT order_status,
CASE
  WHEN LOWER(order_status) LIKE '%pend%' THEN "Pending"
  WHEN LOWER(order_status) LIKE '%deliv%' THEN "Delivered"
  WHEN LOWER(order_status) LIKE '%ship%' THEN "Shipped"
  WHEN LOWER(order_status) LIKE '%ref%' THEN "Refunded"
  WHEN LOWER(order_status) LIKE '%ret%' THEN "Returned"
  ELSE 'Other'
END AS cleaned_order_status
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;

-- ============================================================
-- 3. PRODUCT NAME STANDARDIZATION
-- ============================================================

-- Inspect unique product names before cleaning
SELECT DISTINCT product_name
FROM `sql-data-cleaning-506612.sql_practice.customer_order`
ORDER BY product_name ASC;


-- Standardize product names
SELECT product_name,
CASE
  WHEN LOWER(product_name) LIKE '%app%' THEN 'Apple Watch'
  WHEN LOWER(product_name) LIKE '%ipho%' THEN 'IPhone 14'
  WHEN LOWER(product_name) LIKE '%sams%' THEN 'Samsung Galaxy S22'
  WHEN LOWER(product_name) LIKE '%pix%' THEN 'Google Pixel'
  WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
  ELSE 'Other'
END AS cleaned_product_name
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;


-- ============================================================
-- 4. QUANTITY DATA TYPE CLEANING
-- ============================================================

-- Inspect the quantity field before cleaning
SELECT quantity
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;


-- Convert textual quantities and standardize the data type
SELECT quantity,
CASE
  WHEN LOWER(quantity) = 'two' THEN 2
  ELSE CAST(quantity AS INT64)
END AS cleaned_quantity
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;


-- ============================================================
-- 5. CUSTOMER NAME STANDARDIZATION
-- ============================================================

-- Standardize capitalization of customer names
SELECT customer_name,
INITCAP(customer_name) AS customer_name
FROM `sql-data-cleaning-506612.sql_practice.customer_order`
WHERE customer_name IS NOT NULL;


-- ============================================================
-- 6. DATE STANDARDIZATION
-- ============================================================

-- Convert dates stored in different formats into a
-- standardized DATE format

SELECT
  order_date,
  COALESCE(
    SAFE.PARSE_DATE('%Y-%m-%d', CAST(order_date AS STRING)),
    SAFE.PARSE_DATE('%m/%d/%Y', CAST(order_date AS STRING))
  ) AS standardized_order_date
FROM `sql-data-cleaning-506612.sql_practice.customer_order`;


-- ============================================================
-- 7. DUPLICATE DETECTION AND REMOVAL
-- ============================================================

-- Identify potential duplicate orders based on
-- customer email and product
SELECT *
FROM (
SELECT *,
  ROW_NUMBER() OVER(
    PARTITION BY LOWER(email), LOWER(product_name)
    ORDER BY order_id
  ) AS rn
FROM `sql-data-cleaning-506612.sql_practice.customer_order`
)
WHERE rn = 1;

-- ============================================================
-- 8. FINAL CLEAN DATASET
-- ============================================================

-- Combine all cleaning steps into a single transformation
-- and remove duplicated records.
WITH cleaned_data AS (
  SELECT 
    order_id,
    -- Clean customer name
    INITCAP(customer_name) AS customer_name, 
    email,

    -- Standardize order_status
    CASE
      WHEN LOWER(order_status) LIKE '%pend%' THEN "Pending"
      WHEN LOWER(order_status) LIKE '%deliv%' THEN "Delivered"
      WHEN LOWER(order_status) LIKE '%ship%' THEN "Shipped"
      WHEN LOWER(order_status) LIKE '%ref%' THEN "Refunded"
      WHEN LOWER(order_status) LIKE '%ret%' THEN "Returned"
      ELSE 'Other'
    END AS cleaned_order_status,

    -- Standardize product_name
    CASE
      WHEN LOWER(product_name) LIKE '%app%' THEN 'Apple Watch'
      WHEN LOWER(product_name) LIKE '%ipho%' THEN 'IPhone 14'
      WHEN LOWER(product_name) LIKE '%sams%' THEN 'Samsung Galaxy S22'
      WHEN LOWER(product_name) LIKE '%pix%' THEN 'Google Pixel'
      WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
      ELSE 'Other'
    END AS cleaned_product_name,

    -- Convert quantity to integer
    CASE
      WHEN LOWER(quantity) = 'two' THEN 2
      ELSE SAFE_CAST(quantity AS INT64)
    END AS clean_quantity,

    -- Standardize date format
    COALESCE(
      SAFE.PARSE_DATE('%Y-%m-%d', CAST(order_date AS STRING)),
      SAFE.PARSE_DATE('%m/%d/%Y', CAST(order_date AS STRING))
    ) AS standardized_order_date

  FROM `sql-data-cleaning-506612.sql_practice.customer_order`
  -- Remove records without a customer name
  WHERE customer_name IS NOT NULL
),

deduplicated_data AS (
  SELECT *,
  ROW_NUMBER() OVER(
    PARTITION BY LOWER(email), LOWER(cleaned_product_name)
    ORDER BY order_id
  ) AS rn
  FROM cleaned_data
)

SELECT *
FROM deduplicated_data
WHERE rn = 1

