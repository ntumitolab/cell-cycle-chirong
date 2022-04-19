python split_dataset.py "data/csvs/allimage_path_csvfile.csv" "data/csvs" -v

python train_model.py ^
       --nn_module fnet_nn_2d ^
       --n_iter 10000 ^
       --path_dataset_csv "data/csvs/name_of_allimage_path_csvfile/train.csv" ^
       --class_dataset TiffDataset ^
       --transform_signal fnet.transforms.normalize ^
       --transform_target fnet.transforms.normalize ^
       --patch_size 256 256 ^
       --batch_size 32 ^
       --buffer_size 40 ^
       --buffer_switch_frequency 16000 ^
       --path_run_dir "saved_models/name_of_allimage_path_csvfile" ^
       --gpu_ids 0
