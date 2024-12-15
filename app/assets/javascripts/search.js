function searchRows() {
    // Declare variables
    let ninput, nfilter, cinput, cfilter, table, tr, ntd, ctd, i, ntxtValue, ctxtValue;
    // Name input
    ninput = document.getElementById("name-search");
    nfilter = ninput.value.toUpperCase();
    // Category input
    cinput = document.getElementById("category-search");
    cfilter = cinput.value.toUpperCase();
    // Date inputs
    sinput = document.getElementById("start")
    einput = document.getElementById("end")
    if (sinput.value == "") {
        sfilter = new Date("1-1-0000")
    }
    else {
        sfilter = new Date(sinput.value)
    }
    if (einput.value == "") {
        efilter = new Date("12-31-9999")
    }
    else {
        efilter = new Date(einput.value)
    }
    // Table
    table = document.getElementById("transactions");
    // Rows
    tr = table.getElementsByTagName("tr");
    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        ntd = tr[i].getElementsByTagName("td")[1];
        ctd = tr[i].getElementsByTagName("td")[3];
        dtd = tr[i].getElementsByTagName("td")[0];
        if (ntd) {
            ntxtValue = ntd.textContent || ntd.innerText;
            ctxtValue = (ctd.textContent || ctd.innerText).trim()
            dtxtValue = (dtd.textContent || dtd.innerText).trim()
            date = new Date((dtd.textContent || dtd.innerText).trim())
            console.log(date)
            console.log(efilter)
            if (ntxtValue.toUpperCase().indexOf(nfilter) > -1 && ((ctxtValue.toUpperCase().indexOf(cfilter) > -1 && ctxtValue.length === cfilter.length) || cfilter === "NOFILTER") && date >= sfilter && date <= efilter) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

// Add trim method to String class
if(typeof(String.prototype.trim) === "undefined")
{
    String.prototype.trim = function()
    {
        return String(this).replace(/^\s+|\s+$/g, '');
    };
}

// Add event listeners
$('#name-search').on('keyup',() => {
    $('tr').css('display','table-row');
    searchRows();
})

$('#category-search').on("change",() => {
    $('tr').css('display','table-row');
    searchRows();
})

$('#start').on("change",() => {
    $('tr').css('display','table-row');
    searchRows();
})

$('#end').on("change",() => {
    $('tr').css('display','table-row');
    searchRows();
})