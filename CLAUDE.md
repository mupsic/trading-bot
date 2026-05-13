# CLAUDE.md - Bot Configuration & Routine Prompts

**Purpose:** Central documentation for Claude AI routines and decision-making

---

## 🤖 AI INTEGRATION POINTS

The bot uses Claude in these 5 daily routines:

### 1. PRE-MARKET ANALYSIS (7:00 AM)
**Purpose:** Research, identify trade candidates, set daily bias

**Process:**
1. Finnhub: Get real-time market data (quotes, news, earnings)
2. Claude WebSearch: Get catalysts, economic data, market context
3. Claude: Analyze data, identify 3-5 candidates
4. Telegram: Send trade plan for the day
5. Update: RESEARCH-LOG.md

**Claude Prompt Template:**
```
Based on today's economic calendar, news, and futures:
1. What's the market bias? (Bullish/Bearish/Neutral)
2. What sectors are strong? (List top 3)
3. Identify 5 trade candidates with reasoning
4. What risks should I watch for?
5. Recommended action plan for trading hours

Include: R:R ratios, entry points, stop losses
```

---

### 2. MARKET OPEN SIGNAL (9:30 AM)
**Purpose:** Execute trades based on morning plan

**Process:**
1. Monitor price action at open
2. Claude: Confirm entry signals
3. Alpaca: Execute trades
4. ClickUp: Log execution
5. Update: TRADE-LOG.md

**Claude Prompt Template:**
```
Candidates from this morning: [LIST]

Price at open: [AAPL: $150, GOOGL: $125, MSFT: $380]

Confirm which candidates meet TODAY's entry criteria:
- Volume confirmation?
- Technical support?
- Catalyst still valid?
- Risk/Reward acceptable?

For each: GO or SKIP?
```

---

### 3. MIDDAY REVIEW (12:00 PM)
**Purpose:** Monitor positions, adjust if needed

**Process:**
1. Finnhub: Get real-time quotes and breaking news
2. Claude WebSearch: Check market conditions and catalysts
3. Claude: Assess positions
4. Alpaca: Adjust stops/sizes if needed
5. Telegram: Send status update
6. Update: TRADE-LOG.md

**Claude Prompt Template:**
```
Current open positions:
[AAPL: 100 @ $150 - up $200]
[MSFT: 50 @ $380 - up $50]

Market update: [Real-time data from Finnhub + WebSearch]

For each position:
1. Should I add to it? (Yes/No + reasoning)
2. Should I tighten stop? (Current: 10%)
3. Profit target still valid?
4. Any new risks?

Action: BUY MORE / TIGHTEN STOPS / HOLD / SELL
```

---

### 4. DAILY CLOSE (4:00 PM)
**Purpose:** Finalize trades, calculate P&L

**Process:**
1. Alpaca: Get end-of-day positions
2. Claude: Analyze day's performance
3. ClickUp: Send daily summary
4. Update: TRADE-LOG.md

**Claude Prompt Template:**
```
Today's trades:
[BUY AAPL 100 @ $150, now $152 = +$200]
[SELL GOOGL 50 @ $125, closed = +$500]

Daily P&L: +$700
Trades: 2 executed
Win Rate: 100% (so far)

1. Did I follow all rules? (Y/N)
2. What went well?
3. What could improve?
4. Any rule violations?
5. Notes for tomorrow?
```

---

### 5. WEEKLY REVIEW (Friday 4:00 PM)
**Purpose:** Assess week, identify patterns, adjust rules

**Process:**
1. Compile weekly statistics
2. Claude: Analyze patterns
3. Adjust rules if needed
4. ClickUp: Send weekly report
5. Update: WEEKLY-REVIEW.md

**Claude Prompt Template:**
```
Weekly Performance Summary:
- P&L: +$2,500 (5% return)
- Trades: 8 executed
- Win Rate: 75% (6 wins, 2 losses)
- Best: AAPL +$800
- Worst: GOOGL -$300

Analysis:
1. What strategy worked best?
2. What failed?
3. Pattern detected?
4. Should I adjust rules?
5. Confidence for next week?

Rule Changes Needed? (Y/N) → Detail below
```

---

## 💾 MEMORY STATE

Claude reads and updates these files for context:

```
On each routine run:

1. READ:
   - TRADING-STRATEGY.md (rules, limits)
   - TRADE-LOG.md (today's trades)
   - RESEARCH-LOG.md (today's analysis)
   - WEEKLY-REVIEW.md (weekly patterns)

2. ANALYZE:
   - Current portfolio
   - Open positions
   - Market data (from Finnhub + WebSearch)

3. DECIDE:
   - Should I trade?
   - Which stocks?
   - Entry/exit points?
   - Risk assessment?

4. UPDATE:
   - Log decisions
   - Send ClickUp alert
   - Document reasoning
```

---

## 🎯 DECISION FRAMEWORK

Every Claude decision follows this logic:

```
1. CHECK RULES
   ✓ Max positions (5-6)?
   ✓ Max per position (20%)?
   ✓ Max trades/week (3)?
   → If any violated → SKIP trade

2. CHECK CRITERIA
   ✓ Momentum/breakout visible?
   ✓ Volume confirmation?
   ✓ Technical support?
   ✓ R:R ≥ 1:2?
   → If any missing → SKIP trade

3. CHECK RISK
   ✓ Hard stop at -7%?
   ✓ Trailing stop 10%?
   ✓ Portfolio heat ≤ 100%?
   → If any broken → SKIP trade

4. EXECUTE
   → If all checks pass → BUY/SELL
```

---

## 🔄 INTEGRATION CHECKLIST

To activate Claude-powered routines:

- [ ] Save API keys in `.env` (Alpaca, Finnhub, Telegram)
- [ ] Test scripts (alpaca.sh, finnhub.sh, telegram.sh)
- [ ] Verify memory files readable
- [ ] Setup Claude Code cloud routines with Claude WebSearch
- [ ] Test first routine manually
- [ ] Monitor for 1 week in paper trading
- [ ] Adjust rules based on results
- [ ] Deploy to live (optional)

---

## 📝 EXAMPLE: PRE-MARKET ROUTINE (7 AM)

```bash
#!/bin/bash
# automated-routine.sh

source .env

# 1. Get market data from Finnhub
OIL=$(./scripts/finnhub.sh news | grep -i oil | head -5)
EARNINGS=$(./scripts/finnhub.sh earnings | head -10)
GENERAL_NEWS=$(./scripts/finnhub.sh news | head -10)

# 2. Claude analyzes with WebSearch (native)
# Using Claude's native WebSearch to get catalysts and context

CLAUDE_INPUT="
Date: $(date '+%Y-%m-%d')
Market Data from Finnhub:
Oil/Commodities: $OIL
Economic Events: $EARNINGS
News: $GENERAL_NEWS

Use your WebSearch to find:
1. Today's economic calendar events
2. Major catalysts
3. Sector momentum

Trading Strategy Rules:
[contents of TRADING-STRATEGY.md]

Current P&L:
[contents of WEEKLY-REVIEW.md]

What are today's 5 best trade candidates?
"

# 3. Claude processes with WebSearch enabled
# (WebSearch is native to Claude, no API needed)

# 4. Log research
echo "## $(date '+%Y-%m-%d')" >> memory/RESEARCH-LOG.md
echo "Finnhub Data:" >> memory/RESEARCH-LOG.md
echo "$OIL" >> memory/RESEARCH-LOG.md
echo "$EARNINGS" >> memory/RESEARCH-LOG.md

# 5. Notify via Telegram
./scripts/telegram.sh "📊 Pre-market research ready"
```

---

## 🚀 NEXT STEPS

1. **Setup Claude Code:**
   - Install Claude Code (if not already)
   - Link to this project folder
   - Create 5 scheduled routines (one per function above)

2. **Test Each Routine:**
   - Run pre-market manually
   - Verify Perplexity research
   - Check ClickUp notification
   - Review memory files updated

3. **Optimize:**
   - Adjust routine times
   - Refine Claude prompts
   - Add error handling

4. **Monitor:**
   - First week: paper trading only
   - Track rule compliance
   - Document what works

---

## ⚠️ IMPORTANT

- Claude makes **recommendations**, not guarantees
- **You are responsible** for final decisions
- **Risk management is critical** - hard stops are non-negotiable
- **Test thoroughly** before live trading
- **Review rules weekly** - markets change

---

**This bot is YOUR tool. Use it wisely. 🎯**
