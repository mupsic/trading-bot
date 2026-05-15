# RESEARCH LOG

**Purpose:** Daily pre-market research, analysis, and trade ideas

---

## FORMAT

```
## DATE: YYYY-MM-DD

### PRE-MARKET RESEARCH (7:00 AM)

#### Economic Calendar
- [Event]: [Time] - [Impact]
- Fed Meeting: 2:00 PM - FOMC Statement (HIGH)
- Jobs Report: 8:30 AM - Unemployment rate (HIGH)

#### Market Overview (NewsAPI Research)
- Top News: [From NewsAPI]
- Market Sentiment: [Bullish/Bearish/Neutral]
- Key Events: [Earnings, Fed decisions, economic data]
- Trend: [Based on news analysis]

#### Sector Analysis
- Technology: Strong (AI hype)
- Healthcare: Mixed (earnings concerns)
- Finance: Weak (rate hike fears)

#### Trade Ideas (Top 3 Candidates)
1. **AAPL** - Reason: New product launch rumors
   - Target: $155
   - Risk: $139
   - R:R: 1:2.4

2. **NVDA** - Reason: AI momentum continues
   - Target: $890
   - Risk: $850
   - R:R: 1:2.2

3. **MSFT** - Reason: Copilot adoption
   - Target: $380
   - Risk: $360
   - R:R: 1:4.0

#### Research Sources
- NewsAPI queries: 3
- Key insights: [Summary from news analysis]
- Confidence: [Your confidence level: 75%]

#### Action Plan
- Watch AAPL and NVDA at open
- Wait for volume confirmation
- Skip if Fed news negative
```

---

## TEMPLATE (Copy for each day)

```
## DATE: YYYY-MM-DD

### PRE-MARKET RESEARCH (7:00 AM)

#### Economic Calendar
-

#### Market Overview (Perplexity)
- S&P 500 Futures:
- Nasdaq Futures:
- VIX:
- Trend:

#### Sector Analysis
-

#### Trade Ideas (Top 3 Candidates)
1. **SYMBOL** - Reason:
   - Target:
   - Risk:
   - R:R:

#### Research Sources
-

#### Action Plan
```

---

## HISTORICAL RESEARCH

### 2026-05-11 (Day 1)

#### Economic Calendar
- Fed Decision: Pending
- Jobs Report: Not scheduled
- Earnings: Multiple (AAPL, GOOGL, MSFT)

#### Market Overview
- S&P 500 Futures: TBD
- Market Condition: Waiting for first analysis
- Confidence Level: N/A

#### First Trade Ideas
- [Awaiting first Perplexity research run...]

---

## PERPLEXITY RESEARCH SUMMARY

Keep track of recurring queries:

### Daily Queries
```bash
./scripts/news.sh market          # General market news
./scripts/news.sh earnings        # Earnings & economic data
./scripts/news.sh query "stock market"
```

### Weekly Queries
```bash
./scripts/news.sh sector Technology
./scripts/news.sh sector Healthcare
./scripts/news.sh query "market trends"
```

### On-Demand Queries
```bash
./scripts/news.sh stock AAPL
./scripts/news.sh sector [SECTOR_NAME]
./scripts/news.sh query "[YOUR_SEARCH]"
```

---

---

## 2026-05-13 — Pre-market Research

### Account Snapshot
- Alpaca equity: Unable to verify (API connectivity issue - 403 error)
- Operating capital: $3,000 (HARD CAP)
- Positions value: $0 (no open positions)
- Capital available within cap: $3,000
- Daytrade count: 0/3
- Trades this week: 0/3

### Market Regime ✅ **ON**
- SPY: $740.12 (MA200: ~671 from TipRanks) — **ABOVE MA200** ✓
- VIX: 18.01 — **LOW** (<25 threshold) ✓
- Regime: **ON** — Proceed with candidate analysis
- Reason: Healthy technicals despite hot inflation; mega-cap semis providing strength

### Market Context (WebSearch + Finnhub)

#### Economic Calendar & Data
- **Major Event**: April PPI released today = 1.4% MoM (vs 0.5% expected), 6% YoY (vs 4.8% expected) — HOT inflation
- **199 earnings reports today** — busy May earnings season
- **7 IPO pricings** happening this week
- **Market Reaction**: S&P 500 up 0.07%, Nasdaq up 0.40%, Dow down -0.29% — resilient despite inflation

#### Sector Momentum (Top Performers)
1. **Technology** — STRONG (XLK +0.95%, 6 momentum signals, mega-cap semis leading)
2. **Healthcare** — STRONG (FDA regulatory tailwinds, M&A momentum, strong earnings)
3. **Energy** — STRONG (up 21-22% YTD, oil supply concerns from Iran war)
4. **Financials** — WEAK (down 0.53%, sector under pressure despite good earnings)

#### Notable Pre-Market Movers
- **Positive**: ON Semiconductor +7.9%, Ford +6.1%, Akamai +5.5%
- **Negative**: Constellation Energy -7.8%, AppLovin -7.8%, Carvana -5.5%
- **Extreme**: FCHL +47% (class action risk), WOK -83.6% (reversal), HTCO -27%

### Trade Candidates (Regime ON — Proceed)

**CANDIDATE 1: Microchip Technology (MCHP)**
- **Catalyst**: Beat Q4 2026 earnings (May 7); raised Q1 2027 guidance well above consensus
  - EPS: $0.57 vs $0.51 consensus (+11% beat)
  - Revenue: $1.31B vs $1.26B expected (+4% beat)
  - Q1 2027 guidance: $0.67-$0.71 EPS (vs $0.56 consensus) = +19% upside
- **Current Price**: $96.95 (daily high $99.85, low $96.06)
- **Market Cap**: $52.46B ✓ (well above $1B minimum)
- **Sector Momentum**: Technology/Semiconductors — STRONG ✓
- **Next Earnings**: Not within 7 days ✓
- **Entry**: $96.95
- **Stop (7%)**: $96.95 × 0.93 = $90.16
- **Target (+14%)**: $96.95 × 1.14 = $110.52
- **Position Size**: floor($600 / $96.95) = **6 shares**
- **Risk per Trade**: 6 × ($96.95 - $90.16) = $40.74 (within $42 max) ✓
- **R:R Ratio**: ($110.52 - $96.95) / ($96.95 - $90.16) = $13.57 / $6.79 = **2.0:1** ✓
- **Confidence**: HIGH — Recent beat, raised guidance, strong sector momentum

**CANDIDATE 2: Micron Technology (MU)**
- **Catalyst**: Beat Q2 fiscal 2026 earnings (May 12); guided Q3 up 40% sequential; raised capex guidance
  - Revenue: $23.86B vs $19.76B consensus (+20.7% beat)
  - Net income: $13.79B vs $4.87B consensus (+183% beat)
  - Q3 guidance: $33.5B revenue (40% sequential growth)
  - Capex raised to $25B+ from $20B expected
- **Current Price**: $788.00 (daily high $815.19, low $779.47)
- **Market Cap**: $910.39B ✓ (mega-cap)
- **Sector Momentum**: Technology/Semiconductors — STRONG ✓
- **Next Earnings**: Not within 7 days ✓
- **Entry**: $788.00
- **Stop (7%)**: $788.00 × 0.93 = $733.84
- **Target (+14%)**: $788.00 × 1.14 = $898.32
- **Position Size**: $600 / $788.00 = **0.76 shares** (fractional, if Alpaca allows)
- **Risk per Trade**: 0.76 × ($788.00 - $733.84) = $41.22 (within $42 max) ✓
- **R:R Ratio**: ($898.32 - $788.00) / ($788.00 - $733.84) = $110.32 / $54.16 = **2.0:1** ✓
- **Confidence**: HIGH — Massive earnings beat, strong forward guidance, mega-cap, AI-driven demand

### Risk Factors Today
- **Inflation Concern**: Hot PPI data (6% YoY) may cause volatility or profit-taking in afternoon
- **Earnings Density**: 199 earnings today — potential for whipsaws; watch for surprises
- **Geopolitical Risk**: Iran war disrupting oil supply; potential for energy shocks
- **Small-Cap Weakness**: Dilutive capital raises hitting Russell 2000 (counterbalanced by mega-cap strength)
- **Earnings Blackout**: NVDA earnings on May 20 (7 days out) — skip NVDA to avoid pre-earnings volatility

### Decision
**RECOMMENDATION: TRADE**
- **Primary Candidate**: MCHP (Microchip Technology)
  - Easier position sizing (6 shares vs fractional)
  - Recent earnings beat + raised guidance
  - Strong sector tailwinds
  - Action: **BUY 6 shares MCHP at market open or on any dips to $95**
  
- **Secondary Candidate**: MU (Micron Technology) — if fractional shares allowed
  - Massive earnings beat (+183% net income)
  - Stronger forward guidance (Q3 +40% sequential)
  - Action: **BUY 0.76 shares MU if Alpaca supports fractional**

### Action Plan
1. **At Market Open (9:30 AM ET)**: Execute MCHP buy (6 shares @ ~$97)
2. **Stop Setup**: Immediately place 10% trailing stop on MCHP (GTC)
3. **Hard Stop Backup**: Set manual hard stop at $90.16 (-7%) in ClickUp reminder
4. **Monitor**: Watch for inflation reaction after 2:00 PM (if data gets worse)
5. **Profit Target**: Tighten trailing stop to 8% when position hits +15% ($111)
6. **Optional**: Add MU if fractional shares confirmed available

---

## INSIGHTS & PATTERNS

*Document what works and what doesn't:*

| Pattern | Success Rate | Notes |
|---------|--------------|-------|
| Tech momentum | 70% | Works in bull markets |
| Earnings plays | 50% | Too risky, avoid |
| Fed rate news | 40% | Too volatile, skip |
| Sector rotation | 65% | Good leading indicator |
| Post-earnings beats | 75% | Strong momentum if raised guidance |

---

## RESEARCH CHECKLIST

Every morning at 7:00 AM:
- [ ] Run Perplexity market research
- [ ] Check economic calendar
- [ ] Identify 3-5 trade candidates
- [ ] Set daily bias
- [ ] Document insights
- [ ] Alert: ClickUp message with summary

---

*This log helps you understand WHY you're trading, not just WHAT you're trading.*
