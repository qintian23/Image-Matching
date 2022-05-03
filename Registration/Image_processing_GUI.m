%乱码直接复制替换
function varargout = Image_processing_GUI(varargin)
% IMAGE_PROCESSING_GUI MATLAB code for Image_processing_GUI.fig
%      IMAGE_PROCESSING_GUI, by itself, creates a new IMAGE_PROCESSING_GUI or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING_GUI returns the handle to a new IMAGE_PROCESSING_GUI or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING_GUI.M with the given input arguments.
%
%      IMAGE_PROCESSING_GUI('Property','Value',...) creates a new IMAGE_PROCESSING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_processing_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_processing_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_processing_GUI

% Last Modified by GUIDE v2.5 04-Sep-2021 08:30:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_processing_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_processing_GUI_OutputFcn, ...
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


% --- Executes just before Image_processing_GUI is made visible.
function Image_processing_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_processing_GUI (see VARARGIN)

% Choose default command line output for Image_processing_GUI
handles.output = hObject;

set(handles.save,'Enable','off');
set(handles.exit,'Enable','off');
set(handles.reset,'Enable','off');
set(handles.g1,'Visible','off');
set(handles.g2,'Visible','off');
set(handles.g3,'Visible','off');
set(handles.g4,'Visible','off');
set(handles.g5,'Visible','off');
set(handles.n1,'Enable','off');
set(handles.n2,'Enable','off');
set(handles.n3,'Enable','off');
set(handles.n4,'Enable','off');
set(handles.f1,'Enable','off');
set(handles.f2,'Enable','off');
set(handles.f3,'Enable','off');
set(handles.slider1,'Enable','off');
set(handles.slider2,'Enable','off');
set(handles.slider3,'Enable','off');
set(handles.slider4,'Enable','off');
set(handles.slider5,'Enable','off');
set(handles.m1,'Enable','off');
set(handles.m2,'Enable','off');
set(handles.m3,'Enable','off');
set(handles.m4,'Enable','off');
set(handles.m5,'Enable','off');
set(handles.m6,'Enable','off');
set(handles.m7,'Enable','off');
set(handles.m8,'Enable','off');
set(handles.m9,'Enable','off');
set(handles.p1,'Enable','off');
set(handles.p2,'Enable','off');
set(handles.p3,'Enable','off');
set(handles.p4,'Enable','off');
set(handles.p5,'Enable','off');
set(handles.invc,'Enable','off');
set(handles.dia,'Enable','off');
set(handles.ero,'Enable','off');
set(handles.strel,'Enable','off');
set(handles.strels,'Enable','off');
set(handles.strelv,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_processing_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_processing_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%示波器g4彩色图象更新函数
function updateg4(handles)
r=handles.img(:,:,1);
g=handles.img(:,:,2);
b=handles.img(:,:,3);
x=size(r);
x=(1:x(1,2));
r=r(1,:);
g=g(1,:); 
b=b(1,:);
axes(handles.g4);
cla;
plot(x,r,'r');
hold on
plot(x,g,'g'); 
plot(x,b,'b');
hold off;

ImageData1 = reshape(handles.img(:,:,1), [size(handles.img, 1) * size(handles.img, 2) 1]);
ImageData2 = reshape(handles.img(:,:,2), [size(handles.img, 1) * size(handles.img, 2) 1]);
ImageData3 = reshape(handles.img(:,:,3), [size(handles.img, 1) * size(handles.img, 2) 1]);
[H1, X1] = hist(ImageData1, 1:5:256);
[H2, X2] = hist(ImageData2, 1:5:256);
[H3, X3] = hist(ImageData3, 1:5:256);
axes(handles.g5); 
cla;
hold on;
plot(X1, H1, 'r');
plot(X2, H2, 'g');
plot(X3, H3, 'b');    
axis([0 256 0 max([H1 H2 H3])]);

%示波器灰色图象更新函数
function updateg4_1(handles)

k=handles.img(:,:,1);
x=size(k);
x=(1:x(1,2));
k=k(1,:);
axes(handles.g4);
cla;
plot(x,k,'k');

ImageData = reshape(handles.img, [size(handles.img, 1) * size(handles.img, 2) 1]);
[H, X] = hist(ImageData, 1:5:256);
axes(handles.g5); 
cla;
hold on;
plot(X, H, 'k');  
axis([0 256 0 max(H)]);

%打开
% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)

[file path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, '打开文件');
image=[path file];
handles.file=image;
if (file==0)
    warndlg('请选择一张图片...') ;
end
[fpath, fname, fext]=fileparts(file);
validex=({'.bmp','.jpg','.jpeg','.png'});
found=0;
for (x=1:length(validex))
   if (strcmpi(fext,validex{x}))
       found=1;
     
set(handles.save,'Enable','on');
set(handles.exit,'Enable','on');
set(handles.reset,'Enable','on');
set(handles.g1,'Visible','on');
set(handles.g2,'Visible','on');
set(handles.g3,'Visible','on');
set(handles.g4,'Visible','on');
set(handles.g5,'Visible','on');
set(handles.n1,'Enable','on');
set(handles.n2,'Enable','on');
set(handles.n3,'Enable','on');
set(handles.n4,'Enable','on');
set(handles.f1,'Enable','on');
set(handles.f2,'Enable','on');
set(handles.f3,'Enable','on');
set(handles.slider1,'Enable','on');
set(handles.slider2,'Enable','on');
set(handles.slider3,'Enable','on');
set(handles.slider4,'Enable','on');
set(handles.slider5,'Enable','on');
set(handles.m1,'Enable','on');
set(handles.m2,'Enable','on');
set(handles.m3,'Enable','on');
set(handles.m4,'Enable','on');
set(handles.m5,'Enable','on');
set(handles.m6,'Enable','on');
set(handles.m7,'Enable','on');
set(handles.m8,'Enable','on');
set(handles.m9,'Enable','on');
set(handles.p1,'Enable','on');
set(handles.p2,'Enable','on');
set(handles.p3,'Enable','on');
set(handles.p4,'Enable','on');
set(handles.p5,'Enable','on');
set(handles.invc,'Enable','on');
set(handles.dia,'Enable','on');
set(handles.ero,'Enable','on');
set(handles.strel,'Enable','on');
set(handles.strels,'Enable','on');
set(handles.strelv,'Enable','on');

handles.img=imread(image);
handles.i=imread(image);
h = waitbar(0,'等待...');
steps = 100;

for step = 1:steps
    waitbar(step / steps)
end
close(h) 
axes(handles.g1); 
cla; 
imshow(handles.img);
axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);
break; 
end
end
if (found==0)
     errordlg('文件扩展名不正确，请从可用扩展名[.jpg、.jpeg、.bmp、.png]中选择文件','Image Format Error');
end

set(handles.g3,'Visible','on');
set(handles.g4,'Visible','on');

% 示波器g3更新
mysize=size(handles.img);
if numel(mysize)>2
    r=handles.i(:,:,1);
    g=handles.i(:,:,2);
    b=handles.i(:,:,3);
    x=size(r); 
    x=(1:x(1,2));
    r=r(1,:); 
    g=g(1,:); 
    b=b(1,:);
    axes(handles.g3); 
    cla;
    plot(x,r,'r');
    hold on
    plot(x,g,'g');
    plot(x,b,'b'); 
    set(gca,'xtick',-inf:inf:inf);
    hold off;
else
    k=handles.img(:,:,1);
    x=size(k);
    x=(1:x(1,2));
    k=k(1,:);
    axes(handles.g3);
    cla;
    plot(x,k,'k');
end
    
%示波器g5更新
mysize=size(handles.img);
if numel(mysize)>2
    ImageData1 = reshape(handles.img(:,:,1), [size(handles.img, 1) * size(handles.img, 2) 1]);
    ImageData2 = reshape(handles.img(:,:,2), [size(handles.img, 1) * size(handles.img, 2) 1]);
    ImageData3 = reshape(handles.img(:,:,3), [size(handles.img, 1) * size(handles.img, 2) 1]);
    [H1, X1] = hist(ImageData1, 1:5:256);
    [H2, X2] = hist(ImageData2, 1:5:256);
    [H3, X3] = hist(ImageData3, 1:5:256);
    axes(handles.g5); 
    cla;
    hold on;
    plot(X1, H1, 'r');
    plot(X2, H2, 'g');
    plot(X3, H3, 'b');    
    axis([0 256 0 max([H1 H2 H3])]);
else
    ImageData = reshape(handles.img, [size(handles.img, 1) * size(handles.img, 2) 1]);
    [H, X] = hist(ImageData, 1:5:256);
    axes(handles.g5); 
    cla;
    hold on;
    plot(X, H, 'k');  
    axis([0 256 0 max(H)]);
end
    
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 


% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%退出
% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)

close all;

% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%保存
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)

[file path]= uiputfile('*.jpg','Save Image as');
save=[path file]; imwrite(handles.img,save,'jpg');

% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)

handles.img=handles.i;
axes(handles.g2); 
cla; 
imshow(handles.img);
updateg4(handles);
guidata(hObject,handles);

% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in n1.
function n1_Callback(hObject, eventdata, handles)

handles.img = imnoise(handles.img,'gaussian');
axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);
    
mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in n2.
function n2_Callback(hObject, eventdata, handles)

h = waitbar(0,'等待...');
steps = 200;
for step = 1:steps
    waitbar(step / steps)
end
close(h) 
handles.img = imnoise(handles.img,'poisson');
    axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in n3.
function n3_Callback(hObject, eventdata, handles)

handles.img = imnoise(handles.img,'salt & pepper',0.02);
axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to n3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in n4.
function n4_Callback(hObject, eventdata, handles)

handles.img = imnoise(handles.img,'speckle',0.04);
axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 


% hObject    handle to n4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in f2.
function f2_Callback(hObject, eventdata, handles)

hsize=[8 8]; sigma=1.7;
h=fspecial('gaussian',hsize,sigma);
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in f1.
function f1_Callback(hObject, eventdata, handles)

h=fspecial('average');
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g2); cla; imshow(handles.img)
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in f3.
function f3_Callback(hObject, eventdata, handles)

r=medfilt2(handles.img(:,:,1));
g=medfilt2(handles.img(:,:,2));
b=medfilt2(handles.img(:,:,3)); 
handles.img=cat(3,r,g,b);
axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

x=get(hObject,'Value');
r=handles.img(:,:,1);
g=handles.img(:,:,2);
b=handles.img(:,:,3);
r1=r+x; 
rcon=cat(3,r1,g,b);
axes(handles.g2); 
cla; 
imshow(rcon)
handles.img=rcon;
r=handles.img(:,:,1);
g=handles.img(:,:,2);
b=handles.img(:,:,3);
x=size(r); 
x=(1:x(1,2));
r=r(1,:); 
g=g(1,:); 
b=b(1,:);
axes(handles.g4); 
plot(x,r,'r');
hold on
plot(x,g,'g'); 
plot(x,b,'b'); 
hold off;

% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

x=get(hObject,'Value');
r=handles.img(:,:,1);
g=handles.img(:,:,2); b=handles.img(:,:,3);
g1=g+x; gcon=cat(3,r,g1,b);
axes(handles.g2); cla; imshow(gcon)
handles.img=gcon;

updateg4(handles)

% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)

x=get(hObject,'Value');
r=handles.img(:,:,1);
g=handles.img(:,:,2); b=handles.img(:,:,3);
b1=b+x; bcon=cat(3,r,g,b1);
axes(handles.g2); cla; imshow(bcon)
handles.img=bcon;
updateg4(handles)

% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in m6.
function m6_Callback(hObject, eventdata, handles)

handles.img = rgb2gray(handles.img);
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);


% hObject    handle to m6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m8.
function m8_Callback(hObject, eventdata, handles)

handles.img=fliplr(handles.img);
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to m8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m9.
function m9_Callback(hObject, eventdata, handles)

handles.img=flipud(handles.img);
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);

mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to m9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m1.
function m1_Callback(hObject, eventdata, handles)

mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'sobel');
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m2.
function m2_Callback(hObject, eventdata, handles)

mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'roberts');
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m3.
function m3_Callback(hObject, eventdata, handles)

mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'prewitt');
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m4.
function m4_Callback(hObject, eventdata, handles)

mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'log');
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m5.
function m5_Callback(hObject, eventdata, handles)

mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'canny');
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in invc.
function invc_Callback(hObject, eventdata, handles)

x=handles.img;
r=x(:,:,1); r=256-r;
g=x(:,:,2); g=256-g;
b=x(:,:,3); b=256-b;
handles.img=cat(3,r,g,b);
axes(handles.g2);
cla; 
imshow(handles.img);
updateg4(handles);
guidata(hObject,handles);

% hObject    handle to invc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m7.
function m7_Callback(hObject, eventdata, handles)

thresh = graythresh(handles.img);     %自动确定二值化阈值
handles.img = im2bw(handles.img,thresh);
axes(handles.g2);
cla;
imshow(handles.img);
guidata(hObject,handles);
updateg4_1(handles);

% hObject    handle to m7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in strels.
function strels_Callback(hObject, eventdata, handles)

handles.img=handles.mori;
axes(handles.g2); 
cla; 
imshow(handles.img)
guidata(hObject,handles);
updateg4(handles);

% hObject    handle to strels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)

x=get(hObject,'Value');
img=handles.img;
img=img+x;
axes(handles.g2); cla; imshow(img)
handles.img=img;
updateg4(handles)

% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in dia.
function dia_Callback(hObject, eventdata, handles)

handles.mori=handles.img;
str=strel(handles.strel,handles.value);
handles.mori=imdilate(handles.mori,str);
axes(handles.g2);
cla;
imshow(handles.mori)
guidata(hObject,handles);
handles.img=handles.mori;
mysize=size(handles.img);

guidata(hObject,handles);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to dia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ero.
function ero_Callback(hObject, eventdata, handles)

handles.mori=handles.img;
str=strel(handles.strel,handles.value);
handles.mori=imerode(handles.mori,str);
axes(handles.g2);
cla; 
imshow(handles.mori)
guidata(hObject,handles);
handles.img=handles.mori;

guidata(hObject,handles);
mysize=size(handles.img);
if numel(mysize)>2
    updateg4(handles)
else
    updateg4_1(handles)
end 

% hObject    handle to ero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function strelv_Callback(hObject, eventdata, handles)

handles.value=str2num(get(hObject,'String'));
guidata(hObject,handles);

% hObject    handle to strelv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of strelv as text
%        str2double(get(hObject,'String')) returns contents of strelv as a double


% --- Executes during object creation, after setting all properties.
function strelv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strelv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in strel.
function strel_Callback(hObject, eventdata, handles)

val=get(hObject,'Value');
switch val
        case 1
        helpdlg('请选择一种结构元素类型','Morphological Operations');
        case 2
        handles.strel='diamond';
        case 3
        handles.strel='disk';
        case 4
        helpdlg('值必须是3的非负倍数','Octagon Structure Help');
        handles.strel='octagon';
end
guidata(hObject,handles);

% hObject    handle to strel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns strel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from strel


% --- Executes during object creation, after setting all properties.
function strel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)

rrv=(get(hObject,'Value'));
handles.rot=handles.img;
handles.rot=imrotate(handles.rot,rrv);
axes(handles.g2); cla; imshow(handles.rot);
guidata(hObject,handles)

% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in p2.
function p2_Callback(hObject, eventdata, handles)
%理想低通滤波器
mysize=size(handles.img);
if numel(mysize)>2
    handles.img = rgb2gray(handles.img);
end

I=handles.img;
I=im2double(I);
M=2*size(I,1);
N=2*size(I,2);
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);
D=sqrt(U.^2+V.^2);
D0=80;
H=double(D<=D0);
J=fftshift(fft2(I,size(H,1),size(H,2)));
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1),1:size(I,2));
handles.img=L;

axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);

updateg4_1(handles)




% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in p3.
function p3_Callback(hObject, eventdata, handles)
%巴特沃斯高通滤波器
mysize=size(handles.img);
if numel(mysize)>2
    handles.img = rgb2gray(handles.img);
end

I=handles.img;
I=im2double(I);
M=2*size(I,1);%滤波器行数
N=2*size(I,2);%滤波器列数
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);
D=sqrt(U.^2+V.^2);
D0=30;%截止频率
n=6;%巴特沃斯滤波器阶数
H=1./(1+(D0./D).^(2*n));
J=fftshift(fft2(I,size(H,1),size(H,2)));
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1),1:size(I,2));
handles.img=L;

axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);

updateg4_1(handles)

% hObject    handle to p3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in p4.
function p4_Callback(hObject, eventdata, handles)
%带阻滤波器
mysize=size(handles.img);
if numel(mysize)>2
    handles.img = rgb2gray(handles.img);
end

I=handles.img;
I=imnoise(I,'gaussian',0,0.01);
I=im2double(I);
M=2*size(I,1);%滤波器行数
N=2*size(I,2);%滤波器列数
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);
D=sqrt(U.^2+V.^2);
D0=50;%滤波器D0
W=30;%滤波器带宽
H=double(or(D<(D0-W/2),D>D0+W/2));
J=fftshift(fft2(I,size(H,1),size(H,2)));
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1),1:size(I,2));
handles.img=L;

axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);

updateg4_1(handles)

% hObject    handle to p4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in p5.
function p5_Callback(hObject, eventdata, handles)
%同态滤波器
mysize=size(handles.img);
if numel(mysize)>2
    handles.img = rgb2gray(handles.img);
end

I=handles.img;
J=log(im2double(I)+1);
K=fft2(J);
n=5;
D0=0.1*pi;
rh=0.7;
rl=0.4;
[row, column]=size(J);
for i=1:row
    for j=i:column
        D1(i,j)=sqrt(i^2+j^2);
        H(i,j)=rl+(rh/(1+(D0/D1(i,j))^(2*n)));
    end
end
L=K.*H;
M=ifft2(L);
N=exp(M)-1;
handles.img=N;

axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);

updateg4_1(handles)

% hObject    handle to p5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in p1.
function p1_Callback(hObject, eventdata, handles)
%维纳滤波复原，复原含有噪声和运动模糊的图片
mysize=size(handles.img);
if numel(mysize)>2
    handles.img = rgb2gray(handles.img);
end

I=handles.img;
I=im2double(I);
LEN=20;%参数设置
THETA=10;
PSF=fspecial('motion',LEN,THETA);%产生PSF
J=imfilter(I,PSF,'conv','circular');%运动模糊
noise=0.03*randn(size(I));
K=imadd(J,noise);%添加噪声
NP=abs(fft2(noise)).^2;
NPower=sum(NP(:))/prod(size(noise));
NCORR=fftshift(real(ifft2(NP)));
IP=abs(fft2(I).^2);
IPower=sum(IP(:))/prod(size(I));
ICORR=fftshift(real(ifft2(IP)));
L=deconvwnr(K,PSF,NCORR,ICORR);
handles.img=L;

axes(handles.g2); 
cla; 
imshow(handles.img);
guidata(hObject,handles);

updateg4_1(handles)

% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
