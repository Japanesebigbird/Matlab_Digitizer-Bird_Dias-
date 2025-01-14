function	DegitizePro001();

clear all
close all


	%=================
	%DegitizeFigure
	%=================
	DegitizeFigure();


return;





%=====================================================
%	InternalFunction
%=====================================================
function	DegitizeFigure();

	nCam			=	1;

	global	Time1

	Time1	=	tic;



	%=============
	%PenImage
	%=============
	BaseData.ImageData.Pencil01		=	imread('./ImageDataFile/Pen01.png');
	BaseData.ImageData.Pencil02		=	imread('./ImageDataFile/Pen02.png');
	BaseData.ImageData.RecButton	=	imread('./ImageDataFile/RecButton01.png');
	BaseData.ImageData.Exit				=	imread('./ImageDataFile/Exit.png');
	BaseData.ImageData.Load				=	imread('./ImageDataFile/Load.jpg');
	BaseData.ImageData.VideoDeki	=	imread('./ImageDataFile/Video.png');
	BaseData.ImageData.List				=	imread('./ImageDataFile/List.png');



	BaseData.Degi_Point	=	{''};
	BaseData.RowList		=	{''};
	BaseData.nFr				=	[];
	BaseData.nPoint			=	23;

	Cam								=	[];
	MovieData					=	[];


	%====================
	%Figure1
	%====================
	WindowHandle(1).fig	=	figure;
	set(	WindowHandle(1).fig,...
				'name',									'Bird-DIAS',...
				'numbertitle',					'off',...
				'doublebuffer',					'on',...
				'Toolbar',							'none',...
				'closerequestfcn',			'closereq',...
				'Position',							[0 0 900,600],...
				'Resize',								'off',...
				'Visible',							'on',...
				'tag',									'fig_Degitize',...
				'HitTest',							'Off',...
				'Color',								[0.8 0.8 0.8],...
				'WindowScrollWheelFcn',	@ScrollWheelFcn,...
				'WindowButtonDownFcn',	@MouseButtonDownFcn,...
				'WindowButtonUpFcn',		@MouseUpFunc,...
				'KeyPressFcn',					@KeyPressFunc,...
				'Interruptible',				'Off',...
				'BusyAction',						'cancel',...
				'userdata',							{BaseData Cam MovieData});

	WindowHandle(1).Color			=	get(WindowHandle(1).fig,'Color');
	WindowHandle(1).Posi			=	get(WindowHandle(1).fig,'Position');



	%====
	%Tab
	%====
	nTab	=	nCam;

	WindowHandle(1).TabGroup			=	uitabgroup('Parent',WindowHandle(1).fig);
																	set(	WindowHandle(1).TabGroup,...
																				'Position',			[0,0,1.0,1.0],...
																				'Tag',					'Tag_TabGroup');
	for	iTab	=	1:nTab

		%----
		%Tab
		%----
		TabGroupHandle(1).Tab(iTab)	=	uitab(	'Parent',WindowHandle(1).TabGroup);
																		set(	TabGroupHandle(1).Tab(iTab),...
																					'title',											[ 'Camera ' num2str(iTab) ],...
																					'BackgroundColor',						[	WindowHandle(1).Color	],...
																					'Tag',												[ 'Tag_Tab' num2str(iTab)]);

		%---------
		%Sheet
		%---------
		Handle_Tab		=	TabGroupHandle(1).Tab(iTab);
		uitable(	'Parent',									Handle_Tab,...
							'Position',								[0,0,WindowHandle(1).Posi(3)*0.20,WindowHandle(1).Posi(4)*0.77],...
							'CellSelectionCallback',	{@CellSelectionFunc iTab},...
							'Interruptible',					'Off',...
							'BusyAction',						'cancel',...
							'KeyPressFcn',					@KeyPressFunc,...
							'Tag',										['Tag_Table' num2str(iTab)],...
							'Data',										{' '},...
							'userdata',								{	[1,1]	});


		%-----------
		%MakeAxes
		%-----------
		TabHandle(iTab).Axes			=	axes(	'Parent',			Handle_Tab);
																set(	TabHandle(iTab).Axes,...
																			'Position',								[0.20 0.0 0.80 0.80]);

		%--------
		%Image
		%--------
		Image_Data			=	imread('./ImageDataFile/Original.png');
		[Tate,Yoko,Oku]	=	size(Image_Data);

		TabHandle(iTab).ImageHand	=	image(Image_Data,'Parent',TabHandle(iTab).Axes);

		set(	TabHandle(iTab).ImageHand,...
					'ButtonDownFcn',						{@Get_CoodData iTab},...
					'Tag',											['Tag_Image' num2str(iTab)]);


		%----------
		%Set Axes
		%----------
		set(	TabHandle(iTab).Axes,...
					'Visible',								'on',...
					'Color',									[	WindowHandle(1).Color	],...
					'XColor',									[	WindowHandle(1).Color	],...
					'YColor',									[	WindowHandle(1).Color	],...
					'ZColor',									[	WindowHandle(1).Color	],...
					'Tag',										['Tag_Axes' num2str(iTab)]);


		%-------------
		%	Save Button
		%	Button_Num1
		%-------------
		uicontrol(	Handle_Tab,...
								'style',								'pushbutton',...
								'position',							[	WindowHandle(1).Posi(3)*0.5,	WindowHandle(1).Posi(4)*0.88,	40,	40	],...
								'enable',								'on',...
								'BackgroundColor',			WindowHandle(1).Color,...
								'CData',								BaseData.ImageData.RecButton,...
								'callback',							{@Button_Func_2, 1,iTab});




		%-----------------------
		%	Load Button_CoodData
		%	Button_Num2
		%-----------------------
		uicontrol(	Handle_Tab,...
								'style',								'pushbutton',...
								'position',							[	WindowHandle(1).Posi(3)*0.50,	WindowHandle(1).Posi(4)*0.80,	40,	40	],...
								'enable',								'on',...
								'BackgroundColor',			WindowHandle(1).Color,...
								'CData',								BaseData.ImageData.Load,...
								'callback',							{@Button_Func_2, 2,iTab});


		%-----------------------
		%	Load Button ImageData
		%	Button_Num3
		%-----------------------
		uicontrol(	Handle_Tab,...
								'style',								'pushbutton',...
								'position',							[	WindowHandle(1).Posi(3)*0.50+60,	WindowHandle(1).Posi(4)*0.88,	40,	40	],...
								'enable',								'on',...
								'BackgroundColor',			WindowHandle(1).Color,...
								'CData',								BaseData.ImageData.VideoDeki,...
								'callback',							{@Button_Func_2, 3,iTab});

		%-----------------------
		%	Load Button ImageData
		%	Button_Num4
		%-----------------------
		uicontrol(	Handle_Tab,...
								'style',								'pushbutton',...
								'position',							[	WindowHandle(1).Posi(3)*0.50+60,	WindowHandle(1).Posi(4)*0.80,	40,	40	],...
								'enable',								'off',...
								'BackgroundColor',			WindowHandle(1).Color,...
								'CData',								BaseData.ImageData.List,...
								'callback',							{@Button_Func_2, 4,iTab});


		%-----------------------
		%	String Edit
		%	StartFre
		%	EndFre
		%-----------------------
		XITI	=	WindowHandle(1).Posi(3)*0.65;
		YITI	=	WindowHandle(1).Posi(4)*0.85;
		uicontrol(	Handle_Tab,...
								'style',								'edit',...
								'position',							[XITI,YITI,150,30],...
								'FontSize',							24,...
								'FontName',							'Times New Roman',...
								'HorizontalAlignment',	'center',...
								'enable',								'off',...
								'BackgroundColor',			WindowHandle(1).Color+0.2,...
								'callback',							{@Button_Func_2, 10,iTab},...
								'Tag',									'Tag_StartFre'	);

		uicontrol(	Handle_Tab,...
								'style',								'text',...
								'position',							[XITI,YITI+30,150,25],...
								'string',								'Start Frame',...
								'FontSize',							18,...
								'FontName',							'Times New Roman',...
								'HorizontalAlignment',	'center',...
								'enable',								'on',...
								'BackgroundColor',			WindowHandle(1).Color+0.1);


		XITI	=	WindowHandle(1).Posi(3)*0.83;
		YITI	=	WindowHandle(1).Posi(4)*0.85;
		uicontrol(	Handle_Tab,...
								'style',								'edit',...
								'position',							[XITI,YITI,150,30],...
								'FontSize',							24,...
								'FontName',							'Times New Roman',...
								'HorizontalAlignment',	'center',...
								'enable',								'off',...
								'BackgroundColor',			WindowHandle(1).Color+0.2,...
								'callback',							{@Button_Func_2, 10,iTab},...
								'Tag',									'Tag_EndFre'	);

		uicontrol(	Handle_Tab,...
								'style',								'text',...
								'position',							[XITI,YITI+30,150,25],...
								'string',								'End Frame',...
								'FontSize',							18,...
								'FontName',							'Times New Roman',...
								'HorizontalAlignment',	'center',...
								'enable',								'on',...
								'BackgroundColor',			WindowHandle(1).Color+0.1);


		%-----------------
		%	Exit Button
		%	Button_Num5
		%-----------------
		uicontrol(	Handle_Tab,...
								'style',								'pushbutton',...
								'position',							[1087,822,108,48],...
								'Visible',							'off',...
								'enable',								'off',...
								'BackgroundColor',			WindowHandle(1).Color,...
								'CData',								BaseData.ImageData.Exit,...
								'callback',							{@Button_Func_2, 5,iTab});


		%---------------
		%	Frame Slider
		%	Button_Num6
		%---------------
		XITI	=	5;
		YITI	=	WindowHandle(1).Posi(4)*0.77;

		uicontrol(	Handle_Tab,...
								'style',								'slider',...
								'position',							[XITI,YITI,WindowHandle(1).Posi(3)*0.19,25],...
								'value',								1,...
								'min',									1,...
								'max',									2,...
								'sliderstep',						[1/(2-1),10/(2-1)],...
								'enable',								'on',...
								'callback',							{@Button_Func_2,	6, iTab},...
								'Interruptible',				'Off',...
								'BusyAction',						'cancel',...
								'Tag',									['SliderMove' num2str(iTab)]);


		%-------------
		%Slider Text
		%-------------
		XITI	=	(WindowHandle(1).Posi(3)*0.193);
		YITI	=	WindowHandle(1).Posi(4)*0.77;

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[XITI,YITI,50,25],...
								'String',								'1',...
								'FontName',							'Times New Roman',...
								'FontSize',							18,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'HorizontalAlignment',	'Left',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'Tag',									['SliderText' num2str(iTab)]);

		%--------------------
		%Point Number String
		%--------------------
		XITI	=	5;
		YITI	=	WindowHandle(1).Posi(4)*0.81+3;

		TabHandle(iTab).Point_Num	=...
			uicontrol(	Handle_Tab,...
									'style',								'Text',...
									'position',							[75,YITI,50,30],...
									'String',								'1',...
									'FontName',							'Times New Roman',...
									'FontSize',							20,...
									'FontAngle',						'Italic',...
									'FontWeight',						'Bold',...
									'HorizontalAlignment',	'Left',...
									'BackgroundColor',			[WindowHandle(1).Color],...
									'Tag',									['Point_Num' num2str(iTab)]);

		%------------------
		%Point Name String
		%------------------
		YITI	=	WindowHandle(1).Posi(4)*0.81;

		TabHandle(iTab).Point_Name	=...
		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[130,YITI+8,100,20],...
								'String',								[ ' '	],...
								'FontName',							'Times New Roman',...
								'FontSize',							15,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'HorizontalAlignment',	'Left',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'Tag',									['Point_Name' num2str(iTab)]);

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[1,YITI+18,70,18],...
								'String',								'Degitize',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'HorizontalAlignment',	'Left',...
								'BackgroundColor',			[WindowHandle(1).Color]);

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[1,YITI,70,18],...
								'String',								'Point',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'HorizontalAlignment',	'Right',...
								'BackgroundColor',			[WindowHandle(1).Color]);


		%---------------------------
		%	DegitizeType_RadioButton
		%	Button_Num7
		%---------------------------
		YITI	=	WindowHandle(1).Posi(4)*0.88;

		B_No_Value	=	1;
		B_Re_Value	=	0;
		B_Po_Value	=	0;
		%Normal
		uicontrol(	Handle_Tab,...
								'style',								'radiobutton',...
								'position',							[135+20,YITI,15,15],...
								'value',								1,...
								'min',									0,...
								'max',									1,...
								'enable',								'on',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'callback',							{@Button_Func_2,	7, iTab},...
								'Tag',									['Radio_Norm' num2str(iTab)],...
								'userdata',							{B_No_Value});

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[70+20,YITI,60,15],...
								'String',								'Normal',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'HorizontalAlignment',	'Right');

		%Reverse
		uicontrol(	Handle_Tab,...
								'style',								'radiobutton',...
								'position',							[235+20,YITI,15,15],...
								'value',								0,...
								'min',									0,...
								'max',									1,...
								'enable',								'on',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'callback',							{@Button_Func_2,	7, iTab},...
								'Tag',									['Radio_Rever' num2str(iTab)],...
								'userdata',							{B_Re_Value});

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[170+20,YITI,60,15],...
								'String',								'Reverse',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'HorizontalAlignment',	'Right');

		%Point
		uicontrol(	Handle_Tab,...
								'style',								'radiobutton',...
								'position',							[335+20,YITI,15,15],...
								'value',								0,...
								'min',									0,...
								'max',									1,...
								'enable',								'on',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'callback',							{@Button_Func_2,	7, iTab},...
								'Tag',									['Radio_Point' num2str(iTab)],...
								'userdata',							{B_Po_Value});

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[270+20,YITI,60,15],...
								'String',								'Point',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'HorizontalAlignment',	'Right');

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[70+20,YITI+15,229,25],...
								'String',								'Digitize Type',...
								'FontName',							'Times New Roman',...
								'FontSize',							15,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'HorizontalAlignment',	'Center');



		%--------------
		%	Start Button
		%	Button_Num8
		%--------------
		YITI	=	WindowHandle(1).Posi(4)*0.87;

		TabHandle(iTab).ToggleButton	=...
		uicontrol(	Handle_Tab,...
								'style',								'togglebutton',...
								'position',							[1,YITI,50,50],...
								'value',								0,...
								'min',									0,...
								'max',									1,...
								'enable',								'on',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'CData',								BaseData.ImageData.Pencil01,...
								'callback',							{@Button_Func_2,	8, iTab},...
								'Tag',									['Degi_Toggle' num2str(iTab)]);

		%---------------------------
		%	One Step Up_RadioButton
		%	Button_Num7
		%---------------------------
		YITI	=	WindowHandle(1).Posi(4)*0.80;


		B_Step_Value	=	1;
		%Normal
		uicontrol(	Handle_Tab,...
								'style',								'radiobutton',...
								'position',							[360-20,YITI+2,15,15],...
								'value',								0,...
								'min',									0,...
								'max',									1,...
								'enable',								'off',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'callback',							{@Button_Func_2,	9, iTab},...
								'Tag',									['Radio_Step' num2str(iTab)],...
								'userdata',							{B_Step_Value});

		uicontrol(	Handle_Tab,...
								'style',								'Text',...
								'position',							[290-20,YITI,65,18],...
								'String',								'StepUp',...
								'FontName',							'Times New Roman',...
								'FontSize',							12,...
								'FontAngle',						'Italic',...
								'FontWeight',						'Bold',...
								'BackgroundColor',			[WindowHandle(1).Color],...
								'HorizontalAlignment',	'Right');




	end



return;


%=====================================================
%	InternalFunction ButtonFunction
%=====================================================
function	Button_Func_2(	hObject,	EventData,	Button_Num,	CurrentTab	)


	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');

	%Button_Num
	%	1,	Save Button
	%	2,	Load Button_CoodData
	%	3,	Load Button ImageData
	%	4,	Exit_Button
	%	5,	Slider_Button
	%	6,	Radio_Button (DegiType)

	%	カレントフィギュアのUserdata
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');


	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};


	%=================
	%Get Handle
	%=================
	%Image
	Handle_Image			=	findobj(Handle_DegitizeFig,'tag',['Tag_Image' num2str(CurrentTab)]);

	%ImageAxes
	Handle_ImageAxes	=	findobj(Handle_DegitizeFig,'tag',['Tag_Axes' num2str(CurrentTab)]);

	%Slider
	Handle_Slider				=	findobj(Handle_DegitizeFig,'tag',['SliderMove' num2str(CurrentTab)]);
	Handle_Slider_Text	=	findobj(Handle_DegitizeFig,'tag',['SliderText' num2str(CurrentTab)]);

	%Table
	Handle_Table				=	findobj(Handle_DegitizeFig,'tag',['Tag_Table' num2str(CurrentTab)]);

	%RadioButton
	Handle_Reverse			=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Rever' num2str(CurrentTab)]	);
	Handle_Normal				=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Norm'	 num2str(CurrentTab)]	);
	Handle_Point				=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Point' num2str(CurrentTab)]	);

	%Degi_Toggle
	Handle_Degi_Toggle	=	findobj(Handle_DegitizeFig,'tag',[	'Degi_Toggle' num2str(CurrentTab)]	);

	%Radio_Step
	Handle_Step					=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Step' num2str(CurrentTab)]	);


	%LoadName_DegiSide
	Handle_StartFre		=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_StartFre'	);
	Handle_EndFre			=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_EndFre'		);



%	if	isempty(LoadName_DegiSide)	==	1
%		return;
%	end

	iCam					=	CurrentTab;

	if			Button_Num	==	1

		if	isempty(MovieData)	==	1
			return;
		end

		%------------------------
		%	Save_DegitizeCoodData
		%------------------------
%		StartFre_String			=	get(Handle_StartFre,	'String'		);
%		EndFre_String				=	get(Handle_EndFre,		'String'		);
%
%		if	length(CameraNumber_String)	==	1
%			EndFre_String	=	['0'	EndFre_String	];
%		end

		TempFileName				=	[	 '*.csv'	];
		[FileName,PathName]	=	uiputfile(	TempFileName	);

		if	FileName	==	0
			return
		end

		SaveMat		=	Cam(CurrentTab).CoodData;
		SaveName	=	[PathName FileName];
		dlmwrite(SaveName,SaveMat);

	elseif	Button_Num	==	2

		if	isempty(MovieData)	==	1
			return;
		end

		if	isempty(BaseData.RowList{1})	~=	1	||	isempty(	BaseData.Degi_Point{1}	)	~=	1

			%------------------------
			%	Load_DegitizeCoodData
			%------------------------
			StartFre_String		=	get(Handle_StartFre,	'String'		);
			EndFre_String			=	get(Handle_EndFre,		'String'		);

			if	length(EndFre_String)	==	1
				EndFre_String	=	['0'	EndFre_String	];
			end


			TempFileName				=	[	 '*.csv'	];
			[FileName,PathName]	=	uigetfile(	TempFileName	);

			if	FileName	==	0
				return
			end

			Cood	=	dlmread([PathName FileName]);

			%====================
			%GetCoodData_Main
			%====================
			for	iFr	=	1:BaseData.nFr
				for	iPoint	=	1:BaseData.nPoint
					XStep		=	(iPoint-1)*2+1;
					YStep		=	(iPoint-1)*2+2;
					X_Cood	=	Cood(iFr,XStep);
					Y_Cood	=	Cood(iFr,YStep);

					if	X_Cood	>	0	&	Y_Cood	>	0

						Char_X	=	num2str(X_Cood);
						Char_Y	=	num2str(Y_Cood);

						Piri_X	=	find(Char_X	==	'.');
						Piri_Y	=	find(Char_Y	==	'.');

						if			isempty(Piri_X)	==	1
							Char_X	=	Char_X;
						elseif	isempty(Piri_X)	==	0
							Char_X	=	Char_X(1:Piri_X+1);
						end

						if			isempty(Piri_Y)	==	1
							Char_Y	=	Char_Y;
						elseif	isempty(Piri_Y)	==	0
							Char_Y	=	Char_Y(1:Piri_Y+1);
					end

						if			length(Char_X)	==	1
							TempDisp_Char	=	[Char_X ',      ' Char_Y];
						elseif	length(Char_X)	==	2
							TempDisp_Char	=	[Char_X ',     ' Char_Y];
						elseif	length(Char_X)	==	3
							TempDisp_Char	=	[Char_X ',    ' Char_Y];
						elseif	length(Char_X)	==	4
							TempDisp_Char	=	[Char_X ',   ' Char_Y];
						elseif	length(Char_X)	==	5
							TempDisp_Char	=	[Char_X ',  ' Char_Y];
						elseif	length(Char_X)	==	6
							TempDisp_Char	=	[Char_X ', ' Char_Y];
						end
						Disp_Char	=	cellstr(TempDisp_Char);

						%--About uitable
						Handle_Table									=	findobj(Handle_DegitizeFig,'tag',['Tag_Table' num2str(CurrentTab)]);
						Handle_Table.Data(iFr,iPoint)	=	Disp_Char;
					end	
				end
			end

			Cam(CurrentTab).CoodData	=	Cood;
		end

	elseif	Button_Num	==	3

		if	isempty(BaseData.RowList{1})	==	1

			%---------------------------
			%	Select MovieFile
			%---------------------------
			[FileName,PathName]	=	uigetfile(	'*.mp4*','Select_MovieFile'	);
			if	FileName	==	0
				return;
			end
			MovieData 					= VideoReader(	[	PathName FileName	]	);
			BaseData.nFr				=	MovieData.NumFrames;
			BaseData.Ratio_Pic	=	(	MovieData.Height	/	MovieData.Width	);

			Tate	=	MovieData.Height;
			Yoko	=	MovieData.Width;

			%Show_Image
			set(Handle_Image,'Cdata',read(MovieData,1))

			%Mody_Axes
			set(	Handle_ImageAxes,...
						'Visible',	'off',...
						'XLimMode',	'manual',...
						'YLimMode',	'manual',...
						'ZLimMode',	'manual',...
						'XLim',			[	-(Yoko*0.5)+(Yoko/2),	+	(Yoko*0.5)+(Yoko/2)	],...
						'YLim',			[	-(Tate*0.5)+(Tate/2),	+	(Tate*0.5)+(Tate/2)	]				);

			%Mody_Slider
			if	BaseData.nFr	>	1
				set(	Handle_Slider,...
							'value',								1,...
							'max',									BaseData.nFr,...
							'sliderstep',						[1/(BaseData.nFr-1),10/(BaseData.nFr-1)]	);

				if			(	Handle_Step.Value	==	1	)
					set(	Handle_Slider,	'sliderstep',	[	2/(BaseData.nFr-1),	20/(BaseData.nFr-1)	]	);
				elseif	(	Handle_Step.Value	==	0	)
					set(	Handle_Slider,	'sliderstep',	[	1/(BaseData.nFr-1),	10/(BaseData.nFr-1)	]	);
				end

			else
				set(	Handle_Slider,...
							'enable',								'off'	);

			end

			%------------
			%	Edit
			%	StartFrame
			%	EndFrame
			%------------
			set(	Handle_StartFre,	'String',	num2str(1),							'Enable',	'off'	);
			set(	Handle_EndFre,		'String',	num2str(BaseData.nFr),	'Enable',	'off'	);



			%Mody_Table
			for	iFr	=	1:BaseData.nFr
				BaseData.RowList(iFr)	=	{num2str(iFr)};
			end
			set(	Handle_Table,	'RowName',	BaseData.RowList	);



			%-------------------------
			% Degitize_ListFile	(P1-P50)
			%-------------------------
			for	i	=	1:BaseData.nPoint
				BaseData.Degi_Point(i)	=	{	['P' num2str(i)]	};
			end


			%---------
			%Sheet
			%---------
			set(	Handle_Table,	'ColumnName',	BaseData.Degi_Point,	'ColumnWidth',{80}	);

			BaseData.nPoint	=	length(BaseData.Degi_Point);
			%--------
			%Point
			%--------
			for	iPoint	=	1:BaseData.nPoint
					line(	'Parent',								Handle_ImageAxes,...
								'XData',								[-1],...
								'YData',								[-1],...
								'Marker',								'o',...
								'MarkerFaceColor',			[1 0 0],...
								'MarkerEdgeColor',			[0 0 0],...
								'MarkerSize',						10,...
								'LineStyle',						'none',...
								'Visible',							'on',...
								'HitTest',							'on',...
								'ButtonDownFcn',				{@Get_CoodData CurrentTab},...
								'Tag',									['Tag_Line' num2str(CurrentTab) '_' num2str(iPoint)]);
			end


			%Mody_Initital_CoodData
			Cam(CurrentTab).CoodData	=	-1*ones(BaseData.nFr,BaseData.nPoint*2);
		end

	elseif	Button_Num	==	4

		if	isempty(	BaseData.Degi_Point{1}	)	==	1

			%-------------------------
			%Load Degitize_ListFile
			%-------------------------
			StartFre	=	get(Handle_StartFre,	'String'		);
			EndFre		=	get(Handle_EndFre,	'String'		);

			TempFileName				=	['*' StartFre	'_Degitize_Label.csv'	];
			[FileName,PathName]	=	uigetfile(	TempFileName	);

			ID	=	0;
			while	(ID==0)
				ID	=	fopen(	[PathName FileName],	'r'	);
			end
			Temp_Str	=	fscanf(ID,'%c');
			fclose(ID)

			CammaITI	=	[];
			for	i	=	1:length(Temp_Str)
				if	Temp_Str(i)	==	','
					CammaITI	=	[	CammaITI,	i	];
				end
			end

			S_ITI	=	[	1,	CammaITI+1										];
			E_ITI	=	[			CammaITI-1	length(Temp_Str)	];

			for	i	=	1:length(S_ITI)
				BaseData.Degi_Point(i)	=	{	Temp_Str(	S_ITI(i)	:	E_ITI(i)	)	};
			end

			%---------
			%Sheet
			%---------
			set(	Handle_Table,	'ColumnName',	BaseData.Degi_Point	);

			BaseData.nPoint	=	length(BaseData.Degi_Point);
			%--------
			%Point
			%--------
			for	iPoint	=	1:BaseData.nPoint
					line(	'Parent',								Handle_ImageAxes,...
								'XData',								[-1],...
								'YData',								[-1],...
								'Marker',								'o',...
								'MarkerFaceColor',			[1 0 0],...
								'MarkerEdgeColor',			[0 0 0],...
								'MarkerSize',						10,...
								'Visible',							'on',...
								'HitTest',							'on',...
								'ButtonDownFcn',				{@Get_CoodData CurrentTab},...
								'Tag',									['Tag_Line' num2str(CurrentTab) '_' num2str(iPoint)]);
			end
			Cam(CurrentTab).CoodData	=	-1*ones(BaseData.nFr,BaseData.nPoint*2);
		end

	elseif	Button_Num	==	5

		%=========
		%Exit
		%=========

	elseif	Button_Num	==	6

		%=========
		%Slider
		%=========

		%Start End Frame
		SFr	=	str2num(	Handle_StartFre.String	);
		EFr	=	str2num(	Handle_EndFre.String		);

		%スライダーの調整
		S_Frame			=	round(get(Handle_Slider,'Value'));
		if	S_Frame	<	SFr	
			S_Frame	=	SFr;
		end

		if	S_Frame	>	EFr	
			S_Frame	=	EFr;
		end
		set(	Handle_Slider,	'Value',	S_Frame	);
		S_Frame			=	round(get(Handle_Slider,'Value'));


		%Show_Image
		set(Handle_Slider_Text,		'String',		num2str(S_Frame)					);


		%AllCood
		Handle_Mark	=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(1)]);
		XCood				=	Cam(CurrentTab).CoodData(S_Frame,1:2:end-1);
		YCood				=	Cam(CurrentTab).CoodData(S_Frame,2:2:end-0);
		set(Handle_Mark,'Xdata',XCood,'Ydata',YCood)

		%SelectCood
		Temp			=	get(Handle_Table,'userdata');
		CellPosi	=	Temp{1};
		iPoint		=	CellPosi(2);
		XStep			=	(iPoint-1)*2+1;
		YStep			=	(iPoint-1)*2+2;
		XCood			=	Cam(CurrentTab).CoodData(S_Frame,XStep);
		YCood			=	Cam(CurrentTab).CoodData(S_Frame,YStep);
		Handle_Mark		=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(2)]);
		set(Handle_Mark,'Visible','on','MarkerFaceColor',[0 1 0],'Xdata',XCood,'Ydata',YCood)


		%Show_Image
		set(Handle_Image,					'Cdata',		read(MovieData,S_Frame)		);

	elseif	Button_Num	==	7

		%==============
		%Radio Button
		%==============

		%Value
		Re_Value		=	get(	Handle_Reverse,	'Value'	);
		No_Value		=	get(	Handle_Normal,	'Value'	);
		Po_Value		=	get(	Handle_Point,		'Value'	);

		%B_Value
		Temp01			=	get(	Handle_Reverse,	'userdata'	);
		B_Re_Value	=	Temp01{1};

		Temp02			=	get(	Handle_Normal,	'userdata'	);
		B_No_Value	=	Temp02{1};

		Temp03			=	get(	Handle_Point,		'userdata'	);
		B_Po_Value	=	Temp03{1};

		Temp_Radio(1)	=	(	B_No_Value	~=	No_Value	);
		Temp_Radio(2)	=	(	B_Re_Value	~=	Re_Value	);
		Temp_Radio(3)	=	(	B_Po_Value	~=	Po_Value	);

		set(	Handle_Normal,	'Value',	Temp_Radio(1)	)
		set(	Handle_Reverse,	'Value',	Temp_Radio(2)	)
		set(	Handle_Point,		'Value',	Temp_Radio(3)	)

		set(	Handle_Normal,	'userdata',	{Temp_Radio(1)});
		set(	Handle_Reverse,	'userdata',	{Temp_Radio(2)});
		set(	Handle_Point,		'userdata',	{Temp_Radio(3)});


	elseif	Button_Num	==	8

		%====================
		%	togglebutton_Start
		%====================
		ButtonValue	=	get(	Handle_Degi_Toggle,	'Value'	);
		if	ButtonValue	==	1
			set(	Handle_Degi_Toggle,	'CData',	BaseData.ImageData.Pencil02);

		else
			set(	Handle_Degi_Toggle,	'CData',	BaseData.ImageData.Pencil01);

		end

	elseif	Button_Num	==	9

		%==============
		%StepUp Button
		%==============
		if	isempty(MovieData)	==	1
			Handle_Step.Value	=	1;
			return;
		end

		if			(	Handle_Step.Value	==	1	)
			set(	Handle_Slider,	'sliderstep',	[	2/(BaseData.nFr-1),	20/(BaseData.nFr-1)	]	);

		elseif	(	Handle_Step.Value	==	0	)
			set(	Handle_Slider,	'sliderstep',	[	1/(BaseData.nFr-1),	10/(BaseData.nFr-1)	]	);

		end

	elseif	Button_Num	==	10

		%==============
		%S_Fr E_Fr
		%==============
	end

	set(Handle_DegitizeFig,'userdata',{	BaseData,	Cam,	MovieData	});


return;





%=====================================================
%	Callback Function 
%=====================================================
function	Get_CoodData(	hObject,	EventData,	CurrentTab	)


	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');


	%=================
	%Figure Userdata
	%=================
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');
	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};

	if	isempty(Cam)	==	1
		return;
	end

	%====================
	%About Slider
	%====================
	Handle_Slider_Text	=	findobj(Handle_DegitizeFig,'tag',['SliderText' num2str(CurrentTab)]);
	Handle_Slider_Move	=	findobj(Handle_DegitizeFig,'tag',['SliderMove' num2str(CurrentTab)]);
	SliderValue					=	round(	get(	Handle_Slider_Move,'Value'	)	);

	%==================
	%ImageHandle
	%==================
	Handle_Image			=	findobj(	Handle_DegitizeFig,	'tag',	[	'Tag_Image' num2str(CurrentTab)	]	);

	%====================
	%About PointNumber
	%====================
	Handle_PointNum		=	findobj(	Handle_DegitizeFig,	'tag',	[	'Point_Num' num2str(CurrentTab)		]	);
	Handle_PointName	=	findobj(	Handle_DegitizeFig,	'tag',	[	'Point_Name' num2str(CurrentTab)	]	);
	Temp_iPoint				=	get(	Handle_PointNum,	'String'	);
	PointNumber				=	str2num(Temp_iPoint);

	%====================
	%About ToggleButton
	%====================
	Handle_Toggle			=	findobj(	Handle_DegitizeFig,	'tag',	[	'Degi_Toggle' num2str(CurrentTab)	]	);
	Degi_ToggleValue	=	get(	Handle_Toggle,	'Value'	);

	%=====================================
	%About RadioButton(Normal or Reverse)
	%=====================================
	%Handle
	Handle_Reverse	=	findobj(	Handle_DegitizeFig,	'tag',	[	'Radio_Rever'		num2str(CurrentTab)	]	);
	Handle_Normal		=	findobj(	Handle_DegitizeFig,	'tag',	[	'Radio_Norm'		num2str(CurrentTab)	]	);
	Handle_Point		=	findobj(	Handle_DegitizeFig,	'tag',	[	'Radio_Point'		num2str(CurrentTab)	]	);

	%Value
	Re_Value		=	get(	Handle_Reverse,	'Value'	);
	No_Value		=	get(	Handle_Normal,	'Value'	);
	Po_Value		=	get(	Handle_Point,		'Value'	);


	%Radio_Step
	Handle_Step	=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Step' num2str(CurrentTab)]	);
	Step_Value	=	get(	Handle_Step,	'Value'	);


	%StartFre_EndFre
	Handle_StartFre		=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_StartFre'	);
	Handle_EndFre			=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_EndFre'		);

	SFr	=	str2num(	Handle_StartFre.String	);
	EFr	=	str2num(	Handle_EndFre.String		);


	if	EventData.Button	==	1	&	Degi_ToggleValue	==	1

		%====================
		%GetCoodData_Main
		%====================
		X_Cood	=	EventData.IntersectionPoint(1);
		Y_Cood	=	EventData.IntersectionPoint(2);
		Z_Cood	=	EventData.IntersectionPoint(3);

		Char_X	=	num2str(X_Cood);
		Char_Y	=	num2str(Y_Cood);

		Piri_X	=	find(Char_X	==	'.');
		Piri_Y	=	find(Char_Y	==	'.');

		if			isempty(Piri_X)	==	1
			Char_X	=	Char_X;
		elseif	isempty(Piri_X)	==	0
			Char_X	=	Char_X(1:Piri_X+1);
		end

		if			isempty(Piri_Y)	==	1
			Char_Y	=	Char_Y;
		elseif	isempty(Piri_Y)	==	0
			Char_Y	=	Char_Y(1:Piri_Y+1);
		end

		if			length(Char_X)	==	1
			TempDisp_Char	=	[Char_X ',       ' Char_Y];
		elseif	length(Char_X)	==	2
			TempDisp_Char	=	[Char_X ',      ' Char_Y];
		elseif	length(Char_X)	==	3
			TempDisp_Char	=	[Char_X ',     ' Char_Y];
		elseif	length(Char_X)	==	4
			TempDisp_Char	=	[Char_X ',    ' Char_Y];
		elseif	length(Char_X)	==	5
			TempDisp_Char	=	[Char_X ',   ' Char_Y];
		elseif	length(Char_X)	==	6
			TempDisp_Char	=	[Char_X ',  ' Char_Y];
		elseif	length(Char_X)	==	7
			TempDisp_Char	=	[Char_X ', ' Char_Y];

		end
		Disp_Char	=	cellstr(TempDisp_Char);

		%--About uitable
		Handle_Table																=	findobj(Handle_DegitizeFig,'tag',['Tag_Table' num2str(CurrentTab)]);
		Handle_Table.Data(SliderValue,PointNumber)	=	Disp_Char;

		%--Input CoodData
		PointStep	=	(PointNumber-1)*2+1:(PointNumber-1)*2+2;
		Cam(CurrentTab).CoodData(SliderValue,PointStep)	=	[	X_Cood,	Y_Cood	];

		%===========================
		%---NextPoint_NextFrame
		%===========================
		if			Step_Value	==	1
			AddFre	=	2;
		elseif	Step_Value	==	0
			AddFre	=	1;
		end

		if	No_Value	==	1
			NextFrame	=	SliderValue	+	AddFre;
			NextPoint	=	PointNumber;

			if	NextFrame	>	EFr
				NextFrame	=	SFr;
				NextPoint	=	PointNumber	+	1;

				if	NextPoint	>	BaseData.nPoint
					NextPoint	=	1;
				end
			end
		end

		if	Re_Value	==	1
			NextFrame	=	SliderValue	-	AddFre;
			NextPoint	=	PointNumber;

			if	NextFrame	<	SFr
				NextFrame	=	EFr;
				NextPoint	=	PointNumber	+	1;

				if	NextPoint	>	BaseData.nPoint
					NextPoint	=	1;
				end
			end
		end

		if	Po_Value	==	1
			NextPoint	=	PointNumber	+	1;
			NextFrame	=	SliderValue;

			if	NextPoint	>	BaseData.nPoint
				NextPoint	=	1;
				NextFrame	=	SliderValue	+	AddFre;

				if			NextFrame	>	EFr
					NextFrame	=	SFr;
				end
			end
		end

		%=============
		%PointString
		%=============
		set(	Handle_PointNum,		'String',	num2str(NextPoint)	);
		set(	Handle_PointName,		'String',	[ '   ' char(BaseData.Degi_Point(1,NextPoint))]	);

		if	NextFrame	~=	SliderValue
			set(Handle_Slider_Move,		'Value',		NextFrame										);
			set(Handle_Slider_Text,		'String',		num2str(NextFrame)					);
			set(Handle_Image,					'Cdata',		read(MovieData,NextFrame)		);
		end

		%AllCood
		Handle_Mark	=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(1)]);
		XCood	=	Cam(CurrentTab).CoodData(NextFrame,1:2:end-1);
		YCood	=	Cam(CurrentTab).CoodData(NextFrame,2:2:end-0);
		set(Handle_Mark,'Visible','on','MarkerFaceColor',[1 0 0],'Xdata',XCood,'Ydata',YCood)

		%SelectCood
		Temp			=	get(Handle_Table,'userdata');
		CellPosi	=	Temp{1};
		iPoint		=	CellPosi(2);
		XStep			=	(iPoint-1)*2+1;
		YStep			=	(iPoint-1)*2+2;
		XCood			=	Cam(CurrentTab).CoodData(NextFrame,XStep);
		YCood			=	Cam(CurrentTab).CoodData(NextFrame,YStep);
		Handle_Mark		=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(2)]);
		set(Handle_Mark,'Visible','on','MarkerFaceColor',[0 1 0],'Xdata',XCood,'Ydata',YCood)

	end

	set(Handle_DegitizeFig,'userdata',	{	BaseData,	Cam,	MovieData	})


return;




%=======================================
%Cell Move Function
%=======================================
function	CellSelectionFunc(hObject,EventData,CurrentTab)


	global	Time1




	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');


	%=================
	%Figure Userdata
	%=================
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');
	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};

	if	isempty(Cam)	==	1
		return;
	end

	%====================
	%About Slider
	%====================
	Slider_Text	=	findobj(Handle_DegitizeFig,'tag',['SliderText' num2str(CurrentTab)]);
	Slider_Move	=	findobj(Handle_DegitizeFig,'tag',['SliderMove' num2str(CurrentTab)]);
	SliderValue	=	round(get(Slider_Move,'Value'));

	%====================
	%About Degitize Point
	%====================
	Handle_PointNum		=	findobj(Handle_DegitizeFig,'tag',['Point_Num' num2str(CurrentTab)]);
	Handle_PointName	=	findobj(Handle_DegitizeFig,'tag',['Point_Name' num2str(CurrentTab)]);

	%==================
	%ImageHandle
	%==================
	Handle_Image			=	findobj(Handle_DegitizeFig,'tag',['Tag_Image' num2str(CurrentTab)]);

	%==================
	%TableHandle
	%==================
	Handle_Table	=	findobj(	Handle_DegitizeFig,	'Tag',	[	'Tag_Table' num2str(CurrentTab)	]	);

	%Radio_Step
	Handle_Step					=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Step' num2str(CurrentTab)]	);


	%StartFre_EndFre
	Handle_StartFre		=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_StartFre'	);
	Handle_EndFre			=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_EndFre'		);



	if	isempty(EventData.Indices)	==	1
		return;
	end



	Amari	=	rem(	str2num(Handle_StartFre.String),	2);




	if			Handle_Step.Value	==	1

		if			Amari	==	0
			%偶数

			if	rem(	EventData.Indices(1),	2)	==	1
				CellIti				=	EventData.Indices;
				CellIti(1,1)	=	CellIti(1,1)-1;

				if	CellIti(1,1)	<	1
					CellIti(1,1)	=	2;
				end

			else
				CellIti				=	EventData.Indices;
			end

		elseif	Amari	==	1
			%奇数

			if	rem(	EventData.Indices(1),	2)	==	0
				CellIti				=	EventData.Indices;
				CellIti(1,1)	=	CellIti(1,1)-1;

				if	CellIti(1,1)	<	1
					CellIti(1,1)	=	1;
				end

			else
				CellIti				=	EventData.Indices;
			end
		end

	elseif	Handle_Step.Value	==	0
		%とばし無し
		CellIti				=	EventData.Indices;

	end


	%Position in Cells
%	CellIti			=	EventData.Indices;
	[Tate,Yoko]	=	size(CellIti);

	%Tableのuserdataに位置を更新
	set(Handle_Table,'userdata',{CellIti});


	if	Tate	==	1	&	Yoko	==	2

		set(Handle_PointNum,'String',[num2str(CellIti(1,2))]);
		set(Handle_PointName,'String',[ '   ' char(BaseData.Degi_Point(1,CellIti(1,2)))]);


		%==================
		% Set Image
		%==================
		Temp	=	get(Slider_Move,'Value'		);
		iFr		=	CellIti(1,1);

		%Start End Frame
		SFr	=	str2num(	Handle_StartFre.String	);
		EFr	=	str2num(	Handle_EndFre.String		);

		%スライダーの調整
		if	iFr	<	SFr	
			iFr	=	SFr;
		end

		if	iFr	>	EFr	
			iFr	=	EFr;
		end

		set(Slider_Move,'Value',iFr);
		set(Slider_Text,'String',iFr);


%		if	toc(Time1)	<	0.1
%			return;
%		end
%
%		Time1	=	tic;
		if	iFr	~=	Temp
			set(Handle_Image,		'Cdata',		read(	MovieData,	iFr	)	);
		end


		%==================
		%Mark Handle(Line)
		%==================
		%AllCood
		Handle_Mark	=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(1)]);
		XCood	=	Cam(CurrentTab).CoodData(iFr,1:2:end-1);
		YCood	=	Cam(CurrentTab).CoodData(iFr,2:2:end-0);
		set(Handle_Mark,'Visible','on','MarkerFaceColor',[1 0 0],'Xdata',XCood,'Ydata',YCood)

		%SelectCood
		iPoint				=	CellIti(1,2);
		XStep	=	(iPoint-1)*2+1;
		YStep	=	(iPoint-1)*2+2;
		XCood	=	Cam(CurrentTab).CoodData(iFr,XStep);
		YCood	=	Cam(CurrentTab).CoodData(iFr,YStep);
		Handle_Mark		=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(2)]);
		set(Handle_Mark,'Visible','on','MarkerFaceColor',[0 1 0],'Xdata',XCood,'Ydata',YCood)




	end


return

%======================================
%Key Press Function
%======================================
function	KeyPressFunc(hObject,EventData)


	global	Time1

	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');


	%=================
	%Figure Userdata
	%=================
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');
	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};

	if	isempty(Cam)	==	1
		return;
	end

	%==================
	%Current Tag
	%==================
	Handle_TabGroup		=	findobj(Handle_DegitizeFig,'tag','Tag_TabGroup');
	Handle_C_Tab			=	get(Handle_TabGroup,'SelectedTab');
	TempData					=	get(Handle_C_Tab,'Tag');
	CurrentTab				=	str2num(TempData(end));

	%--------------
	%Handle Table
	%--------------
	Handle_Table	=	findobj(	Handle_DegitizeFig,	'Tag',	[	'Tag_Table' num2str(CurrentTab)	]	);

	%-----------------
	%Delete_CoodData
	%-----------------
	if	(	Handle_Table	==	gco	)	&&	(	strcmp(EventData.Key,'delete')	==	1	)
		Temp			=	get(Handle_Table,'userdata');
		CellPosi	=	Temp{1};

		for	iCell	=	1:length(	CellPosi(:,1)	)
			%--Display Table
			Handle_Table.Data(	CellPosi(	iCell,	1	),	CellPosi(	iCell,	2	)	)	=	{''};

			%--Input CoodData
			PointStep	=	(	CellPosi(	iCell,	2	)-1	)*2+1	:	(	CellPosi(	iCell,	2	)-1	)*2+2;
			Cam(CurrentTab).CoodData(	CellPosi(	iCell,	1	),	PointStep	)	=	[	-1,	-1	];

			iPoint			=	CellPosi(	iCell,	2	);
			iFr					=	CellPosi(	iCell,	1	);
			Handle_Mark	=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(iPoint)]);
			XStep				=	(iPoint-1)*2+1;
			YStep				=	(iPoint-1)*2+2;
			XCood				=	Cam(CurrentTab).CoodData(iFr,XStep);
			YCood				=	Cam(CurrentTab).CoodData(iFr,YStep);
			set(Handle_Mark,'Xdata',XCood,'Ydata',YCood)
		end
	end

	if	isnumeric(CurrentTab)	==	1

		%==================
		%ImageHandle
		%==================
		Handle_Image			=	findobj(Handle_DegitizeFig,'tag',['Tag_Image' num2str(CurrentTab)]);

		%------------------
		%Get Slider Info
		%------------------
		Slider_Text	=	findobj(Handle_DegitizeFig,'tag',['SliderText' num2str(CurrentTab)]);
		Slider_Move	=	findobj(Handle_DegitizeFig,'tag',['SliderMove' num2str(CurrentTab)]);
		SliderValue	=	round(get(Slider_Move,'Value'));

		%------------------
		%Radio_Step
		%------------------
		Handle_Step					=	findobj(Handle_DegitizeFig,'tag',[	'Radio_Step' num2str(CurrentTab)]	);

		%------------------
		%StartFre_EndFre
		%------------------
		Handle_StartFre		=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_StartFre'	);
		Handle_EndFre			=	findobj(	Handle_DegitizeFig,	'tag',	'Tag_EndFre'		);



		AddFre	=	1;
		if	Handle_Step.Value	==	1
			AddFre	=	2;
		end

		%==========================
		%Up Down Button
		%==========================
		if	gco	==	Handle_Image
			if	strcmp(EventData.Key,'downarrow')	==	1	||	strcmp(EventData.Key,'uparrow')	==	1

				Flag	=	1;
				if			strcmp(EventData.Key,'downarrow')	==	1	&	SliderValue	<=	BaseData.nFr-AddFre
					NextFrame	=	SliderValue+AddFre;
					Flag	=	2;

				elseif	strcmp(EventData.Key,'uparrow')	==	1		&	SliderValue-AddFre	>=	1
					NextFrame	=	SliderValue-AddFre;
					Flag	=	2;
				end

				%Start End Frame
				SFr	=	str2num(	Handle_StartFre.String	);
				EFr	=	str2num(	Handle_EndFre.String		);

				%スライダーの調整
				if	NextFrame	<	SFr	
					NextFrame	=	SFr;
				end

				if	NextFrame	>	EFr	
					NextFrame	=	EFr;
				end

				if	Flag	==	2
					set(Slider_Move,		'Value',		NextFrame											);
					set(Slider_Text,		'String',		num2str(NextFrame)						);

					set(Handle_Image,		'Cdata',		read(	MovieData,	NextFrame	)	);

					%AllCood
					Handle_Mark	=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(1)]);
					XCood				=	Cam(CurrentTab).CoodData(	NextFrame,	1:2:end-1	);
					YCood				=	Cam(CurrentTab).CoodData(	NextFrame,	2:2:end-0	);
					set(Handle_Mark,'Xdata',XCood,'Ydata',YCood)

					%SelectCood
					Temp			=	get(Handle_Table,'userdata');
					CellPosi	=	Temp{1};
					iPoint		=	CellPosi(2);
					XStep			=	(iPoint-1)*2+1;
					YStep			=	(iPoint-1)*2+2;
					XCood			=	Cam(CurrentTab).CoodData(NextFrame,XStep);
					YCood			=	Cam(CurrentTab).CoodData(NextFrame,YStep);
					Handle_Mark		=	findobj(Handle_DegitizeFig,'tag',['Tag_Line' num2str(CurrentTab) '_' num2str(2)]);
					set(Handle_Mark,'Visible','on','MarkerFaceColor',[0 1 0],'Xdata',XCood,'Ydata',YCood)
				end
			end
		end
	end


	set(Handle_DegitizeFig,'userdata',	{	BaseData,	Cam,	MovieData	})

return




%=======================================
%Wheel Function
%=======================================
function	ScrollWheelFcn(hObject,EventData)

	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');


	%=================
	%Figure Userdata
	%=================
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');
	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};

	if	isempty(Cam)	==	1
		return;
	end


	%==================
	%Current Tag
	%==================
	Handle_TabGroup		=	findobj(Handle_DegitizeFig,'tag','Tag_TabGroup');
	Handle_C_Tab			=	get(Handle_TabGroup,'SelectedTab');
	TempData					=	get(Handle_C_Tab,'Tag');
	CurrentTab				=	str2num(TempData(end));

	if	isnumeric(CurrentTab)	==	1

			%==============
			%AxesHandle
			%==============
			Handle_Axes				=	findobj(Handle_DegitizeFig,'tag',['Tag_Axes' num2str(CurrentTab)]);
			Handle_Image			=	findobj(Handle_DegitizeFig,'tag',['Tag_Image' num2str(CurrentTab)]);

			%===========
			%ZOOM
			%===========
			XX	=	get(Handle_Axes,'XLim');
			YY	=	get(Handle_Axes,'YLim');

			RangeX	=	XX(2)-XX(1);
			RangeY	=	YY(2)-YY(1);

			if	gco	==	Handle_Image
				ZFact	=	RangeX/25;

				if			EventData.VerticalScrollCount	==	-1	&	(RangeX>20)	&	(RangeY>20)	&	gco	==	Handle_Image
					XX	=	set(Handle_Axes,'XLim',[XX(1)+ZFact,XX(2)-ZFact]);
					YY	=	set(Handle_Axes,'YLim',[YY(1)+(ZFact*BaseData.Ratio_Pic),YY(2)-(ZFact*BaseData.Ratio_Pic)]);

				elseif	EventData.VerticalScrollCount	==	1		&	gco	==	Handle_Image
					XX	=	set(Handle_Axes,'XLim',[XX(1)-ZFact,XX(2)+ZFact]);
					YY	=	set(Handle_Axes,'YLim',[YY(1)-(ZFact*BaseData.Ratio_Pic),YY(2)+(ZFact*BaseData.Ratio_Pic)]);

				end
		end
	end

return



%=====================================================
%Callback Function (Mause Down)
%=====================================================
function	MouseButtonDownFcn(hObject,EventData)

	%==============
	global	XY
	%==============

	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');

	%=================
	%Figure Userdata
	%=================
	Temp_Cell					=	get(Handle_DegitizeFig,'userdata');
	BaseData					=	Temp_Cell{1};
	Cam								=	Temp_Cell{2};
	MovieData					=	Temp_Cell{3};

	if	isempty(Cam)	==	1
		return;
	end

	%==================
	%Current Tag
	%==================
	Handle_TabGroup		=	findobj(Handle_DegitizeFig,'tag','Tag_TabGroup');
	Handle_C_Tab			=	get(Handle_TabGroup,'SelectedTab');
	TempData					=	get(Handle_C_Tab,'Tag');
	CurrentTab				=	str2num(TempData(end));

	if	isnumeric(CurrentTab)	==	1

		%==================
		%Handle_Image
		%==================
		Handle_Image	=	findobj(Handle_DegitizeFig,'tag',['Tag_Image' num2str(CurrentTab)]);

		%==================
		%ClickType
		%==================
		ClickType		=	get(Handle_DegitizeFig,'SelectionType');

		if	gco	==	Handle_Image
			%Right Click
			if	strcmp(ClickType,'alt')
				XY					=	get(groot,'PointerLocation');
				set(Handle_DegitizeFig,'WindowButtonMotionFcn',{@MouseMoveFunc});
			end
		end
	end



return

%=====================================================
%Callback Function (Mause Move)
%=====================================================
function	MouseMoveFunc(hObject,EventData);

	%==============
	global	XY
	%==============


	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');


	%==================
	%Current Tag
	%==================
	Handle_TabGroup		=	findobj(Handle_DegitizeFig,'tag','Tag_TabGroup');
	Handle_C_Tab			=	get(Handle_TabGroup,'SelectedTab');
	TempData					=	get(Handle_C_Tab,'Tag');
	CurrentTab				=	str2num(TempData(end));

	%=============
	%Handle_Axes
	%=============
	Handle_Axes				=	findobj(Handle_DegitizeFig,'tag',['Tag_Axes' num2str(CurrentTab)]);

	NewXY					=	get(groot,'PointerLocation');
	dXY						=	NewXY	-	XY;
	XY						=	NewXY;

	XX	=	get(Handle_Axes,'XLim');
	YY	=	get(Handle_Axes,'YLim');


	RangeX	=	XX(2)-XX(1);
	if	(RangeX/1000>1)
		Ratio	=	RangeX/1000;
		Move	=	Ratio*dXY;
	else
		Ratio	=	1;
		Move	=	Ratio*dXY;
	end

	XX	=	set(Handle_Axes,'XLim',[XX(1)-Move(1),XX(2)-Move(1)]);
	YY	=	set(Handle_Axes,'YLim',[YY(1)+Move(2),YY(2)+Move(2)]);

return

%=====================================================
%Callback Function (Mause Up)
%=====================================================
function	MouseUpFunc(hObject,EventData)

	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(groot,'tag','fig_Degitize');

	set(Handle_DegitizeFig,'WindowButtonMotionFcn','');

return


%=====================================================
%Callback Function Button
%=====================================================
function	CloseRequest(A,B)
	%--------------------
	%Get FigureHandle
	%--------------------
	Handle_DegitizeFig	=	findobj(	groot,	'tag',	'fig_Degitize');
	Handle_SelectFig		=	findobj(	groot,	'tag',	[	'InitialGUI_degiPro_Fig']	);

	%===============
	%Exit_Button
	%===============
	delete(Handle_DegitizeFig)
	delete(Handle_SelectFig)
	set(	Handle_MenuFigure,'visible','On'	);

return;