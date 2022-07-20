#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))

#include <sys/stat.h>
#include <iostream>

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/imgcodecs.hpp>

EXPORT
int loadVideo(
    char* filePath
) {
    std::string tFilePath = std::string(filePath);
    std::string rawFileName = tFilePath.substr(0, tFilePath.find_last_of("."));
    
    std::size_t preSlash = rawFileName.find_last_of("\\");
    if (preSlash == std::string::npos) {
        preSlash = rawFileName.find_last_of("/");
    }

    std::string videoName;
    if (preSlash != std::string::npos) {
        videoName = rawFileName.substr(preSlash + 1, std::string::npos);
    }
    else {
        videoName = rawFileName;
    }

    cv::VideoCapture vidCap;
    if (!vidCap.open(tFilePath)) return 0;

    #ifdef _WIN32

    #else

    std::ostringstream dirss;
    dirss << rawFileName;
    std::string dirStr = dirss.str();
    int status = mkdir(dirStr.c_str(), 0777);

    #endif

    std::cout << "Reading from " << tFilePath << std::endl;
    std::cout << "Writing to " << rawFileName << std::endl;

    int frameCounter = 0;
    cv::Mat readFrame;
    while (vidCap.read(readFrame)) {
        std::ostringstream oss;
        oss << rawFileName << "/" << videoName << "_" << frameCounter << ".jpg";
        std::string frameName = oss.str();

        cv::imwrite(frameName, readFrame);
        frameCounter++;
    }

    vidCap.release();
    std::cout << "Read ended with " << frameCounter - 1 << " frames." << std::endl;

    return frameCounter - 1;
}

EXPORT
int add(int a, int b) {
    return a + b;
}