-- ============================================
-- FASHION RETAIL SALES ANALYSIS
-- Tools: PostgreSQL (Aiven), DBeaver
-- Period: Oct 2022 - Sep 2023
-- ============================================

-- 1. DATA VALIDATION
-- Cek total baris dan kolom
SELECT 
    COUNT(*) as total_transactions,
    COUNT(DISTINCT "Item Purchased") as total_products,
    COUNT(DISTINCT "Payment Method") as payment_methods
FROM fashion_retail.fashion_retail_sales;

-- 2. TOTAL REVENUE (KPI)
SELECT 
    ROUND(SUM("Purchase Amount (USD)"::numeric), 2) as total_revenue_usd,
    ROUND(AVG("Purchase Amount (USD)"::numeric), 2) as avg_transaction_value
FROM fashion_retail.fashion_retail_sales;

-- 3. MONTHLY SALES TREND
SELECT 
    "Month",
    COUNT(*) as transaction_count,
    ROUND(SUM("Purchase Amount (USD)"::numeric), 2) as monthly_revenue
FROM fashion_retail.fashion_retail_sales
GROUP BY "Month"
ORDER BY monthly_revenue DESC;

-- 4. TOP 10 FAST-MOVING PRODUCTS
SELECT 
    "Item Purchased",
    COUNT(*) as units_sold,
    ROUND(SUM("Purchase Amount (USD)"::numeric), 2) as total_revenue,
    ROUND(AVG("Purchase Amount (USD)"::numeric), 2) as avg_price
FROM fashion_retail.fashion_retail_sales
GROUP BY "Item Purchased"
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. PAYMENT METHOD ANALYSIS
SELECT 
    "Payment Method",
    ROUND(AVG("Purchase Amount (USD)"::numeric), 2) as avg_purchase_amount,
    COUNT(*) as total_transactions,
    ROUND(SUM("Purchase Amount (USD)"::numeric), 2) as total_revenue
FROM fashion_retail.fashion_retail_sales
GROUP BY "Payment Method"
ORDER BY avg_purchase_amount DESC;

-- 6. CUSTOMER SATISFACTION BY PAYMENT
SELECT 
    "Payment Method",
    ROUND(AVG("Review Rating"::numeric), 1) as avg_review_rating,
    COUNT("Review Rating") as total_reviews
FROM fashion_retail.fashion_retail_sales
GROUP BY "Payment Method"
ORDER BY avg_review_rating DESC;