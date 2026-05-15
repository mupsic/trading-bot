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

I'll gather all the required data points systematically.Now let me search for specific trade candidates and confirm sector momentum with more precision.Now I have all the data needed. Let me compile the research log.

**Key data points gathered:**
- SPY current: $748.17; SPY 200-day MA: ~$706.38 (Investing.com) or ~$671-674 (TipRanks/Financhill from May 13) → Using most recent from Investing.com: **$706.38**
- VIX: **~18.01** (Yahoo Finance history page) / **17.26** (Yahoo Finance futures page after close) → Current reading ~**17.90-18.01**
- SPY > MA200 ✓ AND VIX < 25 ✓ → **REGIME = ON**
- CSCO: surged ~15% on earnings beat, now ~$117; next earnings Aug 11 → eligible
- AMAT: reported earnings May 14 (yesterday) → just reported, need to assess post-earnings reaction; next earnings ~Aug → eligible but just reported
- AVGO: ~$438, earnings June 3 → within 7 days? No, ~19 days away → eligible but price too high for $600 cap (1 share = $438)
- NVDA reports May 20 → within 7 days, EXCLUDE
- XLK leading sector this week with tech/AI rally

## 2026-05-15 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100000.00
- Operating cap: $3,000
- Cash: $100000.00
- Positions value: $0.00
- Capital available: $3000.00
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $748.17 (MA200: $706.38) — ABOVE
- VIX: 18.01 — LOW
- Regime: ON
- Reason: SPY 200-day moving average is 706.38; SPY at $748.17 is well above MA200, and VIX at 18.01 is below 25 threshold.

### Market Context
- Top catalysts today:
  - The US stock market surged toward new records, as strength in AI-related companies and optimism surrounding the US-China summit in Beijing helped offset global economic pressures. The S&P 500 climbed 0.8% to cross 7,500 for the first time.
  - Shares of Cisco surged 13% after the software giant posted third-quarter results and guidance that beat Wall Street's expectations.
  - Nvidia also jumped 4.4%, extending its monthly gain to 15% after the US approved shipments of H200 chips to 10 Chinese companies.
  - May 15: April industrial production and capacity utilization.
  - Annual CPI gains topped estimates, sending odds of a rate hike much higher and wiping out most chances of a 2026 rate cut.
- Sector leaders:
  - XLK (Technology): Leading sector — XLK had a total return of 60.47% in the past year. The top performing sectors in May 2026 included Communication Services, Technology, Healthcare.
  - XLE (Energy): Elevated due to Iran war/oil at ~$100+
  - XLF (Financials): +0.59% on 5/14
  - XLV (Healthcare): -0.05% on 5/14
- Economic events:
  - April Industrial Production & Capacity Utilization (today)
  - Empire State Manufacturing (today)
  - Trump-Xi Beijing Summit Day 2
  - Hot PPI (yesterday: +1.4% headline) and CPI still reverberating

### Trade Candidates (Regime ON)

1. **CSCO** — Earnings beat catalyst (Q3 FY26: EPS $1.06 vs $1.04 est, Rev $15.84B vs $15.56B est); Shares jumped 14% and headed for their best day in more than two decades after Cisco blew past its AI infrastructure and hyperscaler guidance orders. For fiscal Q4, Cisco guided $1.16-$1.18 in adjusted EPS on $16.7B-$16.9B revenue. Next earnings Aug 11 (safe). Entry ~$117, stop $108.81 (-7%), target $133.38 (+14%), shares=5, cost=$585. R:R 1:2.

2. **AVGO** — Broadcom jumped 4.3% after multiple firms significantly raised price targets, with Wells Fargo increasing to $545 from $430. AI-related semiconductor revenue potentially running 30-40% higher than anticipated. Broadcom also recently disclosed a partnership with Meta to produce a new 2-nanometer AI chip. Earnings June 3 (19 days out, safe). Entry ~$438, stop $407.34 (-7%), target $499.32 (+14%), shares=1, cost=$438. R:R 1:2.

### Risk Factors Today
- SPY RSI (14) is 76.14 — overbought territory, pullback risk elevated
- 10-year Treasury yield traded at 4.48%, touching its highest levels of the year — rising yields pressure growth stocks
- Hot PPI/CPI data eliminating rate cut hopes; rate hike odds rising above 30%
- Iran war/Strait of Hormuz geopolitical risk persists despite positive signals
- Nvidia reports on May 20th — major event risk for entire tech/AI complex next week
- CSCO gapped up ~15% from $101.87; chasing a post-earnings gap carries fade risk
- AVGO at $438/share limits position to 1 share only = concentrated risk on single share

### Decision
HOLD — While Regime is ON and catalysts are strong, both top candidates carry elevated risk:
1. **CSCO** has already gapped +15% and is trading at 52-week highs ($119.36 intraday high yesterday); entering now is chasing a massive gap with high fade probability on day 2. Wait for pullback/consolidation toward $110-112 range.
2. **AVGO** at ~$438 allows only 1 share within $600 cap — insufficient diversification and unable to scale properly.
3. RSI at 76+ on SPY signals overbought broad market; NVDA earnings May 20 creates binary event risk for entire tech sector within 5 trading days.
4. Treasury yields at 2026 highs + hot inflation data = macro headwind for growth/tech.

**Recommendation**: Wait for post-NVDA-earnings clarity (May 20-21) or a 2-3% pullback to enter with better risk/reward. Monitor CSCO for pullback to $108-112 range as swing entry.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-15",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```
