function varargout = SetCrackWithTest(varargin)
% SETCRACKWITHTEST MATLAB code for SetCrackWithTest.fig
%      SETCRACKWITHTEST, by itself, creates a new SETCRACKWITHTEST or raises the existing
%      singleton*.
%
%      H = SETCRACKWITHTEST returns the handle to a new SETCRACKWITHTEST or the handle to
%      the existing singleton*.
%
%      SETCRACKWITHTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETCRACKWITHTEST.M with the given input arguments.
%
%      SETCRACKWITHTEST('Property','Value',...) creates a new SETCRACKWITHTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SetCrackWithTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SetCrackWithTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SetCrackWithTest

% Last Modified by GUIDE v2.5 04-Oct-2016 17:22:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SetCrackWithTest_OpeningFcn, ...
                   'gui_OutputFcn',  @SetCrackWithTest_OutputFcn, ...
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


% --- Executes just before SetCrackWithTest is made visible.
function SetCrackWithTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SetCrackWithTest (see VARARGIN)

% Choose default command line output for SetCrackWithTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global height width Seed_Mat;




% UIWAIT makes SetCrackWithTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);  


% --- Outputs from this function are returned to the command line.
function varargout = SetCrackWithTest_OutputFcn(hObject, eventdata, handles) 
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

global Seed_Mat im2;
% datacursormode on
% menu = findall(get(gcf,'Children'),'Type','uicontextmenu');
% menuCallback = get(menu,'Callback');
% dataCursor = menuCallback{4};
% info = getCursorInfo(dataCursor);
% if ~isempty(info)
% disp(info.Position)
% end
% 
% %  dcm_obj = datacursormode(handles.F1);


[x,y] = ginput(1);


Seed_Mat(floor(y)-1 :floor(y)+1  ,floor(x)-1 : floor(x) +1) = 1;








% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im2;
axes(handles.axes2);
imshow(im2);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Seed_Mat;
axes(handles.axes2);
imshow(Seed_Mat,[]);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Seed_Mat im2 Output;

 Output = Percolation_3(im2,Seed_Mat);
 imshow(Output);
 






% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im im2 height width Seed_Mat figure;
[path,user_cance] = imgetfile();
if user_cance
    msgbox(sprintf('이미지 불러주세요'),'Error','Error');
    return
end

im = imread(path);
im2 = im;
axes(handles.axes2);
imshow(im);
channel=0;

[height,width,channel] = size(im);

Seed_Mat = logical(zeros(height,width));


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Seed_Mat Output im2;
axes(handles.axes2);
imshowpair(Seed_Mat,im2);




% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Seed_Mat Output im2;
axes(handles.axes2);
imshowpair(Seed_Mat,Output);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Seed_Mat Output im2;
axes(handles.axes2);
imshowpair(im2,Output);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Seed_Mat Output im2;
axes(handles.axes2);
imshow(Output);
