-module(channel_world_news_handler).

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
	{Category, _ } = cowboy_req:qs_val(<<"c">>, Req),
	% {Limit, _ } = cowboy_req:qs_val(<<"l">>, Req),
	% {Skip, _ } = cowboy_req:qs_val(<<"skip">>, Req),
	% Url = wildridgeclone_util:world_news_thumb_title_count(binary_to_list(Category), binary_to_list(Limit), binary_to_list(Skip)),
	% % io:format("world news ~p ~n ",[Url]),
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}.

	Url = case binary_to_list(Category) of 
		"us_world" ->
			%Category = "US",
			"http://api.contentapi.ws/news?channel=us_world&limit=4&skip=0&format=short";
			% wildridge_util:news_top_text_news_with_limit("text_us_world","by_id_title_desc_thumb_date",binary_to_list(Count));
		"us_domestic" ->
			%Category = "US",
			"http://api.contentapi.ws/news?channel=us_domestic&limit=4&skip=0&format=short";
			% wildridge_util:news_top_text_news_with_limit("text_us_domestic","by_id_title_desc_thumb_date",binary_to_list(Count));
			
		"us_politics" ->
			%Category = "Politics",
			"http://api.contentapi.ws/news?channel=us_politics&limit=4&skip=0&format=short";
			% wildridge_util:news_top_text_news_with_limit("text_us_politics","by_id_title_desc_thumb_date",binary_to_list(Count));
			
		"us_markets" ->
			%Category = "Entertainment",
			"http://api.contentapi.ws/news?channel=us_markets&limit=5&skip=0&format=short";
			% wildridge_util:news_top_text_news_with_limit("text_us_entertainment","by_id_title_desc_thumb_date",binary_to_list(Count));
		
		
		_ ->
			%Category = "None",
			lager:info("#########################None")

	end,

	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	Body = list_to_binary(Response_mlb),
	{Body, Req, State}.

