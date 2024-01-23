@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie data definition'
define root view entity ZI_MOVIEDATADEF as select from zabap_movie_a
composition [0..*] of ZI_RATINGDATADEF as _rating_data
association [1..1] to ZC_RATING_R as _avg_rating on $projection.MovieUuid = _avg_rating.MovieUuid
{
  key movie_uuid as MovieUuid,
  title as Title,
  genre as Genre,
  publishing_year as PublishingYear,
  runtime_in_min as RuntimeInMin,
  @Semantics.imageUrl: true
  image_url as ImageUrl,
  created_at as CreatedAt,
  created_by as CreatedBy,
  last_changed_at as LastChangedAt,
  last_changed_by as LastChangedBy,
  
  /* Associations */
  _rating_data, // Make association public
  _avg_rating.averageRating
}
