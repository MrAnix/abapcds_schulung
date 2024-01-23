CLASS lhc_zi_ratingdatadef DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS DetermineUserName FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZI_RATINGDATADEF~DetermineUserName.

ENDCLASS.

CLASS lhc_zi_ratingdatadef IMPLEMENTATION.

  METHOD DetermineUserName.

    READ ENTITY IN LOCAL MODE ZI_RATINGDATADEF
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(ratings).

    MODIFY ENTITY IN LOCAL MODE ZI_RATINGDATADEF
      UPDATE FIELDS ( UserName )
      WITH VALUE #( FOR key IN keys ( %tky = key-%tky UserName = sy-uname ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_MOVIEDATADEF DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateGenre FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_MOVIEDATADEF~validateGenre.
    METHODS rateMovie FOR MODIFY
      IMPORTING keys FOR ACTION ZI_MOVIEDATADEF~rateMovie.

ENDCLASS.

CLASS lhc_ZI_MOVIEDATADEF IMPLEMENTATION.

  METHOD validateGenre.

    " SELECT FROM <source>
    "   FIELDS <fields>
    "   WHERE <conditon>
    "   INTO <target>.

    " Read Movies from BO
    READ ENTITY IN LOCAL MODE zi_moviedatadef
      FIELDS ( Genre )
      WITH CORRESPONDING #( keys )
      RESULT FINAL(movies).

    " Process Movies
    LOOP AT movies INTO DATA(movie).

      " Validate Genre and Create Error Message
      SELECT SINGLE FROM ddcds_customer_domain_value( p_domain_name = 'ZABAP_GENRE' )
        FIELDS *
        WHERE value_low = @movie-Genre
        INTO @DATA(dummy).
      IF sy-subrc <> 0.
        DATA(message) = NEW zc_movie_001257( severity = if_abap_behv_message=>severity-error
                                             textid = zc_movie_001257=>invalid_genre ).
        APPEND VALUE #( %tky = movie-%tky %msg = message %element-Genre = if_abap_behv=>mk-on ) TO reported-zi_moviedatadef.
        APPEND VALUE #( %tky = movie-%tky ) TO failed-zi_moviedatadef.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD rateMovie.

    MODIFY ENTITY IN LOCAL MODE ZI_RATINGDATADEF
      CREATE FIELDS ( UserName Rating RatingDate )
      WITH VALUE #( FOR key IN keys ( MovieUuid = key-MovieUuid
                                      UserName = sy-uname
                                      RatingDate = sy-datum
                                      Rating = key-%param-rating ) ).

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
