-- Create a cleaned analytical view for our EE subscriber dataset
CREATE VIEW vw_EE_Subscriber_Metrics AS
SELECT 
    customerID AS CustomerID,
    Contract AS ContractType,
    tenure AS ContractTenureMonths,
    MonthlyCharges AS MonthlyBill_GBP,
    TotalCharges AS TotalBill_GBP,
    Churn AS ChurnStatus
FROM raw_ee_subscribers;

-- Business Analysis Query: Churn Rate by Contract Type
SELECT 
    ContractType,
    COUNT(CustomerID) AS TotalSubscribers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS ChurnedSubscribers,
    ROUND(CAST(SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePercentage
FROM vw_EE_Subscriber_Metrics
GROUP BY ContractType
ORDER BY ChurnRatePercentage DESC;
-- 1. Create a cleaned analytical view using the correct table name
CREATE OR REPLACE VIEW vw_EE_Subscriber_Metrics AS
SELECT 
    customerID AS CustomerID,
    Contract AS ContractType,
    tenure AS ContractTenureMonths,
    MonthlyCharges AS MonthlyBill_GBP,
    TotalCharges AS TotalBill_GBP,
    Churn AS ChurnStatus
FROM `wa_fn-usec_-telco-customer-churn`;

-- 2. Business Analysis Query: Churn Rate by Contract Type
SELECT 
    ContractType,
    COUNT(CustomerID) AS TotalSubscribers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS ChurnedSubscribers,
    ROUND(CAST(SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePercentage
FROM vw_EE_Subscriber_Metrics
GROUP BY ContractType
ORDER BY ChurnRatePercentage DESC;
-- 1. Create a cleaned analytical view using the correct table name
CREATE OR REPLACE VIEW vw_EE_Subscriber_Metrics AS
SELECT 
    customerID AS CustomerID,
    Contract AS ContractType,
    tenure AS ContractTenureMonths,
    MonthlyCharges AS MonthlyBill_GBP,
    TotalCharges AS TotalBill_GBP,
    Churn AS ChurnStatus
FROM `wa_fn-usec_-telco-customer-churn`;

-- 2. Business Analysis Query: Churn Rate by Contract Type
SELECT 
    ContractType,
    COUNT(CustomerID) AS TotalSubscribers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS ChurnedSubscribers,
    ROUND(CAST(SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePercentage
FROM vw_EE_Subscriber_Metrics
GROUP BY ContractType
ORDER BY ChurnRatePercentage DESC;
-- Analysis: Churn Rate by Internet Service Type
SELECT 
    InternetService,
    COUNT(customerID) AS TotalSubscribers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedSubscribers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(customerID) * 100, 2) AS ChurnRatePercentage
FROM `wa_fn-usec_-telco-customer-churn`
GROUP BY InternetService
ORDER BY ChurnRatePercentage DESC;
-- Analysis: Churn Rate by Customer Tenure Group
SELECT 
    CASE 
        WHEN ContractTenureMonths <= 12 THEN 'New (0-12 Months)'
        WHEN ContractTenureMonths BETWEEN 13 AND 24 THEN 'Mid-Term (13-24 Months)'
        ELSE 'Long-Term (24+ Months)'
    END AS TenureGroup,
    COUNT(CustomerID) AS TotalSubscribers,
    SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS ChurnedSubscribers,
    ROUND(CAST(SUM(CASE WHEN ChurnStatus = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePercentage
FROM vw_EE_Subscriber_Metrics
GROUP BY TenureGroup
ORDER BY ChurnRatePercentage DESC;