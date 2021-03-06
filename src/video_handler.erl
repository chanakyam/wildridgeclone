-module(video_handler).
-include("includes.hrl").
-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	{CategoryBinary, _} = cowboy_req:qs_val(<<"id">>, Req),
	Category = binary_to_list(CategoryBinary),

	% Url_all_news = wildridgeclone_util:video_data(Category),
	% %io:format("url: ~p~n",[Url_all_news]), 
	% {ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_all_news,[],get,[],[]),
	% ResAllNews = string:sub_string(ResponseAllNews, 1, string:len(ResponseAllNews) -1 ),
	% Params = jsx:decode(list_to_binary(ResAllNews)),

	Url_news = string:concat("http://api.contentapi.ws/v?id=",Category ), 
	{ok, "200", _, ResponseNews} = ibrowse:send_req(Url_news,[],get,[],[]),
	ResNews = string:sub_string(ResponseNews, 1, string:len(ResponseNews) -1 ),
	Params = jsx:decode(list_to_binary(ResNews)),

	 % for video display
	% Url = wildridgeclone_util:video_count(binary_to_list(<<"full_composite_article">>),binary_to_list(<<"1">>),binary_to_list(<<"2">>)),
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),	
	% ResponseParams = jsx:decode(list_to_binary(Res)),
	% [ResponseRows] = proplists:get_value(<<"rows">>, ResponseParams),
	% VideoParams = proplists:get_value(<<"value">>, ResponseRows),

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=2&format=long",
	% io:format("movies url: ~p~n",[Url]), 
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[VideoParams] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	{ok, Body} = video_dtl:render([{<<"videoParam">>,VideoParams},{<<"allnews">>,Params}]),
	% io:format("url: ~p~n", [allnews]), 
    {Body, Req, State}.
