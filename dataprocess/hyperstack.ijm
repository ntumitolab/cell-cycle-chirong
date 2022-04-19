inputdir = getDirectory("Choose a Directory");
filelist = getFileList(inputdir);

for (i=0;i<filelist.length;i++) {
    j = split(filelist[i],"/");
    file = filelist[i] + j[0];
    file = file + ".tif";
    open(file);
    selectImage(j[0] + ".tif");
    run("Stack to Hyperstack...", "order=xyczt(default) channels=5" + " slices=1" + " frames=68 display=Grayscale");
    save("D:/allen/data/mydata/ac_time_seperated/20220412/merged/"+file);
    close("*");
}
