<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV="Expires" CONTENT="Thu, 01 Dec 1994 16:00:00 GMT">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<meta name="keywords" content="﻿sudoku solver, solve sudoku">
<meta name="description" content="The Sudoku solver allows you to enter sudoku puzzles from the newspaper or other websites, and get the right solution for them.">
<!--true on local-->
<!--<base href="http://www.sudoku.name/~sudoku/"/>-->
<!--true on server-->
<base href="http://www.sudoku.name/"/><title>Sudoku solver</title>
<LINK href="sudoku.css" type=text/css rel=stylesheet>

<script language=javascript>


//check if there are any numbers
function solve_puzzle()
{
	//tmp=document.getElementById('select_difficult').selectedIndex;
	//alert("yes "+tmp);
	if (document.getElementById('select_difficult').selectedIndex>0)	
	{
		
		//check fields
		var flag=0;
		for (i=1;i<82;i++)
		{
			
			if (document.getElementById('c'+i).value>0)
			{
				flag=1;
				//alert(flag);
				break;
			}
		}
		if (flag==0)//no numbers
		{
			alert("Please enter initial Sudoku puzzle numbers");
			return;
		}
		else//initial numbers in place submit
		{
			document.getElementById('solve').value='1';
			form1.target='_top';
			document.form1.action='';
			document.form1.submit();
		}
	}
	else//if (document.getElementById('difficul').selectedIndex>0)	
	{
		//alert("no");
		alert("Please choose the Sudoku difficulty level");
		
		document.getElementById('select_difficult').selectedIndex=0;
		document.getElementById('select_difficult').focus();
		return;
	}
	
} 

function change_puzzle()
{
	document.getElementById('change').value='1';
	form1.target='_top';
	document.form1.action='';
	document.form1.submit();
}
	//all cells read only
	//place initial numbers&mark background cells
	shown_arr1=new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	
		difficulty=0;
	
function repaint()
{
	//repaint cells
	for (i=1;i<82;i++)//insert initial numbers repaint cells
	{
		//if ($_POST['c'.$i]!="") echo $_POST['c'.$i];
		if (shown_arr1[i-1]>0) 
		{
			//alert();
			//tmp='c'+i;
			//tmp=document.getElementById('c'+i).value;
			//alert("before "+tmp);
			document.getElementById('c'+i).value=shown_arr1[i-1];
			document.getElementById('cell'+i).bgColor= '#E5E5E5';
			
			//tmp=document.getElementById('c'+i).value;
			//alert("after "+tmp);
			
		}
	}
}

	//initializing vars
	var col_counter=1;//1-9
	var row_counter=1;//1-9
	var region_counter=1;//1-9
	var cell_counter=0;//0-82
	var direction=1;//1||-1
	puzzle_arr=new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	initial_puzzle_arr=new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);


function check_symmetry()
{
	//check 4 regions
	legal=1;//1=symmetry 0=not symmetry
	
	region1=new Array(0,0,0,0,0,0,0,0,0);
	region2=new Array(0,0,0,0,0,0,0,0,0);
	region3=new Array(0,0,0,0,0,0,0,0,0);
	region4=new Array(0,0,0,0,0,0,0,0,0);
	
	region6=new Array(0,0,0,0,0,0,0,0,0);
	region7=new Array(0,0,0,0,0,0,0,0,0);
	region8=new Array(0,0,0,0,0,0,0,0,0);
	region9=new Array(0,0,0,0,0,0,0,0,0);
	
	tmp_region=new Array(1,4,7,28,31,34,55,58,61);
	//create regions 
	for (i=1;i<10;i++)
	{
		if (i==5) i++;//without center
		tmp_counter=0;
		
		//tmp_arr=new Array(0,0,0,0,0,0,0,0,0);
		start=tmp_region[i-1];
		finish=tmp_region[i-1]+21;
		for (j=start;j<finish;j+=9)//row
		{
			for (j1=j;j1<j+3;j1++)//column
			{
				/*
				if (i==9) 
				{
					tmp=j1-1;
					alert("initial_puzzle_arr[j1-1]="+initial_puzzle_arr[tmp]+" j1-1="+tmp);
				}
				*/
				//initial_puzzle_arr
				
				//if (shown_arr1[j1-1]!=0) tmp=1;
				if (initial_puzzle_arr[j1-1]!=0) tmp=1;
				else tmp=0;
				eval("region"+i)[tmp_counter]=tmp;
				tmp_counter++;
			}
		}
	}//end checking regions
	
//alert(region1.toString()+"\n"+region2.toString()+"\n"+region3.toString()+"\n"+region4.toString()+"\n"+region6.toString()+"\n"+region7.toString()+"\n"+region8.toString()+"\n"+region9.toString());
	
	//now we have all regions in arrays
	//compare individualy
	
	twin_regions=new Array(1,9,2,8,3,7,4,6);
	
	//region1 region8
	for (j=0;j<8;j+=2)
	{
		//if (i==4) i++;
		i=0;
		//first_region=twin_regions[j];
		
		if (eval("region"+twin_regions[j])[i]!=eval("region"+twin_regions[j+1])[i+8]) 
		{
			legal=0;
			//alert("j="+j+" i="+i+" i+8="+(i+8));
		}
		else if (eval("region"+twin_regions[j])[i+1]!=eval("region"+twin_regions[j+1])[i+7]){
			legal=0;
			//alert("j="+j+" i+1="+(i+1)+" i+7="+(i+7));
		}
		else if (eval("region"+twin_regions[j])[i+2]!=eval("region"+twin_regions[j+1])[i+6]){
			legal=0;
			//alert("j="+j+" i+2="+(i+2)+" i+6="+(i+6));
		}
		else if (eval("region"+twin_regions[j])[i+3]!=eval("region"+twin_regions[j+1])[i+5]){
			legal=0;
			//alert("j="+j+" i+3="+(i+3)+" i+5="+(i+5));
		}
		
		else if (eval("region"+twin_regions[j])[i+5]!=eval("region"+twin_regions[j+1])[i+3]){
			legal=0;
			//alert("j="+j+" i+5="+(i+5)+" i+3="+(i+3));
		}
		else if (eval("region"+twin_regions[j])[i+6]!=eval("region"+twin_regions[j+1])[i+2]){
			legal=0;
			//alert("j="+j+" i+6="+(i+6)+" i+2="+(i+2));
		}
		else if (eval("region"+twin_regions[j])[i+7]!=eval("region"+twin_regions[j+1])[i+1]){
			legal=0;
			//alert("j="+j+" i+7="+(i+7)+" i+1="+(i+1));
		}
		else if (eval("region"+twin_regions[j])[i+8]!=eval("region"+twin_regions[j+1])[i+0]){
			legal=0;
			//alert("j="+j+" i+8="+(i+8)+" i+0="+(i+0));
		}
		
		if (legal==0) break;
		
	}
	
	document.getElementById('sudoku_symmetry').value=legal;
	
	return legal;
	//alert(legal);
	//alert("region9="+str1);
	
}

function stop_control()
{
	//continue when remove mark
	if (document.getElementById('mark').checked== false) window.setTimeout('solver.guess();', 1);
	//else mouse=2;
}
	
function check_grid()//check fields!!!
{
	empty=0;
	legal=0;
	//alert('yes');
	//prepare shown cells array

	//check rows
	for (i=1;i<10;i++)
	{
		tmp_arr=new Array(0,0,0,0,0,0,0,0,0);
		start=1+((i-1)*9);
		finish=((i-1)*9)+10;
		for (j=start;j<finish;j++)//check cell of row
		{
			tmp=document.getElementById('c'+j).value;
			if (tmp!="")//disrigard empty cells
			{
				//alert(tmp);
				if (tmp_arr[tmp-1]==0) tmp_arr[tmp-1]=tmp;
				else 
				{
					//error
					legal=1;
					//mark duplicaned cells
					
					//return;// false;
					break;
				}
			}
			else empty=1;
			//t+=1;
		}
		//t+=9;
	}//end check rows
	
	//check columns
	for (i=1;i<10;i++)
	{
		//i= column start
		tmp_arr=new Array(0,0,0,0,0,0,0,0,0);
		start=i;
		finish=73+i;
		for (j=start;j<finish;j+=9)//check cell of column
		{
			tmp=document.getElementById('c'+j).value;
			if (tmp!="")//disrigard empty cells
			{
				//alert(tmp);
				if (tmp_arr[tmp-1]==0) tmp_arr[tmp-1]=tmp;
				else 
				{
					//error
					legal=1;
					//mark duplicaned cells
					
					//return;// false;
					break;
				}
			}
			else empty=1;
		}
	}//end column check
	
	//check regions
	for (i=1;i<10;i++)
	{
		tmp_region=new Array(1,4,7,28,31,34,55,58,61);
		tmp_arr=new Array(0,0,0,0,0,0,0,0,0);
		start=tmp_region[i-1];
		finish=tmp_region[i-1]+21;
		for (j=start;j<finish;j+=9)//row
		{
			for (j1=j;j1<j+3;j1++)//column
			{
				tmp=document.getElementById('c'+j1).value;
				if (tmp!="")//disrigard empty cells
				{
					//alert(tmp);
					if (tmp_arr[tmp-1]==0) tmp_arr[tmp-1]=tmp;
					else 
					{
						//error
						legal=1;
						//mark duplicaned cells
		
						
						//return;// false;
						break;
					}
				}
				else empty=1;
			}
		}
	}//end checking regions
	
	if (legal==1)
	{
		alert('This Sudoku puzzle cannot be solved');
		return false;
	}
	return true;
} 

'use strict';
var solver = {
    // Copyright (c) by Rolandas Gricius, 2014
    // For http://www.sudoku.name/tmp-solve.php
    inDebug: 0,
    max_iter: 100000,
    debug: function () {
        if (!this.inDebug) return;
        var deb = document.getElementById('debug');
        if (deb) {
            deb.parentNode.removeChild(deb);
            deb = null;
        }

        if (!deb) {
            var tbl, tr, td;
            deb = document.createElement("td"); deb.setAttribute('id', 'debug'); deb.setAttribute('valign', 'top');
            deb.innerText = (new Date).toISOString().replace('T', ' ').replace('Z', ' ');
            tbl = document.createElement("table"); tbl.setAttribute('border', '1');
            deb.appendChild(tbl);

            for (var i = 0; i < 81; i++) {
                if (i % 9 == 0) {
                    tr = document.createElement("tr");
                    tbl.appendChild(tr);
                }
                td = document.createElement("td"); td.setAttribute('id', 'd' + i);
                td.setAttribute('style', 'height: 35px; width: 30px; text-align: center; font-weight: normal; font-size: 24px;');
                if ((i - i % 27 + i % 9 - i % 3) % 2 == 0) {
                    td.bgColor = "#F0F0F0";
                }
                tr.appendChild(td);
            }
            document.getElementById('sudoku_symmetry').parentNode.parentNode.children[0].insertAdjacentElement("afterEnd", deb);
        }

        for (var i = 0; i < 81; i++) {
            document.getElementById('d' + i).innerText = this.possibilities_arr[i];
        }
    },
    puzzle_arr: new Array(81),
    solved_arr: new Array(81),
    possibilities_arr: new Array(81),
    changed: 0,
    setCell: function (i, n) {
        this.changed = 1;
        this.puzzle_arr[i] = parseInt(n);
        this.solved_arr[i] = 1;
        this.possibilities_arr[i] = n;
        document.getElementById('c' + (i + 1)).value = n;

        var start = [i - i % 9, i % 9, i - i % 27 + i % 9 - i % 3];
        var end = [start[0] + 9, 81, start[2] + 21];
        var incr = [1, 9, 1];
        for (var idx = 0; idx < 3; idx++) {
            for (var j = start[idx]; j < end[idx]; j += idx == 2 && j % 3 == 2 ? 7 : incr[idx]) {
                if (j == i) continue;
                this.possibilities_arr[j] = this.possibilities_arr[j].replace(n, '');
                if (this.possibilities_arr[j].length == 1 && this.solved_arr[j] != 1) {
                    this.setCell(j, this.possibilities_arr[j]);
                }
            }
        }
    },
    init: function () {
        for (var i = 0; i < 81; i++) {
            // clear previous solving attempt
			if (document.getElementById('cell' + (i + 1)).bgColor.toUpperCase() != "#E5E5E5") {
            //if (document.getElementById('cell' + (i + 1)).bgColor != "#E5E5E5") {
				//alert("yes-"+i);
                document.getElementById('cell' + (i + 1)).bgColor = "";
                document.getElementById('c' + (i + 1)).value = '';
            }
            this.possibilities_arr[i] = "123456789";
        }

        if (!shown_arr1) shown_arr1 = new Array(81);
        for (var i = 0; i < 81; i++) {
            var n = document.getElementById('c' + (i + 1)).value;
            shown_arr1[i] = 0;
            if (parseInt(n) > 0) {
                shown_arr1[i] = parseInt(n);
                this.setCell(i, n);
            }
        }

        while (this.changed) {
            this.changed = 0;

            var ei = [81, 9, 81];
            var ej = [9, 81, 21];
            var ii = [9, 1, 3];
            var ij = [1, 9, 1];

            for (var idx = 0; idx < 3; idx++) {
                for (var i = 0; i < ei[idx]; i += idx == 2 && i % 27 == 6 ? 21 : ii[idx]) {
                    for (var j = i; j < i + ej[idx]; j += idx == 2 && j % 3 == 2 ? 7 : ij[idx]) {
                        if (this.possibilities_arr[j].length == 2) {
                            for (var k = j; k < i + ej[idx]; k += idx == 2 && k % 3 == 2 ? 7 : ij[idx]) {
                                if (k == j) continue;
                                if (this.possibilities_arr[j] == this.possibilities_arr[k]) {
                                    for (var l = i; l < i + ej[idx]; l += idx == 2 && l % 3 == 2 ? 7 : ij[idx]) {
                                        if (l == j || l == k) continue;
                                        this.possibilities_arr[l] = this.possibilities_arr[l].replace(this.possibilities_arr[j][0], '');
                                        this.possibilities_arr[l] = this.possibilities_arr[l].replace(this.possibilities_arr[j][1], '');
                                        if (this.possibilities_arr[l].length == 1 && this.solved_arr[l] != 1) {
                                            this.setCell(l, this.possibilities_arr[l]);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            for (var idx = 0; idx < 3; idx++) {
                for (var i = 0; i < ei[idx]; i += idx == 2 && i % 27 == 6 ? 21 : ii[idx]) {
                    var uses = ["", "", "", "", "", "", "", "", "", ""];
                    for (var j = i; j < i + ej[idx]; j += idx == 2 && j % 3 == 2 ? 7 : ij[idx]) {
                        var sj = j < 10 ? "0" + j.toString() : j.toString();
                        for (var nx = 0; nx < this.possibilities_arr[j].length; nx++) {
                           // uses[parseInt(this.possibilities_arr[j][nx])] += sj;
							uses[parseInt(this.possibilities_arr[j].charAt(nx))] += sj;
                        }
                    }
                    for (var ui = 1; ui < 10; ui++) {
                        switch (uses[ui].length) {
                            case 0:
                                alert('This Sudoku puzzle cannot be solved');
                                return;
                            case 2:
                                var n = parseInt(uses[ui]);
                                if (this.solved_arr[n] != 1) {
                                    this.setCell(n, ui.toString());
                                }
                                break;
                            case 4:
                                for (var uj = ui + 1; uj < 10; uj++) {
                                    if (uses[ui] == uses[uj]) {
                                        //var n1 = parseInt(uses[ui].substr(0, 2));
										var n1 = parseInt(uses[ui].substr(0, 2),10);
                                        //var n2 = parseInt(uses[ui].substr(2, 2));
										var n2 = parseInt(uses[ui].substr(2, 2),10);
                                        if (this.possibilities_arr[n1].length != 2 || this.possibilities_arr[n2].length != 2) {
                                            this.changed = 1;
                                            this.possibilities_arr[n1] = ui.toString() + uj.toString();
                                            this.possibilities_arr[n2] = ui.toString() + uj.toString();
                                        }
                                    }
                                }
                                // break; // This is intentionally commented out.
                            case 6:
                                /*
								var ns = parseInt(uses[ui].substr(0, 2));
                                var nm = parseInt(uses[ui].substr(2, 2));
                                var ne = parseInt(uses[ui].substr(uses[ui].length - 2, 2));
								*/
								var ns = parseInt(uses[ui].substr(0, 2),10);
                                var nm = parseInt(uses[ui].substr(2, 2),10);
                                var ne = parseInt(uses[ui].substr(uses[ui].length - 2, 2),10);
                                if (((ns / 3 | 0) == (ne / 3 | 0)) ||
                                    (ns % 9 == ne % 9 && (ns / 27 | 0) == (ne / 27 | 0) && nm % 9 == ns % 9)) {
                                    var start = [ns - ns % 9, ns % 9, ns - ns % 27 + ns % 9 - ns % 3];
                                    var end = [start[0] + 9, 81, start[2] + 21];
                                    var incr = [1, 9, 1];
                                    var uidx = idx < 2 ? 2 : ((ns / 3 | 0) == (ne / 3 | 0)) ? 0 : 1;
                                    for (var j = start[uidx]; j < end[uidx]; j += uidx == 2 && j % 3 == 2 ? 7 : incr[uidx]) {
                                        if (j == ns || j == nm || j == ne) continue;
                                        var l = this.possibilities_arr[j].length;
                                        this.possibilities_arr[j] = this.possibilities_arr[j].replace(ui.toString(), '');
                                        if (!this.changed && this.possibilities_arr[j].length != l) {
                                            this.changed = 1;
                                        }
                                    }
                                }
                                break;
                        }
                    }
                }
            }
        }
        this.debug();
        this.guess();
    },
    curr_guess: 0,
    validGuess: function (i, n) {
        var start = [i - i % 9, i % 9, i - i % 27 + i % 9 - i % 3];
        var end = [start[0] + 9, 81, start[2] + 21];
        var incr = [1, 9, 1];
        for (var idx = 0; idx < 3; idx++) {
            for (var j = start[idx]; j < end[idx]; j += idx == 2 && j % 3 == 2 ? 7 : incr[idx]) {
                if (j == i) continue;
                if (this.puzzle_arr[j] == n) {
                    return false;
                }
            }
        }
        return true;
    },
    fullCheck: function () {
        for (var i = 0; i < 81; i++) {
            if (!this.validGuess(i, this.puzzle_arr[i])) return false;
        }
        return true;
    },
    guess: function () {
        if (!document.getElementById("mark") || document.getElementById("mark").checked == false) {
            if (this.solved_arr[this.curr_guess] != 1) {
                var nx = 0;
                if (this.puzzle_arr[this.curr_guess]) {
                    nx = this.possibilities_arr[this.curr_guess].indexOf(this.puzzle_arr[this.curr_guess].toString()) + 1;
                }
                if (nx < this.possibilities_arr[this.curr_guess].length) {
                   // var sn = this.possibilities_arr[this.curr_guess][nx];
				   var sn = this.possibilities_arr[this.curr_guess].charAt(nx);
                    document.getElementById('c' + (this.curr_guess + 1)).value = sn;
                    this.puzzle_arr[this.curr_guess] = parseInt(sn);
                    if (this.validGuess(this.curr_guess, parseInt(sn))) {
                        this.curr_guess++;
                    }
                } else {
                    document.getElementById('c' + (this.curr_guess + 1)).value = '';
                    delete this.puzzle_arr[this.curr_guess];
                    do {
                        this.curr_guess--;
                    } while (this.solved_arr[this.curr_guess] == 1);
                    if (this.curr_guess < 0) {
                        alert('This Sudoku puzzle cannot be solved');
                        return;
                    }
                }
            } else {
                while (this.solved_arr[this.curr_guess] == 1) {
                    this.curr_guess++;
                }
            }
            if (this.curr_guess == 81) {
                // Do we need to check if it is solved?
                if (this.fullCheck()) {
                    if (this.inDebug) alert((new Date).toISOString().replace('T', ' ').replace('Z', ' '));
                    //alert('Puzzle has been successfully solved. You can also share this puzzle.');
                    symmetry=check_symmetry();
					//alert(symmetry+" hello ");
					if (symmetry==1) 
					{
						//alert("simetrical");
						
						//check difficult level, determine rand size
						rand_dif=0;
						new_difficult=2;
						//select_difficult
						if ((new_difficult>0)&&(new_difficult<5))//if later want to add a new difficult level, change here lets say to 6
						{
							difficulty=new_difficult;//new difficult chosen
							document.getElementById('difficult_hidden').value=difficulty;//for later ajax use
						}
						//else dont change anything
						//alert(difficulty);//remove later. Check when choosing dont know, check different difficult than the chosen.
						switch (difficulty)
						{
							case 1:
							rand_dif=3;//5->23/10/14 ,56,110,127~%20
							break
							
							case 2:
							rand_dif=10;//10->23/10/14 ,110,127~%30//%20
							break;
							
							case 3:
							rand_dif=3;//2;//56,110,127~%50
							break;
							
							case 4:
							rand_dif=0;//10~%100
							break;
						}
						//alert(difficulty+"- - "+rand_dif);
						//rand_dif=0;//remove later
						if (Math.floor(Math.random()*rand_dif)==0) 
						{
							//alert("send ajax");
							send_ajax();//only if falls into the rand(will reduce total new puzzles)
						}
						//if (Math.floor(Math.random()*rand_dif==0)) send_ajax();//only if falls into the rand(will reduce total new puzzles)
						else 
							{
								document.getElementById('share_sudoku').style.display='';
							}
												}//if (symmetry==1)
					else 
						{
							document.getElementById('share_sudoku').style.display='';
						}
											alert('Puzzle has been successfully solved. You can also share this puzzle.');
					//else alert("not simetrical");
                } else {
                    alert('This Sudoku puzzle cannot be solved');
                }
                return;
            }
            if (this.max_iter-- < 0) return;
            if (!(this.curr_guess >= 0 && this.curr_guess < 82)) { alert('Out of bounds: ' + this.curr_guess); return; }
            window.setTimeout('solver.guess();', 1);
        }
    },
    version: 1
}


function solution()
{
	solver.init();
}

function delete_marking(id)
{
	if (document.getElementById('c'+id).value.length==0)
	{
		document.getElementById('cell'+id).bgColor= '#FFFFFF';
	}
	//look for red flags, there can be only 2
}
function move(e,id)
{
	
	if(window.event) key = window.event.keyCode; // IE
	else key = e.which; // standard (ff)
	//left=37
	//right=39
	//up=38
	//down=40
	if (key==37)//left
	{
		if ((id==1)||(id==10)||(id==19)||(id==28)||(id==37)||(id==46)||(id==55)||(id==64)||(id==73))
		{
			//don't move left
		}
		else
		{
			//delete after checking
			//check how to act on readonly field
			//move 1 cell left
			document.getElementById('c'+(id-1)).focus();
			//document.getElementById('c'+(id-1)).select();
		}
	}
	else if (key==39)//right
	{
		if ((id==9)||(id==18)||(id==27)||(id==36)||(id==45)||(id==54)||(id==63)||(id==72)||(id==81))
		{
			//don't move left
		}
		else
		{
			//move 1 cell right
			tmp_id=id;
			tmp_id++;
			//alert(tmp_id);
			document.getElementById('c'+tmp_id).focus();
		}
	}
	else if (key==38)//up
	{
		if ((id==1)||(id==2)||(id==3)||(id==4)||(id==5)||(id==6)||(id==7)||(id==8)||(id==9))
		{
			//don't move left
		}
		else
		{
			//move 1 cell right
			tmp_id=id;
			tmp_id-=9;
			//alert(tmp_id);
			document.getElementById('c'+tmp_id).focus();
		}
	}
	else if (key==40)//down
	{
		if ((id==73)||(id==74)||(id==75)||(id==76)||(id==77)||(id==78)||(id==79)||(id==80)||(id==81))
		{
			//don't move left
		}
		else
		{
			//move 1 cell right
			
			//tmp_id=id;
			tmp_id=parseInt(id);
			tmp_id=tmp_id+9;
			//alert(tmp_id);
			document.getElementById('c'+tmp_id).focus();
		}
	}
}

function valid_number(e,tmp_cell)
{
	var key;
	var keychar;
	//tmp=tmp_cell;
	//tmp_cell='cell'+tmp_cell;
	if (window.event) key = window.event.keyCode;
	else if (e) 
	{
		//alert(e.which);
		key = e.which;
	}
	else return true;
	//save_change('save_list');//when keypressed inside cell make update available
	
	keychar = String.fromCharCode(key);
	//alert(key);
	if (("123456789").indexOf(keychar) > -1) 
	{
		document.getElementById(tmp_cell).bgColor= '#E5E5E5';

		return true;
	}
	else if ((key==8)||(key==0)) 
	{
		if (document.getElementById(tmp_cell).value.length==0) document.getElementById(tmp_cell).bgColor= '#FFFFFF';

		return true;
	}
	else return false;
	
}
function send_ajax()//communicate with server
{
	//alert("sending ajax");
	var xmlhttp;
	solution_str="";
	shown_str="";
	
	for (i=1;i<82;i++) 
	{
		if (shown_arr1[i-1]>0) shown_str+="1";
		else shown_str+="0";
		
		solution_str+=document.getElementById('c'+i).value;
	}
	//alert (shown_str);
	//alert (solution_str);
	
	//var params = "shown_str="+shown_str+"&solution_str="+solution_str;
	//var params = "shown_str="+shown_str+"&solution_str="+solution_str+"&symmetry=1";
	difficult=document.getElementById('difficult_hidden').value;//might be empty
	var params = "shown_str="+shown_str+"&solution_str="+solution_str+"&symmetry=1&difficult="+difficult;
	if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Your browser does not support XMLHTTP!");
	}
	
	xmlhttp.onreadystatechange=function()//what to do with Data recived fromserver
	{
		if(xmlhttp.readyState==4)//complete to recieve data
		{
			//alert("finish sending "+xmlhttp.responseText);
							document.getElementById('share_sudoku').style.display='';
				document.getElementById('sharing_div').style.display='none';
				
				document.getElementById('go_to_puzzle').style.display='';
				
				//document.getElementById('sharing_div').style.display='none';
				
				//tmp_str=xmlhttp.responseText;
				document.getElementById("go_to_puzzle").innerHTML ='<a href="'+xmlhttp.responseText+'"><img src="pictures/upload-sudoku.png" width="20" height="18" border="0"><b> Share Sudoku</b></a>';
							
		}
	}
	xmlhttp.open("POST","ajax_upload_sudoku.php",true);//the script to run an who to send data(GET/POST)
	//xmlhttp.send(null);
	//Send the proper header information along with the request
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", params.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(params);
	
}

function ajax_upload_sudoku()//communicate with server
{
	var xmlhttp;
	solution_str="";
	shown_str="";
	
	document.getElementById('searching_animate').style.display='';
	document.getElementById('sharing_div').style.display='none';
	//
	//create shown str
	/*for (i=1;i<4;i++) 
	{
			alert(shown_arr1[i]);
	}
	*/
	for (i=1;i<82;i++) 
	{
		if (shown_arr1[i-1]>0) shown_str+="1";
		else shown_str+="0";
		
		solution_str+=document.getElementById('c'+i).value;
	}
	//alert (shown_str);
	//alert (solution_str);
	
	var params = "shown_str="+shown_str+"&solution_str="+solution_str+"&symmetry=0";
	if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Your browser does not support XMLHTTP!");
	}
	
	xmlhttp.onreadystatechange=function()//what to do with Data recived fromserver
	{
		if(xmlhttp.readyState==4)//complete to recieve data
		{
			//xmlhttp.responseText;// response string
			//alert(xmlhttp.responseText);
			//var b = xmlhttp.responseText;
			//var temp = new Array();
			//temp = b.split('&');
			
			document.getElementById('searching_animate').style.display='none';
			document.getElementById('go_to_puzzle').style.display='';
			//tmp_str=xmlhttp.responseText;
			document.getElementById("go_to_puzzle").innerHTML ='<a href="'+xmlhttp.responseText+'"><img src="pictures/upload-sudoku.png" width="20" height="18" border="0"><b> Go To Puzzle</b></a>';
			//confirm
			var x=window.confirm("Upload complete! Would you like to view your puzzle online?")
			if (x)
			{
				window.location = xmlhttp.responseText;
				//return true;
			}
			else
			{
				//return false;
			}
			//show here hash and id of puzzle to check it out
			//document.getElementById("times_used").innerHTML =xmlhttp.responseText+" hands checked!";
		}
	}
	xmlhttp.open("POST","ajax_upload_sudoku.php",true);//the script to run an who to send data(GET/POST)
	//xmlhttp.send(null);
	//Send the proper header information along with the request
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", params.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(params);
	
}

</script>
</head>

<body leftmargin="0" topmargin="0" onLoad="javascript:repaint(); if (check_grid()) solution();">
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.4&appId=622097744505434";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td colspan="2" align="center"> 
      <!-- Casale Media: 728x90 (Banner) -->
<script type="text/javascript">
var CasaleArgs = new Object();
CasaleArgs.version = 2;
CasaleArgs.adUnits = "2";
CasaleArgs.casaleID = 64157;
</script>
<script type="text/javascript" src="http://js.casalemedia.com/casaleJTag.js"></script>
<!-- DO NOT MODIFY --><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:14px;"><tr><td rowspan="2" nowrap="nowrap"><a href="/"><img src="pictures/head2.png" width="372" height="61" border="0" title="" alt="" style="margin-right:8px"></a></td><td width="100%" align="left">    <div style="direction:ltr">
        <a href="signup.php?ln=en" rel="nofollow"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">﻿Sign up</font></a><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> | <a href="login.php?ln=en" rel="nofollow">Log In</a></font> 
        </div>
    </td><td rowspan="2" align="right" nowrap="nowrap"><img src="pictures/sudoku-logo.png" width="201" height="61" /></td></tr>
  <tr>
    <td height="100%" align="left" valign="bottom">
    
    &nbsp;</td>
  </tr>
</table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td width="20%" align="left" valign="top"> 
      <style type="text/css">
/*SPRITES*/
.sprite-menu {background:url(pictures/csg-5199d41e7a0e2.png);}

.sprite-menu-menu1_03{ background-position: 0 0; width: 12px; height: 12px; } 
.sprite-menu-small-sudoku{ background-position: 0 -62px; width: 15px; height: 15px; } 
.sprite-menu-sudoku-book{ background-position: 0 -127px; width: 16px; height: 14px; } 
.sprite-menu-sudoku-favorites{ background-position: 0 -191px; width: 21px; height: 22px; } 
.sprite-menu-sudoku-rules{ background-position: 0 -263px; width: 16px; height: 16px; } 
.sprite-menu-sudoku-solver{ background-position: 0 -329px; width: 15px; height: 15px; } 
.sprite-menu-upload-sudoku{ background-position: 0 -394px; width: 20px; height: 18px; } 
</style>
<table border="0" cellspacing="0" cellpadding="0" style="margin-top:37px"><tr><td><table width="100%" border="0" cellspacing="1" cellpadding="2" style="font-family:Verdana, Geneva, sans-serif; font-size:14px; border:#666 1px solid;"><tr><td width="10%" valign="top"><img src="pictures/transparent.gif" class="sprite-menu sprite-menu-small-sudoku" alt=""></td><td width="90%"><a href="/">Sudoku</a></td></tr><tr><td valign="top"><img src="pictures/transparent.gif" class="sprite-menu sprite-menu-sudoku-rules"></td><td><a href="rules/en">Rules</a></td></tr><tr><td valign="top" nowrap><img src="pictures/transparent.gif" class="sprite-menu sprite-menu-sudoku-solver"></td><td><a href="sudoku-solver/en" style="color:#000">Solver</a></td></tr>
    <tr>
      <td valign="top" nowrap><img src="pictures/scoreboard.png" width="16" height="16"></td><td><a href="/hall-of-fame.php?ln=en&get_user_id=" style="color:#000">﻿Scoreboard</a></td></tr> </table></td></tr></table>	      </td>
    <td width="80%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td> <form name="form1" method="post" action="sudoku-solver/en">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
                  <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif">
                                                <tr> 
                        <td width="328" align="center" valign="top"><h1><u>Sudoku solver</u></h1>
                        <div style=" font-size:12px; margin-bottom:10px; margin-top:10px; text-align:left">
                        Enter Sudoku puzzle numbers you found in the newspaper or on other websites and click the solve puzzle button, to get the right solution. Please note that the harder the puzzle is, the longer it would take to solve it.                        </div></td>
                        <td valign="top">&nbsp;</td>
                        <td align="right" valign="top">&nbsp;</td>
                      </tr>
                                                
                      
                      <tr> 
                        <td width="328" valign="top">
						 <table width="70%" cellpadding="0" cellspacing="2" bgcolor="#000000">
                                                                    <tr> 
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell1" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c1" id="c1"											
										onKeyPress="return valid_number(event,'cell1')" onKeyUp="delete_marking(1)" onKeyDown="move(event,'1')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell2" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c2" id="c2"											
										onKeyPress="return valid_number(event,'cell2')" onKeyUp="delete_marking(2)" onKeyDown="move(event,'2')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell3" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c3" id="c3"											
										onKeyPress="return valid_number(event,'cell3')" onKeyUp="delete_marking(3)" onKeyDown="move(event,'3')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell10" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c10" id="c10"											
										onKeyPress="return valid_number(event,'cell10')" onKeyUp="delete_marking(10)" onKeyDown="move(event,'10')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell11" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c11" id="c11"											
										onKeyPress="return valid_number(event,'cell11')" onKeyUp="delete_marking(11)" onKeyDown="move(event,'11')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell12" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c12" id="c12"											
										onKeyPress="return valid_number(event,'cell12')" onKeyUp="delete_marking(12)" onKeyDown="move(event,'12')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell19" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c19" id="c19"											
										onKeyPress="return valid_number(event,'cell19')" onKeyUp="delete_marking(19)" onKeyDown="move(event,'19')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell20" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c20" id="c20"											
										onKeyPress="return valid_number(event,'cell20')" onKeyUp="delete_marking(20)" onKeyDown="move(event,'20')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell21" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c21" id="c21"											
										onKeyPress="return valid_number(event,'cell21')" onKeyUp="delete_marking(21)" onKeyDown="move(event,'21')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell4" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c4" id="c4"											
										onKeyPress="return valid_number(event,'cell4')" onKeyUp="delete_marking(4)" onKeyDown="move(event,'4')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell5" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c5" id="c5"											
										onKeyPress="return valid_number(event,'cell5')" onKeyUp="delete_marking(5)" onKeyDown="move(event,'5')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell6" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c6" id="c6"											
										onKeyPress="return valid_number(event,'cell6')" onKeyUp="delete_marking(6)" onKeyDown="move(event,'6')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell13" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c13" id="c13"											
										onKeyPress="return valid_number(event,'cell13')" onKeyUp="delete_marking(13)" onKeyDown="move(event,'13')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell14" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c14" id="c14"											
										onKeyPress="return valid_number(event,'cell14')" onKeyUp="delete_marking(14)" onKeyDown="move(event,'14')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell15" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c15" id="c15"											
										onKeyPress="return valid_number(event,'cell15')" onKeyUp="delete_marking(15)" onKeyDown="move(event,'15')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell22" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c22" id="c22"											
										onKeyPress="return valid_number(event,'cell22')" onKeyUp="delete_marking(22)" onKeyDown="move(event,'22')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell23" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c23" id="c23"											
										onKeyPress="return valid_number(event,'cell23')" onKeyUp="delete_marking(23)" onKeyDown="move(event,'23')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell24" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c24" id="c24"											
										onKeyPress="return valid_number(event,'cell24')" onKeyUp="delete_marking(24)" onKeyDown="move(event,'24')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell7" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c7" id="c7"											
										onKeyPress="return valid_number(event,'cell7')" onKeyUp="delete_marking(7)" onKeyDown="move(event,'7')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell8" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c8" id="c8"											
										onKeyPress="return valid_number(event,'cell8')" onKeyUp="delete_marking(8)" onKeyDown="move(event,'8')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell9" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c9" id="c9"											
										onKeyPress="return valid_number(event,'cell9')" onKeyUp="delete_marking(9)" onKeyDown="move(event,'9')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell16" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c16" id="c16"											
										onKeyPress="return valid_number(event,'cell16')" onKeyUp="delete_marking(16)" onKeyDown="move(event,'16')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell17" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c17" id="c17"											
										onKeyPress="return valid_number(event,'cell17')" onKeyUp="delete_marking(17)" onKeyDown="move(event,'17')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell18" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c18" id="c18"											
										onKeyPress="return valid_number(event,'cell18')" onKeyUp="delete_marking(18)" onKeyDown="move(event,'18')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell25" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c25" id="c25"											
										onKeyPress="return valid_number(event,'cell25')" onKeyUp="delete_marking(25)" onKeyDown="move(event,'25')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell26" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c26" id="c26"											
										onKeyPress="return valid_number(event,'cell26')" onKeyUp="delete_marking(26)" onKeyDown="move(event,'26')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell27" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c27" id="c27"											
										onKeyPress="return valid_number(event,'cell27')" onKeyUp="delete_marking(27)" onKeyDown="move(event,'27')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                      </tr>
                                                                    <tr> 
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell28" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c28" id="c28"											
										onKeyPress="return valid_number(event,'cell28')" onKeyUp="delete_marking(28)" onKeyDown="move(event,'28')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell29" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c29" id="c29"											
										onKeyPress="return valid_number(event,'cell29')" onKeyUp="delete_marking(29)" onKeyDown="move(event,'29')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell30" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c30" id="c30"											
										onKeyPress="return valid_number(event,'cell30')" onKeyUp="delete_marking(30)" onKeyDown="move(event,'30')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell37" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c37" id="c37"											
										onKeyPress="return valid_number(event,'cell37')" onKeyUp="delete_marking(37)" onKeyDown="move(event,'37')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell38" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c38" id="c38"											
										onKeyPress="return valid_number(event,'cell38')" onKeyUp="delete_marking(38)" onKeyDown="move(event,'38')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell39" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c39" id="c39"											
										onKeyPress="return valid_number(event,'cell39')" onKeyUp="delete_marking(39)" onKeyDown="move(event,'39')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell46" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c46" id="c46"											
										onKeyPress="return valid_number(event,'cell46')" onKeyUp="delete_marking(46)" onKeyDown="move(event,'46')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell47" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c47" id="c47"											
										onKeyPress="return valid_number(event,'cell47')" onKeyUp="delete_marking(47)" onKeyDown="move(event,'47')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell48" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c48" id="c48"											
										onKeyPress="return valid_number(event,'cell48')" onKeyUp="delete_marking(48)" onKeyDown="move(event,'48')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell31" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c31" id="c31"											
										onKeyPress="return valid_number(event,'cell31')" onKeyUp="delete_marking(31)" onKeyDown="move(event,'31')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell32" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c32" id="c32"											
										onKeyPress="return valid_number(event,'cell32')" onKeyUp="delete_marking(32)" onKeyDown="move(event,'32')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell33" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c33" id="c33"											
										onKeyPress="return valid_number(event,'cell33')" onKeyUp="delete_marking(33)" onKeyDown="move(event,'33')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell40" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c40" id="c40"											
										onKeyPress="return valid_number(event,'cell40')" onKeyUp="delete_marking(40)" onKeyDown="move(event,'40')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell41" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c41" id="c41"											
										onKeyPress="return valid_number(event,'cell41')" onKeyUp="delete_marking(41)" onKeyDown="move(event,'41')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell42" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c42" id="c42"											
										onKeyPress="return valid_number(event,'cell42')" onKeyUp="delete_marking(42)" onKeyDown="move(event,'42')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell49" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c49" id="c49"											
										onKeyPress="return valid_number(event,'cell49')" onKeyUp="delete_marking(49)" onKeyDown="move(event,'49')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell50" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c50" id="c50"											
										onKeyPress="return valid_number(event,'cell50')" onKeyUp="delete_marking(50)" onKeyDown="move(event,'50')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell51" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c51" id="c51"											
										onKeyPress="return valid_number(event,'cell51')" onKeyUp="delete_marking(51)" onKeyDown="move(event,'51')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell34" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c34" id="c34"											
										onKeyPress="return valid_number(event,'cell34')" onKeyUp="delete_marking(34)" onKeyDown="move(event,'34')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell35" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c35" id="c35"											
										onKeyPress="return valid_number(event,'cell35')" onKeyUp="delete_marking(35)" onKeyDown="move(event,'35')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell36" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c36" id="c36"											
										onKeyPress="return valid_number(event,'cell36')" onKeyUp="delete_marking(36)" onKeyDown="move(event,'36')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell43" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c43" id="c43"											
										onKeyPress="return valid_number(event,'cell43')" onKeyUp="delete_marking(43)" onKeyDown="move(event,'43')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell44" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c44" id="c44"											
										onKeyPress="return valid_number(event,'cell44')" onKeyUp="delete_marking(44)" onKeyDown="move(event,'44')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell45" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c45" id="c45"											
										onKeyPress="return valid_number(event,'cell45')" onKeyUp="delete_marking(45)" onKeyDown="move(event,'45')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell52" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c52" id="c52"											
										onKeyPress="return valid_number(event,'cell52')" onKeyUp="delete_marking(52)" onKeyDown="move(event,'52')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell53" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c53" id="c53"											
										onKeyPress="return valid_number(event,'cell53')" onKeyUp="delete_marking(53)" onKeyDown="move(event,'53')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell54" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c54" id="c54"											
										onKeyPress="return valid_number(event,'cell54')" onKeyUp="delete_marking(54)" onKeyDown="move(event,'54')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                      </tr>
                                                                    <tr> 
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell55" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c55" id="c55"											
										onKeyPress="return valid_number(event,'cell55')" onKeyUp="delete_marking(55)" onKeyDown="move(event,'55')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell56" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c56" id="c56"											
										onKeyPress="return valid_number(event,'cell56')" onKeyUp="delete_marking(56)" onKeyDown="move(event,'56')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell57" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c57" id="c57"											
										onKeyPress="return valid_number(event,'cell57')" onKeyUp="delete_marking(57)" onKeyDown="move(event,'57')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell64" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c64" id="c64"											
										onKeyPress="return valid_number(event,'cell64')" onKeyUp="delete_marking(64)" onKeyDown="move(event,'64')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell65" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c65" id="c65"											
										onKeyPress="return valid_number(event,'cell65')" onKeyUp="delete_marking(65)" onKeyDown="move(event,'65')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell66" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c66" id="c66"											
										onKeyPress="return valid_number(event,'cell66')" onKeyUp="delete_marking(66)" onKeyDown="move(event,'66')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell73" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c73" id="c73"											
										onKeyPress="return valid_number(event,'cell73')" onKeyUp="delete_marking(73)" onKeyDown="move(event,'73')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell74" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c74" id="c74"											
										onKeyPress="return valid_number(event,'cell74')" onKeyUp="delete_marking(74)" onKeyDown="move(event,'74')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell75" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c75" id="c75"											
										onKeyPress="return valid_number(event,'cell75')" onKeyUp="delete_marking(75)" onKeyDown="move(event,'75')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell58" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c58" id="c58"											
										onKeyPress="return valid_number(event,'cell58')" onKeyUp="delete_marking(58)" onKeyDown="move(event,'58')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell59" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c59" id="c59"											
										onKeyPress="return valid_number(event,'cell59')" onKeyUp="delete_marking(59)" onKeyDown="move(event,'59')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell60" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c60" id="c60"											
										onKeyPress="return valid_number(event,'cell60')" onKeyUp="delete_marking(60)" onKeyDown="move(event,'60')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell67" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c67" id="c67"											
										onKeyPress="return valid_number(event,'cell67')" onKeyUp="delete_marking(67)" onKeyDown="move(event,'67')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell68" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c68" id="c68"											
										onKeyPress="return valid_number(event,'cell68')" onKeyUp="delete_marking(68)" onKeyDown="move(event,'68')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell69" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c69" id="c69"											
										onKeyPress="return valid_number(event,'cell69')" onKeyUp="delete_marking(69)" onKeyDown="move(event,'69')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell76" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c76" id="c76"											
										onKeyPress="return valid_number(event,'cell76')" onKeyUp="delete_marking(76)" onKeyDown="move(event,'76')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell77" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c77" id="c77"											
										onKeyPress="return valid_number(event,'cell77')" onKeyUp="delete_marking(77)" onKeyDown="move(event,'77')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell78" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c78" id="c78"											
										onKeyPress="return valid_number(event,'cell78')" onKeyUp="delete_marking(78)" onKeyDown="move(event,'78')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                        <td width="33%" bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="2" bgcolor="#CCCCCC">
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell61" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c61" id="c61"											
										onKeyPress="return valid_number(event,'cell61')" onKeyUp="delete_marking(61)" onKeyDown="move(event,'61')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell62" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c62" id="c62"											
										onKeyPress="return valid_number(event,'cell62')" onKeyUp="delete_marking(62)" onKeyDown="move(event,'62')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell63" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c63" id="c63"											
										onKeyPress="return valid_number(event,'cell63')" onKeyUp="delete_marking(63)" onKeyDown="move(event,'63')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell70" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c70" id="c70"											
										onKeyPress="return valid_number(event,'cell70')" onKeyUp="delete_marking(70)" onKeyDown="move(event,'70')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell71" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c71" id="c71"											
										onKeyPress="return valid_number(event,'cell71')" onKeyUp="delete_marking(71)" onKeyDown="move(event,'71')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell72" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c72" id="c72"											
										onKeyPress="return valid_number(event,'cell72')" onKeyUp="delete_marking(72)" onKeyDown="move(event,'72')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                                <tr bgcolor="#FFFFFF"> 
                                                                                    <td id="cell79" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c79" id="c79"											
										onKeyPress="return valid_number(event,'cell79')" onKeyUp="delete_marking(79)" onKeyDown="move(event,'79')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell80" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c80" id="c80"											
										onKeyPress="return valid_number(event,'cell80')" onKeyUp="delete_marking(80)" onKeyDown="move(event,'80')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                    <td id="cell81" bgcolor=""> 

                                            <input type="text" class="i2" size="1" maxlength="1" name="c81" id="c81"											
										onKeyPress="return valid_number(event,'cell81')" onKeyUp="delete_marking(81)" onKeyDown="move(event,'81')" 
									 readonly AUTOCOMPLETE="off"></td>
                                                                                  </tr>
                                                                              </table></td>
                                                                      </tr>
                                                                  </table>
                        </td>
                        <td width="4" valign="top">&nbsp;</td>
                        <td valign="top"> 
                        <table width="1" border="0" cellspacing="0" cellpadding="0">
                          <tr valign="top">
                            <td>
                            <table width="50%" border="0" cellspacing="0" cellpadding="4">
                            <tr> 
                              <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px; font-family:Verdana, Geneva, sans-serif;">
                              							  									<tr id="share_sudoku" style="display:none"> 
                                    <td nowrap>
                                    <div style=" margin-bottom:10px;" id="sharing_div">
                                    <a href="javascript:ajax_upload_sudoku();"><img src="pictures/upload-sudoku.png" width="20" height="18" border="0" title="Puzzle has been successfully solved"><b><font color="#000000" size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                      Share Sudoku</font></b></a>
                                    </div>
                                    <div id="searching_animate" style=" display:none;font-family:Verdana, Geneva, sans-serif; font-size:10px;margin-bottom:10px;">
    <img src="pictures/upload-sudoku.png" width="20" height="18" border="0" title="Puzzle has been successfully solved"> Sharing<img src="pictures/loading_animation.gif" width="30" height="30" align="absmiddle" />
    </div>
    <div style=" margin-bottom:10px;font-family:Verdana, Geneva, sans-serif; font-size:12px; display:none" id="go_to_puzzle">
                                    
                                    </div>
                                   </td>
                                  </tr>                              
							                                                                      <tr> 
                                    <td nowrap><input type="checkbox" name="mark" value="checkbox" id="mark" onClick="stop_control();"> 
                                      <font size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                                      Stop</font></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td nowrap> <p><A HREF="javascript:change_puzzle();"><img src="pictures/small-sudoku.png" width="15" height="15" border="0" title="Change initial puzzle"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                                    Change initial puzzle</font></a> </p></td>
                                  </tr>                                  <tr> 
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td nowrap><a href="sudoku-solver/en" title="Blank puzzle"><img src="pictures/blank-sudoku.png" width="15" height="15" border="0" title="Blank puzzle"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                                      Blank puzzle</font></a></td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td nowrap><A HREF="javascript:;" onClick="javascript:
									win=window.open('','myWin','width=560,height=550,scrollbars=yes,left=100,top=0'); 
									form1.target='myWin';
									form1.action='print-sudoku.php?ln=en&p=Print&type=1'
									document.form1.submit();
									"><img src="pictures/printer.png" width="15" height="17" border="0" title="Print"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                                      Print</font></a></td>
                                  </tr>
                                  <tr>
                                    <td nowrap>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td nowrap>
                                    <div class="fb-like" data-href="http://www.sudoku.name/sudoku-solver/en" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false" style="float:left;"></div>
                                    </td>
                                  </tr>
                                   <tr>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td nowrap>
                                    <div class="g-plusone" data-href="http://www.sudoku.name/sudoku-solver/en" data-size="medium" data-width="120px" data-align="left"></div>
                                   </td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td nowrap><a href="https://twitter.com/share" class="twitter-share-button" data-url="http://www.sudoku.name/sudoku-solver/en" data-text="Sudoku solver" data-via="SudokuName">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script></td>
                                  </tr>
                                </table></td>
                            </tr>
                          </table>
                          </td>
                            <td>
                             
							
							<div style="margin-left:50px;">
                            <script type="text/javascript"><!--
							google_ad_client = "pub-5027040478877022";
							google_ad_width = 336;
							google_ad_height = 280;
							google_ad_format = "336x280_as";
							google_ad_type = "text_image";
							google_ad_channel ="";
							google_color_border = "ffffff";
							google_color_bg = "ffffff";
							google_color_link = "000000";
							google_color_url = "000000";
							google_color_text = "000000";
							//--></script> <script type="text/javascript"
							  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
							</script>
                            </div>
							
							
                           
                            
</td>
                          </tr>
                        </table>

                        
                        
                          <input name="difficult_hidden" type="hidden" id="difficult_hidden">
                          <input name="sudoku_symmetry" type="hidden" id="sudoku_symmetry">
						  <input name="solve" type="hidden" id="solve">
						  <input name="change" type="hidden" id="change">							<input name="hidden_c1" type="hidden" id="hidden_c1" value="">
														<input name="hidden_c2" type="hidden" id="hidden_c2" value="">
														<input name="hidden_c3" type="hidden" id="hidden_c3" value="">
														<input name="hidden_c4" type="hidden" id="hidden_c4" value="">
														<input name="hidden_c5" type="hidden" id="hidden_c5" value="">
														<input name="hidden_c6" type="hidden" id="hidden_c6" value="">
														<input name="hidden_c7" type="hidden" id="hidden_c7" value="">
														<input name="hidden_c8" type="hidden" id="hidden_c8" value="">
														<input name="hidden_c9" type="hidden" id="hidden_c9" value="">
														<input name="hidden_c10" type="hidden" id="hidden_c10" value="">
														<input name="hidden_c11" type="hidden" id="hidden_c11" value="">
														<input name="hidden_c12" type="hidden" id="hidden_c12" value="">
														<input name="hidden_c13" type="hidden" id="hidden_c13" value="">
														<input name="hidden_c14" type="hidden" id="hidden_c14" value="">
														<input name="hidden_c15" type="hidden" id="hidden_c15" value="">
														<input name="hidden_c16" type="hidden" id="hidden_c16" value="6">
														<input name="hidden_c17" type="hidden" id="hidden_c17" value="">
														<input name="hidden_c18" type="hidden" id="hidden_c18" value="">
														<input name="hidden_c19" type="hidden" id="hidden_c19" value="">
														<input name="hidden_c20" type="hidden" id="hidden_c20" value="">
														<input name="hidden_c21" type="hidden" id="hidden_c21" value="">
														<input name="hidden_c22" type="hidden" id="hidden_c22" value="">
														<input name="hidden_c23" type="hidden" id="hidden_c23" value="">
														<input name="hidden_c24" type="hidden" id="hidden_c24" value="5">
														<input name="hidden_c25" type="hidden" id="hidden_c25" value="">
														<input name="hidden_c26" type="hidden" id="hidden_c26" value="">
														<input name="hidden_c27" type="hidden" id="hidden_c27" value="">
														<input name="hidden_c28" type="hidden" id="hidden_c28" value="">
														<input name="hidden_c29" type="hidden" id="hidden_c29" value="">
														<input name="hidden_c30" type="hidden" id="hidden_c30" value="">
														<input name="hidden_c31" type="hidden" id="hidden_c31" value="">
														<input name="hidden_c32" type="hidden" id="hidden_c32" value="">
														<input name="hidden_c33" type="hidden" id="hidden_c33" value="">
														<input name="hidden_c34" type="hidden" id="hidden_c34" value="">
														<input name="hidden_c35" type="hidden" id="hidden_c35" value="">
														<input name="hidden_c36" type="hidden" id="hidden_c36" value="">
														<input name="hidden_c37" type="hidden" id="hidden_c37" value="">
														<input name="hidden_c38" type="hidden" id="hidden_c38" value="">
														<input name="hidden_c39" type="hidden" id="hidden_c39" value="">
														<input name="hidden_c40" type="hidden" id="hidden_c40" value="">
														<input name="hidden_c41" type="hidden" id="hidden_c41" value="">
														<input name="hidden_c42" type="hidden" id="hidden_c42" value="">
														<input name="hidden_c43" type="hidden" id="hidden_c43" value="">
														<input name="hidden_c44" type="hidden" id="hidden_c44" value="">
														<input name="hidden_c45" type="hidden" id="hidden_c45" value="">
														<input name="hidden_c46" type="hidden" id="hidden_c46" value="">
														<input name="hidden_c47" type="hidden" id="hidden_c47" value="">
														<input name="hidden_c48" type="hidden" id="hidden_c48" value="">
														<input name="hidden_c49" type="hidden" id="hidden_c49" value="">
														<input name="hidden_c50" type="hidden" id="hidden_c50" value="">
														<input name="hidden_c51" type="hidden" id="hidden_c51" value="">
														<input name="hidden_c52" type="hidden" id="hidden_c52" value="">
														<input name="hidden_c53" type="hidden" id="hidden_c53" value="">
														<input name="hidden_c54" type="hidden" id="hidden_c54" value="">
														<input name="hidden_c55" type="hidden" id="hidden_c55" value="">
														<input name="hidden_c56" type="hidden" id="hidden_c56" value="">
														<input name="hidden_c57" type="hidden" id="hidden_c57" value="">
														<input name="hidden_c58" type="hidden" id="hidden_c58" value="">
														<input name="hidden_c59" type="hidden" id="hidden_c59" value="">
														<input name="hidden_c60" type="hidden" id="hidden_c60" value="">
														<input name="hidden_c61" type="hidden" id="hidden_c61" value="">
														<input name="hidden_c62" type="hidden" id="hidden_c62" value="">
														<input name="hidden_c63" type="hidden" id="hidden_c63" value="">
														<input name="hidden_c64" type="hidden" id="hidden_c64" value="">
														<input name="hidden_c65" type="hidden" id="hidden_c65" value="">
														<input name="hidden_c66" type="hidden" id="hidden_c66" value="">
														<input name="hidden_c67" type="hidden" id="hidden_c67" value="">
														<input name="hidden_c68" type="hidden" id="hidden_c68" value="">
														<input name="hidden_c69" type="hidden" id="hidden_c69" value="">
														<input name="hidden_c70" type="hidden" id="hidden_c70" value="">
														<input name="hidden_c71" type="hidden" id="hidden_c71" value="">
														<input name="hidden_c72" type="hidden" id="hidden_c72" value="">
														<input name="hidden_c73" type="hidden" id="hidden_c73" value="">
														<input name="hidden_c74" type="hidden" id="hidden_c74" value="">
														<input name="hidden_c75" type="hidden" id="hidden_c75" value="">
														<input name="hidden_c76" type="hidden" id="hidden_c76" value="">
														<input name="hidden_c77" type="hidden" id="hidden_c77" value="">
														<input name="hidden_c78" type="hidden" id="hidden_c78" value="">
														<input name="hidden_c79" type="hidden" id="hidden_c79" value="">
														<input name="hidden_c80" type="hidden" id="hidden_c80" value="">
														<input name="hidden_c81" type="hidden" id="hidden_c81" value="">
							</td>
                      </tr>
                                                  <tr>
                            <td colspan="3" valign="top">
                            <div style="margin-top:0px">
                            <div style="  font-size:12px; direction:ltr; text-align:left; float:left; font-family:Verdana, Geneva, sans-serif; margin-top:15px;">
                                        <div style=" font-size:12px; text-decoration:underline; margin-bottom:12px; text-align:center">
                  New Uploads:
                  </div>
                           <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139194/88a839f2f6f1427879fc33ee4acf4f66';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">9</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">3</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">7</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">5</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">1</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139194/88a839f2f6f1427879fc33ee4acf4f66';">
                              Easy</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent">									
        
          </div>
          
          
       
        

				         <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139180/44968aece94f667e4095002d140b5896';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">5</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">4</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">3</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">9</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139180/44968aece94f667e4095002d140b5896';">
                              Easy</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent">									
        
          </div>
          
          
       
        

				         <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139178/c61aed648da48aa3893fb3eaadd88a7f';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">2</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">4</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139178/c61aed648da48aa3893fb3eaadd88a7f';">
                              Hard++</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent">									
        
          </div>
          
          
       
        

				         <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139169/bba6bca05fecde04c682328e44b974b7';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">1</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">2</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">4</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">9</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139169/bba6bca05fecde04c682328e44b974b7';">
                              Hard++</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Good"><img src="pictures/star.png" border="0" title="Good"><img src="pictures/star.png" border="0" title="Good"><img src="pictures/star.png" border="0" title="Good"><img src="pictures/half-star.png" title="Good">									
        
          </div>
          
          
       
        

				         <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139166/a87c11b9100c608b7f8e98cfa316ff7b';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">8</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">2</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">1</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">6</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">7</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">5</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">3</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">4</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">9</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139166/a87c11b9100c608b7f8e98cfa316ff7b';">
                              Hard</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent">									
        
          </div>
          
          
       
        

				         <div style=" float:left; text-align:center; font-size:12px; margin-right:5px; direction:ltr">
          
          <table style=" font-family:Verdana, Geneva, sans-serif; font-size:9px;" width="1%" height="1%" border="0" cellpadding="0" cellspacing="0" id="table_"  onmouseover="javascript:this.style.cursor='pointer';" onClick="javascript:
            window.location = '/puzzles/en/u139165/912d2b1c7b2826caf99687388d2e8f7c';">
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">1</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">5</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                                <tr> 
                                                                    <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap><img src="pictures/spacer-white.gif" width="10" height="10"></td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                  <td width="10" height="10" align="center" nowrap bgcolor="#E5E5E5">9</td>                                  <td width="1" background="pictures/spacer-black.gif"><img src="pictures/spacer-black.gif" width="1" height="100%"></td>
                                                                  </tr>
                                                                <tr> 
                                  <td colspan="7"><img src="pictures/spacer-black.gif" width="100%" height="1"></td>
                                </tr>
                                                    </table>
          
		  
          </div>
          
          <div style="float:left; margin-right:20px; ">
          
          <a href="javascript:window.location = '/puzzles/en/u139165/912d2b1c7b2826caf99687388d2e8f7c';">
                              Hard</a>
          
          <table width="1" border="0" cellspacing="0" cellpadding="0" style=" font-size:10px">
          <tr>
            <td nowrap>10-</td>
            <td nowrap>Apr</td>
            <td nowrap>-2016</td>
          </tr>
        </table>
        
        
         									
									<img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent"><img src="pictures/star.png" border="0" title="Excellent">									
        
          </div>
          
          
       
        

				                    <div style=" clear:both; height:10px;"></div>
                  <div style=" text-align:center">
                  <img src="pictures/more.png" alt="More Sudoku Puzzles" title="More Uploads" border="0" /> <a href="more/en/0/0/" rel="nofollow">More Uploads</a>
                  </div>
                  
                                        
                  
                  </div>
                            </div></td>
                            </tr>
                                                                    </table>
                    
                  </td>
                  <td width="100%" valign="top">&nbsp;</td>
  </tr>
</table>
            </form></td>
        </tr>
      </table></td>
  </tr>
  <tr align="center"> 
    <td colspan="2"><br> 
      <div style=" font-family:Verdana, Geneva, sans-serif; font-size:12px; width:780px; text-align:center; margin-top:15px">
<div style="font-weight:bold">
<a href="/">Sudoku</a>
	 | 
    <a href="index-es.php">Español</a>
        | 
	<a href="index-pt.php" >Português</a>
	  | 
	<a href="index-de.php">Deutsch</a> 
	 | 
	<a href="index-ru.php">Судоку</a> 
	| 
    <a href="index-nl.php">Nederlands</a>
	| 
    <a href="index-it.php">Italiano</a>
	| 
    <a href="index-fr.php">Français</a>
        | 
	<a href="index-sk.php">Slovenský</a>
        | 
	<a href="index-bg.php">Български</a>
	| 
    <a href="index-pl.php">Polski</a>
        | 
	<a href="index-hb.php">סודוקו</a>
	| 
    <a href="index-ar.php">العربية</a>
	| 
    <a href="index-tr.php">Türkçe</a>
	| 
    <a href="index-el.php">Σουντόκου</a>
	| 
    <a href="index-jp.php">日本語</a>
	| 
    <a href="index-cn.php">數獨</a>
	| 
    <a href="index-ko.php">스도쿠</a>
	| 
    <a href="index-id.php">Bahasa Indonesia</a>
	| 
    <a href="index-th.php">ซูโดะกุ</a>
    | 
    <a href="all_lang.php">More languages</a>
</div>
    <br />
     	<a href="/contact-us.php?ln=en">contact us</a>
         <br /><br />
     ﻿© www.sudoku.name All rights reserved       <br/>
       2005-2015  
</div>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-244750-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
	//ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	//ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>    </td>
  </tr>
</table>
<!-- Place this tag in your head or just before your close body tag. this is G+ -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
</body>
</html>
