function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 25-May-2018 06:23:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%to set axes handles not to show ticks on axes
axes(handles.axes1);
set(gca,'XtickLabel',[],'YtickLabel',[]);

%to set axes handles not to show ticks on axes
axes(handles.axes2);
set(gca,'XtickLabel',[],'YtickLabel',[]);
%to set axes handles not to show ticks on axes
axes(handles.axes3);
set(gca,'XtickLabel',[],'YtickLabel',[]);

%to set axes handles not to show ticks on axes
axes(handles.axes4);
set(gca,'XtickLabel',[],'YtickLabel',[]);



% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_load_data.
function push_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to push_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcmdir = uigetdir;
files = dir(dcmdir);
files(1:2) = [];
fullfilenames = cellfun(@(x)fullfile(dcmdir,x),{files.name},'uniformoutput',0);
tmp = dicomread(fullfilenames{1});
global img;
global sz;
sz = size(img);
img = zeros([size(tmp) length(fullfilenames)]);
for i = 1:length(fullfilenames)
    img(:,:,i) = dicomread(fullfilenames{i});
end

disp('Data Loaded')
% --- Executes on button press in push_smooted.
function push_smooted_Callback(hObject, eventdata, handles)
% hObject    handle to push_smooted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Step 1
%Perform smoothing on the cine images for improved image clustering
set(handles.text_cluster,'visible','off');
set(handles.text_original,'visible','on');
set(handles.text_smooth,'visible','on');
global img;
global sz;
global imgSmoothed

opengl software
for j=1:2
    if j==1
        axes(handles.axes1);
        imagesc(img(:,:,1));
        handles.img(:,:,1) = img(:,:,1);
        colormap('gray')
    else
        axes(handles.axes2);
        imagesc(img(:,:,15));
        handles.img(:,:,15) = img(:,:,2);
        colormap('gray')        
    end
    if j==1
        axes(handles.axes3);
        imagesc(imgSmoothed(:,:,1));
        handles.imgSmoothed(:,:,1) = imgSmoothed(:,:,1);
        colormap('gray')
    else
        axes(handles.axes4);
        imagesc(imgSmoothed(:,:,15));
        handles.imgSmoothed(:,:,15) = imgSmoothed(:,:,15);
        colormap('gray')
    end
    
    guidata(hObject, handles);
end


% --- Executes on button press in push_cluster.
function push_cluster_Callback(hObject, eventdata, handles)
% hObject    handle to push_cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Step 2
% Use a k-means to start clustering like-segments together
set(handles.text_cluster,'visible','on');
set(handles.text_smooth,'visible','off');
set(handles.text_smooth,'visible','off');



global img;
global sz;
global imgSmoothed
global kInfo;
global combinedClusters;

%% Step 3

opengl software
for j=1:4
    if j==1
        axes(handles.axes1);
        imagesc(kInfo.mask(:,:,1));
        handles.kInfo.mask(:,:,1) = kInfo.mask(:,:,1);
        colormap('jet')
    elseif j==2
        axes(handles.axes2);
        imagesc(kInfo.mask(:,:,5));
        handles.kInfo.mask(:,:,5) = kInfo.mask(:,:,5);
        colormap('jet')
    elseif j==3
        axes(handles.axes3);
        imagesc(kInfo.mask(:,:,10));
        handles.kInfo.mask(:,:,10) = kInfo.mask(:,:,10);
        colormap('jet')
    else
        axes(handles.axes4);
        imagesc(kInfo.mask(:,:,15));
        handles.kInfo.mask(:,:,15) = kInfo.mask(:,:,15);
        colormap('jet')
    end
    
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_localization.
function push_localization_Callback(hObject, eventdata, handles)
% hObject    handle to push_localization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Step 4
global img;
global sz;
global imgSmoothed
global kInfo;
global combinedClusters;
global LVlocal;

%%% Localization of Left Ventricle using Blob Techniques
k = 3;
totImgMask = kmeans2(sum(imgSmoothed,3),k);
stdImg = std(imgSmoothed,[],3);

% The blood pool will be brightest and will have highest k-group

[B,L] = bwboundaries(totImgMask == k);
L2 = (totImgMask == k) .* stdImg;
Lstd = zeros(length(B),1);

for i = 1:length(B)    
    blob = L == i;
    Lstd(i) = sum(sum(blob .* L2));
end


f1= figure(1);
[~,ind] = max(Lstd);
subplot(1,3,1)
imagesc(L2)
title('Blobs highlighting standard deviations across time')
axis image
subplot(1,3,2)
plot(Lstd)
title('Plot of sum of std blobs')
subplot(1,3,3)
imagesc(L == ind);
title('Localized LV using Blob Techniques')
axis image

LVpos = (L==ind);
colormap('jet')

%% Localizing left ventricle using Overlaying techniques
d=round(linspace(1,sz(3),2));
opengl software
f2=figure(2);
for i = 1:length(d)
    subplot(1,2,i)
    imagesc(img(:,:,d(i)));
    axis image
    hold on
    tmp = zeros(sz(1),sz(2),3);
    tmp(:,:,1) = LVlocal(:,:,d(i));
    overlay = imagesc(tmp);
    set(overlay,'AlphaData',LVlocal(:,:,d(i)) * 0.7);
    colormap('gray')
end
colormap('gray')
hb = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off', ...
    'Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 0.975,'\bf Localized Left Ventricle Using Overlaying Technique', ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment', 'top', ...
    'FontSize',13);
    
    guidata(hObject, handles);



% --- Executes on button press in push_process.
function push_process_Callback(hObject, eventdata, handles)
% hObject    handle to push_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global sz;
global imgSmoothed
global kInfo;
global combinedClusters;
global LVlocal;
disp('Processing..........................')
% Adaptive Smoothing
disp('Started smoothing.........')
imgSmoothed = adaptiveSmoothing(img);
disp('Smoothing completed!!!')
disp('Started Clustering..............')
% Clustering of Smoothed image
kInfo = getKClusters(imgSmoothed,22);
disp('Clustering completed!!!')
disp('Combining the clusters......')
% Combine all related clusters
combinedClusters = kMeansClusterCombine(kInfo);
disp('Combining the clustering is done!!!')
disp('Started Localizing......')
% Automatically identify the location of the LV
LVlocal = cineLVLocalize(img);
disp('Finished')
disp('Now you may press the smoothed Images')
disp('button to see outputs ')
disp('same for clustered images and localization') 