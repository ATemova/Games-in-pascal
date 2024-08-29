program Hangman;

var
  word: string;
  display: string;
  guessed: char;
  attempts: integer;

procedure InitializeGame(var word: string; var display: string);
begin
  word := 'PASCAL';
  display := StringOfChar('_', Length(word));
  attempts := 6;
end;

procedure UpdateDisplay(var display: string; word: string; guessed: char);
var
  i: integer;
begin
  for i := 1 to Length(word) do
    if word[i] = guessed then
      display[i] := guessed;
end;

function WordGuessed(display: string): boolean;
begin
  WordGuessed := Pos('_', display) = 0;
end;

begin
  InitializeGame(word, display);
  repeat
    writeln('Word: ', display);
    writeln('Attempts left: ', attempts);
    write('Guess a letter: ');
    readln(guessed);
    if Pos(guessed, word) > 0 then
      UpdateDisplay(display, word, guessed)
    else
      Dec(attempts);
    if WordGuessed(display) then
    begin
      writeln('Congratulations! You guessed the word: ', word);
      break;
    end;
  until attempts = 0;
  if attempts = 0 then
    writeln('You ran out of attempts! The word was: ', word);
end.
