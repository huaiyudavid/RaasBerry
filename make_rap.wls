#!/usr/bin/env wolframscript
(* ::Package:: *)

rulerSequence[0] = {1};
rulerSequence[n_Integer] := rulerSequence[n] = Riffle[
    rulerSequence[n - 1],
    ConstantArray[1/2^n, 2^(n - 1)]];

makeSoundSequence[instrument_String, hitPattern_List,
                  startTime_, soundVolume_] :=
  SoundNote[instrument, startTime + {(# - 1)/8, #/8}, 
     SoundVolume -> soundVolume] & /@
   First /@ Position[hitPattern, 1];
clapSequence = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0};
bassPattern = RandomVariate@*BernoulliDistribution /@ rulerSequence[4];
stickPattern = {1, 0, 0, 0, 1, 0 , 0, 0, 1, 0, 0, 0, 1, 0, 0, 0};
vibraPattern = ReplacePart[ConstantArray[0, 16],( RandomInteger[{0, 3}]*4+1)-> 1];
lyrics = Import["~/Documents/Programming/VandyHacks/raasberry/generated_lyrics.txt"];
length = Length[StringSplit[lyrics, "\n"]]*4;
beat = Sound@Join[
Flatten[makeSoundSequence["BassDrum", bassPattern, #, 1]& /@ Range[0,length-2 2],2],
Flatten[makeSoundSequence["HiHatClosed", Riffle[ConstantArray[1, 8], ConstantArray[0, 8]], #, 0.4]& /@ Range[0,length-2, 2],2],
Flatten[makeSoundSequence["ElectricSnare", clapSequence, #, 1]& /@ Range[0,length-2, 2],2],
Flatten[makeSoundSequence["Vibraslap", vibraPattern, #, 1]& /@ Range[0,length-2, 2],2]
  ];
Export["~/Documents/Programming/VandyHacks/raasberry/beat.wav", beat];
applyStretch[audioSample_Audio] := 
{AudioTimeStretch[audioSample, 4/(Duration@audioSample)[[1]] ], 0};
beatFile = Import["~/Documents/Programming/VandyHacks/raasberry/beat.wav"];
rap = Audio@beat + 5*AudioJoin[applyStretch@SpeechSynthesize[#, Voice -> "RMS"]& /@ StringSplit[lyrics, "\n"]];
Export["~/Documents/Programming/VandyHacks/raasberry/rap.wav", rap];
