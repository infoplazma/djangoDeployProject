const searchText = document.getElementById('searchText');
const prmButton = document.getElementById('prmButton');
const restoreButton = document.getElementById('restoreButton');

function input_data(){
    console.log("Input data");
    searchText.innerText = "Input Data";
}

function restore_data(){
    console.log("Input data");
    searchText.innerText = "Column 1";
}

prmButton.addEventListener('click', input_data);
restoreButton.addEventListener('click', restore_data);