/* Sets up row selection and sorting by column content.
   Taken from 'JavaScrpt' by Negrino and Smith, Ch 15, p 395
*/

var category = 'Munros';
var selected =  'All';
var hill_ids = new Array();
var hill_names = new Array();

$('#caption').html(get_caption());


$(document).ready(function() {
 /*setup_table();*/

    // Category button sets Munros, Corbetts, etc.
    $(".category_button").click(function(){
        category = $(this).attr("value");
        $('#caption').html(get_caption());
        $.ajax({
            url: '/hills.js',
            type: 'GET',
            data: {category: $(this).attr("value")}
        });
    });

    // Select button sets All, Climbed, etc.
    $(".select_button").click(function(){
        selected = $(this).attr('value');
        $('#caption').html(get_caption());
        $('table tbody tr').each(function() {
            if (selected == 'All') {
                $(this).show();  
            } else if (selected == 'Climbed') {
                if ($(this).find("input").eq(1).attr("value") == 'true') {
                    $(this).show(); 
                } else { 
                    $(this).hide();
                }
            } else if (selected == 'To do') {
                if ($(this).find("input").eq(1).attr("value") == 'false') {
                    $(this).show(); 
                } else { 
                    $(this).hide();
                }
            }  
        })
    });     

});

function setup_table(){
    // Gets called each time table is loaded
    $("tr").mouseover(function() {
		$(this).addClass("over");
	});

	$("tr").mouseout(function() {
		$(this).removeClass("over");
	});
	
    // Selects row, stores hill_id, and gets mates
    $("tr").click(function() {
        id = $(this).find("input").first().attr("value")
        name = $(this).find('td').eq(1).text()
        
        index = hill_ids.indexOf(id)
        if (index == -1){
            hill_ids.push(id)
            hill_names.push(name)
        } else {
            hill_ids.splice(index, 1) 
            hill_names.splice(index, 1) 
        }
        $.ajax({
            url: '/hills/get_mates.js',
            type: 'POST',
            data: {hill_ids: hill_ids},
        });
        $('#hidden_hill_ids').attr('value', hill_ids)
        $('#hill_names').html(hill_names.toString().replace(/,/g,'<br>'))
        $(this).toggleClass("selected");
    });

 
    
	$("#hill_table").tablesorter({
        widthFixed: true,
		sortList:[[1,0]],
        cssHeader: "background",
		cssAsc: "sortUp",
		cssDesc: "sortDown", 
		/*widgets: ["zebra"]*/
	})/*.tablesorterPager({container: $("#pager")});*/
};


function get_caption() {
    if (selected == 'All') {
           return '<h1> All '.concat(category, '</h1>');
    } else if (selected == 'Climbed') {
            return '<h1>'.concat(category, ' climbed</h1>');
    } else if (selected == 'To do') {
            return '<h1>'.concat(category, ' to do</h1>');
    };
};

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

