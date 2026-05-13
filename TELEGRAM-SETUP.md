# 📱 TELEGRAM BOT SETUP GUIDE

Complete integration of Telegram Bot notifications for your trading bot.

---

## ✅ STEP 1: You Already Have the Bot Token

You've obtained your Telegram Bot Token from @BotFather. It looks like:
```
1234567890:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgh
```

---

## ✅ STEP 2: Get Your Chat ID

You have **two options**:

### Option A: Using the Bot (Easy)
1. Open Telegram
2. Find your bot (the one you created with @BotFather)
3. Click **START** or send any message to the bot
4. Go to this URL in your browser:
   ```
   https://api.telegram.org/bot{YOUR_BOT_TOKEN}/getUpdates
   ```
   Replace `{YOUR_BOT_TOKEN}` with your actual token.

5. Look for the response. You'll see JSON with:
   ```json
   {
     "ok": true,
     "result": [
       {
         "update_id": 123456789,
         "message": {
           "message_id": 1,
           "from": {
             "id": 1234567890,  ← THIS IS YOUR CHAT_ID
             "is_bot": false,
             "first_name": "Your Name"
           },
           "chat": {
             "id": 1234567890,  ← OR THIS (same number)
             "first_name": "Your Name",
             "type": "private"
           },
           "date": 1715000000,
           "text": "Hi"
         }
       }
     ]
   }
   ```

   Copy the number in `"id"` (usually same as `chat.id`)

### Option B: Using a Service
1. Message @userinfobot in Telegram
2. It will reply with your user ID (Chat ID)

---

## ✅ STEP 3: Update Your .env File

Open your `.env` file in VS Code and add:

```bash
# TELEGRAM BOT (Mobile Notifications)
TELEGRAM_BOT_TOKEN=your_token_here
TELEGRAM_CHAT_ID=your_chat_id_here
```

**Example:**
```bash
TELEGRAM_BOT_TOKEN=1234567890:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgh
TELEGRAM_CHAT_ID=1234567890
```

**Save the file (Cmd + S)**

---

## ✅ STEP 4: Make Script Executable

In Terminal, navigate to your project and run:

```bash
cd ~/Projects/trading-bot
chmod +x scripts/telegram.sh
```

---

## ✅ STEP 5: Test the Integration

Run the test command:

```bash
./scripts/telegram.sh test
```

You should **immediately see a message in Telegram** from your bot saying:
```
🤖 Bot Test
Your Telegram integration is working!
Chat ID: [your_chat_id]
```

If you don't see it:
1. Check that `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID` are correct in `.env`
2. Make sure you messaged the bot first (so it has a chat history)
3. Verify the token is copied completely (no extra spaces)

---

## 📝 Usage Examples

Now you can send messages from your bot:

### Send a Simple Message
```bash
./scripts/telegram.sh send "Good morning! Market analysis ready."
```

### Send a Trade Notification
```bash
./scripts/telegram.sh trade BUY AAPL 100 150.25 "breakout above 20-day MA"
```

Output in Telegram:
```
📊 TRADE EXECUTION
Action: BUY
Symbol: AAPL
Quantity: 100
Price: $150.25
Reason: breakout above 20-day MA
Time: 2026-05-11 09:30:45
```

### Send an Alert
```bash
./scripts/telegram.sh alert WARNING "Capital running low - 15% remaining"
```

### Send a Position Update
```bash
./scripts/telegram.sh position AAPL 100 150.00 152.50 250 1.67
```

### Send Daily Summary
```bash
./scripts/telegram.sh summary 700 2 100 "AAPL +500" "GOOGL -100"
```

---

## 🔄 Integration with Trading Scripts

In your automated routines, you can now add Telegram notifications:

```bash
#!/bin/bash
source .env

# Get account info
ACCOUNT=$(./scripts/alpaca.sh account)

# Send to Telegram
./scripts/telegram.sh send "Account Status:
$ACCOUNT"
```

---

## 🎯 Integration Checklist

- [ ] Got Bot Token from @BotFather
- [ ] Messaged bot to generate Chat ID
- [ ] Found Chat ID via getUpdates or @userinfobot
- [ ] Updated `.env` with both values
- [ ] Made `telegram.sh` executable
- [ ] Ran `./scripts/telegram.sh test` successfully
- [ ] Received test message in Telegram
- [ ] Ready to integrate into routines

---

## ⚠️ Troubleshooting

### "getUpdates returns empty result"
- You must message the bot first
- The chat must exist before you can send messages
- Try messaging the bot again, then check getUpdates

### "Message not sent" but no error
- Check your `TELEGRAM_BOT_TOKEN` is exactly correct
- Ensure `TELEGRAM_CHAT_ID` is a number with no quotes
- Try the test command: `./scripts/telegram.sh test`

### "Unauthorized" error
- Your Bot Token is incorrect or expired
- Go back to @BotFather and check the token
- Consider generating a new token if it's been compromised

### "Chat not found"
- Your Chat ID is incorrect
- Verify using the getUpdates method above
- The Chat ID should be a long number (10+ digits)

---

## 🚀 Next: Automate with Scheduled Routines

Once Telegram is working, you can set up 5 daily routines:

1. **7:00 AM** - Pre-market research
2. **9:30 AM** - Market open signals
3. **12:00 PM** - Midday position review
4. **4:00 PM** - Daily close summary
5. **Friday 4:00 PM** - Weekly review

Each routine can send a Telegram notification with:
- Trade candidates and analysis
- Trade executions
- Position updates
- Daily P&L summary
- Weekly performance review

---

**Your notification system is now live! 🎯**
