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
hitPattern = RandomVariate@*BernoulliDistribution /@ rulerSequence[4];

pitchedSounds = {"Accordion", "Agogo", "AltoSax", "Applause", 
   "Atmosphere", "Bagpipe", "Bandoneon", "Banjo", "BaritoneSax", 
   "Bass", "BassAndLead", "Bassoon", "Bird", "BlownBottle", "Bowed", 
   "BrassSection", "Breath", "Brightness", "BrightPiano", "Calliope", 
   "Celesta", "Cello", "Charang", "Chiff", "Choir", "Clarinet", 
   "Clavi", "Contrabass", "Crystal", "DrawbarOrgan", "Dulcimer", 
   "Echoes", "ElectricBass", "ElectricGrandPiano", "ElectricGuitar", 
   "ElectricPiano", "ElectricPiano2", "EnglishHorn", "Fiddle", 
   "Fifths", "Flute", "FrenchHorn", "FretlessBass", "FretNoise", 
   "Glockenspiel", "Goblins", "Guitar", "GuitarDistorted", 
   "GuitarHarmonics", "GuitarMuted", "GuitarOverdriven", "Gunshot", 
   "Halo", "Harmonica", "Harp", "Harpsichord", "Helicopter", 
   "HonkyTonkPiano", "JazzGuitar", "Kalimba", "Koto", "Marimba", 
   "MelodicTom", "Metallic", "MusicBox", "MutedTrumpet", "NewAge", 
   "Oboe", "Ocarina", "OrchestraHit", "Organ", "PanFlute", 
   "PercussiveOrgan", "Piano", "Piccolo", "PickedBass", 
   "PizzicatoStrings", "Polysynth", "Rain", "Recorder", "ReedOrgan", 
   "ReverseCymbal", "RockOrgan", "Sawtooth", "SciFi", "Seashore", 
   "Shakuhachi", "Shamisen", "Shanai", "Sitar", "SlapBass", 
   "SlapBass2", "SopranoSax", "Soundtrack", "Square", "Steeldrums", 
   "SteelGuitar", "Strings", "Strings2", "Sweep", "SynthBass", 
   "SynthBass2", "SynthBrass", "SynthBrass2", "SynthDrum", 
   "SynthStrings", "SynthStrings2", "SynthVoice", "Taiko", 
   "Telephone", "TenorSax", "Timpani", "Tinklebell", "TremoloStrings",
    "Trombone", "Trumpet", "Tuba", "TubularBells", "Vibraphone", 
   "Viola", "Violin", "Voice", "VoiceAahs", "VoiceOohs", "Warm", 
   "Whistle", "Woodblock", "Xylophone"};

(* Evaluate the following line to preload all pitched sounds
   from Wolfram's servers.
EmitSound[{SoundNote["C4", {0, 1}, #]}] & /@ pitchedSounds; *)

(* Example beat:
Sound@Join[
  makeSoundSequence["BassDrum", hitPattern, 0],
  makeSoundSequence["BassDrum", hitPattern, 2],
  makeSoundSequence["BassDrum", hitPattern, 4],
  makeSoundSequence["BassDrum", hitPattern, 6],
  makeSoundSequence["HiHatClosed",
   Riffle[ConstantArray[1, 8], ConstantArray[0, 8]], 0, 0.4],
  makeSoundSequence["HiHatClosed",
   Riffle[ConstantArray[1, 8], ConstantArray[0, 8]], 2, 0.4],
  makeSoundSequence["HiHatClosed",
   Riffle[ConstantArray[1, 8], ConstantArray[0, 8]], 4, 0.4],
  makeSoundSequence["HiHatClosed",
   Riffle[ConstantArray[1, 8], ConstantArray[0, 8]], 6, 0.4],
  makeSoundSequence["Clap", clapSequence, 0],
  makeSoundSequence["Clap", clapSequence, 2],
  makeSoundSequence["Clap", clapSequence, 4],
  makeSoundSequence["Clap", clapSequence, 6]
  ] *)
