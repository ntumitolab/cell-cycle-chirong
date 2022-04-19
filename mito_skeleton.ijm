////////////////////////////// 2D Pipeline //////////////////////////////

//Preprocess_2D
input = "data/SVM/test/mito/"; // path to the mitochondria images to be analyzed
output = "data/SVM/test/before_th/";
if (!File.exists(output)) {
	File.makeDirectory(output);
}

//adapTH_2D_sauvola
//input = "data/SVM/test/before_th/";
//output = "data/SVM/test/sauvola/";
//if (!File.exists(output)) {
//	File.makeDirectory(output);
//}

//getFinalTH_with_invert
//input = "data/SVM/test/sauvola/";
//output = "data/SVM/test/final_th/";
//if (!File.exists(output)) {
//	File.makeDirectory(output);
//}

//do_skeletonize
//input = "data/SVM/test/final_th/";
//output = "data/SVM/test/skeleton/";
//if (!File.exists(output)) {
//	File.makeDirectory(output);
//}

//Analyze_Particle_Results
//input = "data/SVM/test//final_th/";
//if (!File.exists("data/SVM/test/Analyze_Particle/")) {
//	File.makeDirectory("data/SVM/test/Analyze_Particle/");
//}
//output = "data/SVM/test/Analyze_Particle/results/";
//output2 = "data/SVM/test/Analyze_Particle/summary/";
//output3 = "data/SVM/test/Analyze_Particle/outline/";
//if (!File.exists(output)) {
//	File.makeDirectory(output);
//}
//if (!File.exists(output2)) {
//	File.makeDirectory(output2);
//}
//if (!File.exists(output3)) {
//	File.makeDirectory(output3);
//}

//Analyze_Skeleton
//input = "data/SVM/test/skeleton/";
//if (!File.exists("data/SVM/test/Analyze_Skeleton/")) {
//	File.makeDirectory("data/SVM/test/Analyze_Skeleton/");
//}
//output = "data/SVM/test/Analyze_Skeleton/summary/";
//if (!File.exists(output)) {
//	File.makeDirectory(output);
//}

////////////////////////////// select function //////////////////////////////
setBatchMode(true);
list = getFileList(input);
list2 = newArray(list.length);

// delete the ".tif" from the name and save them in the list2 array
for (i = 0; i < list.length; i++) {
	list2[i] = substring(list[i], 0, lengthOf(list[i]) - 4);
}

// select some of the following for loops to run 

for (i = 0; i < list.length; i++) {
	preprocess_2D(input, output, list[i]);
}

//for (i = 0; i < list.length; i++) {
//	preprocess_3D(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	preprocess_3D_old(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	bc_only(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	adapTH_3D_sauvola(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	Analyze_Particle_Results(input, output, list[i], list2[i]);
//}

//for (i = 0; i < list.length; i++) {
//	getFinalTH(input, output, list[i], list2[i]);
//}

//for (i = 0; i < list.length; i++) {
//	getFinalTH_with_invert(input, output, list[i], list2[i]);
//}
//
//for (i = 0; i < list.length; i++) {
//	do_skeletonize(input, output, list[i], list2[i]);
//}
//
//for (i = 0; i < list.length; i++) {
//	Analyze_Skeleton(input, output, list[i], list2[i]);
//}

//for (i = 0; i < list.length; i++) {
//	adapTH_2D_mean(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	adapTH_2D_niblack(input, output, list[i]);
//}
//
//for (i = 0; i < list.length; i++) {
//	adapTH_2D_sauvola(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	Objects_Counter_3D(input, output, list[i], list2[i]);
//}

//for (i = 0; i < list.length; i++) {
//	adapTH_3D(input, output, list[i]);
//}

//for (i = 0; i < list.length; i++) {
//	Analyze_Particle_3D(input, output, list[i], list2[i]);
//}

//for (i = 0; i < list.length; i++) {
//	get_threhsold_for_skeleton(input, output, list[i], list2[i]);
//}



setBatchMode(false);

////////////////////////////// functions (parameters adjustment) //////////////////////////////

function Analyze_Particle_Results(input, output, filename, filename_without_extension) {
	//print('enter');
	open(input + filename);
	run("Analyze Particles...", "size=0.20-Infinity show=Outlines display clear include summarize record in_situ");
	selectWindow("Summary");
	saveAs("results", output2 + filename_without_extension + "_Summary" + ".csv");
	selectWindow("Results");
	saveAs("results", output + filename_without_extension + "_Results" + ".csv");
	selectWindow(filename);
	saveAs("Tiff", output3 + filename_without_extension + "_Outline" + ".tif");
	selectWindow("Results");
	run("Close");
	selectWindow(filename_without_extension + "_Summary" + ".csv");
	run("Close");
}

function getFinalTH(input, output, filename, filename_without_extension){
	open(input + filename);
	run("Analyze Particles...", "size=0.20-Infinity show=Masks clear in_situ");
	selectWindow(filename);
	saveAs("Tiff", output + filename_without_extension + "_FinalTH" + ".tif");
	run("Close");
}
function getFinalTH_with_invert(input, output, filename, filename_without_extension){
	open(input + filename);
	run("Duplicate...", "title=mask.tif");
	selectWindow("mask.tif");
	run("Analyze Particles...", "size=0.20-Infinity show=Masks clear include in_situ");
	run("Create Selection");
	selectWindow(filename);
	run("Analyze Particles...", "size=0.20-Infinity show=Masks clear in_situ");
	run("Restore Selection");
	run("Invert");
	run("Analyze Particles...", "size=0.05-Infinity show=Masks clear in_situ");
	run("Invert");	
	selectWindow(filename);
	run("Select None");
	selectWindow("mask.tif");
	close();
	selectWindow(filename);
	saveAs("Tiff", output + filename_without_extension + "_FinalTH" + ".tif");
	run("Close");
}
function preprocess_2D(input, output, filename) {
	open(input + filename);
	run("Subtract Background...", "rolling=30");
	run("8-bit");
	//run("Add Noise");
	run("Sigma Filter Plus", "radius=2 use=2 minimum=0.2 outlier");
	run("Enhance Local Contrast (CLAHE)", "blocksize=64 histogram=256 maximum=1.25 mask=*None*");
	// if you want to do gamma:
	run("Gamma...", "value=1.2");
	run("8-bit");
	// if you want to do b&c intensity normalization:
	BCauto();
	
	saveAs("Tiff", output + filename);
	close();
}
function preprocess_3D_old(input, output, filename) {
	open(input + filename);
	run("Subtract Background...", "rolling=10");
	run("Sigma Filter Plus", "radius=1 use=2 minimum=0.2 outlier");

	// CLAHE_all_stack_start
	blocksize = 64;
	histogram_bins = 256;
	maximum_slope = 3;
	mask = "*None*";
	fast = true;
	process_as_composite = true;
	 
	getDimensions( width, height, channels, slices, frames );
	isComposite = channels > 1;
	parameters =
	  "blocksize=" + blocksize +
	  " histogram=" + histogram_bins +
	  " maximum=" + maximum_slope +
	  " mask=" + mask;
	if ( fast )
	  parameters += " fast_(less_accurate)";
	if ( isComposite && process_as_composite ) {
	  parameters += " process_as_composite";
	  channels = 1;
	}
	   
	for ( f=1; f<=frames; f++ ) {
	  Stack.setFrame( f );
	  for ( s=1; s<=slices; s++ ) {
	    Stack.setSlice( s );
	    for ( c=1; c<=channels; c++ ) {
	      Stack.setChannel( c );
	      run( "Enhance Local Contrast (CLAHE)", parameters );
	    }
	  }
	}
	// CLAHE_all_stack_end

	// if you want to do gamma:
	run("Gamma...", "value=0.90");
	
	// if you want to do b&c intensity normalization:
	// run("Brightness/Contrast...");
	// run("Enhance Contrast", "saturated=0.35");
	// run("Apply LUT");
	run("8-bit");
	BCauto_3D();
	
	saveAs("Tiff", output + filename);
	close();
}
function bc_only(input, output, filename) {
	open(input + filename);
	BCauto_3D();
	saveAs("Tiff", output + filename);
	close();
}
function preprocess_3D(input, output, filename) {
	open(input + filename);
	run("Subtract Background...", "rolling=10");
	run("Sigma Filter Plus", "radius=2 use=2 minimum=0.2 outlier");

	// CLAHE_all_stack_start
	blocksize = 64;
	histogram_bins = 256;
	maximum_slope = 1.25;
	mask = "*None*";
	fast = true;
	process_as_composite = true;
	 
	getDimensions( width, height, channels, slices, frames );
	isComposite = channels > 1;
	parameters =
	  "blocksize=" + blocksize +
	  " histogram=" + histogram_bins +
	  " maximum=" + maximum_slope +
	  " mask=" + mask;
	if ( fast )
	  parameters += " fast_(less_accurate)";
	if ( isComposite && process_as_composite ) {
	  parameters += " process_as_composite";
	  channels = 1;
	}
	   
	for ( f=1; f<=frames; f++ ) {
	  Stack.setFrame( f );
	  for ( s=1; s<=slices; s++ ) {
	    Stack.setSlice( s );
	    for ( c=1; c<=channels; c++ ) {
	      Stack.setChannel( c );
	      run( "Enhance Local Contrast (CLAHE)", parameters );
	    }
	  }
	}
	// CLAHE_all_stack_end

	// if you want to do gamma:
	run("Gamma...", "value=0.90");
	
	// if you want to do b&c intensity normalization:
	// run("Brightness/Contrast...");
	// run("Enhance Contrast", "saturated=0.35");
	// run("Apply LUT");
	run("8-bit");
	BCauto_3D();
	
	saveAs("Tiff", output + filename);
	close();
}
function adapTH_2D_mean(input, output, filename) {
	open(input + filename);
	setOption("ScaleConversions", true);
	run("8-bit");
	run("adaptiveThr ", "using=Mean from=137 then=-23");
	run("Despeckle");
	run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
	saveAs("Tiff", output + filename);
	close();
}
function adapTH_2D_niblack(input, output, filename) {
	open(input + filename);
	setOption("ScaleConversions", true);
	run("8-bit");
	run("Auto Local Threshold", "method=Niblack radius=25 parameter_1=0.2 parameter_2=-10 white");
	run("Despeckle");
	run("Remove Outliers...", "radius=3 threshold=50 which=Bright");
	saveAs("Tiff", output + filename);
	close();
}
function adapTH_2D_sauvola(input, output, filename){
	open(input + filename);
	setOption("ScaleConversions", true);
	//run("8-bit");
	run("Auto Local Threshold", "method=Sauvola radius=60 parameter_1=-0.45 parameter_2=128 white");
	run("Despeckle");
	run("Remove Outliers...", "radius=3 threshold=50 which=Bright");
	saveAs("Tiff", output + filename);
	close();
}
function adapTH_3D(input, output, filename) {
	open(input + filename);
	run("8-bit");
	run("Auto Local Threshold", "method=Mean radius=50 parameter_1=-20 parameter_2=0 white stack");
	run("Despeckle", "stack");
	run("Remove Outliers...", "radius=2 threshold=50 which=Bright stack");
	run("3D Fill Holes");
	saveAs("Tiff", output + filename);
	close();
}
function adapTH_3D_sauvola(input, output, filename) {
	open(input + filename);
	run("8-bit");
	run("Auto Local Threshold", "method=Sauvola radius=25 parameter_1=-0.5 parameter_2=128 white stack");
	run("Despeckle", "stack");
	run("Remove Outliers...", "radius=3 threshold=50 which=Bright stack");
	//run("3D Fill Holes");
	saveAs("Tiff", output + filename);
	close();
}
function do_skeletonize(input, output, filename, filename_without_extension) {
	open(input + filename);
	run("Skeletonize (2D/3D)");
	saveAs("Tiff", output + filename_without_extension + ".tif");
	close();
}
function Analyze_Skeleton(input, output, filename, filename_without_extension) {
	open(input + filename);
	run("Analyze Skeleton (2D/3D)", "prune=none");
	selectWindow("Tagged skeleton");
	close();
	selectWindow("Results");
	saveAs("results", output + filename_without_extension + "_Skeleton_Results" + ".csv");
}
function Objects_Counter_3D(input, output, filename, filename_without_extension) {
	open(input + filename);
	run("Duplicate...",  "title=dupli1.tif duplicate");
	run("Duplicate...", "title=dupli2.tif duplicate");
	run("3D OC Options", "volume surface nb_of_obj._voxels nb_of_surf._voxels integrated_density mean_gray_value std_dev_gray_value median_gray_value minimum_gray_value maximum_gray_value centroid mean_distance_to_surface std_dev_distance_to_surface median_distance_to_surface centre_of_mass bounding_box show_masked_image_(redirection_requiered) dots_size=5 font_size=10 show_numbers white_numbers store_results_within_a_table_named_after_the_image_(macro_friendly) redirect_to=dupli1.tif");
	selectWindow("dupli2.tif");
	run("3D Objects Counter", "threshold=128 slice=6 min.=60 max.=9524844 objects statistics");
	run("3D Objects Counter", "threshold=128 slice=6 min.=60 max.=9524844 objects");
	selectWindow("Statistics for " + "dupli2.tif redirect to dupli1.tif");
	saveAs("results", output + filename_without_extension + "_Results" + ".csv");
	run("Close");
	selectWindow("Objects map of " + "dupli2.tif redirect to dupli1.tif");
	saveAs("Tiff", output2 + filename);
	run("Close");
	
	// save final_th 
	selectWindow("Masked image for dupli2.tif redirect to dupli1.tif");
	saveAs("Tiff", output3 + filename);
	run("Close");
	close("*");
}
function Analyze_Particle_3D(input, output, filename, filename_without_extension) {
	open(input + filename);
	run("Analyze Regions 3D", "volume surface_area mean_breadth sphericity euler_number bounding_box centroid equivalent_ellipsoid ellipsoid_elongations max._inscribed surface_area_method=[Crofton (13 dirs.)] euler_connectivity=26");
	selectWindow("Log");
	run("Close");
	selectWindow(filename_without_extension + "-morpho");
	saveAs("results", output + filename_without_extension + "_Analyze_Particle_3D" + ".csv");
	run("Close");
	close();
}
function BCauto(){
	 AUTO_THRESHOLD = 5000;
	 getRawStatistics(pixcount);
	 limit = pixcount/10;
	 threshold = pixcount/AUTO_THRESHOLD;
	 nBins = 256;
	 getHistogram(values, histA, nBins);
	 i = -1;
	 found = false;
	 do {
	         counts = histA[++i];
	         if (counts > limit) counts = 0;
	         found = counts > threshold;
	 } while ((!found) && (i < histA.length-1))
	 hmin = values[i];
	
	 i = histA.length;
	 do {
	         counts = histA[--i];
	         if (counts > limit) counts = 0;
	         found = counts > threshold;
	 } while ((!found) && (i > 0))
	 hmax = values[i];
	
	 setMinAndMax(hmin, hmax);
	 //print(hmin, hmax);
	 run("Apply LUT");
}
function BCauto_3D(){
	 AUTO_THRESHOLD = 5000;
	 getRawStatistics(pixcount);
	 limit = pixcount/10;
	 threshold = pixcount/AUTO_THRESHOLD;
	 nBins = 256;
	 getHistogram(values, histA, nBins);
	 i = -1;
	 found = false;
	 do {
	         counts = histA[++i];
	         if (counts > limit) counts = 0;
	         found = counts > threshold;
	 } while ((!found) && (i < histA.length-1))
	 hmin = values[i];
	
	 i = histA.length;
	 do {
	         counts = histA[--i];
	         if (counts > limit) counts = 0;
	         found = counts > threshold;
	 } while ((!found) && (i > 0))
	 hmax = values[i];
	
	 setMinAndMax(hmin, hmax);
	 //print(hmin, hmax);
	run("Apply LUT", "stack");
}

// remove small holes to avoid over skeletonized
function get_threhsold_for_skeleton(input, output, filename, filename_without_extension) {
	open(input + filename);
	for (n=1; n<=nSlices; n++) {
		setSlice(n);
		run("Duplicate...", "title=mask.tif");
		selectWindow("mask.tif");
		run("Analyze Particles...", "size=0.20-Infinity show=Masks clear include in_situ");
		run("Create Selection");
		selectWindow(filename);
		run("Analyze Particles...", "size=0.20-Infinity show=Masks clear in_situ slice");
		run("Restore Selection");
		run("Invert", "slice");
		run("Analyze Particles...", "size=0.05-Infinity show=Masks clear in_situ slice");
		run("Restore Selection");
		run("Invert", "slice");	
		selectWindow(filename);
		run("Select None");
		selectWindow("mask.tif");
		close();
	}
	selectWindow(filename);
	saveAs("Tiff", output + filename_without_extension + "_th_for_skeleton" + ".tif");
	run("Close");

}
// Closes the "Results" and "Log" windows and all image windows
function cleanUp() {
    requires("1.30e");
    if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Close" );
    {
    if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }
    while (nImages()>0) {
          selectImage(nImages());  
          run("Close");
    }
}
