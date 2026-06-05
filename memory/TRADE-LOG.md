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

### 2026-05-22 — EOD Snapshot
- **Alpaca equity (reported)**: $100011.26
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $818.51 (27.3% deployed)
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
| AAPL | 1 | 298.7$ | 308.61$ | 9.91$ (3.3%) | 1.2% |
| NOW | 5 | 101.71$ | 101.98$ | 1.35$ (0.3%) | 2.3% |

### 2026-05-25 — EOD Snapshot
- **Alpaca equity (reported)**: $100012.22
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $819.47 (27.3% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 308.82$ | 10.12$ (3.4%) | 0% |
| NOW | 5 | 101.71$ | 102.13$ | 2.1$ (0.4%) | 0% |

### 2026-05-26 — EOD Snapshot
- **Alpaca equity (reported)**: $100000.75
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $808 (26.9% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 308.5$ | 9.8$ (3.3%) | -0.1% |
| NOW | 5 | 101.71$ | 99.9$ | -9.05$ (-1.8%) | -2.2% |

### 2026-05-27 — EOD Snapshot
- **Alpaca equity (reported)**: $100033.59
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $840.837 (28.0% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 311.49$ | 12.79$ (4.3%) | 1% |
| NOW | 5 | 101.71$ | 105.8694$ | 20.797$ (4.1%) | 6% |

### 2026-05-28 — EOD Snapshot
- **Alpaca equity (reported)**: $100060
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $867.25 (28.9% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 312.2$ | 13.5$ (4.5%) | 0.4% |
| NOW | 5 | 101.71$ | 111.01$ | 46.5$ (9.1%) | 8.7% |

### 2026-05-29 18:33:39 — STOP TIGHTENED: NOW
- Position at +21.6%
- Trailing 10% → 5%

### 2026-05-29 — EOD Snapshot
- **Alpaca equity (reported)**: $100146.75
- **Operating equity (capped)**: $3000
- **Cash**: $99192.75
- **Positions value**: $954.0021999999999 (31.8% deployed)
- **Day P&L**: $0 (0.0%)
- **Phase P&L**: $0 (0.0%)
- **Peak equity**: $3000
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 0 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 311.2022$ | 12.5022$ (4.2%) | -0.4% |
| NOW | 5 | 101.71$ | 128.56$ | 134.25$ (26.4%) | 18.2% |

### 2026-06-01 — Trade Entry: MSFT
- **Ticker**: MSFT
- **Side**: BUY
- **Shares**: 1
- **Entry price**: $461.0 (intended)
- **Position cost**: $461.0
- **Stop**: trailing 10% GTC (order_id: 1daa217a-7378-4231-9fa8-581876b112c0)
- **Target**: $525.54
- **Catalyst**: Nvidia RTX Spark Superchip partnership announced at Computex Taipei — MSFT Windows on Arm architecture; stock breaking above $450 resistance for first time since January; 42/48 analysts rate Buy or better
- **Sector**: Technology
- **Buy order_id**: 4aaa17a7-d4c5-4601-bb6c-289fb3481bfe
- **Capital used after**: $768.71 / $3000

### 2026-06-01 — EOD Snapshot
- **Alpaca equity (reported)**: $100150
- **Operating equity (capped)**: $3000
- **Cash**: $99392.06
- **Positions value**: $757.94 (25.3% deployed)
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
| AAPL | 1 | 298.7$ | 305.66$ | 6.96$ (2.3%) | -2.1% |
| MSFT | 1 | 461.59$ | 452.28$ | -9.31$ (-2%) | 0.5% |

### 2026-06-02 — EOD Snapshot
- **Alpaca equity (reported)**: $100147.53
- **Operating equity (capped)**: $3000
- **Cash**: $99392.05
- **Positions value**: $755.48 (25.2% deployed)
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
| AAPL | 1 | 298.7$ | 314.8$ | 16.1$ (5.4%) | 2.8% |
| MSFT | 1 | 461.59$ | 440.68$ | -20.91$ (-4.5%) | -4.3% |

### 2026-06-03 19:50:23 — POSITION CLOSED (Hard Stop -7%)
- **Ticker**: MSFT
- **Reason**: unrealized_plpc reached -7.17%
- **Exit price**: ~$428.5 (market order)
- **Realized P&L**: $-33.09
- **Hold**: from entry @ $461.59

### 2026-06-03 — EOD Snapshot
- **Alpaca equity (reported)**: $100133.89
- **Operating equity**: $100133.89
- **Cash**: $99820.43
- **Positions value**: $313.46 (0.3% deployed)
- **Day P&L**: $97133.89 (3237.8%)
- **Total P&L (desde inicio)**: $97133.89 (3237.8%)
- **Peak equity**: $100133.89
- **Drawdown from peak**: 0.0%
- **Trades today**: 0
0
- **Trades this week**: 1 / 3
- **Daytrade count**: 0 / 3

**Open positions:**

| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |
|--------|--------|-------|---------|-----------------|---------|
| AAPL | 1 | 298.7$ | 313.46$ | 14.76$ (4.9%) | -0.6% |

### 2026-06-05 — Trade Entry: JPM
- **Ticker**: JPM
- **Side**: BUY
- **Shares**: 72
- **Entry price**: $275.0 (intended)
- **Position cost**: $19800.0
- **Stop**: trailing 10% GTC (order_id: 8b795aa0-b7f5-477e-b27b-2fe2dbed2c43)
- **Target**: $313.5
- **Catalyst**: JPM +3% Thursday in XLF financials rotation; JPMorgan CEO Dimon set to present SpaceX largest-ever IPO to investors — deal flow catalyst; hot jobs print supports bank earnings
- **Sector**: Financials (XLF)
- **Buy order_id**: 6fa30e49-425b-4681-9209-b4a2970384fc
- **Capital used after**: $20113.19 / $100133.61
