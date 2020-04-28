%% Point select area of the original video and choose the time to save a new video

clear
[file,path]=uigetfile({'*.wmv;*.avi' 'Video file'},'Select the video','C:\');

% %
vidObj = VideoReader([path '\' file]);
t0 = vidObj.CurrentTime;
answer = inputdlg({'Enter new file name:','Enter start time (h:m:s):','Enter duration (s):'},'Input',[1 35]);
myVideo = VideoWriter(answer{1},'MPEG-4');
depVideoPlayer = vision.DeployableVideoPlayer;
% %
stime = datevec(answer{2});
startTime = 3600*stime(4)+60*stime(5)+stime(6); %s
duration = str2num(answer{3}); %s
endTime = startTime+duration;
% %
thisframe = readFrame(vidObj);
figure('WindowState', 'maximized')
imagesc(thisframe); axis image; box off; axis off;
rect = round(getrect); close;

vidObj.CurrentTime=startTime;
open(myVideo)
i=1;
while vidObj.CurrentTime<endTime
    thisframe = readFrame(vidObj);
    newVideoFrame = imcrop(thisframe,rect);
%     depVideoPlayer(newVideoFrame);
    writeVideo(myVideo,newVideoFrame);
%     pause(1/vidObj.FrameRate);
end
close(myVideo)

msgbox('Operation Completed','Success');