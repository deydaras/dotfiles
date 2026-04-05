CONFIG_FILE="config.json"

# 1. Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Install it with: sudo apt install jq"
    exit 1
fi

# 2. Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: $CONFIG_FILE not found."
    exit 1
fi

# 3. Extract PROJECT_ID using jq
PROJECT_ID=$(jq -r '.PROJECT_ID' "$CONFIG_FILE")
REGION=$(jq -r '.REGION' "$CONFIG_FILE")

if [[ "$PROJECT_ID" == "null" ]]; then
    echo "Error: PROJECT_ID not found in $CONFIG_FILE"
    exit 1
fi

echo "--- Starting Google Cloud Login ---"
# 4. Trigger the web browser login
# This will pause the script until you complete the login in your browser
gcloud auth login

echo "--- Configuring Project: $PROJECT_ID ---"

# 5. Set the project and region automatically
gcloud config set project "$PROJECT_ID"
gcloud config set compute/region "$REGION"

echo "----------------------------------------"
echo "Setup Complete!"
echo "Active Account: $(gcloud auth list --filter=status:ACTIVE --format="value(account)")"
echo "Active Project: $(gcloud config get-value project)"
