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

I'll gather all the required data points systematically.Now let me search for sector ETF performance and pre-market movers.Now let me search for specific swing trade candidates with catalysts that fit our criteria.Now I have all the data needed. Let me compile the research log.

Key data points gathered:
- **SPY**: Current $748.17 (from Finnhub). MA200: Multiple sources show ~$671-706 range. TipRanks (May 13) shows SMA200 at $671.11; Investing.com shows $706.38; Financhill shows $673.98. I'll use the most recent/reliable: Investing.com at ~$706.
- **VIX**: Yahoo Finance shows 17.90 (today); CBOE prev close 17.26
- **CSCO**: Surged ~14-17% on massive earnings beat, trading ~$115-117, AI order book raised to $9B
- **AMAT**: Beat earnings (EPS $2.86 vs $2.68 est), Q3 guidance $8.95B revenue, but pre-market down ~$14 from $440.56
- **Sector**: XLK (Technology) clearly strongest, +60% 1Y return, SOX up 64% since March
- **NVIDIA earnings May 20**: event risk for tech

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
- SPY: $748.17 (MA200: ~$706) — ABOVE
- VIX: 17.90 — LOW
- Regime: **ON**
- Reason: SPY 200-day moving average is 706.38, SPY at $748.17 is well above; VIX at 17.90 is below 25 threshold.

### Market Context
- Top catalysts today:
  - The S&P 500 rose 0.77% to finish at a record 7,501.24 on Thursday — new all-time highs on S&P 500 and Nasdaq
  - Cisco CEO Chuck Robbins told CNBC that skyrocketing demand for AI is powering the industry toward a "networking supercycle." Shares jumped 14% after Cisco blew past its AI infrastructure and hyperscaler guidance, lifting its forecast from $5 billion to $9 billion.
  - Applied Materials delivered record Q2 revenue of $7.91 billion, driven by strong demand for AI and semiconductor equipment, with optimistic Q3 revenue guidance of $8.95 billion.
  - Top U.S. executives, including Elon Musk, Tim Cook, and Jensen Huang, joined Donald Trump and President Xi Jinping at a high-stakes 2026 welcoming banquet in Beijing.
  - U.S. wholesale prices skyrocketed in April far above consensus estimates — monthly PPI rose 1.4% and core surged 1%. Analysts had expected 0.4% and 0.3%.
- Sector leaders:
  - XLK (Technology): Strongest — XLK had a total return of 60.47% in the past year; PHLX Semiconductor Index (SOX) has risen 64% since the end of March
  - XLF (Financials): +0.59% Thursday
  - XLI (Industrials): +0.51% Thursday
  - XLE (Energy): Oil at ~$102/bbl, elevated on Strait of Hormuz tensions
  - XLV (Healthcare): -0.05% Thursday
- Economic events:
  - Friday (May 15): Capacity Utilization, Empire State Manufacturing, Industrial Production
  - Jerome Powell's term as Fed Chair ends Friday May 15; Kevin Warsh transition
  - The 10-year Treasury yield traded at 4.48%, touching its highest levels of the year
  - 30-year Treasury yield tops 5.1% (per Finnhub headlines)

### Trade Candidates (Regime ON)

1. **CSCO** — Massive Q3 earnings beat + AI order book raised to $9B; Cisco reported EPS of $1.06 vs expectations of $1.00, a 6% beat; Cisco raised its fiscal 2026 AI infrastructure order outlook from $5 billion to $9 billion; Morgan Stanley raised price target to $120 from $91; Rosenblatt raised price target to $150 from $100. Entry ~$117.00 (post-gap consolidation), stop $108.81 (-7%), target $133.38 (+14%), shares=5, cost=$585.00, R:R 1:2. Next earnings not until 8/12/2026.

2. **MU (Micron Technology)** — Micron Technology (MU) surged more than 15% last week on a wave of high-bandwidth memory orders for AI; beneficiary of same AI/HBM supercycle driving AMAT/CSCO. Strong sector momentum in semis. Entry requires price check — based on prior research MU was ~$788 but may have moved significantly. At that price, $600 cap allows 0 full shares → **SKIP** (price too high for position sizing).

**Replacement candidate:**

2. **HPE (Hewlett Packard Enterprise)** — Notable gainers among liquid option names include Hewlett Packard Enterprise (HPE) $34.11 +2.04; direct AI networking/infrastructure beneficiary of same supercycle as CSCO; sector momentum strong. Entry ~$34.00, stop $31.62 (-7%), target $38.76 (+14%), shares=17, cost=$578.00, R:R 1:2. Next earnings ~June 2026 (>7 days away).

### Risk Factors Today
- The May 15 Polymarket contract implied a 99% probability that the benchmark index would open lower on Friday — expect pullback at open
- "The hot PPI data is sending yields sharply higher" — inflation concerns could weigh on tech
- Nvidia reports on May 20th — a "sell on the news" reaction could occur — binary event risk for tech sector next week
- Some investors have grown cautious about the increasingly narrow nature of the rally. Strategists have warned that the market's advance is becoming increasingly dependent on a handful of technology stocks.
- RSI (14) at 76.14 — overbought territory
- 30-year Treasury yield above 5.1%, highest in nearly a year — bond competition for equities
- CSCO already gapped up 14%+ — chasing a gap carries risk of mean reversion
- AMAT stock has dropped $14.12 in pre-market trading — suggests post-earnings profit-taking in semis possible

### Decision
**HOLD** — While regime is ON and CSCO has a legitimate catalyst, the risk-reward for entering today is unfavorable:
1. CSCO gapped up ~15% yesterday; entering after a gap this large means buying extended, with limited upside to a reasonable target and high risk of pullback
2. Polymarket pricing 99% chance of lower open — likely selling pressure at open
3. Hot PPI data + yields at 2026 highs creates macro headwind
4. NVDA earnings May 20 is a binary event that could reverse the entire tech rally
5. RSI overbought at 76 on SPY — pullback likely before sustainable entry
6. Better to wait for a consolidation day or pullback in CSCO/tech names to enter at lower-risk levels

**Recommendation:** Monitor CSCO for a pullback to the $110-112 support zone (prior gap fill level) next week for a better entry. Also watch for NVDA earnings reaction May 20 as a sector-wide catalyst.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-15",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```

I'll gather the required data points systematically.Now let me search for sector ETF performance and pre-market movers:Now let me search for specific candidate stocks with catalysts:Now I have all the data I need. Let me compile the research log.

Key data gathered:
- **SPY**: $740.03 (live), MA200: ~$672.78-675.59 (multiple sources, using TipRanks at $672.78 and Financhill at $675.59) → SPY ABOVE MA200
- **VIX**: Last close 18.43, current ~18.33-18.99 → BELOW 25
- **Regime**: ON (SPY > MA200 AND VIX < 25)
- Key catalysts: NVDA earnings Wed, Iran war/oil tensions, rising Treasury yields, FOMC minutes Wed, Bill Ackman MSFT stake, RAMP M&A (+27%), BRC +12%, RKLB earnings beat momentum
- Pre-market movers: RAMP +27% (M&A), BRC +12%, RKLB +4.1%, MSFT +3.1%, HCWB +203%
- Sector: XLK (Tech) leading with 51.42% 1Y return and 22.58% trailing returns; XLE benefiting from oil; XLF supported by rising yields
- RKLB at ~$129.86 premarket — too expensive for $600 cap (only 4 shares at $600/$130 = 4.6 shares)
- MSFT around high price — too expensive for a meaningful position
- BRC (Brady Corp) at ~$85-90 range, gained 12% — need to check
- Need affordable stocks with catalysts under $600 position size

RKLB: ~$130 → 4 shares × $130 = $520 ≤ $600 ✓ — but RSI overbought at these levels, up 472% in a year. NVDA earnings Wed is a risk factor for the whole tech/aerospace complex. No RKLB earnings in next 7 days (reported May 7) ✓.

MSFT: ~$475+ → only 1 share for $475 ≤ $600 ✓ — catalyst is Ackman stake. No earnings in next 7 days ✓. But $475 for 1 share is thin.

BRC (Brady Corp): ~$85-90, gained 12% premarket today — let me consider this. Market cap ~$4.5B. But need to know exact catalyst.

Given the constraints and risks (rising yields, oil tensions, Schwab "moderately bearish" outlook, overbought RSI on SPY at 78.69), I should be cautious.

## 2026-05-18 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100000.00
- Operating cap: $3,000
- Cash: $100000.00
- Positions value: $0.00
- Capital available: $3000.00
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $740.03 (MA200: $672.78) — ABOVE
- VIX: 18.43 — LOW
- Regime: ON
- Reason: SPY's 200-day simple moving average is 672.78; SPY at $740.03 is +10% above MA200. VIX at 18.99, up +3.04% pre-market but well below 25 threshold.

### Market Context
- Top catalysts today:
  - Stocks were rising and oil prices were easing as investors monitored developments in the U.S.-Iran conflict and geared up for earnings from Nvidia (NVDA) later this week.
  - Nvidia and Target (TGT) are both scheduled to post quarterly results on Wednesday. Walmart (WMT) is slated to report earnings on Thursday.
  - U.S. Treasury yields are breaching several key levels across the curve today (2-year > 4.0%, 10-year > 4.50%, 30-year > 5.0%).
  - LiveRamp Holdings (RAMP) surged 27% in early trading on news that advertising firm Publicis Groupe will acquire the company in an all-cash deal valued at $2.5 billion.
  - Shares of Microsoft Corporation gained 3.1% following hedge fund manager Bill Ackman's disclosure of a new stake via Pershing Square Capital Management.
  - Chances of a Fed rate hike sometime this year climbed to 45%, according to the CME FedWatch Tool.
- Sector leaders:
  - XLK (Technology): XLK had a total return of 51.42% in the past year; earnings for XLK members expected up 43% this year — STRONGEST
  - XLE (Energy): Benefiting from Iran war oil spike, IEO (Oil & Gas ETF) up +2.63%, XLE up +2.36% on Friday
  - XLF (Financials): Close at $51.10, only -0.37% Friday; supported by rising yields/NIM expansion
  - XLV (Healthcare): $145.10, -1.04% Friday
  - XLY (Consumer Disc): $116.53, -1.80% Friday — lagging
  - XLP (Consumer Staples): $84.64, -0.40% Friday — defensive
- Economic events:
  - NY Empire State Manufacturing Index for May jumped to 19.6, in contrast to the Zacks Consensus Estimate of 7.
  - Key events this week: Pending Home Sales (Tue), Fed FOMC meeting minutes (Wed), NVDA + WMT earnings.
  - Kevin Warsh prepares to take over the Federal Reserve when Chairman Jerome Powell's term ends.

### Trade Candidates (Regime ON)

**NOTE: Despite Regime ON, significant caution warranted.**

The confluence of rising bond yields, potential for higher oil prices, and the effective ending of Q1 earnings season may provide enough catalyst for some healthy consolidation. Schwab's forecast is "Moderately Bearish" for this week. SPY RSI (14) is 78.69 — deeply overbought. 84.3% of S&P 500 companies exceeded earnings expectations with average upside surprise of 18.6%, so the positive earnings cycle is largely priced in.

Given these headwinds, only 1 high-conviction candidate identified:

1. **MSFT** — Bill Ackman/Pershing Square new stake catalyst + software sector breakout (IGV above 100d SMA), entry ~$475, stop $441.75 (-7%), target $541.50 (+14%), shares=1, cost=$475, R:R 1:2
   - Shares of Microsoft Corporation (MSFT) rose 3.1% after hedge fund manager Bill Ackman disclosed a new stake in the company through Pershing Square Capital Management.
   - Two bullish catalysts: Figma "beat and raise" quarter + Ackman's new MSFT stake citing "highly compelling valuation".
   - Market cap: ~$3T ✓ | No earnings within 7 days ✓ | Tech sector leading ✓
   - **CONCERN**: Only 1 share at $475 — thin position, limited upside in dollar terms (~$66 target gain). Rising yields are headwind for tech multiples.

**REJECTED candidates:**
- RKLB ($129.86): RKLB has returned 472% over the past year and 68% year to date. Massively extended; only 4 shares fit budget. No clear near-term catalyst beyond post-earnings momentum. Risk of pullback if NVDA disappoints Wed.
- RAMP ($RAMP): M&A target at fixed acquisition price — no swing upside remaining in an acquisition deal.
- BRC ($85-90): Moved +12% already today; chasing gap-up without established setup.

### Risk Factors Today
- The 10-year Treasury note yield spiked nine basis points to 4.55%, the highest in a year, indicating rising concerns about war-related inflation leading to possible rate hikes.
- IEA head warned commercial oil inventories are depleting rapidly with only a few weeks' worth left due to the Iran war and the closure of the Strait of Hormuz.
- NVDA earnings Wednesday could swing entire tech sector ±5%
- The SOX now trades 32% above its 50-day moving average — historically extreme premium
- SPY RSI 78.69 = deeply overbought; 30-year yield at multi-year highs
- Fed rate hike probability at 45% — a sharp reversal from near-zero a month ago

### Decision
HOLD — Regime is ON but risk/reward is unfavorable for new entries today. SPY is deeply overbought (RSI 78.69), Treasury yields at year-highs, oil supply crisis escalating, and NVDA earnings Wednesday introduces massive binary event risk. Schwab outlook is "Moderately Bearish" for this week. MSFT is a viable candidate but 1-share position at $475 offers limited dollar upside ($66 at target) relative to the macro headwinds. Better to wait for a pullback or post-NVDA clarity mid-week before deploying capital.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-18",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```

Now I have all the data I need. Let me compile the research log.

Key findings:
- **SPY**: Current price ~$734.46 (from Finnhub). SPY 200-day SMA is $672.78. Also Investing.com shows SPY MA200 at $712.56 and Financhill shows 675.59. Using the TipRanks figure (672.78) as it's a clear SMA200 from May 16. SPY at 734.46 is ABOVE MA200. ✅
- **VIX**: VIX closed at 17.82. Pre-market VIX is at 18.99, up +3.04%. Yahoo shows VIX at 18.85. Under 25. ✅
- **REGIME = ON** (SPY > MA200 AND VIX < 25)

Market context:
- Stock futures are lower and oil prices are falling amid inflation fears and the previous session's tech sell-off.
- Trump called off a scheduled attack on Iran because "serious negotiations" are underway.
- Nvidia earnings coming out Wednesday May 20th after the bell.
- Home Depot beat Wall Street's expectations on the top and bottom lines and reaffirmed its full-year guidance.
- Treasury yields are spiking across the curve (10-year > 4.50%).

Sector data from Yahoo (May 18): XLF +1.25%, XLP +1.49%, XLV +0.43%, XLY -0.18%. XLK appears to be selling off today. Defensive/financials leading.

MPC: Price ~$259.53. Too expensive for $600 max (can only buy 2 shares = $519). Marathon Petroleum beat Q1 profit estimates, benefiting from stronger refining margins. Multiple analyst upgrades with Goldman raising PT to $291. Ex-dividend date May 20, 2026. However, at $259+ per share, 2 shares = ~$519, which fits.

But caution flags are significant: market is pulling back, overbought RSI, rising bond yields, tech sell-off, NVDA earnings risk Wed. The Schwab analyst gave a "Moderately Bearish" forecast for this week. This is a tricky environment.

Let me assess candidates carefully. Given the environment (pullback, rising yields, war uncertainty), I should be cautious. XLF and XLP showing relative strength. MPC has strong Q1 beat + buyback expansion + going ex-div tomorrow, but the stock is near 52-week highs and insider selling. 

Given the high uncertainty (NVDA earnings Wed, Iran tensions, bond yields spiking, overbought conditions), the prudent call is HOLD despite regime being ON.

## 2026-05-19 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100000.00
- Operating cap: $3,000
- Cash: $100000.00
- Positions value: $0.00
- Capital available: $3000.00
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $734.46 (MA200: $672.78) — ABOVE
- VIX: 18.85 — LOW
- Regime: ON
- Reason: SPY well above 200-day MA (+9.2%); VIX under 25 threshold at ~18.85, confirming low-vol bull regime

### Market Context
- Top catalysts today:
  - **US-Iran ceasefire talks**: Trump called off scheduled attack on Iran; "serious negotiations" underway — creating geopolitical whipsaw risk
  - **NVDA earnings Wednesday (May 20 AMC)**: Analysts expect $1.78 EPS (+120% YoY) on $79.2B revenue; this will set tone for AI/tech complex
  - **Home Depot Q1 beat**: Revenue $41.77B (vs $41.63B est), adj EPS $3.43 (vs $3.41 est); full-year guidance reaffirmed — retail reading
  - **Treasury yields spiking**: 10-year >4.50%, 30-year >5.0%; global bond selloff (Japan JGB highest since 1997) — rate-hike fears under new Fed Chair Warsh
  - **Tech sell-off continuation**: S&P futures -0.49%, Nasdaq -0.78% pre-market; AMAT sold off despite earnings beat Friday; Cerebras (CBRS) -4% after 68% IPO debut
- Sector leaders (last session, May 18):
  - XLP (Consumer Staples): +1.49%
  - XLF (Financials): +1.25%
  - XLV (Healthcare): +0.43%
  - XLY (Consumer Disc): -0.18%
  - XLK (Technology): selling off today (SOX pulled back from ATH)
  - XLE (Energy): mixed — oil falling on Iran ceasefire hopes
- Economic events:
  - 36 economic events scheduled for Tuesday May 19
  - NVDA earnings Wed May 20 (mega catalyst for entire market)
  - Lowe's (LOW) earnings Wed May 20
  - Global bond yield repricing ongoing
  - New Fed Chair Kevin Warsh settling in; rate hike now priced as possibility

### Trade Candidates (Regime ON — but environment hostile)

**EVALUATED BUT REJECTED:**

1. **MPC** — Q1 earnings beat ($1.65 adj EPS vs $0.75 est), $5B buyback authorization, multiple analyst upgrades (Goldman PT $291). Price ~$259.53, 2 shares = $519. **REJECTED**: Near 52-week high ($261.61), insider selling on May 15, ex-dividend tomorrow May 20 (likely to gap down after ex-div), and oil prices falling on Iran peace hopes create headwind for refinery margins.

2. **XLF components (JPM, BAC)** — Financials showing relative strength on rising yields. **REJECTED**: Bond yield spike is creating financial stress risk, not just NIM expansion. Uncertainty too high with Warsh's first moves as Fed Chair unknown.

3. **HD** — Q1 beat, guidance reaffirmed. **REJECTED**: Same-store sales flat, beat came on lowered estimates. At ~$350+ per share, only 1 share possible. Consumer spending under pressure from gas prices. Not compelling R:R.

### Risk Factors Today
- **NVDA earnings Wednesday**: Entire market hangs on this print; any "sell the news" reaction could drag indices -2%+
- **Bond yield breakout**: Global synchronized duration repricing; 30-yr >5% is a major warning
- **Iran uncertainty**: Ceasefire on "a knife edge" per Reuters; any escalation reversal would spike oil and VIX
- **Overbought technicals**: RSI 78.69 on SPY (sell signal); MACD also showing sell signal; Schwab outlook "Moderately Bearish" for this week
- **Post-earnings air pocket**: After NVDA, there are few remaining bullish catalysts to sustain AI rally
- **Rate hike repricing**: Market now pricing possible Fed hike under Warsh — a major shift from prior rate-cut expectations

### Decision
HOLD — Regime is ON but the risk/reward environment is deeply unfavorable this week. Multiple converging headwinds (NVDA binary event in 24 hours, global bond rout, overbought technicals, geopolitical knife-edge) make it imprudent to deploy fresh capital. The bot has 3 trades/week available; better to wait for post-NVDA clarity (Thursday/Friday) when the market's direction will be more legible. No edge identified today that justifies a position entry with hard -7% stop risk into this volatility cluster.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-19",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```

I'll gather the required market data systematically.Now let me search for sector ETF performance and pre-market movers:Now let me search for specific stock candidates with catalysts:Now I have all the data I need. Let me compile the research log.

## 2026-05-20 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100002.38
- Operating cap: $3,000
- Cash: $99701.30
- Positions value: $301.08
- Capital available: $2698.92
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $735.59 (MA200: ~$717) — ABOVE
- VIX: 17.96 — LOW
- Regime: **ON**
- Reason: SPY 200-day moving average is 717.18, current SPY at $735.59 is well above. VIX at 17.96 is below 25 threshold. Both conditions pass.

### Market Context
- Top catalysts today:
  - Nvidia (NVDA) first-quarter earnings report after the close — the AI chipmaking giant is widely viewed as a barometer for the artificial intelligence market
  - FOMC minutes release today; also expected earnings from Analog Devices (ADI), TJX Companies (TJX), Lowe's (LOW), Williams-Sonoma (WSM) and Intuit (INTU)
  - U.S. 20-Year and 30-Year Treasury are now at levels not seen since 2007 — rising yields headwind
  - Iran's Revolutionary Guard threatened to expand the Middle East conflict; Trump told lawmakers Washington would end the conflict "very quickly"
  - BofA reinstated coverage on ServiceNow (NOW) May 18 with a buy rating, arguing AI is the strongest tailwind NOW has ever seen
- Sector leaders (today's session from Yahoo data):
  - XLV (Healthcare): +1.10%, XLP (Consumer Staples): +0.22%, XLK (Technology): -session dependent
  - XLE (Energy): +1.17% — top sector gainer driven by Iran war/oil prices
  - XLF (Financials): -1.24%, XLY (Consumer Disc): -1.11%
  - **This week's strongest: XLE (Energy) and XLV (Healthcare)** — defensive/energy rotation amid rising yields and geopolitical risk
- Economic events:
  - FOMC Minutes (2:00 PM ET) — final Powell-era minutes
  - Several hawkish Fed voices have underscored persistent inflation pressures, with analysts expecting rates to stay on indefinite hold
  - 10-year Treasury yield closing around 4.66% and the 2-year yield near 4.11%

### Trade Candidates (Regime ON)

**IMPORTANT FILTERS APPLIED:**
- LOW reports earnings TODAY → **EXCLUDED** (event risk)
- NVDA reports earnings TODAY → **EXCLUDED**
- TJX, INTU, WSM report TODAY → **EXCLUDED**
- NOW (ServiceNow) — already reported Q1 on April 22, next earnings ~July → ELIGIBLE but price ~$101 means 5 shares = $505 ✓
- Software sector showing recovery: Software names went the other direction from chips, led by nearly 5% pre-market gains for ServiceNow (NOW)

1. **NOW** — BofA Buy reinstated (PT $130) + Experian AI partnership + software sector rotation away from semis, entry $101.00, stop $93.93 (-7%), target $115.14 (+14%), shares=5, cost=$505, R:R 1:2
   - BofA forecasts 18% to 22% revenue growth for NOW from 2026 through 2028. Key Q1 2026: Subscription revenues of $3.671 billion, up 22% year over year
   - Bernstein raised price target to $236 from $226, maintained Outperform rating
   - No earnings within 7 days ✓ | Market cap >$1B ✓ | Software sector showing positive momentum ✓

2. **AAPL** — ALREADY HELD (1 share @ $298.70, current $301.08, +0.8%). No action needed. Trailing stop should be active.

**Note on caution:** The S&P 500 fell for its third straight day and the potential for a "sell on the news" reaction around NVDA earnings is a possibility. FOMC minutes + rising yields create an uncertain afternoon. Recommend limiting to ONE new position today and waiting to see NVDA reaction before deploying more capital.

### Risk Factors Today
- **NVDA earnings after close** — could swing entire market sentiment; avoid entering any semi/AI-hardware names pre-report
- **FOMC minutes at 2 PM ET** — hawkish surprise risk given CME FedWatch now estimating higher odds for a hike
- **Rising Treasury yields** — 10-year yield at 4.66%, 20Y and 30Y at levels not seen in nearly two decades
- **Iran geopolitical escalation** — oil at ~$108-111/bbl adding inflation pressure
- **RSI overbought on SPY** — SPY RSI (14) is 78.69, creating a Sell signal — market technically stretched
- **3-day consecutive decline** in S&P 500 — potential for further consolidation

### Decision
**TRADE [NOW]** — One new position only. Conservative sizing given elevated macro risk. Enter NOW in first hour if price holds above $99. Place 10% trailing stop immediately after fill. Hold AAPL position with existing stop.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-20",
  "regime": "ON",
  "decision": "TRADE",
  "candidates": [
    {
      "symbol": "NOW",
      "entry_price": 101.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 5,
      "position_cost": 505.00,
      "target_price": 115.14,
      "catalyst": "BofA reinstated Buy rating (PT $130) on May 18; Bernstein PT raised to $236; Experian multi-year AI partnership announced May 15; software sector rotation gaining momentum as capital rotates from semis to enterprise software ahead of NVDA earnings",
      "sector": "Technology (Enterprise Software)",
      "rr_ratio": "1:2"
    }
  ]
}
```

I'll gather the required market data systematically.Now let me search for sector ETF performance and pre-market movers.Now I have enough data. Let me compile the key findings:

**CRITICAL FINDING: Today is Memorial Day (May 25, 2026) — US markets are CLOSED.**

Let me now compile the research log with all data gathered.

Key data points:
- **SPY**: $745.66 (from Finnhub). The SPY 200-day moving average is 722.35 (Investing.com), though SPY's 200-day simple moving average is 672.78 (TipRanks, from May 16). The more current Investing.com figure of ~722 is likely more recent. I'll use a synthesis: multiple sources show MA200 between 672-722. The Investing.com data appears most current.
- **VIX**: VIX: 16.70 (Yahoo Finance, as of May 22 close)
- **Market is CLOSED**: The NYSE and Nasdaq will be closed on Memorial Day, May 25, 2026, in observance of the federal holiday honoring fallen service members.

## 2026-05-25 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100,012.22
- Operating cap: $3,000
- Cash: $99,192.75
- Positions value: $819.47
- Capital available: $2,180.53
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $745.66 (MA200: ~$722.35) — ABOVE
- VIX: 16.70 — LOW
- Regime: **ON**
- Reason: SPY well above MA200 (+3.2%), VIX comfortably below 25. Bullish regime confirmed.

### Market Context
- **⚠️ US MARKETS CLOSED TODAY — MEMORIAL DAY HOLIDAY ⚠️**
- Top catalysts this week:
  - US-Iran peace talks progressing; Kevin Warsh expected to take oath as new Federal Reserve chairman
  - US computer makers surged after strong results from China's Lenovo Group. Dell Technologies hit a record high and HP Inc. climbed over 15%
  - S&P Global U.S. Manufacturing PMI increased to 55.3 in May from 54.5 in April, the highest reading since May of 2022
  - The S&P 500 gained 0.4%, extending its winning streak to eight consecutive weeks
  - Thursday brings Q1 GDP second estimate and April PCE prices
- Sector leaders (last session):
  - XLV (Healthcare): +1.17%
  - XLI (Industrials): +0.73%
  - XLK (Technology): ~+0.4%
  - XLF (Financials): +0.41%
  - XLY (Consumer Disc): +0.40%
  - XLP (Staples): +0.17%
- Economic events this week:
  - Mon 5/25: Markets closed (Memorial Day)
  - Tue 5/26: May consumer confidence; earnings from AutoZone (AZO) and Zscaler (ZS)
  - Wed 5/27: April new home sales; earnings from MRVL, CRM, SNPS, SNOW, DKS
  - Thu 5/28: Q1 GDP second estimate, April PCE prices; earnings from DELL, DLTR, MDB, BBY, COST, ADSK, GAP

### Trade Candidates (Regime ON, but market CLOSED today)
**No trades possible today — Memorial Day holiday. Markets reopen Tuesday 5/26.**

Potential candidates to research for Tuesday 5/26 open:
1. **DELL** — Dell Technologies hit a record high last week on PC/AI momentum; however earnings Wed 5/27 — **EXCLUDED** (earnings within 7 days)
2. **HPQ** — HPQ shares jumped 15.3% driven by optimism over its Personal Systems business. Growth in AI PCs and the Windows 11 refresh cycle powered demand; however earnings Wed 5/27 — **EXCLUDED**
3. **CRM** — Earnings Wed 5/27 — **EXCLUDED**
4. **MRVL** — Earnings Wed 5/27 — **EXCLUDED**

⚠️ Heavy earnings week ahead (CRM, MRVL, SNOW, DELL, COST, BBY, ADSK) eliminates most high-quality candidates due to the "no earnings within 7 days" rule.

### Risk Factors Today
- NYSE and Nasdaq closed on Memorial Day, May 25, 2026 — no trading possible
- University of Michigan Consumer Sentiment fell to 44.8 in May, its lowest reading on record. Respondents cited the cost of living and inflation as concerns
- Earlier this week, the 30-year bond yield hit a nearly 19-year high thanks to heavy inflation fueled by the Middle East conflict
- Fed minutes reveal that further rate hikes remain a possibility if inflation stays above the 2% target
- Earnings catalysts get much thinner ahead. Focus shifts toward the mid-June Fed meeting, when economic and rate projections could offer hawkish views
- Thursday PCE data could move markets significantly
- Most swing trade candidates have earnings this week (event risk)

### Decision
**HOLD** — US markets are closed today (Memorial Day). No trades can be executed. Regime is ON and capital is available ($2,180.53), but the dense earnings calendar this week (CRM, MRVL, DELL, COST, BBY, ADSK, SNOW) eliminates most quality candidates under the "no earnings within 7 days" rule. Will re-evaluate Tuesday pre-market for opportunities in names NOT reporting this week.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-25",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```

I'll gather the required market data systematically.Now I have sufficient data to compile the research log. Let me synthesize:

**Key Data Points:**
- SPY current: $751.05 (from Finnhub live data)
- SPY 200-day MA: ~$722.35 (Investing.com) or ~$672-675 (TipRanks/Financhill from mid-May). The most recent from Investing.com gives $722.35.
- VIX: ~16.61-16.75 (Yahoo Finance live data shows 16.61 pre-market, 16.75 intraday)
- QQQ: $727.80, up +1.43%
- Pre-market: MU +8.3%, GNRC fresh from Jefferies upgrade
- Sector: XLK +1.00%, XLV +1.17%, XLF +0.41%, XLY +0.40%, XLP +0.17%
- Key events: Consumer confidence today, MRVL/CRM/SNOW earnings Wed, GDP/PCE Thu

MU at ~$795 is way too expensive for $600 position cap (would get 0 shares). GNRC at ~$270 allows 2 shares max = $540. Let me check for better candidates within budget.

## 2026-05-26 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100003.46
- Operating cap: $3,000
- Cash: $99192.75
- Positions value: $810.72
- Capital available: $2189.28
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $751.05 (MA200: ~$722.35) — ABOVE
- VIX: 16.61 — LOW
- Regime: **ON**
- Reason: The SPY 200-day moving average is 722.35 and SPY trades at $751.05, well above MA200; VIX is at 16.75, well below the 25 threshold.

### Market Context
- Top catalysts today:
  - Investor sentiment improved after President Donald Trump said talks with Iran to end the war were "proceeding nicely," boosting hopes that a diplomatic resolution may be within reach.
  - Oil prices fell sharply following Trump's comments, with West Texas Intermediate crude futures dropping more than 5% in early trading. Lower oil prices could help ease inflation concerns.
  - Micron Technology (MU) climbs +8.3% on $3.1B volume following a bullish Bernstein supply-chain report. Markets are focused on the "AI supply crunch" narrative as MU and Marvell Technology (MRVL) lead the Nasdaq higher.
  - President Donald Trump led a ceremony swearing in Kevin Warsh as chair of the Federal Reserve.
  - The S&P 500 is coming off its eighth consecutive weekly gain, its longest winning streak since late 2023.
- Sector leaders (day change from Yahoo):
  - XLV (Healthcare): +1.17%
  - XLK (Technology): +1.00%
  - XLI (Industrials): +0.73%
  - XLF (Financials): +0.41%
  - XLY (Consumer Disc): +0.40%
  - XLP (Staples): +0.17%
- Economic events:
  - May 26: May consumer confidence and expected earnings from AutoZone (AZO) and Zscaler (ZS).
  - May 27: April new home sales and expected earnings from Dick's Sporting Goods (DKS), Marvell Technology (MRVL), Salesforce (CRM), Synopsys (SNPS), and Snowflake (SNOW).
  - May 28: First quarter GDP second estimate, April Personal Consumption Expenditures (PCE) prices, and expected earnings from Dell (DELL), Dollar Tree (DLTR), MongoDB (MDB), Best Buy (BBY), Costco (COST), AutoDesk (ADSK), and Gap (GAP).

### Trade Candidates (Regime ON)

1. **GNRC** — On May 22, 2026, Jefferies upgraded Generac Holdings Inc GNRC from Hold to Buy, raising its price target from $239 to $302. This upgrade resulted in a more than 3% increase in Generac's stock price. The upgrade thesis centered on expectations that Generac could secure meaningful hyperscaler supply agreements over the next few years. In its first-quarter 2026 update, Generac reported net sales growth and raised full-year 2026 guidance to mid-to-high teens percent growth. Entry ~$270, stop $251.10 (-7%), target $307.80 (+14%), shares=2 ($540), R:R 1:2. No earnings within 7 days. Industrials sector +0.73% today.

2. **CRWD** — CrowdStrike Holdings Inc. (CRWD + $18.17 to $666.40) hit a notable 52-week high last week. Strong cybersecurity momentum with AI-driven endpoint security demand. Sector leader in XLK. However, at ~$666/share, only 0 shares fit within $600 cap. **DISQUALIFIED — price exceeds $600 single-share limit.**

3. **DDOG** — Datadog Inc. (DDOG + $2.22 to $220.26) hit a 52-week high. Strong observability/AI ops momentum in enterprise software. Entry ~$220, stop $204.60 (-7%), target $250.80 (+14%), shares=2 ($440), R:R 1:2. No earnings within 7 days. Technology sector +1.00% today. **However**, DDOG reports earnings in early June window — need to verify. Schwab calendar does not list DDOG this week. Candidate passes.

### Risk Factors Today
- Focus shifts toward the mid-June Fed meeting, when economic and rate projections could offer hawkish views. Between the lack of earnings, focus on geopolitical tensions, and worries about rate hikes, there are challenges ahead.
- PCE data Thursday (May 28) could spike volatility if inflation runs hot
- SPY RSI (14) is 78.69, overbought territory — potential short-term pullback risk
- Middle East situation remains fluid; oil reversal could rattle markets
- Portfolio only 27% deployed — significantly under target 75-85% range, leaving room to add

### Decision
TRADE [GNRC] — Strong specific catalyst (Jefferies upgrade to Buy, $302 PT, data center hyperscaler contracts), sector momentum positive, fits within position sizing rules. DDOG considered but deferred pending earnings date confirmation next session.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-26",
  "regime": "ON",
  "decision": "TRADE",
  "candidates": [
    {
      "symbol": "GNRC",
      "entry_price": 270.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 2,
      "position_cost": 540.00,
      "target_price": 307.80,
      "catalyst": "Jefferies upgraded to Buy from Hold on May 22 with PT raised to $302; data center hyperscaler backup power contracts expected; Q1 beat with raised FY2026 guidance to mid-to-high teens growth",
      "sector": "Industrials",
      "rr_ratio": "1:2"
    }
  ]
}
```

Now let me compile all the data and produce the research log.

## 2026-05-27 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100023.30
- Operating cap: $3,000
- Cash: $99192.75
- Positions value: $830.55
- Capital available: $2169.45
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $750.55 (MA200: ~$722) — ABOVE
- VIX: ~17.01 — LOW
- Regime: **ON**
- Reason: The SPY 200-day moving average is 722.35, suggesting that the ETF is Buy. SPY current price $750.55 is well above MA200. VIX previous close was 17.01, well under 25 threshold. Both conditions met.

### Market Context
- Top catalysts today:
  - **US-Iran deal progress**: Stock indexes settled mostly higher on Tuesday, with the S&P 500 and Nasdaq 100 posting new all-time highs. Stocks found support as a drop in crude oil prices and bond yields fueled a rally in technology stocks after officials signaled the US was nearing a deal with Iran to reopen the Strait of Hormuz and restore oil flows.
  - **Semiconductor surge**: Shares of Micron Technology jumped 19% and topped $1 trillion in market capitalization amid bullishness among analysts on the Street. UBS in particular sees more than 100% upside ahead for the stock. Chip stocks rose on Tuesday, with the VanEck Semiconductor ETF (SMH) gaining more than 3% to touch a new 52-week high. On Semiconductor added nearly 9%, as did Western Digital. Advanced Micro Devices gained 6%.
  - **Earnings week**: Wednesday: Abercrombie & Fitch, Agilent Technologies, DICK's Sporting Goods, HP Inc., Marvell Technology, PDD Holdings, Salesforce, Snowflake, Synopsys.
  - **PCE data Friday**: The week's biggest number is April's Personal Consumption Expenditures (PCE) reading, which is due Friday.
  - **Oil price decline**: Technology, industrials and materials leading the gains, while energy, consumer staples and healthcare stocks recorded the sharpest declines.
- Sector leaders:
  - **XLK (Technology)**: Strongest — XLK +1.60% on Tuesday, driven by semis/AI
  - **XLF (Financials)**: XLF +0.41%
  - **XLY (Cons. Discretionary)**: XLY +0.40%
  - **XLV (Healthcare)**: XLV -0.71%
  - **XLE (Energy)**: XLE -0.34% — lagging on oil price drop
- Economic events:
  - PCE data Friday May 29
  - Consumer confidence (released Tue)
  - Heavy earnings week (CRM, MRVL, DELL, COST, SNPS)

### Pre-market Movers
- Verra Mobility (VRRM) plunged -49.5% on 624k shares after Avis Budget Group terminated its partnership effective September 2026.
- Zscaler (ZS) is gapping down -22.9% on 277k shares after slashing its free cash flow margin guidance due to higher AI-related capital expenditures.
- Soligenix (SNGX) skyrocketed 107.6% on 52M shares after claiming its ThermoVax platform can rapidly develop a vaccine for the Bundibugyo Ebola virus. This move comes with a massive 193x volume ratio.
- Pre-market indexes: S&P 500 +0.31%, Nasdaq 100 +0.69%, Dow +0.33%, Russell 2000 +0.74%.

### Trade Candidates (Regime ON)

**1. AMD (Advanced Micro Devices) — $467-470 range**
- **Catalyst**: The catalyst is the launch of MI450 products and Helios rack-scale solutions. AMD recently tagged a fresh 52-week and historical high at $481.41. Next earnings date Aug 4, 2026 — safe window. Semis are in full momentum with SMH at new 52-week highs.
- Entry: ~$470, Stop: $437 (-7%), Target: $536 (+14%), shares=1, cost=$470
- R:R = 1:2
- **ISSUE**: At ~$470/share, 1 share = $470 (within $600 limit) ✅

**2. OKLO (Oklo Inc.) — $66-72 range**
- **Catalyst**: Oklo's shares surged over 10% after being selected for advanced negotiations under the U.S. Department of Energy's Surplus Plutonium Utilization Program. The program provides Oklo with a potential pathway to access surplus plutonium fuel. Short interest stands at 28.6 million shares representing 19.6% of the float — high short squeeze potential.
- **RISK**: Oklo faces execution risks, including regulatory approval delays and commercialization challenges. Pre-revenue, speculative, high volatility, ~60% off ATH. **DISQUALIFIED** — too speculative/volatile for swing trading rules, and damaged longer-term trend.

**3. ON (ON Semiconductor) — ~$60-65 range**
- **Catalyst**: On Semiconductor added nearly 9% on Tuesday. Riding semiconductor momentum wave, benefiting from EV/industrial recovery + AI power management demand. Earnings already reported (April). Next earnings ~Aug. Market cap ~$27B ✅
- Entry: ~$64, Stop: $59.50 (-7%), Target: $73 (+14%), shares=9, cost=$576
- R:R = 1:2

### Risk Factors Today
- **PCE Friday**: Hot inflation print could reverse market gains and tighten rate cut expectations
- **US-Iran deal uncertainty**: Investors remained cautiously hopeful that the US and Iran could still secure an agreement despite renewed tensions. Deal collapse = oil spike, risk-off
- **Extended valuations**: S&P 500 and Nasdaq at all-time highs; RSI overbought on multiple timeframes
- **Zscaler contagion risk**: Traders are monitoring if the weakness in high-multiple software names like ZS spreads to broader tech indices.
- **Heavy earnings this week**: CRM, MRVL, DELL, COST — misses could create sector volatility

### Decision
**TRADE** [AMD, ON] — Technology sector is the clear leader, semiconductor momentum is surging with SMH at new highs. Both candidates have specific catalysts, no near-term earnings, and fit within sizing rules. Prefer AMD for quality/momentum and ON for broader semi exposure at lower price point allowing better position sizing.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-27",
  "regime": "ON",
  "decision": "TRADE",
  "candidates": [
    {
      "symbol": "AMD",
      "entry_price": 470.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 1,
      "position_cost": 470.00,
      "target_price": 535.80,
      "catalyst": "MI450 AI GPU launch upcoming in H2 2026, semiconductor sector at new 52-week highs, SMH +3% on Tuesday, AMD at all-time high $481 with strong breakout momentum",
      "sector": "Technology",
      "rr_ratio": "1:2"
    },
    {
      "symbol": "ON",
      "entry_price": 64.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 9,
      "position_cost": 576.00,
      "target_price": 72.96,
      "catalyst": "Semiconductor sector breakout — ON surged 9% on Tuesday with SMH at 52-week high, EV/industrial power management demand recovery, AI power infrastructure tailwind",
      "sector": "Technology",
      "rr_ratio": "1:2"
    }
  ]
}
```

I'll gather the required market data systematically.Now let me search for sector ETF performance and Snowflake/software rally details.Let me get the Best Buy details and check for candidates with specific price levels.Now I have all the data I need. Let me compile the research log.

## 2026-05-28 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100047.09
- Operating cap: $3,000
- Cash: $99192.75
- Positions value: $854.34
- Capital available: $2145.66
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $752.35 (MA200: ~$722) — ABOVE
- VIX: 16.29 — LOW
- Regime: **ON**
- Reason: The SPY 200-day moving average is 722.35, and SPY is trading at $752.35, well above MA200. VIX previous close was 16.29, well below the 25 threshold. Both conditions met.

### Market Context
- Top catalysts today:
  - **PCE inflation data**: The personal consumption expenditures (PCE) price index rose 3.8% year over year last month, economists had been looking for readings of 0.5% and 3.8% — in line with expectations
  - **Snowflake AI surge**: Software stocks popped after Snowflake said it plans to spend $6 billion on compute from Amazon; shares surged 35% headed for its best day ever
  - **Dell $9.7B Pentagon contract**: Shares of Dell Technologies were climbing nearly 4% after the Defense Department awarded the company a $9.7 billion contract
  - **Best Buy earnings beat**: Best Buy stock jumps 10% after Q1 EPS of $1.28 beats estimates; revenue hits $8.94B and comparable sales rise 2% year-over-year
  - **US-Iran tensions**: Stocks were falling and oil prices rising as investors monitored U.S.-Iran tensions; Iran's Islamic Revolutionary Guard Corps launched an attack targeting a U.S. air base
- Sector leaders:
  - XLK (Technology): +28.75% YTD — strongest, XLK had a total return of 63.55% in the past year; AI/software rally fueling momentum
  - XLY (Consumer Discretionary): +1.64% today, BBY earnings boost
  - XLP (Consumer Staples): +1.42% today, defensive bid
  - XLF (Financial): -0.84% today, Iran risk weighing
  - XLE (Energy): volatile on Iran oil dynamics
- Economic events:
  - Thursday (May 28): Continuing Claims, Durable Goods, Q2 GDP – Second Estimate, Initial Claims, PCE Prices, Personal Income, Personal Spending
  - Expected earnings from Dell (DELL), Dollar Tree (DLTR), MongoDB (MDB), Best Buy (BBY), Costco (COST), AutoDesk (ADSK), and Gap (GAP)

### Trade Candidates (Regime ON)

**Assessment of candidates:**

1. **BBY (Best Buy)** — Q1 earnings beat ($1.28 vs $1.22 est), comparable sales +2% vs +1% guide, gaming/computing strength. Entry ~$68 (post-gap), stop $63.24 (-7%), target $77.52 (+14%), shares=8, cost=$544. **HOWEVER: Earnings just reported TODAY — this is event risk/chasing a gap. SKIP per strategy rules (avoid earnings announcements).**

2. **DELL (Dell Technologies)** — $9.7B Pentagon contract, +4% pre-market, trading ~$318. **PROBLEM: Reports earnings AFTER CLOSE TODAY. Per rules, must avoid earnings within 7 days. Also, price ~$318 means max 1 share = $318, but earnings tonight = unacceptable event risk. SKIP.**

3. **SNOW (Snowflake)** — Massive 35% gap on earnings beat + $6B AWS deal. **PROBLEM: Just reported earnings, massive gap-up = chasing. Also ~$240/share post-gap, high volatility. SKIP.**

All strong-catalyst stocks today are either reporting earnings today or just reported — **all fail the "no earnings within 7 days" filter**.

**Alternative scan — stocks with tech/AI tailwind, no upcoming earnings:**
- AAPL: Already in portfolio. Cannot add (no averaging into winners beyond position limit).
- NOW: Already in portfolio.
- No clean candidates pass ALL filters simultaneously today (catalyst + no earnings + sector momentum + sizing).

### Risk Factors Today
- **US-Iran escalation**: Iran's IRGC launched an attack targeting a U.S. air base; U.S. strikes targeted Iranian drones and a launch site near the Strait of Hormuz
- **PCE inflation sticky at 3.8%**: Higher than prior months, limits Fed flexibility
- **Heavy earnings calendar today**: Many stocks in flux, unpredictable gaps
- **Oil price volatility**: Brent crude above $93, inflation risk
- **Market breadth narrowing**: the character of the market remains where levels of resistance hold less weight than levels of support, there are certainly fractures around the periphery as breadth narrows

### Decision
**HOLD** — Regime is ON, but all high-catalyst candidates today are contaminated by same-day or imminent earnings reports, violating our "no earnings within 7 days" rule. Existing positions (AAPL +4.2%, NOW +6.8%) are performing well. Current deployment is 28.5% vs target 75-85% — we have capacity but no clean setups today. Will reassess tomorrow after the DELL/COST/MDB earnings dust settles for potential post-earnings continuation plays.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-28",
  "regime": "ON",
  "decision": "HOLD",
  "candidates": []
}
```

I'll gather the required market data systematically.Now let me get sector ETF performance and pre-market movers data.Let me get more specific data on NetApp and SoFi which are surging pre-market, plus confirm NOW's current status.Now I have all the data I need. Let me compile the research log.

**Key data points gathered:**
- SPY current: $757.86 (from Finnhub). SPY 200-day MA: ~$722 (Investing.com shows $722.35, TipRanks from May 16 shows $672.78 — the Investing.com figure is more recent). Actually, the most recent sources vary: Investing.com says $722.35 (MA200), TipRanks May 16 says $672.78, Financhill says $675.59. The Investing.com figure appears to be the MA20, not MA200. Let me use the TipRanks and Financhill data which are consistent (~$672-675 for the 200-day SMA).
- VIX: ~15.74-16.33 range. CNBC shows prev close 16.29, Yahoo shows 15.74 at close, Yahoo Finance calendar shows VIX at 15.85 pre-market.
- SPY > MA200 ✓, VIX < 25 ✓ → REGIME = ON
- Key catalysts: U.S.-Iran tentative deal, PCE data, record S&P/Nasdaq, NetApp earnings beat, SoFi stablecoin launch
- Sector data from Yahoo: XLV +1.40%, XLY +0.42%, XLK (tech strong with 28.26% trailing return), XLF -0.29%, XLP -0.18%
- Pre-market movers: NTAP +18.3%, SOFI +7.7%
- NOW position: +17.3% unrealized, nearing profit target 1

Now for candidates:
- NTAP: Just reported earnings (already happened) — stock surging 18% pre-market. This is a post-earnings breakout, not pre-earnings risk. ~$130 pre-market (was ~$110 before). At ~$130, shares=4 would be $520. Good candidate.
- SOFI: At ~$18.72 today. SoFiUSD stablecoin catalyst + earnings momentum. At ~$18, shares=33 would be $594. But SOFI is volatile, down 45% YTD, P/E at 38.6. Higher risk.

Let me check if these fit within capital constraints: current positions value $909.77, available within cap $2,090.23. Max per position $600.

## 2026-05-29 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100102.52
- Operating cap: $3,000
- Cash: $99192.75
- Positions value: $909.77
- Capital available: $2090.23
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $757.86 (MA200: ~$675) — ABOVE
- VIX: 15.85 — LOW
- Regime: ON
- Reason: SPY 200-day moving average is around $722 (various sources range $672-$722; SPY at $757.86 is well above all estimates). VIX at 15.74, down 3.38%, well below 25 threshold. Bullish regime confirmed.

### Market Context
- Top catalysts today:
  - Stock futures inched higher on reports that the U.S. and Iran had reached a tentative agreement to reopen the Strait of Hormuz and begin nuclear talks.
  - The critical PCE price index for April was slightly below expectations at 0.4% for headline and 0.2% for core — digesting yesterday's data
  - Nasdaq, S&P 500 set new records despite elevated PCE; market at all-time highs
  - NetApp stock surged +18.3% in pre-open trading after the company delivered record-breaking Q4 fiscal 2026 results
  - SoFi Technologies is launching SoFiUSD, a stablecoin issued directly by its U.S. national bank unit, driving +7.7% pre-market move
- Sector leaders:
  - XLV (Healthcare): +1.40%
  - XLK (Technology): leading YTD with 28.26% trailing return, QQQ +0.72% today
  - XLY (Consumer Discretionary): +0.42%
  - XLF (Financials): -0.29%
  - XLP (Consumer Staples): -0.18%
- Economic events:
  - Friday (May 29): Advanced International Trade in Goods, Advanced Retail Inventories, Advanced Wholesale Inventories, Chicago Purchasing Managers' Index (PMI)
  - May 29: No major data or earnings expected (per Schwab)

### Trade Candidates (Regime ON)
1. **NTAP** — Q4 FY2026 earnings beat ($2.43 EPS vs $2.27 est, $1.95B rev vs $1.87B est), entry ~$130, stop $120.90 (-7%), target $148.20 (+14%), shares=4, cost=$520, R:R 1:2
   - NTAP reported Q4 earnings surpassing analyst expectations with an EPS of $2.43 against a forecast of $2.27. Revenue reached $1.95 billion, exceeding projections of $1.87 billion.
   - NetApp delivered record quarterly and annual financial results underpinned by substantial growth in cloud, all flash, and Keystone segments, propelled mainly by broad-based enterprise AI adoption.
   - FY27 Revenue Guidance: $7.325 billion to $7.575 billion, implying 8% growth at midpoint.
   - Sector: Technology (XLK leading); market cap ~$25B; earnings already reported (no upcoming event risk)

2. **SOFI** — SoFiUSD stablecoin launch (first U.S. national bank stablecoin) + Q1 earnings beat, entry ~$18.50, stop $17.21 (-7%), target $21.09 (+14%), shares=32, cost=$592, R:R 1:2
   - In Q1 2026, SoFi Technologies reported total revenue of $1.100368B, edging past the $1.05B consensus
   - SoFi Technologies is making headlines with its recent launch of the SoFiUSD stablecoin, marking it as the first U.S. national bank to issue a bank-backed digital currency.
   - At the current price, SoFi stock trades at 35 times trailing 12-month earnings — fairly cheap for growth
   - ⚠️ CONCERN: SoFi Stock Is Down 45% This Year — catching a falling knife risk. SoFi's current P/E ratio stands at 38.6, which is significantly higher than the 5-year median P/E of 28.69. Mixed analyst sentiment. **SKIP — volatility too high, downtrend intact.**

### Risk Factors Today
- VP Vance said U.S. and Iran are "not there yet" on an agreement. Iranian state media dismissed reports of an agreement as "incorrect." Deal could collapse → oil spike, risk-off
- Core PCE rose 3.3%, up from 3.2% in March, while headline PCE rose 3.8% — inflation still elevated
- There's still a lot of froth in the market and many stocks have come a long way very quickly
- The selloff in long-term government bonds is a reminder that traditional portfolio hedges are proving less reliable today
- Friday before potential weekend geopolitical escalation (Iran situation fluid)
- NTAP gapping up 18% — risk of buying into gap exhaustion

### Decision
TRADE [NTAP] — Strong earnings beat with record results and AI-driven growth. Post-earnings gap-up with fundamental support. Wait for first 15-min candle to confirm entry doesn't fade. If gap holds above $128, enter with 4 shares. Conservative sizing due to gap-up risk.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-05-29",
  "regime": "ON",
  "decision": "TRADE",
  "candidates": [
    {
      "symbol": "NTAP",
      "entry_price": 130.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 4,
      "position_cost": 520.00,
      "target_price": 148.20,
      "catalyst": "Q4 FY2026 earnings beat: EPS $2.43 vs $2.27 est, revenue $1.95B vs $1.87B est. Record annual results. FY27 guidance implies 8% revenue growth. AI-driven enterprise demand acceleration.",
      "sector": "Technology",
      "rr_ratio": "1:2"
    }
  ]
}
```

Now I have enough data to compile the research log. Let me synthesize all findings:

**Key Data Points:**
- SPY current: $757.11 (from Finnhub). SPY 200-day MA: ~$722 (Investing.com says $722.35, sources vary between $672-$722 depending on age; most current from Investing.com is $722.35)
- VIX: 15.32 at close May 29, currently ~16.17 intraday (Yahoo Finance shows VIX at 16.17 today)
- SPY > MA200 ✓ AND VIX < 25 ✓ → REGIME = ON
- Top catalysts: Nvidia RTX Spark Superchip at Computex, Dell blowout earnings, Berkshire/TMHC deal, US-Iran tensions/oil surge, Jobs report Friday
- Sector: XLK (Tech) +1.67% today leading, XLE (Energy) +2.5% today, XLF +0.60%
- Pre-market movers: NVDA +4.7%, MSFT +2.4%, DELL +7.2%, HPE +5.67%, ARM +17%, TMHC +22.3%, HUM +7.7%

**Candidate analysis:**
- DELL at ~$430 — too expensive for $600 cap (can only buy 1 share = $430)
- NVDA at ~$221 — can buy 2 shares = $442, has catalyst (RTX Spark)
- MSFT at ~$461 — can buy 1 share = $461, has catalyst (Nvidia partnership)
- HUM at ~$329 — can buy 1 share = $329, catalyst (guidance reaffirmation + Deutsche Bank upgrade), next earnings Jul 29
- HPE — earnings today (CRDO, HPE report today per Schwab), must avoid

Let me check positions: AAPL $306.08 already held. Available capital = $2,693.92.

## 2026-06-01 — Pre-market Research

### Account Snapshot
- Alpaca equity: $100159.74
- Operating cap: $3,000
- Cash: $99853.65
- Positions value: $306.08
- Capital available: $2693.92
- Daytrade count: 0/3
- Bot state: ACTIVE

### Market Regime
- SPY: $757.11 (MA200: ~$722.35) — ABOVE
- VIX: 16.17 — LOW
- Regime: ON
- Reason: SPY 200-day moving average is $722.35, SPY trading at $757.11 well above MA200; VIX at 15.32 at close, currently ~16.17 — both conditions met.

### Market Context
- Top catalysts today:
  - Shares of Microsoft (MSFT) and Dell (DELL) and HP (HPE) rose after Nvidia (NVDA) announced a major push into the personal computer market. Jensen Huang revealed that the RTX Spark Superchip will launch this fall in select laptops and desktops.
  - Taylor Morrison Home (TMHC) surged 22.3% on news that Berkshire Hathaway (BRK-B) will acquire the homebuilder in an all-cash deal worth about $6.8 billion.
  - Oil prices pushed higher after Iran suspended talks with the US, adding uncertainty around the ceasefire deal. WTI crude rose 8% to $94 a barrel.
  - Humana stock surged +7.7% after reaffirming its FY2026 earnings outlook, with Deutsche Bank upgrading to Buy and nearly doubling its price target to $441.
  - A big focus this week will be Friday's release of monthly employment figures (Nonfarm Payrolls).
- Sector leaders:
  - Energy sector +2.5% today on gas price increase; tech +1.67%.
  - XLF +0.60% (financials positive)
  - XLV -0.93%, XLY -0.97%, XLP -1.80% (defensive sectors lagging)
- Economic events:
  - Monday (June 1): Construction Spending, ISM Manufacturing Index. Wednesday: ADP Employment, ISM Non-Manufacturing. Friday: Nonfarm Payrolls, Unemployment Rate.

### Trade Candidates (Regime ON)

1. **MSFT** — Nvidia RTX Spark partnership catalyst driving +2.4% today; MSFT is up 2.4% at $461.07, back above the $450 mark for the first time since suffering a late-January post-earnings bear gap. 42 of 48 analysts have "buy" or better ratings. Entry ~$461, stop $428.73 (-7%), target $525.54 (+14%), shares=1, cost=$461. R:R 1:2. Next earnings ~late July. No earnings within 7 days ✓.

2. **HUM** — Humana surged +7.7% after reaffirming FY2026 outlook; management scheduled to meet investors June 1-30 reaffirming at least $9.00 adjusted EPS. Deutsche Bank upgraded to Buy with price target nearly doubled to $441 from $235. Entry ~$329, stop $305.97 (-7%), target $375.06 (+14%), shares=1, cost=$329. R:R 1:2. Next earnings report on Jul 29, 2026. No earnings within 7 days ✓. Healthcare sector weak today but company-specific catalyst very strong.

### Risk Factors Today
- Iran suspended talks with the US, adding uncertainty and spiking oil prices — could trigger broader risk-off if escalation continues
- 10-year T-note yield climbed to a 16-month high of 4.69% — rising yields pressure equity valuations
- Friday's jobs report could bolster expectations of removing the easing bias at June's Fed meeting under Chairman Warsh
- Oil at $94/barrel feeding inflation expectations; market near all-time highs = potential sell-the-news risk
- Wall Street struggles to start June after a record-setting May — seasonal weakness in June historically
- HUM is RSI overbought after a 21.5% run in the past month — entry risk on a pullback

### Decision
TRADE [MSFT, HUM] — Both have specific, named catalysts with favorable R:R. MSFT benefits from Nvidia RTX Spark partnership (tech sector leading). HUM has double catalyst of guidance reaffirmation + major analyst upgrade. Combined new position cost = ~$790, total deployed with AAPL ($306) = ~$1,096, well within $3,000 cap. Monitor oil/Iran situation for broader risk-off before executing.

### CANDIDATES (machine-readable)
```json
{
  "date": "2026-06-01",
  "regime": "ON",
  "decision": "TRADE",
  "candidates": [
    {
      "symbol": "MSFT",
      "entry_price": 461.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 1,
      "position_cost": 461.00,
      "target_price": 525.54,
      "catalyst": "Nvidia RTX Spark Superchip partnership announced at Computex Taipei — MSFT Windows on Arm architecture; stock breaking above $450 resistance for first time since January; 42/48 analysts rate Buy or better",
      "sector": "Technology",
      "rr_ratio": "1:2"
    },
    {
      "symbol": "HUM",
      "entry_price": 329.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 1,
      "position_cost": 329.00,
      "target_price": 375.06,
      "catalyst": "FY2026 guidance reaffirmation ($9.00+ adjusted EPS); Deutsche Bank upgrade to Buy with PT nearly doubled to $441 from $235; Q1 2026 earnings beat with 23.5% revenue growth; next earnings Jul 29",
      "sector": "Healthcare",
      "rr_ratio": "1:2"
    }
  ]
}
```
