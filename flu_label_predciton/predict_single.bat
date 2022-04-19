setlocal

set DATASET=ac_bf0615_pdmito
set MODEL_DIR="saved_models/%DATASET%"
set N_IMAGES=100000
set GPU_IDS=1
set TEST_OR_TRAIN=test
set MODE=single

python predict_single_channel.py --class_dataset TiffDataset2 ^
--transform_signal fnet.transforms.normalize ^
--transform_target fnet.transforms.normalize ^
--path_model_dir "saved_models/%DATASET%/" ^
--mode %MODE% ^
--path_dataset "data/csvs/20220412bf.csv" ^
--n_images 100000 ^
--no_prediction_unpropped ^
--path_save_dir "D:/allen/predict_single/%DATASET%/" ^
--gpu_ids 1

endlocal