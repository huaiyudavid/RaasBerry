lyricFiles = Import["~/eminem/ohhla.com/anonymous/*/*/*.txt"];

On[Assert];
preprocess[lyricFile_] := Block[
   {preTagPosition, endPreTagPosition, lyricBody, bracketPosition},
   preTagPosition = StringPosition[lyricFile, "<pre>"];
   endPreTagPosition = StringPosition[lyricFile, "</pre>"];
   If[Length[preTagPosition] == 1 && Length[endPreTagPosition] == 1,
    lyricBody = StringTake[lyricFile,
      {preTagPosition[[1, 2]] + 1, endPreTagPosition[[1, 1]] - 1}];
    bracketPosition = StringPosition[lyricBody, "]"];
    If[Length[bracketPosition] > 0,
     lyricBody = StringDrop[lyricBody,
       First@First@StringPosition[lyricBody, "]"]]];
    lyricBody = 
     StringReplace[lyricBody, "[" ~~ Shortest[___] ~~ "]" -> ""];
    lyricBody = StringReplace[lyricBody, "(" ~~ Shortest[___] ~~ ")" -> ""];
    lyricBody = StringReplace[lyricBody, "{" ~~ Shortest[___] ~~ "}" -> ""];
    lyricBody = StringReplace[lyricBody,
      Thread@Rule[ToUpperCase /@ Alphabet[], Alphabet[]]];
    lyricBody = StringReplace[lyricBody, "." | "," | "?" | "!" | "+" -> ""];
    lyricBody = StringReplace[lyricBody, "-" -> " "];
    lyricBody,
    ""]];
