const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = 3000;

app.get('/move-files', (req, res) => {
    const scriptPath = './scripts/move-files.ps1'; // Replace with the actual path to the PowerShell script if needed

    exec(`powershell.exe -ExecutionPolicy Bypass -File "${scriptPath}"`, (error, stdout, stderr) => {
        if (error) {
            console.error(`An error occurred: ${error.message}`);
            return res.status(500).json({ error: error.message });
        }

        if (stderr) {
            console.error(`An error occurred: ${stderr}`);
            return res.status(500).json({ error: stderr });
        }

        console.log(`Script output: ${stdout}`);
        res.status(200).json({ message: 'Script executed successfully', output: stdout });
    });
});

app.listen(port, () => {
    console.log(`API is running at http://localhost:${port}`);
});
