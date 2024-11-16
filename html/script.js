// Add an event listener to listen for messages
window.addEventListener('message', function(event) {
    if (event.data.action === "updateMoney") {
        // Format the cash and bank amounts
        document.getElementById("cash").innerText = "" + event.data.cash +"€";
        document.getElementById("bank").innerText = "" + event.data.bank + "€";
    }
    // Update job and grade
    if (event.data.action === "updateJob") {
        document.getElementById("job").innerText = event.data.job;
        document.getElementById("grade").innerText = event.data.grade;
    }
    // Open or close the HUD when requested
    if (event.data.action === "open") {
        document.getElementById("moneyHud").style.display = "block";
    } else if (event.data.action === "close") {
        document.getElementById("moneyHud").style.display = "none";
    }
});

// Function to format money values (e.g., 1000 -> 1k, 1000000 -> 1m)
function formatMoney(amount) {
    // Convert the amount to a number
    amount = parseInt(amount);
    
    if (amount >= 1000000000000) {
        // If the number is greater than or equal to a million, format it as "1m"
        return (amount / 1000000000000).toFixed(1) + 't'; 
    }else if (amount >= 1000000000) {
        // If the number is greater than or equal to a million, format it as "1m"
        return (amount / 1000000000).toFixed(1) + 'b'; 
    }else if (amount >= 1000000) {
        // If the number is greater than or equal to a million, format it as "1m"
        return (amount / 1000000).toFixed(1) + 'm'; 
    } else if (amount >= 1000) {
        // If the number is greater than or equal to a thousand, format it as "1k"
        return (amount / 1000).toFixed(1) + 'k'; 
    } else {
        // For amounts less than a thousand, just return the number as is
        return amount.toString();
    }
}
