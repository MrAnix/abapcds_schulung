@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating Data Definiton'
define view entity ZI_RATINGDATADEF as select from zabap_rating_a
association to parent ZI_MOVIEDATADEF as _moviedata
  on $projection.MovieUuid = _moviedata.MovieUuid
{
  key rating_uuid as RatingUuid,
  movie_uuid as MovieUuid,
  user_name as UserName,
  rating as Rating,
  rating_date as RatingDate,
  _moviedata // Make association public
}
