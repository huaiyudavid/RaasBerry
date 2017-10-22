pronunciationDictFile = Import["~/cmudict.txt"];
pronunciationDict = First /@ GroupBy[
    Select[StringSplit /@ Select[
       StringSplit[pronunciationDictFile, "\n"],
       StringMatchQ[LetterCharacter ~~ ___]],
     !StringMatchQ[First[#], ___ ~~ ")"] &],
    ToLowerCase@*First -> Rest];

rhymingPortion[word_String] := Block[{stressedSyllables},
   stressedSyllables = Position[
     StringMatchQ[pronunciationDict[word],
     ___ ~~ ("1" | "2")], True];
   If[Length[stressedSyllables] > 0,
    pronunciationDict[word][[
      First@Last@stressedSyllables ;;]],
    pronunciationDict[word]]];

rhymeClasses = GroupBy[Keys[pronunciationDict], rhymingPortion];

forceRhymeScheme[lines_List, rhymeScheme_String] := Block[
   {newLines, classPositions, knownWords, nearestRhymeFunction},
   newLines = lines;
   Do[
    classPositions = First /@ Position[
       Characters[rhymeScheme], schemeClass];
    knownWords = Select[
      Last /@ StringSplit@lines[[classPositions]],
      KeyExistsQ[pronunciationDict, #] &];
    If[Length[knownWords] > 0,
     nearestRhymeFunction = RandomChoice @* (
        Nearest@rhymeClasses@rhymingPortion@
           RandomChoice[knownWords]);
     Do[newLines[[i]] = StringJoin@Riffle[
         MapAt[nearestRhymeFunction,
          StringSplit@lines[[i]], -1],
         " "],
      {i, classPositions}]],
    {schemeClass, Union@Characters[rhymeScheme]}];
   newLines];

forceRhymeScheme[lines_String, rhymeScheme_String] :=
  StringJoin@Riffle[
    forceRhymeScheme[StringSplit[lines, "\n"], rhymeScheme],
    "\n"];

(* Example usage:

forceRhymeScheme[
 "there's a shitop and back yo
 cause i ain't takin away too ran the bags you'd be doin this
 a young time i feel a thug's evalurent
 blame your tangerous fake tabs to show you producerate combine
 kon artist: eminem shady
  slim and in your cap up down 
 jackin no discussion; i get once  went months with the chin
 tell him  on my brain i'm pissed off an excore
 then they say i'm gettin busy put a gat on the michael ta ha
 i'm jumpin pissin' up the three arms ring
 i got niggas'll be able to hear
 i fall in hell out called him mixtape
 she's taking some wreck",
 "AAAABBBBCCDDD"]

Result:

"there's a shitop and back yo
cause i ain't takin away too ran the bags you'd be doin tho
a young time i feel a thug's devault
blame your tangerous fake tabs to show you producerate coe
kon artist: eminem shinn
slim and in your cap up din
jackin no discussion; i get once went months with the chin
tell him on my brain i'm pissed off an mclin
then they say i'm gettin busy put a gat on the michael ta ha
i'm jumpin pissin' up the three arms ona
i got niggas'll be able to hear
i fall in hell out called him manteer
she's taking some weir" *)
