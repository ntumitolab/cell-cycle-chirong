# Cell cycle phases classification

##
Download data from the link: https://github.com/ntumitolab/cell-cycle-chirong/releases/tag/publication

## System requirement and enviroment settings
A  graphics card with at least 6GB of ram.

- Create virtual environment
```shell
conda env create -f cellcycleenv.yml
```

## Train an ResNet34 model
- Activate the environment
```shell
conda activate cc
```
- Open Jupyter Notebook (or jupyterlab)
```shell
jupyter notebook
```
- After the Jupyter Notebook has opened, clicking train_ResNet34.ipynb.  
- Modify the paths to your data or folder.  
- Modify the hyperparameters if you want.  
- Start training.  

## Calssify cell cylce phases by a trained ResNet34 model.
- Activate the environment
```shell
conda activate cc
```
- Open Jupyter Notebook (or jupyterlab)
```shell
jupyter notebook
```

- After the Jupyter Notebook has opened,
    - if the cells weren't labeled, clicking ResNet34_not_labeled_images_classification.
    - if the cells were labeled, clicking ResNet34_labeled_images_classification.
- Modify the paths to your data or folder.
- Start classifying.
    
## Train an SVM model
- Analyze mitochondria
    - Start up ImageJ
    - Open mito_skeleton.ijm
    - Modify the paths
    - Follow the order to Analyze mitochondria
- Open SVM.ipynb.
- Modify the paths to the folders.
- Modify hyperparameters.
- Start training.

## Calssify cell cylce phases by a trained SVM model.
- Analyze mitochondria
- Open SVM_classifying_labeled_images.ipynb or SVM_notlabeled.ipynb
- Modify the paths to the folders.
- Start classifying.
