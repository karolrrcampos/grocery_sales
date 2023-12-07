USE marketsales;

CREATE TABLE mktsales(
order_id VARCHAR(10) PRIMARY KEY,
order_date VARCHAR(50),
order_month VARCHAR(50),
order_year VARCHAR(50),
product_category VARCHAR(50),
product_subcategory VARCHAR(50),
original_price DECIMAL(15,2),
sales_price DECIMAL(10,2),
discount_percentage VARCHAR(10),
profit DECIMAL(10,2),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);

-- Volume de vendas e lucro por cidade
CREATE TABLE vendas_lucro_cidade AS
SELECT city,
       COUNT(*) AS AmountSold,
       REPLACE(FORMAT(ROUND(SUM(profit), 2), 2), ',', '') AS TotalProfit
FROM mktsales
GROUP BY city
ORDER BY AmountSold DESC;

-- Volume de vendas e lucro por cidade
CREATE TABLE vendas_lucro_estado AS
SELECT state,
       COUNT(*) AS AmountSold,
       REPLACE(FORMAT(ROUND(SUM(profit), 2), 2), ',', '') AS TotalProfit
FROM mktsales
GROUP BY state
ORDER BY AmountSold DESC;

-- Volume de vendas e lucro por subcategoria de produtos
CREATE TABLE vendas_lucro_sub AS
SELECT product_subcategory,
       COUNT(*) AS AmountSold,
       REPLACE(FORMAT(ROUND(SUM(profit), 2), 2), ',', '') AS TotalProfit
FROM mktsales
GROUP BY product_subcategory
ORDER BY AmountSold DESC;

-- Volume de vendas e média lucro por mês de cada ano
CREATE TABLE vendas_avglucro_mes_ano AS
SELECT order_year, order_month, 
    COUNT(*) AS AmountSold,
    REPLACE(FORMAT(ROUND(AVG(profit), 2), 2), ',', '') AS AvgProfit
    FROM mktsales
GROUP BY order_month, order_year
ORDER BY order_year;

-- Volume de vendas e lucro de categoria por ano
CREATE TABLE vendas_lucro_categ_ano AS
SELECT order_year, product_category,
    COUNT(*) AS AmountSold,
    REPLACE(FORMAT(ROUND(SUM(profit), 2), 2), ',', '') AS TotalProfit
    FROM mktsales
GROUP BY order_year, product_category
ORDER BY order_year;