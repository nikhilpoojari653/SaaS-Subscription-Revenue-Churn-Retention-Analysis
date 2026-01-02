--- Monthly MRR
SELECT
  billing_month,
  SUM(monthly_price) AS total_mrr
FROM subs_data
WHERE subscription_status = 'Active'
GROUP BY billing_month
ORDER BY billing_month;

--- Revenue Movement
SELECT
  billing_month,
  revenue_change_type,
  SUM(monthly_price) AS revenue_amount
FROM subs_data
GROUP BY billing_month, revenue_change_type
ORDER BY billing_month;

--- Net MRR Change (Advanced, VERY IMPORTANT)
SELECT billing_month,
  SUM(
    CASE
      WHEN revenue_change_type IN ('New','Expansion') THEN monthly_price
      WHEN revenue_change_type IN ('Contraction','Churn') THEN -monthly_price
      ELSE 0
    END
  ) AS net_mrr_change
FROM subs_data
GROUP BY billing_month
ORDER BY billing_month;

--- Cohort Revenue
SELECT
  signup_month,
  billing_month,
  SUM(monthly_price) AS cohort_revenue
FROM subs_data
WHERE subscription_status = 'Active'
GROUP BY signup_month, billing_month
ORDER BY signup_month, billing_month;

--- Tier-wise ARPU
SELECT
  pricing_tier,
  SUM(monthly_price) / COUNT(DISTINCT customer_id) AS arpu
FROM subs_data
WHERE subscription_status = 'Active'
GROUP BY pricing_tier;

--- Tier-wise Expansion vs Contraction
SELECT
  pricing_tier,
  revenue_change_type,
  SUM(monthly_price) AS revenue
FROM subs_data
GROUP BY pricing_tier, revenue_change_type;



