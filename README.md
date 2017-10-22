# RaasBerry (Rap as a Service - Berry)
A smart robot that raps like your favorite artist.

## Installation
### __Python__
Install the header files for Python 2.7 and the HDF5 library:
```
sudo apt-get -y install python2.7-dev
sudo apt-get install libhdf5-dev
```

Install the following libraries using `pip`:
```
Cython
numpy
argparse
h5py
six
```

### __Torch__
Install [torch](http://torch.ch/docs/getting-started.html#_).

### __Mathematica__
Install [Mathematica](https://www.wolfram.com/mathematica/) through any means you would like.

## Usage
### Obtain training data:
Place all text training data in lyrics.txt and run in the /torch-rnn directory.
```
python scripts/preprocess.py --input_txt lyrics.txt --output_h5 lyrics.h5 --output_json lyrics.json --val_frac 0.01 --test_frac 0.01
```

### Train the model:
```
th train.lua -gpu -1 -input_h5 lyrics.h5 -input_json lyrics.json -rnn_size 512 -num_layers 2 -checkpoint_every 20 -checkpoint_name cv/checkpoint
```

### Obtain a sample of the model output:
```
th sample.lua -gpu -1 -checkpoint cv/`ls -v cv | tail -n 1` -sample 1
```

### Generate an audio sample of the rap:

Place the desired lyrics in generated_lyrics.txt.

Run `wolframscript make_rap.wls` in the root directory of the project.

The script will produce rap.wav, an audio file containing the rap demo.

A pre-made sample is already stored in the current rap.wav.
