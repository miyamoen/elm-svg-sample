module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import Graphics.Render as Render exposing (..)
import Color exposing (Color)


---- MODEL ----


type alias Model =
    { bars : List Bar }


type alias Bar =
    { value : Float, fill : Color }


chartData : List Bar
chartData =
    [ Bar 100 Color.blue
    , Bar 20 Color.red
    , Bar 10 Color.green
    ]


init : ( Model, Cmd Msg )
init =
    ( { bars = chartData }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


svgHeight : number
svgHeight =
    120


svgWidth : number
svgWidth =
    340


barWidth : number
barWidth =
    100


barInterval : number
barInterval =
    20


view : Model -> Html Msg
view { bars } =
    List.indexedMap bar bars
        |> group
        |> svg 0 0 svgWidth svgHeight


bar : Int -> Bar -> Form msg
bar i { value, fill } =
    rectangle barWidth value
        |> filled (solid fill)
        |> position ( i * barWidth + i * barInterval + barWidth // 2 |> toFloat, svgHeight - value / 2 )



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
