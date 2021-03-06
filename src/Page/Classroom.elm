module Page.Classroom exposing (..)

{-| View functions for the codeschool.lms.classroom app
-}

import Data.Classroom exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Misc.Util exposing (closestDate)
import Ui.Generic exposing (date, emoticon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)


--------------------------------------------------------------------------------
-- LIST VIEWS
--------------------------------------------------------------------------------


classroomList : List ClassroomInfo -> Html msg
classroomList lst =
    let
        empty =
            [ emoticon ":-("
            , p [ class "center-text" ]
                [ text "Sorry, you are not enrolled in any classrooms."
                , br [] []
                , text "Please click the add button to register to new classroom."
                ]
            ]

        listing =
            [ div [ class "classroom-info-list" ] (List.map classroomInfo lst)
            ]

        fab_ =
            div [] []

        children =
            case lst of
                [] ->
                    fab_ :: empty

                _ ->
                    fab_ :: listing
    in
    div [ class "classroom-page" ]
        [ simpleHero "List of Classrooms" "See all classrooms you are enrolled" "simple-hero__page-red"
        , div [ class "container" ] children
        ]


classroomInfo : ClassroomInfo -> Html msg
classroomInfo cls =
    div [ class "classroom-info-card" ]
        [ div [ class "classroom-info-card__image" ] []
        , div [ class "classroom-info-card__title" ]
            [ text cls.name
            ]
        , h2 [ class "classroom-info-card__teacher" ]
            [ strong [] [ text "Teacher: " ]
            , text cls.teacher
            ]
        , p [ class "classroom-info-card__description" ]
            [ text cls.shortDescription
            ]
        , div [ class "classroom-info-card__toolbar" ]
            [ button
                [ attribute "raised" "raised" ]
                [ text "Go" ]
            ]
        ]



--------------------------------------------------------------------------------
-- DETAIL VIEWS
--------------------------------------------------------------------------------


classroom : Classroom -> Html msg
classroom cls =
    div []
        [ simpleHero cls.name cls.shortDescription "simple-hero__page-red"
        , div [ class "container" ]
            [ h2 [] [ text "What brings you here today?" ]
            , promoTable
                ( promoSimple "code"
                    "Questions"
                    []
                    [ text "Click here to practice and solve questions" ]
                , promoSimple "forum"
                    "Forum"
                    []
                    [ text "Participate in the classroom forum." ]
                , promoSimple "info"
                    "Info"
                    []
                    [ text "Extra info on the course." ]
                )
            ]
        , div [ class "container " ]
            [ h2 [] [ text "Lessons" ]
            , listOfLessons cls.lessons
            ]
        ]


listOfLessons : List Lesson -> Html msg
listOfLessons lst =
    div [] <| List.map lesson lst


lesson : Lesson -> Html msg
lesson lesson =
    div [ class "classroom-lesson" ]
        [ h1 []
            [ text lesson.description
            , span [ class "classroom-lesson__date" ] [ text <| "Date: " ++ date lesson.date ]
            ]
        ]



---- EXAMPLES ----


web : ClassroomInfo
web =
    { name = "Web Programming"
    , teacher = "Fábio Mendes"
    , shortDescription = "A course on web-programming featuring many interesting things. sdfsds sdfs idfu sidu fsdif d. sfush idfuhsifd."
    }


webDetail : Classroom
webDetail =
    { name = "Web Programming"
    , teacher = "Fábio Mendes"
    , shortDescription = "Learn the basics of programming."
    , longDescription = "Asds dfoisdf osidfj sdfo dsfios jdfoisd, sdif sidf sodfi , fdius dfoisdfosd."
    , lessons =
        [ Lesson (closestDate ( 2017, 1, 1 )) "Basic control flow structures"
        , Lesson (closestDate ( 2017, 1, 20 )) "Functions"
        , Lesson (closestDate ( 2017, 2, 7 )) "Recursion"
        , Lesson (closestDate ( 2017, 2, 30 )) "Classes and object orientation"
        ]
    }


testClassroom : Classroom
testClassroom =
    { name = "Classroom"
    , teacher = "Nothing"
    , shortDescription = "Test course."
    , longDescription = "DSFSDF"
    , lessons = []
    }


numeric : ClassroomInfo
numeric =
    { name = "Numeric Calculus Numeric Calculus Numeric Calculus Numeric Calculus", teacher = "Fábio Mendes", shortDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis porta bibendum. Duis bibendum vel neque dictum suscipit. Nullam auctor leo porta, posuere nisl rutrum, ultrices erat. Mauris bibendum metus quis sapien hendrerit condimentum. Sed nec risus felis. Proin dignissim eleifend mattis. Aenean eget ligula tortor. Cras non aliquet risus." }


clsList : List ClassroomInfo
clsList =
    [ web, numeric, web, web ]
