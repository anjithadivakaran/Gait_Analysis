function varargout = gait_analysis(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gait_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @gait_analysis_OutputFcn, ...
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

function gait_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

axes(handles.axes11);
imshow('1angle.png');
axes(handles.axes12);
imshow('2angle.png');
axes(handles.axes13);
imshow('3angle.png');


function varargout = gait_analysis_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function figure1_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject);


% function for uploading the video file
function pushbutton_get_file1_Callback(hObject, eventdata, handles)

file_name=uigetfile({'*.mp4;*.AVI;'},'Choose file');
if file_name ~= 0
    set(handles.pushbutton_get_file1, 'Enable', 'Off');
    video = VideoReader(file_name);
    frameNo = 1;
    [angle1, user_cent] = main_f(handles,video,frameNo);
    assignin('base','angle1',angle1);
    assignin('base','user_cent',user_cent);
    step_loop(handles,angle1,1,user_cent); 
end
set(handles.pushbutton10, 'Enable', 'On');


% --- Executes on button press in pushbutton10. Resets all the GUI
% components
function pushbutton10_Callback(hObject, eventdata, handles)
set(handles.pushbutton_get_file1, 'Enable', 'On');
set(handles.pushbutton10, 'Enable', 'Off');
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes8,'reset');
cla(handles.axes9,'reset');
cla(handles.axes10,'reset');
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
