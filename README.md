# Trading Bot - Automated AI Trading System

**Status:** Initial Setup
**Last Updated:** 2026-05-11

---

## 📋 Overview

Automated trading bot powered by Claude AI, integrated with:
- **Alpaca** for trade execution (stocks, ETFs)
- **NewsAPI** for real-time financial news and market research (FREE)
- **ClickUp** for notifications and trade logging

This bot executes trades based on pre-defined rules, daily market analysis, and AI-driven decision-making.

---

## 📁 Project Structure

```
trading-bot/
├── scripts/
│   ├── alpaca.sh          # Trade execution wrapper
│   ├── perplexity.sh      # Market research queries
│   └── clickup.sh         # Notifications & logging
├── memory/
│   ├── TRADING-STRATEGY.md    # Rules, position sizing, stops
│   ├── TRADE-LOG.md           # Daily trade records
│   ├── RESEARCH-LOG.md        # Pre-market analysis
│   ├── WEEKLY-REVIEW.md       # Performance & adjustments
│   └── README.md              # Memory system docs
├── logs/
│   └── [auto-generated logs]
├── .env                   # API keys (LOCAL, NEVER COMMIT)
├── .env.template          # Template for .env setup
├── .gitignore             # Protect .env from git
└── README.md              # This file
```

---

## 🚀 Quick Start

### 1. Setup Environment Variables

```bash
# Copy template
cp .env.template .env

# Edit with your API keys
nano .env
```

Fill in:
- `ALPACA_API_KEY` & `ALPACA_API_SECRET`
- `NEWSAPI_API_KEY`
- `CLICKUP_API_TOKEN`, `CLICKUP_WORKSPACE_ID`, `CLICKUP_CHAT_ID`

### 2. Make Scripts Executable

```bash
chmod +x scripts/alpaca.sh
chmod +x scripts/perplexity.sh
chmod +x scripts/clickup.sh
```

### 3. Test Each Integration

```bash
# Test Alpaca (get account info)
./scripts/alpaca.sh account

# Test NewsAPI (market research)
./scripts/news.sh market

# Test ClickUp (send message)
./scripts/clickup.sh send "Bot initialized successfully"
```

---

## 📊 Daily Trading Workflow

The bot runs 5 daily routines:

### 1. **Pre-Market (7:00 AM)**
- NewsAPI research: Financial news, market conditions, earnings
- Claude analysis: Identify 3-5 trade candidates
- ClickUp alert: Send daily trade plan
- Update: RESEARCH-LOG.md

### 2. **Market Open (9:30 AM)**
- Monitor positions
- Check for entry signals
- Execute trades if criteria met
- Log to TRADE-LOG.md & ClickUp

### 3. **Midday (12:00 PM)**
- Review open positions
- Adjust trailing stops if needed
- Monitor risk levels
- Send status update

### 4. **Daily Close (4:00 PM)**
- Finalize all trades
- Log P&L
- Update TRADE-LOG.md
- Send EOD summary to ClickUp

### 5. **Weekly Review (Friday 4:00 PM)**
- Calculate weekly performance
- Check rule compliance
- Document lessons learned
- Plan next week

---

## 📋 Trading Rules (ENFORCE STRICTLY)

### Position Management
- **Max positions:** 5-6 concurrent
- **Max per position:** 20% of portfolio
- **Max trades/week:** 3

### Risk Management
- **Trailing stop:** 10% on all positions (tighten at +15%/+20%)
- **Hard stop loss:** -7% (AUTO-SELL if hit)
- **Risk/Reward:** Minimum 1:2

### Entry Criteria
- Momentum breakout on high volume
- Technical: Break above 20-day MA
- Catalyst: News, earnings, etc.
- R:R: Must have 1:2 or better

---

## 🔐 Security

### NEVER:
- ❌ Commit `.env` file
- ❌ Share API keys in messages
- ❌ Hardcode secrets in scripts
- ❌ Upload `.env` to GitHub/cloud

### DO:
- ✅ Use `.env` for secrets
- ✅ Add `.env` to `.gitignore`
- ✅ Rotate API keys periodically
- ✅ Monitor account for suspicious activity

---

## 📈 Usage Examples

### Buy a Stock
```bash
./scripts/alpaca.sh buy AAPL 100 market
```

### Sell at Limit Price
```bash
./scripts/alpaca.sh sell AAPL 100 limit 155.00
```

### Set Trailing Stop
```bash
./scripts/alpaca.sh trailing-stop AAPL 0.10
```

### Market Research
```bash
./scripts/news.sh stock AAPL
./scripts/news.sh sector Technology
./scripts/news.sh market
./scripts/news.sh earnings
```

### Send Notification
```bash
./scripts/clickup.sh trade BUY AAPL 100 150.25
./scripts/clickup.sh alert WARNING "Capital running low"
./scripts/clickup.sh summary "+500" "2" "66%"
```

---

## 📊 Memory System

The bot learns and improves through 4 memory files:

| File | Purpose | Update | Owner |
|------|---------|--------|-------|
| TRADING-STRATEGY.md | Rules & parameters | Monthly/Quarterly | You |
| TRADE-LOG.md | Daily trade records | Daily (auto) | Bot |
| RESEARCH-LOG.md | Pre-market analysis | Daily (7am) | Bot |
| WEEKLY-REVIEW.md | Performance analysis | Weekly (Fri) | You |

---

## 🛠️ Troubleshooting

### Alpaca Connection Failed
```bash
# Check API keys
echo $ALPACA_API_KEY
echo $ALPACA_API_SECRET

# Verify base URL for paper trading
# Should be: https://paper-api.alpaca.markets
```

### Perplexity Queries Too Expensive
- Limit queries to key routines (pre-market, daily close)
- Use `market` or `stock` commands (pre-built, optimized)
- Avoid excessive queries during market hours

### ClickUp Messages Not Arriving
- Check workspace ID and chat ID
- Test with: `./scripts/clickup.sh send "Test"`
- Fallback: Messages logged to `logs/clickup-fallback.log`

---

## 💡 Next Steps

1. **Setup:** Fill in `.env` with API keys ✓
2. **Test:** Run each script individually
3. **Paper Trade:** Trade with virtual money first
4. **Monitor:** Check daily logs and ClickUp messages
5. **Optimize:** Adjust rules based on weekly reviews
6. **Live Trade:** Move to real money (optional, risky)

---

## 📚 Documentation

- **TRADING-STRATEGY.md** - Complete rule book
- **TRADE-LOG.md** - How to log trades
- **RESEARCH-LOG.md** - Daily research format
- **WEEKLY-REVIEW.md** - Performance tracking

---

## ⚠️ Disclaimer

- **Paper trading only (initially).** Real trading carries risk.
- **Past performance ≠ future results.** Markets are unpredictable.
- **You are responsible** for compliance with your local regulations.
- **Use at your own risk.** Test thoroughly before deploying.

---

## 📧 Support

Issues? Check:
1. `.env` file is filled correctly
2. API keys are valid and active
3. Scripts have execute permissions (`chmod +x`)
4. Network connection is stable
5. Cloud routines are configured (if using)

---

**Happy Trading! 🚀**
