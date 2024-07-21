# gpt-pushover
Pushover notifications from ChatGPT using bash/shell command gptn

# setup and install

### 1. 

Open your terminal (connected via PuTTY) and create a new file named gptn in your home directory:

nano ~/gptn

### 2. 

Paste the script into the file

then Press CTRL+X, then Y, and then ENTER to save the file and exit the editor.

### 3. 

then run the following commands one after the other to move the script and make it executable: 

sudo mv ~/gptn /usr/local/bin/gptn

sudo chmod +x /usr/local/bin/gptn

### 4. 

Now you can run the script from anywhere in your terminal by typing:

gptn your prompt here


# updating script

if you need/want to update the script. do the following, presuming you already created it, before. 

### 1. 

Open the existing script in an editor:

sudo nano /usr/local/bin/gptn

### 2. 

edit the script. 

Press CTRL+X, then Y, and then ENTER to save the file and exit the editor.

### 3. 

it should already be executable, you can ensure it by running:

sudo chmod +x /usr/local/bin/gptn

### 4. 

Now, your script should be updated and ready to use with the new improvements. You can run it as usual with:

gptn your prompt here


