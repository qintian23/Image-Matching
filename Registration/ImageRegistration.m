function varargout=ImageRegistration(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gui_Singleton=1;
gui_State=struct('gui_Name', mfilename, 'gui_Singleton', gui_Singleton, 'gui_OpeningFcn', @ImageRegistration_OpeningFcn, ...
                 'gui_OutputFcn', @ImageRegistration_OutputFcn, 'gui_LayoutFcn', [], 'gui_Callback', []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(pwd);

function ImageRegistration_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output=hObject;
    guidata(hObject, handles);
end

function varargout = ImageRegistration_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;
end

function pushbutton1_Callback(hObject, eventdata, handles)
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
end

function pushbutton2_Callback(hObject, eventdata, handles)
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
end


function pushbutton3_Callback(hObject, eventdata, handles)
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
end

end