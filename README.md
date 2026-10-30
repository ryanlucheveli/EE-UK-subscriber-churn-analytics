# EE UK Subscriber Churn Analysis

## 📊 Executive Summary & Business Context
* **Objective:** Perform an end-to-end customer churn analysis on EE telecom subscription data[cite: 1] to identify key drivers of customer attrition and provide data-driven retention recommendations.
* **Business Impact:** Customer acquisition costs in the telecom industry are high; identifying at-risk subscribers allows business units to deploy targeted retention interventions before cancellation occurs.
* **Key Insights Uncovered:** 
  * **Contract Type:** Month-to-month contracts experience a disproportionately high churn rate (42.71%) compared to fixed-term plans[cite: 4].
  * **Internet Service:** Fiber optic internet service subscribers exhibit higher attrition (41.89%)[cite: 5], signaling potential pain points in service quality, pricing, or competitor displacement.
  * **Customer Tenure:** New subscribers (0–12 months tenure) are the most vulnerable segment, showing a 47.68% churn rate[cite: 5].

---

## 🛠️ Data Preparation & SQL Methodology
To standardize and analyze the raw data inside MySQL Workbench (`EE_Customer_DB`), a structured analytical view was created to clean column names and types:

```sql
CREATE OR REPLACE VIEW vw_EE_Subscriber_Metrics AS
SELECT 
    customerID AS CustomerID,
    Contract AS ContractType,
    tenure AS ContractTenureMonths,
    MonthlyCharges AS MonthlyBill_GBP,
    TotalCharges AS TotalBill_GBP,
    Churn AS ChurnStatus
FROM `wa_fn-usec_-telco-customer-churn`;
