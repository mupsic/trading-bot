# TRADE LOG

**Purpose:** Daily record of all executed trades, P&L, and decision-making

---

## FORMAT

```
## DATE: YYYY-MM-DD

### MORNING ANALYSIS
- Market Condition: [Bullish/Bearish/Neutral]
- Key Events: [Economic calendar, earnings, news]
- Trade Plan: [What we're looking for today]
- Perplexity Summary: [Key insights]

### TRADES EXECUTED
1. **SYMBOL: AAPL**
   - Time: 10:30 AM
   - Side: BUY
   - Qty: 100
   - Entry Price: $150.25
   - Stop Loss: $139.73 (7%)
   - Trail Stop: 10%
   - Reason: Momentum breakout, earnings coming

2. **SYMBOL: GOOGL**
   - Time: 2:15 PM
   - Side: SELL
   - Qty: 50
   - Entry Price: $125.00
   - Profit: +$625.00
   - Duration: 3 days
   - Reason: +20% target hit, take profit

### EOD SUMMARY
- Total Trades: 2
- Winning: 1 (GOOGL +$625)
- Losing: 0
- Neutral: 1 (AAPL - open)
- Daily P&L: +$625
- Open Positions: 1 (AAPL)

### NOTES
- Followed all rules ✓
- No violations
- Capital preserved

---
```

## TEMPLATE (Copy this for each day)

```
## DATE: YYYY-MM-DD

### MORNING ANALYSIS
- Market Condition:
- Key Events:
- Trade Plan:
- Perplexity Summary:

### TRADES EXECUTED
[Add trades as they happen]

### EOD SUMMARY
- Total Trades:
- Winning:
- Losing:
- Neutral:
- Daily P&L:
- Open Positions:

### NOTES
```

---

## HISTORICAL TRADES

*Add your trades here as you execute them. This log is auto-populated by ClickUp.*

### 2026-05-14 — Market Open Execution (NO TRADES)
- **Time**: 13:38 UTC (9:38 AM ET)
- **Status**: ⏸ Halted at STEP 1 — Today's research entry missing
- **Reason**: RESEARCH-LOG.md has no entry for 2026-05-14. Per routine STEP 1, missing/empty research → STOP, no trades.
- **Bot State**: PAUSED=no (not a manual pause)
- **Pre-flight checks performed**:
  - Date confirmed: 2026-05-14 (Thursday)
  - Alpaca paper account: ACTIVE ✓ ($100k buying power, daytrade_count=0, no blocks) — credentials now working (yesterday's 403 issue appears resolved)
  - Operating capital cap: $3,000
  - Open positions: 0
  - Capital used: $0 / $3,000
- **Planned candidates evaluated**: NONE — no research entry to draw from
- **Action taken**:
  - Telegram alert sent: "Market Open 2026-05-14: No trades today. Reason: missing pre-market research entry."
  - No orders placed
  - No stops needed (no positions opened)
- **Notes**:
  - Pre-market routine (7 AM) appears to have skipped or failed to write today's RESEARCH-LOG entry.
  - Yesterday's research recommended MCHP (6 sh @ $97) and MU (0.76 sh @ $788) but planned trades were blocked by Alpaca 403. Alpaca is now working — however, yesterday's candidates are stale (prices likely moved; catalysts may not re-validate).
  - **Recommended follow-up**: investigate why pre-market routine did not produce a 2026-05-14 research entry; re-run pre-market manually or wait for tomorrow.

---

### 2026-05-13 — Market Open Execution (FAILED)
- **Time**: 9:30 AM ET
- **Status**: ❌ API Authentication Error (403)
- **Issue**: Alpaca API rejected credentials in .env file
  - ALPACA_API_KEY appears to be invalid or expired
  - ALPACA_API_SECRET authentication failed
- **Planned Candidates**: 
  - MCHP (6 shares @ $97) — BLOCKED
  - MU (0.76 shares @ $788) — BLOCKED
- **Action Taken**: 
  - Telegram alert sent
  - No orders executed (API unavailable)
  - Requires manual credential renewal in .env
- **Notes**: Routine executed autonomously but halted at credential verification. User must renew Alpaca API keys.

---

### 2026-05-11 (First Trade)
- **Status:** Awaiting first trade...
- **Account:** Paper Trading (Alpaca)
- **Capital:** $[amount]

---

## STATISTICS (Updated Weekly)

| Metric | Value |
|--------|-------|
| Total Trades | 0 |
| Winning Trades | 0 |
| Losing Trades | 0 |
| Win Rate | 0% |
| Avg Win | $0 |
| Avg Loss | $0 |
| Total P&L | $0 |
| Best Trade | N/A |
| Worst Trade | N/A |
| Profit Factor | N/A |

---

## COMPLIANCE CHECKLIST

Every end of day:
- [ ] All trades logged
- [ ] P&L verified
- [ ] Open positions reviewed
- [ ] Trailing stops active
- [ ] No rule violations
- [ ] ClickUp notified

---

*This log is CRITICAL for auditing your bot and understanding what works.*

### 2026-05-15 — EOD Snapshot
- **Alpaca equity (reported)**: $100000
- **Operating equity (capped)**: $3000
- **Cash**: $100000
- **Positions value**: $0 (0.0% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

### 2026-05-18 — EOD Snapshot
- **Alpaca equity (reported)**: $100000
- **Operating equity (capped)**: $3000
- **Cash**: $100000
- **Positions value**: $0 (0.0% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

### 2026-05-19 — EOD Snapshot
- **Alpaca equity (reported)**: $100000
- **Operating equity (capped)**: $3000
- **Cash**: $100000
- **Positions value**: $0 (0.0% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

### 2026-05-20 — Trade Entry: NOW
- **Ticker**: NOW
- **Side**: BUY
- **Shares**: 5
- **Entry price**: $101.0 (intended)
- **Position cost**: $505.0
- **Stop**: trailing 10% GTC (order_id: c826ec59-7e43-41ef-93e4-05d9cd0d49aa)
- **Target**: $115.14
- **Catalyst**: BofA reinstated Buy rating (PT $130) on May 18; Bernstein PT raised to $236; Experian multi-year AI partnership announced May 15; software sector rotation gaining momentum as capital rotates from semis to enterprise software ahead of NVDA earnings
- **Sector**: Technology (Enterprise Software)
- **Buy order_id**: e73054c3-c829-4148-b87d-27e209dae62b
- **Capital used after**: $804.85 / $3000

### 2026-05-20 — EOD Snapshot
- **Alpaca equity (reported)**: $100003.11
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $810.36 (27.0% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 1
- **Trades this week**: 1 / 3
- **Daytrade count**: 1 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 301.51$ | 2.81$ (0.9%) | 0.9% |
| NOW | 5 | 101.71$ | 101.77$ | 0.3$ (0.1%) | -0.1% |

### 2026-05-21 — EOD Snapshot
- **Alpaca equity (reported)**: $100006.63
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $813.88 (27.1% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 1 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 304.48$ | 5.78$ (1.9%) | 0.7% |
| NOW | 5 | 101.71$ | 101.88$ | 0.85$ (0.2%) | -1.4% |
