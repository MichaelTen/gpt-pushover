#!/bin/bash

# Your OpenAI API key
API_KEY="YOUR_OPENAI_API_KEY"

# Your Pushover user key
USER_KEY="YOUR_PUSHOVER_USER_KEY"

# Your Pushover API key
PUSHOVER_API_KEY="YOUR_PUSHOVER_API_KEY"

# Join all arguments into a single string
PROMPT="$*"

# Function to wrap text at a specified width
wrap_text() {
    local text="$1"
    local width=80
    echo "$text" | fold -s -w "$width"
}

# Make the request and capture the response
RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d '{
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": "'"$PROMPT"'"}],
      "temperature": 0.7
    }')

# Check if the request was successful
if echo "$RESPONSE" | jq -e '.error' > /dev/null; then
    echo "Error: $(echo $RESPONSE | jq -r '.error.message')"
    exit 1
fi

# Extract and prepare the response text
RESPONSE_TEXT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')
FORMATTED_RESPONSE=$(wrap_text "\n$RESPONSE_TEXT\n")

# Output the formatted response
echo -e "$FORMATTED_RESPONSE"

# Send the response as a Pushover notification
curl -s \
    --form-string "token=$PUSHOVER_API_KEY" \
    --form-string "user=$USER_KEY" \
    --form-string "message=$RESPONSE_TEXT" \
    https://api.pushover.net/1/messages.json > /dev/null

# Log the question and response to a markdown file
LOG_FILE="$HOME/gpt_log.md"
{
    echo "## $(date)"
    echo
    echo "**Question:** $PROMPT"
    echo
    echo "**Response:**"
    wrap_text "$RESPONSE_TEXT"
    echo
    echo "---"
} >> "$LOG_FILE"
