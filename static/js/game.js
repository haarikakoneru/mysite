var needsReset = false;
var won = true;
var board = [];
var paused = false;
var freeplay = false;
var currentLevel = 'easy_level';

var timeOptions = {"easy_level": 5, "medium_level": 8, "hard_level": 10};

$(document).ready(function () {
	$(".grid_cell.editable").live("keypress", function(e) {
		if (needsReset) {
			highlight();
			needsReset = false;
		}
		if (e.keyCode < 48 || e.keyCode > 57) {
			e.preventDefault();
		}
	});
	$("#welcome_msg").show();
	$(".game_buttons").hide();
	// startNewGame();
    // startTimer();
    // setTimerOptions(true);
    
    $("a.game_level").on("click", function() {
    	if (won || confirm("Are you sure you want to start a new game?")) {
    		level = $(this).prop("id");
    		generatePuzzle(level);
    		if(level == "easy_level"){
    			$("#displayLevel").html("You are playing Easy Level");
    		}else if(level == "medium_level"){
    			$("#displayLevel").html("You are playing Medium Level");
    		}else if(level == "hard_level"){
    			$("#displayLevel").html("You are playing Hard Level");
    		}
    	}
        // generatePuzzle('easy');
	});
    
    $("a.pause_resume_timer").on("click", function() {
        if ($(this).html() == "Pause") {
            paused = true;
            blockBoard(true);
            $("#game_timer").countdown('pause');
            $(this).html("Resume");
        } else {
            paused = false;
            blockBoard(false);
            $("#game_timer").countdown('resume');
            $(this).html("Pause");
        }
		return false;
	});
    
    $("a.remove_timer").on("click", function() {
        setTimerOptions(false);
        if (paused) {
            paused = false;
            blockBoard(false);
        }
		return false;
	});
    
	$("a.new_game").on("click", function() {
		if (won || confirm("Are you sure you want to start a new game?")) {
			startNewGame(currentLevel);
            startTimer();
            setTimerOptions(true);
            setGameOptions(true);
		}
		return false;
	});
    
    $("a.reset_game").on("click", function() {
		if (confirm("Are you sure you want to reset the game?")) {
            paused = false;
            fillBoard(board);
            startTimer();
            setTimerOptions(true);
            setGameOptions(true);
		}
		return false;
	});
	
	$("a.check_game").on("click", function() {
		checkGame();
		// answer = getGameJSON();
		// console.log(answer);
		// $.ajax({
			// type : "POST",
			// url : "/check_solution",
			// dataType : "json",
			// contentType: "application/json;charset=utf-8",
			// data: JSON.stringify(answer)
		// }).done(function(data, textStatus, jqXHR) {
			// ajaxindicatorstop();
			// if (data['results']) {
				// highlight(data['results']);
				// if (data['won']) {
					// showWonMessage();
					// won = true;
				// }
			// } else {
				// alert("Invalid response from server...");
			// }
		// });
		
		return false;
	});
});

function checkGame(showLost) {
	answer = getGameJSON();
	console.log(answer);
	$.ajax({
		type : "POST",
		url : "/check_solution",
		dataType : "json",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(answer)
	}).done(function(data, textStatus, jqXHR) {
		ajaxindicatorstop();
		if (data['results']) {
			highlight(data['results']);
			if (data['won']) {
				showWonMessage();
				won = true;
			} else if(showLost) {
				showLostMessage();
			}
		} else {
			alert("Invalid response from server...");
		}
	});
}

function startTimer() {
    var options = {
        autostart: true,
        m: timeOptions[currentLevel],
        s: 0,
        
        // show a message after the countdown timer once the countdown has ended
        done: function() {
            if (!freeplay) {
                blockBoard(true);
                setTimerOptions(false);
                setGameOptions(false);
                checkGame(true);
                // showLostMessage();
            }
        }
    };
    // instantiate the countdown
    $(".pause_resume_timer").html("Pause");
    $("#game_timer").countdown(options);
}

function blockBoard(block) {
    $("#sudoku_grid table tr").each(function(i, row) {
		$(this).find("td").each(function(j, col) {
			$input = $(this).find("input");
			if (block) {
                $input.addClass("blocked");
                $input.prop("disabled", true);
            } else {
                $input.removeClass("blocked");
                $input.prop("disabled", false);
			}
		});
	});
}

function showWonMessage() {
	$('#modalWon').modal('show');
}

function showLostMessage() {
    $('#modalTimeUp').modal('show');
}

function highlight(results) {
	$("#sudoku_grid table tr").each(function(i, row) {
		$(this).find("td").each(function(j, col) {
			$input = $(this).find("input");
			$input.removeClass("wrong").removeClass("right");
			if (results) {
				if (!needsReset) {
					needsReset = true;
				}
				
				if (results[i][j] === true) {
					$input.addClass("right");
				} else if (results[i][j] === false) {
					$input.addClass("wrong");
				}
			}
		});
	});
}

function getGameJSON() {
	var arr = [];
	$("#sudoku_grid table tr").each(function(i, row) {
		var r = [];
		$(this).find("td").each(function(j, col) {
			val = $(this).find("input").val();
			r.push(val == '' ? 0 : parseInt(val));
		});
		arr.push(r);
	});
	return {"answer": arr};
}

function setGameOptions(show) {
    if (show) {
        $(".reset_game").show();
        $(".check_game").show();
    } else {
        $(".reset_game").hide();
        $(".check_game").hide();
    }
}

function setTimerOptions(show) {
    if (show) {
        freeplay = false;
        $("#game_timer").show();
        $(".pause_resume_timer").show();
        $(".remove_timer").show();
        $("#game_timer").countdown('start');
    } else {
        freeplay = true;
        $("#game_timer").hide();
        $(".pause_resume_timer").hide();
        $(".remove_timer").hide();
        $("#game_timer").countdown('stop');
    }
}

function startNewGame(level) {
	$("#welcome_msg").hide();
	$(".game_buttons").show(); 
	/*needsReset = false;
	won = false;
    freeplay = false;
    paused = false;
    
	$.ajax({
		type : "GET",
		url : "/get_board",
		dataType : "json"
	}).done(function(data, textStatus, jqXHR) {
		ajaxindicatorstop();
		if (data['board']) {
            board = data['board'];
			fillBoard(board);
		} else {
			alert("Invalid response from server...");
		}
	});*/
	
	needsReset = false;
	won = false;
    freeplay = false;
    paused = false;
	$.ajax({
		url:'get_board/'+level,
		dataType:'json',
		type:'GET'
	}).done(function(data, textStatus, jqXHR) {
		ajaxindicatorstop();
		if (data['board']) {
            board = data['board'];
			fillBoard(board);
		} else {
			alert("Invalid response from server...");
		}
	});
}

function generatePuzzle(level){
	currentLevel = level;
	startNewGame(level);
    startTimer();
    setTimerOptions(true);
    setGameOptions(true);
}


function fillBoard(board) {
	content = "<table>";
	$.each(board, function(i, row) {
		content += "<tr>";
		$.each(row, function(j, col) {
			content += "<td>";
			content += "<input type=\"text\" class=\"grid_cell" + (col == 0 ? " editable" : "") + "\" value=\"" + (col == 0 ? "" : col) + "\"  maxlength=\"1\"" + (col == 0 ? "" : " readonly=\"readonly\"") + " />";
			content += "</td>";
		});
		content += "</tr>";
	});
	content += "</table>";
	
	$("#sudoku_grid").html(content);
}

function myNavFunction(id) {
	$("#date-popover").hide();
	var nav = $("#" + id).data("navigation");
	var to = $("#" + id).data("to");
	console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
}

$(document).ajaxStart(function() {
	//show ajax indicator
	ajaxindicatorstart('Please wait');
}).ajaxStop(function() {
	//hide ajax indicator
	ajaxindicatorstop();
});

function ajaxindicatorstart(text) {
	if ($('body').find('#resultLoading').attr('id') != 'resultLoading') {
		$('body').append('<div id="resultLoading" style="display:none"><div>' + text + '</div><div class="bg"></div></div>');
	}

	$('#resultLoading').css({
		'width': '100%',
		'height': '100%',
		'position': 'fixed',
		'z-index': '10000000',
		'top': '0',
		'left': '0',
		'right': '0',
		'bottom': '0',
		'margin': 'auto'
	});

	$('#resultLoading .bg').css({
		'background': '#000000',
		'opacity': '0.7',
		'width': '100%',
		'height': '100%',
		'position': 'absolute',
		'top': '0'
	});

	$('#resultLoading>div:first').css({
		'width': '250px',
		'height': '75px',
		'text-align': 'center',
		'position': 'fixed',
		'top': '0',
		'left': '0',
		'right': '0',
		'bottom': '0',
		'margin': 'auto',
		'font-size': '16px',
		'z-index': '10',
		'color': '#ffffff'

	});

	$('#resultLoading .bg').height('100%');
	$('#resultLoading').fadeIn(300);
	$('body').css('cursor', 'wait');
}

function ajaxindicatorstop() {
	$('#resultLoading .bg').height('100%');
	$('#resultLoading').fadeOut(300);
	$('body').css('cursor', 'default');
}

