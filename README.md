# olist_data_analysis_using_sql
A data analytics project leveraging SQL to interrogate the Olist Brazilian E-commerce dataset. Covers business-driven queries across order lifecycle, revenue trends, seller performance, and customer segmentation to derive decision-ready insights.

## :bookmark_tabs: Table of Contents
1. [Project Overview](#project-overview)
2. [Dataset](#dataset)
3. [Data Cleaning](#data-cleaning)
4. [Analysis Structure](#analysis-structure)
5. [Key Insights](#key-insights)
6. [Repository Structure](#repository-structure)

## Project Overview
This project applies structured SQL analysis to the Olist Brazilian E-commerce public dataset to answer real-
world business questions across four progressive complexity levels, from revenue aggregation to advanced
customer segmentation and RFM scoring.

The **goal** is to simulate the analytical workflow of a data analyst at a tech/e-commerce company: 
- clean the data
- formulate hypotheses
- write production-grade queries
- surface actionable insights

Focus Area | Questions |
|---|---|
| Business Health | Monthly revenue, top categories by state, payment methods breakdown |
| Logistics & Customer Satisfaction | Delivery reliability, rating vs. delay correlation, underperforming sellers |
| Advanced Analytics  | Retention rate, CLV ranking, monthly cohort analysis, 7-day moving average |
| Customer & Operational Intelligence | Full RFM segmentation, seller logistics incident report |
## Dataset
Source: [Brazilian E-Commerce by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

The dataset contains approximately 100k orders placed on Olist between 2016 and 2018. It includes information on order
status, pricing, payment, freight, customer location, product attributes, and seller reviews.

The following schema explains how each dataset relates to the others.
<img width="2486" height="1496" alt="image" src="https://github.com/user-attachments/assets/4a7b95b1-45d7-4990-bc35-6f200f3d01ec" />

## Data Cleaning
Before running any analysis, raw data was cleaned using **PowerQuery** to ensure consistency and reliability.

Key transformations made on raw data:
- Removed duplicate records and null values in critical columns
- Standardized date formats across timestamp fields
- Filtered orders to only include **delivered** status where relevant for revenue and logistics analysis
- Normalized inconsistent category names using the translation mapping table
## Analysis Structure

### **Business Health**

- **Monthly Revenue Analysis**: Calculates total revenue and order count per month and year, broken down by seller.

- **Top Categories by Brazilian State**: Identifies the top 3 product categories by revenue in each Brazilian state.

- **Payment Methods Breakdown**: Computes usage percentage, average ticket, and total volume for each payment type.

### Logistics & Customer Satisfaction

- **Delivery Reliability by State**: Measures average late delivery days per state by comparing actual vs. estimated delivery dates, surfacing the worst-performing regions.

- **Review Score vs. Delivery Delay**: Segments orders into on-time and late, then compares average review scores across groups — quantifying the customer satisfaction impact of logistics failures.

- **Underperforming Sellers**: Flags sellers with a low average review score and a high number of products sold, identifying systemic quality or logistics issues at the seller level.

### Advanced Analytics

- **Retention Rate**: Calculates the percentage of customers who placed more than one order, using a unique customer identifier to deduplicate across accounts.

- **Customer Lifetime Value (CLV) Ranking**: Computes total lifetime spend per customer, ranks them, and enriches the output with city and most-purchased product category. Returns top 100 customers.

- **Monthly Cohort Analysis**: Isolates customers whose first purchase was in January 2017 and tracks how many returned within the following 6 months.

- **7-Day Moving Average**: Smooths daily revenue by excluding weekends and applying a rolling average, exposing underlying sales trends without noise.

### Customer & Operational Intelligence

- **Full RFM Segmentation**: Scores all customers on Recency, Frequency, and Monetary dimensions, assigning quintile-based scores to enable targeted segmentation.

- **Seller Logistics Incident Report**: Identifies sellers whose average shipping time exceeds their state's average by more than 20%, surfacing potential review score impact from logistics outliers.

## 💡 Key Insights

- 💳 **Credit cards dominate** payment methods with **75.4% of transactions** and an average ticket of **$163** — debit cards account for just 1.5% of the total.
- 📦 **The state of Amapá (AP) has delivery delays double** those of the second worst-performing state in the country.
- ⭐ **Orders delivered on time score 50% higher** on average than late ones — logistics is not just an ops problem, it's a customer experience problem.
- 🔁 **Retention rate: 0%** — every customer in the dataset bought once and never came back. That's not a data issue, that's a business signal.
- ⚠️ **128 sellers** take at least 1.2x longer to ship than their state average — one of them averages **29 days against a state average of 4**.

## Repository Structure
```
olist_data_analysis_using_sql/
│
├── README.md
├── top_categories_by_state.sql
├── payment_methods.sql
├── delivery_reliability.sql
├── review_vs_delay.sql
├── underperforming_sellers.sql
├──  retention_rate.sql
├── clv_ranking.sql
├── cohort_analysis.sql
├── moving_average_revenue.sql
├── rfm_segmentation.sql
├── seller_incident_report.sql
```
