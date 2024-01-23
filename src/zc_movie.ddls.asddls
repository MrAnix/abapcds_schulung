@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie Projection View'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_MOVIE
  provider contract transactional_query
as projection on ZI_MOVIEDATADEF
{
  key MovieUuid,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  Title,
  Genre,
  PublishingYear,
  RuntimeInMin,
  ImageUrl,
  CreatedAt,
  CreatedBy,
  LastChangedAt,
  LastChangedBy,
  /* Associations */
  _rating_data : redirected to composition child ZC_RATING,
  averageRating

}
