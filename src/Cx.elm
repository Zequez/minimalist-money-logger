module Cx exposing (at, c, cx)

import Html exposing (Attribute)
import Html.Attributes exposing (attribute, class, classList)


c : String -> Attribute msg
c =
    class


cx : List ( String, Bool ) -> Attribute msg
cx =
    classList


at : String -> String -> Attribute msg
at =
    attribute
