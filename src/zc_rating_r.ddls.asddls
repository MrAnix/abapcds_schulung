@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating Computer'
define view entity ZC_RATING_R as select from ZI_RATINGDATADEF
{
  key MovieUuid,
  avg (Rating as abap.dec( 16, 2 )) as averageRating 
}
group by
  MovieUuid

