%rebase('game_base.tpl', Page_Title='Sudoku Game')

<div class="row">
	<div class="game_buttons col-md-offset-1 col-md-10">
		<ul>
			<li><span id="game_timer">0:00</span></li>
			<li><a href="#" class="pause_resume_timer">Pause</a></li>
			<li><a href="#" class="remove_timer">Remove Timer</a></li>
			<li><a href="#" class="new_game">New Game</a></li>
			<li><a href="#" class="reset_game">Reset</a></li>
			<li><a href="#" class="check_game">Check</a></li>
		</ul>
	</div>
</div>
<div class="row" id="welcome_msg">
	<h1>Welcome to SUDOKU -SEM STARS!</h1>
	<h2>Experience the Sudoku Game play.</h2>
	<h3>Please select the difficulty level</h3>
</div>
<div id="sudoku_grid"></div>

<!-- Modal -->
<div id="modalWon" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Congratulations !!! You Won !!!</h4>
      </div>
      <div class="modal-body">
        <p>What's next? Click on "New Game" or select a different level and enjoy unlimited rounds.</p>
      </div>
      <!--div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div-->
    </div>
  </div>
</div>

<!-- Modal -->
<div id="modalTimeUp" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Time Up !!! You Lost !!!</h4>
      </div>
      <div class="modal-body">
        <p>Dont worry !!! Click on "New Game" or select a different level and enjoy unlimited rounds.</p>
      </div>
      <!--div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div-->
    </div>
  </div>
</div>


