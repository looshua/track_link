#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/imgcodecs.hpp>

EXPORT
int loadVideo(
    char* filePath
) {
    std::string tFilePath = std::string(filePath);
    std::string rawFileName = tFilePath.substr(0, tFilePath.find_last_of("."));

    cv::VideoCapture vidCap;
    if (!vidCap.open(filePath)) return 0;

    int frameCounter = 0;
    cv::Mat readFrame;
    while (vidCap.read(readFrame)) {
        std::ostringstream oss;
        oss << rawFileName << "_" << frameCounter << ".jpg";
        std::string frameName = oss.str();

        cv::imwrite(frameName, readFrame);
    }

    return 1;
}

EXPORT
int add(int a, int b) {
    return a + b;
}