import torch.utils.data
from fnet.data.fnetdataset import FnetDataset
from fnet.data.tifreader import TifReader

import fnet.transforms as transforms

import pandas as pd

import pdb
import numpy as np
import glob

class TiffDataset2(FnetDataset):
    """Dataset for Tif files."""

    def __init__(self, mode = 'multi' , path: str = None, is_csv = True,
                    transform_source = [transforms.normalize],
                    transform_target = None):
        
        if mode not in ['multi', 'single']:
            raise ValueError("mode should be multi or single.")
        self.mode = mode
        self.is_csv = is_csv
   
        if self.mode == 'multi':
            self.df = pd.read_csv(path)
            assert all(i in self.df.columns for i in ['path_signal', 'path_target'])
            self.transform_source = transform_source
            self.transform_target = transform_target
        else:
            # if the mode is single, both directory path or csv file path are acceptable
            # must use '/' as the directory separator
            if is_csv:
                self.df = pd.read_csv(path)
            else:
                self.df = None
                self.file_name = glob.glob(path+'/*')
            self.transform_source = transform_source
        
        


    def __getitem__(self, index):
        if self.mode == 'multi':
            element = self.df.iloc[index, :]
            tiff = TifReader(element['path_tiff']).get_image()
            im_out = list()
            target_channel = element['path_target']
            signal_channel = element['path_signal']
            if tiff.ndim == 4: # (Z, C, Y, X)
                im_out.append(tiff[:,signal_channel,:,:])
                if target_channel != np.nan:
                    im_out.append(tiff[:,target_channel,:,:]) 
            else:
                im_out.append(tiff[signal_channel,:,:])
                if target_channel != np.nan:
                    im_out.append(tiff[target_channel,:,:]) 
            if self.transform_source is not None:
                for t in self.transform_source: 
                    im_out[0] = t(im_out[0])

            if self.transform_target is not None and (len(im_out) > 1):
                for t in self.transform_target: 
                    im_out[1] = t(im_out[1])
        else:
            im_out = list()
            if self.df is None:
                tiff = TifReader(self.file_name[index]).get_image()
            else:
                #print(self.df.iloc[index,0])
                tiff = TifReader(self.df.iloc[index,0]).get_image()
            #tiff = np.expand_dims(tiff, axis=0)
            im_out.append(tiff)
            if self.transform_source is not None:
                for t in self.transform_source:
                    im_out[0] = t(im_out[0])

        
        im_out = [torch.from_numpy(im).float() for im in im_out]
        
        #unsqueeze to make the first dimension be the channel dimension
        im_out = [torch.unsqueeze(im, 0) for im in im_out]
        
        return im_out
    
    def __len__(self):
        if self.mode == 'multi':
            return len(self.df)
        else:
            if self.is_csv:
                return len(self.df)
            else:
                return len(self.file_name)

    def get_information(self, index):
        if self.mode == 'multi':
            return self.df.iloc[index, :].to_dict()
        else:
            if self.is_csv:
                return self.df.iloc[index, :].to_dict()
            else:
                return {'path_signal':self.file_name[index]}
        
        
