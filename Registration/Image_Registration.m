function varargout = Image_Registration(varargin)
% IMAGE_REGISTRATION MATLAB code for Image_Registration.fig
%      IMAGE_REGISTRATION, by itself, creates a new IMAGE_REGISTRATION or raises the existing
%      singleton*.
%
%      H = IMAGE_REGISTRATION returns the handle to a new IMAGE_REGISTRATION or the handle to
%      the existing singleton*.
%
%      IMAGE_REGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_REGISTRATION.M with the given input arguments.
%
%      IMAGE_REGISTRATION('Property','Value',...) creates a new IMAGE_REGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Registration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Registration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Registration

% Last Modified by GUIDE v2.5 03-May-2022 21:55:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Registration_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Registration_OutputFcn, ...
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

addpath(pwd);

% --- Executes just before Image_Registration is made visible.
function Image_Registration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Registration (see VARARGIN)

% Choose default command line output for Image_Registration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Registration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Registration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc
    %%%%%%%%%%%%%% 调用OpenImage.m 读入参考图像并获取文件名、图像大小 %%%%%%%%%%%%%%%%%%
    Image_I.FileInformation.IsImage=0;
    while Image_I.FileInformation.IsImage==0
        Image_I=OpenImage;
    end
    delete(Image_I.figure1);
    handles.ImsizeI=Image_I.FileInformation.imsize;
    handles.filenameI=Image_I.FileInformation.filename;
    handles.names_dispI=Image_I.FileInformation.names_disp;
    set(hObject.text2, 'String', handles.names_dispI);
    guidata(hObject, handles);

    %%%%%%%%%%%%%% 显示参考图像
    axes(handles.axes1)
    I=imread(handles.filenameI);
    imshow(I)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc
    %%%%%%%%%%%%%% 调用OpenImage.m 读入浮动图像并获取文件名、图像大小 %%%%%%%%%%%%%%%%%%
    Image_J.FileInformation.IsImage=0;
    while Image_J.FileInformation.IsImage==0
        Image_J=OpenImage;
    end
    delete(Image_J.figure1);
    handles.ImsizeJ=Image_J.FileInformation.imsize;
    handles.filenameJ=Image_J.FileInformation.filename;
    handles.names_dispJ=Image_J.FileInformation.names_disp;
    set(hObject.text3, 'String', handles.names_dispJ);
    guidata(hObject, handles);

    %%%%%%%%%%%%%% 显示参考图像
    axes(handles.axes2)
    J=imread(handles.filenameJ);
    imshow(J)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc;
    %%%%%%%%%%%%%% 检查是否已输入参考图像与浮动图像 %%%%%%%%%%%%%%%%%%
    axesIbox = get(handles.axes1, 'box');
    axesJbox = get(handles.axes2, 'box');
    if strcmp(axesIbox, 'off') | strcmp(axesJbox, 'off')
        errordlg('Please select Image for Registration', 'Error')
        error('NO Image!');
    end

    %%%%%%%%%%%%%% 检查参考图像与浮动图像大小是否相同 %%%%%%%%%%%%%%%%%%
    handles.isSameSizeIJ=strcmp(handles.ImsizeI, handles.Imsize_J);
    if handles.isSameSizeIJ~=1
        errordlg('Please Size doesn''t match')
    end

    %%%%%%%%%%%%%% 读入并复制图像，一幅用于配准过程，另一幅用于配准后输出 %%%%%%%%%%%%%%%%%%
    I1=imread(handles.filenameI);
    J1=imread(handles.filenameJ);
    handles.Old_I=I1;
    handles.Old_J=J1;
    I=ImageTransfer_add(I1);
    J=ImageTransfer_add(J1);
    handles.I=I;
    handles.J=J;

    guidata(hObject, handles);

    %%%%%%%%%%%%%% 显示配准前参考图像与浮动图像的“融合”效果图 %%%%%%%%%%%%%%%%%%
    axes(handles.axes3);
    imshow(uint8(I+J));

    %%%%%%%%%%%%%% 调用函数GLPF.m，完成高斯低通预处理 %%%%%%%%%%%%%%%%%%
    [I, J]=GLPF(handles);
    handles.I=I;
    handles.J=J;
    guidata(hObject, handles);

    %%%%%%%%%%%%%% 调用函数Powell.m，实现图像配准 %%%%%%%%%%%%%%%%%%
    tic
    RegistrationParameters = Powell(handles);
    toc
    ElapsedTime=toc;

    %%%%%%%%%%%%%% 显示配准结果 %%%%%%%%%%%%%%%%%%
    handles.RegistrationParameters=RegistrationParameters;
    x=RegistrationParameters(1);
    y=RegistrationParameters(2);
    ang=RegistrationParameters(3);
    MI_Value=RegistrationParameters(4);
    RegistrationResult=sprintf('X,Y,Angle=[%.5f] [%.5f] [%.5f]', x, y, ang);
    MI_Value=sprintf('MI-Value=[%.4f]', MI_Value);
    ElapsedTime=sprintf('Elapsed Time=[%.3f]', ElapsedTime)

    axes(handles.axes4);
    [FusionImage, RegistrationImage]=Fusion(handles);
    imshow(FusionImage);

    axes(handles.axes5)
    imshow(RegistrationImage)

    set(handles.text8, 'string', RegistrationResult);
    set(handles.text9, 'string', MI_Value);
    set(handles.text10, 'string', ElapsedTime);