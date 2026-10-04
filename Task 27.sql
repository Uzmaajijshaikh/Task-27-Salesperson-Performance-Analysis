Query 1
SELECT Region,ROUND(SUM(Sales), 2) AS Total_Sales FROM superstore GROUP BY Region ORDER BY Total_Sales DESC;

Query 2
SELECT Region,ROUND(SUM(Profit), 2) AS Total_Profit FROM superstore GROUP BY Region ORDER BY Total_Profit DESC;

Query 3
SELECT Region,ROUND(SUM(Sales), 2) AS Total_Sales,ROUND(SUM(Profit), 2) AS Total_Profit FROM superstore GROUP BY Region ORDER BY Total_Sales DESC;

Query 4
SELECT Region,ROUND(SUM(Sales), 2) AS Total_Sales,ROUND(SUM(Profit), 2) AS Total_Profit,ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin_Percent FROM superstore GROUP BY Region ORDER BY Profit_Margin_Percent DESC;

Query 5
SELECT Region,COUNT(DISTINCT "Order ID") AS Total_Orders FROM superstore GROUP BY Region ORDER BY Total_Orders DESC;

Query 6
SELECT Region,ROUND(SUM(Sales) / COUNT(DISTINCT "Order ID"), 2) AS Average_Order_Value FROM superstore GROUP BY Region ORDER BY Average_Order_Value DESC;

Query 7
SELECT Region,COUNT(DISTINCT "Order ID") AS Total_Orders,ROUND(SUM(Sales), 2) AS Total_Sales,ROUND(SUM(Profit), 2) AS Total_Profit,ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin_Percent,
ROUND(SUM(Sales) / COUNT(DISTINCT "Order ID"), 2) AS Average_Order_Value FROM superstore GROUP BY Region ORDER BY Total_Profit DESC;

Query 8
SELECT Region,substr("Order Date", -4) AS Order_Year,ROUND(SUM(Sales), 2) AS Total_Sales FROM superstore GROUP BY Region, Order_Year ORDER BY Region, Order_Year;

Query 9
SELECT Region,ROUND((SUM(CASE WHEN substr("Order Date", -4) = '2017' THEN Sales ELSE 0 END) - SUM(CASE WHEN substr("Order Date", -4) = '2014' THEN Sales ELSE 0 END)) * 100.0 / SUM(CASE WHEN substr("Order Date", -4) = '2014' THEN Sales ELSE 0 END), 2) AS Sales_Growth_Percent FROM superstore GROUP BY Region ORDER BY Sales_Growth_Percent DESC;

Query 10
SELECT Region,ROUND(SUM(Sales), 2) AS Total_Sales,RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank FROM superstore GROUP BY Region ORDER BY Sales_Rank;

Query 11
SELECT Region,ROUND(SUM(Profit), 2) AS Total_Profit,RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank FROM superstore GROUP BY Region ORDER BY Profit_Rank;

Query 12
WITH Regional_Performance AS (SELECT Region,SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit, COUNT(DISTINCT "Order ID") AS Total_Orders
FROM superstore GROUP BY Region)
SELECT Region,ROUND(Total_Sales, 2) AS Total_Sales,ROUND(Total_Profit, 2) AS Total_Profit,Total_Orders,ROUND(Total_Sales / Total_Orders, 2) AS Average_Order_Value,RANK() OVER (ORDER BY Total_Profit DESC) AS Profit_Rank,RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM Regional_Performance ORDER BY Profit_Rank;

Query 13
SELECT Region,Segment,ROUND(SUM(Sales), 2) AS Total_Sales,ROUND(SUM(Profit), 2) AS Total_Profit,COUNT(DISTINCT "Order ID") AS Total_Orders,
ROUND(SUM(Sales) / COUNT(DISTINCT "Order ID"), 2) AS Average_Order_Value FROM superstore GROUP BY Region, Segment ORDER BY Region, Total_Profit DESC;