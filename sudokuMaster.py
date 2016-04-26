import random

def make_board(m=3):
    """Return a random filled m**2 x m**2 Sudoku board."""
    n = m ** 2
    board = [[None for _ in range(n)] for _ in range(n)]

    def search(c=0):
        i, j = divmod(c, n)
        i0, j0 = i - i % 3, j - j % 3  # Origin of mxm block
        numbers = list(range(1, n + 1))
        random.shuffle(numbers)
        for x in numbers:
            if (x not in board[i]  # row
                and all(row[j] != x for row in board)  # column
                and all(x not in row[j0:j0 + m]  # block
                        for row in board[i0:i])): 
                board[i][j] = x
                if c + 1 >= n ** 2 or search(c + 1):
                    return board
        else:
            # No number is valid in this cell: backtrack and try again.
            board[i][j] = None
            return None

    return search()

def puzzle_board(board):
    pass
    

def get_board(board):
    s = ""
    spacer = "++---+---+---++---+---+---++---+---+---++\n"
    s += spacer.replace('-', '=')
    for i, line in enumerate(board):
        s += ("|| {} | {} | {} || {} | {} | {} || {} | {} | {} ||\n"
            .format(*(cell or ' ' for cell in line)))
        if (i + 1) % 3 == 0: s += spacer.replace('-', '=')
        else: s += spacer
    return s


def create_puzzle(board,level):
    from copy import deepcopy
    size = len(board[0])
    members = range(0, size)
    puzzle = deepcopy(board)
    count = random.randrange(3, 5)
    for row in puzzle:
        if level == "easy_level":
            count = random.randrange(3, 5)
        elif level == "mediun_level":
            count = random.randrange(4, 6)
        elif level == "hard_level":
            count = random.randrange(5, 7)
            
        hidden = random.sample(members, count)
        
        for member in hidden:
            row[member] = 0
            
    return puzzle
    
def check_answer(board, puzzle, answer):
    results = []
    rows = len(board)
    cols = len(board[0])
    won = True
    
    for i in range(rows):
        tmp = []
        for j in range(cols):
            if puzzle[i][j] == 0:
                tmp.append(board[i][j] == answer[i][j])
            else:
                tmp.append(board[i][j])
        if won and False in tmp:
            won = False
        results.append(tmp)
        
    return (won, results)
