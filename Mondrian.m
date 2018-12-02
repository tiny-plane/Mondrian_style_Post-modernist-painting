function varargout = Mondrian(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mondrian_OpeningFcn, ...
                   'gui_OutputFcn',  @Mondrian_OutputFcn, ...
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
end

function Mondrian_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
gca;
axis off
end

function varargout = Mondrian_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end

function color_num_Callback(hObject, eventdata, handles)
temp=round(get(handles.color_num,'Value'));
set(handles.num_color,'String',num2str(temp));
end

function color_num_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function draw_pushbutton_Callback(hObject, eventdata, handles)
num_color=round(get(handles.color_num,'Value'));
num_slice=round(get(handles.times_num,'Value'));
main_fun(num_color,num_slice);
end

function times_num_Callback(hObject, eventdata, handles)
temp=round(get(handles.times_num,'Value'));
set(handles.num_slice,'String',num2str(temp));
end

function times_num_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end
function RandomMondrian(a,b,L,W,Lev,num_color)
if Lev==1
    return
elseif Lev==2
    temp=randperm(2);
    temp=temp(1);
    if temp>=2
        return
    end
end
temp=randperm(4);
temp=temp(1);
L1=L/4;
L3=3*L1;
W1=W/4;
W3=3*W1;
Lev=Lev-1;
switch temp
    case 1
        Draw_rect(a,b,L1,W1,num_color)
        Draw_rect(a+L1,b,L3,W1,num_color);
        Draw_rect(a,b+W1,L1,W3,num_color);
        Draw_rect(a+L1,b+W1,L3,W3,num_color);
        RandomMondrian(a,b,L1,W1,Lev,num_color);
        RandomMondrian(a+L1,b,L3,W1,Lev,num_color);
        RandomMondrian(a,b+W1,L1,W3,Lev,num_color);
        RandomMondrian(a+L1,b+W1,L3,W3,Lev,num_color);
    case 2
        Draw_rect(a,b,L3,W1,num_color)
        Draw_rect(a+L3,b,L1,W1,num_color);
        Draw_rect(a,b+W1,L3,W3,num_color);
        Draw_rect(a+L3,b+W1,L1,W3,num_color);
        RandomMondrian(a,b,L3,W1,Lev,num_color);
        RandomMondrian(a+L3,b,L1,W1,Lev,num_color);
        RandomMondrian(a,b+W1,L3,W3,Lev,num_color);
        RandomMondrian(a+L3,b+W1,L1,W3,Lev,num_color);
    case 3
        Draw_rect(a,b,L1,W3,num_color)
        Draw_rect(a+L1,b,L3,W3,num_color);
        Draw_rect(a,b+W3,L1,W1,num_color);
        Draw_rect(a+L1,b+W3,L3,W1,num_color);
        RandomMondrian(a,b,L1,W3,Lev,num_color);
        RandomMondrian(a+L1,b,L3,W3,Lev,num_color);
        RandomMondrian(a,b+W3,L1,W1,Lev,num_color);
        RandomMondrian(a+L1,b+W3,L3,W1,Lev,num_color);
    otherwise
        Draw_rect(a,b,L3,W3,num_color)
        Draw_rect(a+L3,b,L1,W3,num_color);
        Draw_rect(a,b+W3,L3,W1,num_color);
        Draw_rect(a+L3,b+W3,L1,W1,num_color);
        RandomMondrian(a,b,L3,W3,Lev,num_color);
        RandomMondrian(a+L3,b,L1,W3,Lev,num_color);
        RandomMondrian(a,b+W3,L3,W1,Lev,num_color);
        RandomMondrian(a+L3,b+W3,L1,W1,Lev,num_color);
end
end
function Draw_rect(a,b,L,W,num_color,~)
temp=randperm(num_color);
temp=temp(1);
switch temp
    case 1
        color=[160 41 50];
    case 2
        color=[23 124 176];
    case 3
        color=[120 146 98];
    case 4
        color=[169 129 117];
    case 5
        color=[163 226 197];
    case 6
        color=[217 182 18];
    case 7
        color=[239 222 176];
    otherwise
        color=[66 75 80];
end
color=color/255;
x=[a a+L a+L a];
y=[b b b+W b+W];
fill(x,y,color);
end
function main_fun(num_color,num_slice)
gca;
cla;
hold on
axis off
axis([0 10 0 10])
RandomMondrian(0,0,10,10,num_slice,num_color);
hold off
end