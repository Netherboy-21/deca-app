function searchRows() {
    // Declare variables
    let ninput, nfilter, cinput, cfilter, table, tr, ntd, ctd, i, ntxtValue, ctxtValue;
    ninput = document.getElementById("name-search");
    nfilter = ninput.value.toUpperCase();
    cinput = document.getElementById("category-search");
    cfilter = cinput.value.toUpperCase();
    table = document.getElementById("transactions");
    tr = table.getElementsByTagName("tr");
    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        ntd = tr[i].getElementsByTagName("td")[1];
        ctd = tr[i].getElementsByTagName("td")[3];
        if (ntd) {
            ntxtValue = ntd.textContent || ntd.innerText;
            ctxtValue = (ctd.textContent || ctd.innerText).trim()
            if (ntxtValue.toUpperCase().indexOf(nfilter) > -1 && ((ctxtValue.toUpperCase().indexOf(cfilter) > -1 && ctxtValue.length === cfilter.length) || cfilter === "NOFILTER")) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

if(typeof(String.prototype.trim) === "undefined")
{
    String.prototype.trim = function()
    {
        return String(this).replace(/^\s+|\s+$/g, '');
    };
}

$('#name-search').on('keyup',() => {
    $('tr').css('display','table-row');
    searchRows();
})

$('#category-search').on("change",() => {
    $('tr').css('display','table-row');
    searchRows();
})