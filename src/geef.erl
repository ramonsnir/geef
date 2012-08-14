-module(geef).
-export([hex_to_raw/1, repository/1, repository_path/1, repository_odb/1, odb_exists/2]).
-on_load(load_enif/0).

hex_to_raw(_Val) ->
    nif_error(?LINE).    

repository_open(_Val) ->
    nif_error(?LINE).

repository_get_path(_Val) ->
    nif_error(?LINE).

repository_get_odb(_Val) ->
    nif_error(?LINE).

repository_path({repository, Handle}) ->
    repository_get_path(Handle).

repository(Path) ->
    {ok, Repository} = repository_open(Path),
    {repository, Repository}.

repository_odb({repository, Handle}) ->
    {ok, Odb} = repository_get_odb(Handle),
    {odb, Odb}.

odb_object_exists(_Val, _Val) ->
    nif_error(?LINE).

odb_exists({odb, Handle}, Sha) ->
    odb_object_exists(Handle, Sha).

nif_error(Line) ->
    exit({nif_not_loaded,module,?MODULE,line,Line}).

load_enif() ->
    case code:priv_dir(geef) of
        {error, bad_name} ->
            SoName = filename:join("priv", geef);
        Dir ->
            SoName = filename:join(Dir, geef)
    end,
    io:format("Hey There: ~s~n", [SoName]),
    erlang:load_nif(SoName, 0).
