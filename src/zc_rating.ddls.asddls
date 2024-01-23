@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating Projection View'
@Metadata.allowExtensions: true
define view entity ZC_RATING 
  as projection on ZI_RATINGDATADEF
{
  key RatingUuid,
  MovieUuid,
  UserName,
  Rating,
  RatingDate,
  /* Associations */
  _moviedata : redirected to parent ZC_MOVIE
  
}
