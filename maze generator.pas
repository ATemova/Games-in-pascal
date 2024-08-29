program MazeGeneratorSolver;

const
  N = 10;

type
  TMaze = array[1..N, 1..N] of boolean;
  TVisited = array[1..N, 1..N] of boolean;

var
  maze: TMaze;
  visited: TVisited;

procedure InitializeMaze(var maze: TMaze);
var
  i, j: integer;
begin
  for i := 1 to N do
    for j := 1 to N do
      maze[i, j] := false;
end;

procedure PrintMaze(maze: TMaze);
var
  i, j: integer;
begin
  for i := 1 to N do
  begin
    for j := 1 to N do
      if maze[i, j] then
        write('#')
      else
        write(' ');
    writeln;
  end;
end;

procedure GenerateMaze(var maze: TMaze; x, y: integer);
const
  dx: array[1..4] of integer = (-1, 1, 0, 0);
  dy: array[1..4] of integer = (0, 0, -1, 1);
var
  i, nx, ny, dir: integer;
  directions: array[1..4] of integer;
begin
  for i := 1 to 4 do
    directions[i] := i;
  
  for i := 1 to 4 do
  begin
    dir := random(4) + 1;
    nx := directions[i];
    directions[i] := directions[dir];
    directions[dir] := nx;
  end;

  for i := 1 to 4 do
  begin
    nx := x + dx[directions[i]];
    ny := y + dy[directions[i]];

    if (nx > 1) and (ny > 1) and (nx < N) and (ny < N) and not visited[nx, ny] then
    begin
      maze[nx, ny] := true;
      visited[nx, ny] := true;
      GenerateMaze(maze, nx, ny);
    end;
  end;
end;

function SolveMaze(maze: TMaze; var visited: TVisited; x, y: integer): boolean;
begin
  if (x = N) and (y = N) then
    exit(true);
  
  if (x > 0) and (y > 0) and (x <= N) and (y <= N) and (maze[x, y] = true) and (not visited[x, y]) then
  begin
    visited[x, y] := true;

    if SolveMaze(maze, visited, x + 1, y) or
       SolveMaze(maze, visited, x - 1, y) or
       SolveMaze(maze, visited, x, y + 1) or
       SolveMaze(maze, visited, x, y - 1) then
      exit(true);

    visited[x, y] := false;
  end;
  
  SolveMaze := false;
end;

begin
  randomize;
  InitializeMaze(maze);
  visited[1, 1] := true;
  GenerateMaze(maze, 1, 1);
  PrintMaze(maze);
  
  if SolveMaze(maze, visited, 1, 1) then
    writeln('Maze solved!')
  else
    writeln('No solution found!');
end.
