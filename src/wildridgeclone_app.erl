-module(wildridgeclone_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
        {'_',[
                {"/", home_page_handler, []},

                 {"/api/worldnews/channel", channel_world_news_handler, []},                 
                 {"/api/videos/channel", feed_videos_handler, []},                 
                 {"/tnc", tnc_page_handler, []},
                 {"/more", more_handler, []},
                 {"/video", video_handler, []},
                 {"/more_news", more_news_handler, []},                 
                 {"/more_videos", more_videos_handler, []},
                            
                %%
                %% Release Routes
                %%
                {"/css/[...]", cowboy_static, {priv_dir, wildridgeclone, "static/css"}},
                {"/images/[...]", cowboy_static, {priv_dir, wildridgeclone, "static/images"}},
                {"/js/[...]", cowboy_static, {priv_dir, wildridgeclone, "static/js"}},
                {"/fonts/[...]", cowboy_static, {priv_dir, wildridgeclone, "static/fonts"}}
                % %%
                %% Dev Routes
                %%
                % {"/css/[...]", cowboy_static, {dir, "priv/static/css"}},
                % {"/images/[...]", cowboy_static, {dir, "priv/static/images"}},
                % {"/js/[...]", cowboy_static, {dir,"priv/static/js"}},
                % {"/fonts/[...]", cowboy_static, {dir, "priv/static/fonts"}}
        ]}      
    ]),    

    {ok, _} = cowboy:start_http(http,100, [{port, 10004}],[{env, [{dispatch, Dispatch}]}
              ]),
    wildridgeclone_sup:start_link().

stop(_State) ->
    ok.
