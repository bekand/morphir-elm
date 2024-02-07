module Morphir.Visual.Components.InstantInputComponent exposing (..)

import Element exposing (Element)
import Element.Input as Input
import Html
import Html.Attributes as HTMLAttributes exposing (for, style, type_, value, step)
import Html.Events exposing (onInput)
import Morphir.Visual.Theme exposing (Theme)


type alias Config msg =
    { onStateChange : InstantInputState -> msg
    , label : Element msg
    , placeholder : Maybe (Input.Placeholder msg)
    , state : InstantInputState
    }


type alias InstantInputState =
    { date : Maybe String
    }


initState : Maybe String -> InstantInputState
initState initialDate =
    { date = initialDate }


view : Theme -> Config msg -> Element msg
view theme config =
    let
        state =
            config.state
    in
    Html.label [style "display" "flex"]
        [ Html.div
            [ style "background-color" "rgb(51, 76, 102 )"
            , style "padding" "5px"
            , style "margin-right" "5px"
            , style "display" "inline"
            , style "color" "rgb(179, 179, 179)"
            ]
            [ Html.text "local date" ]
        , Html.input
            [ type_ "datetime-local"
            , step "1"
            , HTMLAttributes.min "1970-01-01"
            , value (config.state.date |> Maybe.withDefault "")
            , onInput (\datestr -> config.onStateChange { state | date = Just datestr })
            , for "local date"
            ]
            []
        ]
        |> Element.html
