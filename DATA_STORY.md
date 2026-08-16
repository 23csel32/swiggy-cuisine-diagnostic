# Data Story — Swiggy Cuisine Performance Diagnostic

**Period covered:** January–June 2026 (Delivered orders only, from `monthly_cuisine_revenue.csv`)

## Cuisines Above Target

| Cuisine | Total Revenue | Target | Variance | % Variance |
|---|---|---|---|---|
| North Indian | ₹216,297 | ₹180,000 | +₹36,297 | +20.17% |
| South Indian | ₹63,417 | ₹50,000 | +₹13,417 | +26.83% |
| Italian | ₹14,735 | ₹10,000 | +₹4,735 | +47.35% |

North Indian is the platform's largest cuisine by revenue and clears its (also largest) target
by over 20%. Italian has the smallest absolute target and beats it by the widest margin
(+47.35%), though its total revenue base is still the smallest of the six cuisines.

## Cuisines Below Target

| Cuisine | Total Revenue | Target | Variance | % Variance |
|---|---|---|---|---|
| Fast Food | ₹55,123 | ₹60,000 | -₹4,877 | -8.13% (Watch) |
| Chinese | ₹127,840 | ₹140,000 | -₹12,160 | -8.69% (Watch) |
| Desserts | ₹19,694 | ₹25,000 | -₹5,306 | -21.22% (Critical) |

Fast Food and Chinese are both in the "Below Target - Watch" band — each missing its target by
roughly 8%, which is a manageable gap. Desserts is the one cuisine in the "Below Target -
Critical" band, missing its target by over 21%, the largest shortfall (in percentage terms) on
the platform.

## Recommendations for the Category Team

1. **Prioritize catalog and restaurant-acquisition effort on Desserts.** It is the only cuisine
   in the Critical shortfall band. Given its target (₹25,000) is already the second-smallest on
   the platform, the shortfall suggests either too few active dessert restaurants or low order
   volume per restaurant — both fixable by onboarding more dessert listings and running
   dessert-specific promotions, rather than by lowering the target.

2. **Review the least-active restaurants inside the Chinese and Fast Food cuisines** (see the
   ascending order-count ranking in `02_aggregation_joins.sql`, Task 4(b)). Both cuisines are
   close to target (within ~9%), so the fix is likely concentrated in a handful of
   underperforming restaurants rather than the whole cuisine — pulling low-order-count Chinese
   and Fast Food restaurants for a listing-quality or pricing review is a smaller, more targeted
   intervention than a catalog-wide push.

*All figures above are taken directly from `03_reporting.sql` (Task 5c) and reconciled against
the Cuisine Summary sheet in `Swiggy_Cuisine_Diagnostic.xlsx`; no numbers here are estimated.*
