# Olist Brazilian E-Commerce — Insights Report

> **Project:** End-to-End Data Analysis Portfolio  
> **Tools:** PostgreSQL, Power BI  
> **Dataset:** Olist Brazilian E-Commerce (Kaggle)  
> **Period Analysed:** September 2016 — October 2018

---

## Executive Summary

Olist is a Brazilian e-commerce marketplace that connects small businesses to major retail channels. This analysis covers 99,441 orders, 96,096 unique customers, 3,095 sellers, and R$16.01M in total revenue. Five key business opportunities and risks were identified across revenue growth, geographic concentration, delivery performance, customer satisfaction, and retention.

---

## Insight 1 — Strong Revenue Growth With a Late 2018 Drop

**Finding:**
Monthly revenue grew consistently from R$0.1M in late 2016 to a peak of approximately R$1.2M in mid-2018, representing roughly 12x growth over two years. However, a sharp decline is visible from August 2018 onwards.

**So What:**
The growth trajectory confirms Olist successfully scaled its marketplace model. However the late 2018 drop is a red flag — it could indicate seasonal slowdown, increased competition, or data incompleteness for the final months of the dataset.

**Action:**
Investigate the August 2018 drop specifically — check whether it is a data collection issue (incomplete month) or a genuine business decline. If genuine, analyse which product categories and states drove the drop.

---

## Insight 2 — São Paulo Dominates But Creates Concentration Risk

**Finding:**
São Paulo (SP) accounts for approximately 42% of all orders — more than the next 5 states combined. The top 3 states (SP, RJ, MG) together represent nearly 70% of total orders.

**So What:**
This geographic concentration is both a strength and a vulnerability. SP's dominance likely reflects where Olist's seller network is strongest and where logistics are most efficient. However, over-reliance on one region creates risk — any disruption to SP logistics (strikes, extreme weather, carrier issues) would cripple nearly half of Olist's business.

**Action:**
Prioritise seller acquisition and marketing campaigns in RJ, MG, and RS which show strong existing demand and represent natural expansion markets. Diversifying revenue across more states reduces concentration risk and unlocks significant growth potential.

---

## Insight 3 — Late Deliveries Directly Destroy Customer Satisfaction

**Finding:**
Orders delivered on time received an average review score of 4.3★. Late orders received an average of 2.6★ — a drop of 1.7 stars. Additionally 1★ reviews (11,424) outnumber 2★ and 3★ reviews combined — customers who are unhappy are extremely unhappy.

**So What:**
Delivery timing is the single biggest driver of customer satisfaction on Olist. Customers do not leave neutral reviews when deliveries are late — they leave the worst possible rating. This directly impacts Olist's platform reputation and seller rankings.

**Action:**
Implement a delivery performance monitoring dashboard for sellers. Sellers with late delivery rates above 10% should receive automated warnings. Consider showing customers more conservative estimated delivery dates to manage expectations and reduce disappointment.

---

## Insight 4 — Northern States Have the Worst Delivery Performance

**Finding:**
States like AM (Amazonas), RR (Roraima), AP (Amapá) and PA (Pará) consistently show the highest late delivery percentages — some exceeding 30% late rate compared to SP's rate of under 5%.

**So What:**
Brazil's northern states are geographically remote and have limited logistics infrastructure. Customers in these states are being set up to fail — they receive poor estimated delivery dates and then suffer even worse actual delivery times. This is both a customer experience problem and a business growth barrier since these states have low but growing order volumes.

**Action:**
Partner with regional carriers who specialise in northern Brazil logistics. Alternatively display region-specific estimated delivery dates that reflect realistic northern delivery timelines rather than using national averages — underpromise and overdeliver.

---

## Insight 5 — Credit Cards Dominate But Boleto Shows Financial Inclusion

**Finding:**
Credit cards account for 73.92% of payments. Boleto (a Brazilian bank slip payment method) accounts for 19.04%. Debit cards and vouchers make up the remaining 7%.

**So What:**
Boleto's 19% share is significant — it represents customers who either don't have credit cards or prefer not to use them online. This is a financial inclusion story unique to Brazil. Boleto users tend to be from lower income brackets and smaller cities — a largely untapped market segment for Olist.

**Action:**
Ensure the checkout experience for boleto payments is seamless. Consider targeted promotions for boleto users (e.g. small discounts for boleto payment) to grow this segment. Also investigate whether boleto orders have higher cancellation rates due to payment abandonment — this would be a key metric to monitor.

---

## Insight 6 — Customer Retention Is Very Low

**Finding:**
Out of 96,096 unique customers, approximately 96.7% placed only 1 order. Fewer than 3,400 customers ordered more than once. This means Olist is almost entirely dependent on acquiring new customers rather than retaining existing ones.

**So What:**
Acquiring a new customer typically costs 5-7x more than retaining an existing one. With a 97% one-time buyer rate Olist is running an extremely expensive customer acquisition treadmill. Even a small improvement in retention — say bringing repeat purchase rate from 3% to 6% — would significantly improve revenue without additional acquisition costs.

**Action:**
Implement a post-purchase email sequence targeting customers 30-60 days after their first order with personalised product recommendations based on their purchase category. Introduce a loyalty programme or repeat purchase discount. Investigate whether low retention is driven by poor experience (late delivery, bad products) or simply low purchase frequency in the categories Olist serves.

---

## Insight 7 — Review Participation Is High But Scores Are Polarised

**Finding:**
99,224 reviews were submitted out of 99,441 orders — a near 100% review completion rate. Score distribution is U-shaped: 57% gave 5★, 11% gave 1★, with relatively few 2★, 3★, or 4★ reviews.

**So What:**
The high review completion rate suggests Olist's review request system works effectively. The polarised distribution is typical of e-commerce — customers are motivated to review when they are either delighted or angry, rarely for average experiences. The 11% of customers giving 1★ represents approximately 10,900 highly dissatisfied customers — a significant reputational risk on a public platform.

**Action:**
Prioritise resolving the 1★ review drivers — cross reference these orders with late delivery data to confirm delivery is the primary cause. For orders flagged as likely to be late, send a proactive customer service message before the estimated delivery date to manage expectations and potentially prevent 1★ reviews.

---

## Summary of Recommendations

| Priority | Recommendation | Expected Impact |
|---|---|---|
| High | Fix northern state delivery performance | Reduce late orders, improve review scores |
| High | Implement post-purchase retention emails | Increase repeat purchase rate |
| High | Investigate August 2018 revenue drop | Identify and address revenue risk |
| Medium | Expand seller network in RJ and MG | Reduce SP concentration risk |
| Medium | Set state-specific delivery estimates | Manage customer expectations |
| Low | Boleto-specific promotions | Grow underserved customer segment |

---

*Insights report prepared as part of the Olist E-Commerce Data Analysis Portfolio Project.*  
*Analysis by: Nitesh*
