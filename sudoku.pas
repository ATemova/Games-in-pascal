program SudokuSolver;

const
  N = 9;

type
  TSudokuGrid = array[1..N, 1..N] of integer;

var
  grid: TSudokuGrid;

function IsSafe(grid: TSudokuGrid; row, col, num: integer): boolean;
var
  x, y, startRow, startCol: integer;
begin
  for x := 1 to N do
    if (grid[row, x] = num) or (grid[x, col] = num) then
      exit(false);
      
  startRow := row - (row - 1) mod 3;
  startCol := col - (col - 1) mod 3;

  for x := 0 to 2 do
    for y := 0 to 2 do
      if grid[startRow + x, startCol + y] = num then
        exit(false);

  IsSafe := true;
end;

function SolveSudoku(var grid: TSudokuGrid): boolean;
var
  row, col, num: integer;
  emptyFound: boolean;
begin
  emptyFound := false;
  
  for row := 1 to N do
  begin
    for col := 1 to N do
    begin
      if grid[row, col] = 0 then
      begin
        emptyFound := true;
        break;
      end;
    end;
    if emptyFound then break;
  end;

  if not emptyFound then
    exit(true);

  for num := 1 to 9 do
  begin
    if IsSafe(grid, row, col, num) then
    begin
      grid[row, col] := num;

      if SolveSudoku(grid) then
        exit(true);

      grid[row, col] := 0;
    end;
  end;

  SolveSudoku := false;
end;

procedure PrintGrid(grid: TSudokuGrid);
var
  row, col: integer;
begin
  for row := 1 to N do
  begin
    for col := 1 to N do
      write(grid[row, col]:2);
    writeln;
  end;
end;

begin
  grid := (
    (5, 3, 0, 0, 7, 0, 0, 0, 0),
    (6, 0, 0, 1, 9, 5, 0, 0, 0),
    (0, 9, 8, 0, 0, 0, 0, 6, 0),
    (8, 0, 0, 0, 6, 0, 0, 0, 3),
    (4, 0, 0, 8, 0, 3, 0, 0, 1),
    (7, 0, 0, 0, 2, 0, 0, 0, 6),
    (0, 6, 0, 0, 0, 0, 2, 8, 0),
    (0, 0, 0, 4, 1, 9, 0, 0, 5),
    (0, 0, 0, 0, 8, 0, 0, 7, 9)
  );

  if SolveSudoku(grid) then
    PrintGrid(grid)
  else
    writeln('No solution exists');
end.
