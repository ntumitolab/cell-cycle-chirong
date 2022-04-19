# Label-free prediction of fluorescence images from transmitted light microscopy

## System Requirements
Installing on windows 10 is recommended.
n graphics card with >10GB of ram.

### Environment setup
- Create virtual environment
```shell
conda env create -f fnetenv.yml
```


## Train a model
- Activate the environment:
```shell
conda activate fnet
```
- Modify the path to the csv file and the hyperparameters in train_model_2d.bat.
- Execute the batch file
```shell
train_model_2d.bat
```

## Test your trained model
- Activate the environment:
```shell
conda activate fnet
```
- Modify the path to the csv file and the hyperparameters in predict.bat.
```shell
predict.bat
```
- Open pearsonr.ipynb to get the performance of your model.

## Fluorescent-label images prediction
- If you have a set of data only with transmitted-light images, use predict_single.bat to predict the Fluorescent-label images.  

## Reference
The code is modified from the following paper.
```
@article{Ounkomol2018,
  author = {Chawin Ounkomol and Sharmishtaa Seshamani and Mary M. Maleckar and Forrest Collman and Gregory R. Johnson},
  title = {Label-free prediction of three-dimensional fluorescence images from transmitted-light microscopy},
  journal = {Nature Methods}
  doi = {10.1038/s41592-018-0111-2},
  url = {https://doi.org/10.1038/s41592-018-0111-2},
  year  = {2018},
  month = {sep},
  publisher = {Springer Nature America,  Inc},
  volume = {15},
  number = {11},
  pages = {917--920},
}
```

