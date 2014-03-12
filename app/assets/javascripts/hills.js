/* Sets up row selection and sorting by column content.
   Taken from 'JavaScrpt' by Negrino and Smith, Ch 15, p 395
*/
$(document).ready(function() {
	$("tr").mouseover(function() {
		$(this).addClass("over");
	});

	$("tr").mouseout(function() {
		$(this).removeClass("over");
	});
	
	$("#theTable").tablesorter({
		sortList:[[1,0]],
        cssHeader: "background",
		cssAsc: "sortUp",
		cssDesc: "sortDown",
		widgets: ["zebra"]
	});
});

$(function() {
	$( "#accordion" ).accordion();
});

$(document).on('change', '#column_check input', function() {

    var checked = $(this).is(":checked");
    var index = $(this).index()/2;

    $('table thead tr').each(function() {
        if(checked) {
            $(this).find("th").eq(index).show();   
        } else {
            $(this).find("th").eq(index).hide();   
        }
    });
 
    $('table tbody tr').each(function() {
        if(checked) {
            $(this).find("td").eq(index).show();   
        } else {
            $(this).find("td").eq(index).hide();   
        }
    });     
});

