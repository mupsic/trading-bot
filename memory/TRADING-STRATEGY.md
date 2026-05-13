# TRADING STRATEGY - RULES & PARAMETERS

**Last Updated:** 2026-05-11
**Status:** ACTIVE

---

## POSITION MANAGEMENT

### Max Positions
- **Maximum concurrent positions:** 5-6
- **Maximum capital per position:** 20% of portfolio
- **Minimum position size:** 1 share or equivalent

### Trade Frequency
- **Max trades per week:** 3
- **Trading hours:** 9:30 AM - 4:00 PM EST (NYC)
- **Excluded:** Earnings announcements, major economic data

---

## STOP LOSS & PROFIT TAKING

### Trailing Stops (DEFAULT)
- **All positions:** 10% trailing stop loss
- **Type:** Percentage-based trailing stop
- **Execution:** Market order when triggered

### Hard Stop Loss
- **Absolute maximum loss:** -7% per position
- **Trigger:** Immediate sell if hit
- **Override:** NONE - This is a hard rule

### Profit Taking
- **Target 1 (+15%):** Tighten trailing stop to 8%
- **Target 2 (+20%):** Tighten trailing stop to 5%
- **Full exit:** Manual decision or if trailing stop triggered

---

## POSITION SIZING

### Capital Allocation (Example for $10,000)
```
Position 1: $2,000 (20%)
Position 2: $2,000 (20%)
Position 3: $2,000 (20%)
Position 4: $2,000 (20%)
Position 5: $2,000 (20%)
TOTAL:      $10,000 (100%)
```

### PDT (Pattern Day Trader) Rules
- **Day trades per 5 days:** Max 3
- **Minimum account balance:** $25,000 (for live trading)
- **Paper trading:** N/A (unlimited)

---

## ENTRY CRITERIA

### Pre-Market Analysis (7:00 AM)
- [ ] Check Perplexity for daily economic calendar
- [ ] Review overnight news and futures
- [ ] Identify 3-5 candidate stocks
- [ ] Set daily bias (Bullish, Bearish, Neutral)

### Entry Signals
- **Momentum:** Stock up 2-3% on high volume
- **Technical:** Break above 20-day moving average
- **Catalyst:** Earnings, FDA approval, major news
- **Sector:** Sector momentum (tech, healthcare, etc.)

### Risk/Reward Ratio
- **Minimum R:R:** 1:2 (for every $1 risk, expect $2 gain)
- **Example:** Enter at $100, stop at $93 (-$7 risk), target $114 (+$14 gain)

---

## RULE VIOLATIONS & PENALTIES

| Violation | Penalty |
|-----------|---------|
| More than 6 positions | Sell oldest position |
| Exceed 20% per position | Reduce to 20% |
| More than 3 trades/week | Pause trading |
| Position loses >7% | Auto-sell (hard stop) |
| Forgotten trailing stop | Manual review required |

---

## STRATEGY EVOLUTION

### Review Schedule
- **Daily:** EOD trade review (ClickUp logs)
- **Weekly:** Strategy performance + rule adherence
- **Monthly:** P&L analysis, slippage, commissions
- **Quarterly:** Strategy adjustment (if needed)

### Rule Changes
- All changes documented with date and reason
- Changes effective next trading day
- Previous rules archived in git history

---

## NOTES & OBSERVATIONS

- **Slippage Target:** <0.5% on market orders
- **Commission Model:** 0.5% per executed order (when monetized)
- **Timezone:** Spain (UTC+1/+2) or Brasil (UTC-3/-2) - adjust as needed
- **Backtesting:** Test rules on 6-month historical data before deployment

---

**⚠️ IMPORTANT:** These rules are NON-NEGOTIABLE. Bot will enforce them automatically.
