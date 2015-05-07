var app = angular.module('wildridgeclone', ['ui.bootstrap']);

app.factory('wildridgecloneHomePageService', function ($http) {
	return {		

		getTopNews: function (category, count, skip) {
			return $http.get('/api/worldnews/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
        return result.data.articles;
			});
		},		
		
		getVideo: function (category, count, skip) {
			return $http.get('/api/videos/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
        return result.data.articles;
			});

		},			
	};
});

app.controller('WildridgecloneHome', function ($scope, wildridgecloneHomePageService) {
  //the clean and simple way
  $scope.latestVideos = wildridgecloneHomePageService.getVideo('by_id_title_desc_thumb_date',5,0);
  $scope.worldNews    = wildridgecloneHomePageService.getTopNews('us_world',4,0);
  $scope.USNews       = wildridgecloneHomePageService.getTopNews('us_domestic',4,0);
  $scope.PoliticsNews = wildridgecloneHomePageService.getTopNews('us_politics',4,0);
  $scope.USMarkets    = wildridgecloneHomePageService.getTopNews('us_markets',5,0);

  // $scope.worldNews    = wildridgecloneHomePageService.getWorldNews('by_id_title_desc_thumb_date',4,0);
  // $scope.USNews       = wildridgecloneHomePageService.getUSNews('by_id_title_desc_thumb_date',4,0);
  // $scope.PoliticsNews = wildridgecloneHomePageService.getPoliticsNews('by_id_title_desc_thumb_date',4,0);
  // $scope.USMarkets    = wildridgecloneHomePageService.getUSMarketsNews('by_id_title_desc_thumb_date',5,0);    
  // $scope.imageGallery     = wildridgecloneHomePageService.getImages('image_gallery_view',8,0);
  // $scope.latestInterviews = wildridgecloneHomePageService.getInterviews('interviews_view',5,0);	
  // $scope.currentYear = (new Date).getFullYear();
  //for video player
  	var video = "http://video.contentapi.ws/"+$('#video_val').val() 	
 	// start of code for generating cb,pagetit,pageurl
 	// var vastURI = 'http://vast.optimatic.com/vast/getVast.aspx?id=en732n1l1f3&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]';
	// var vastURI = 'http://ad4.liverail.com/?LR_PUBLISHER_ID=44293&LR_SCHEMA=vast2-vpaid';
	
	$scope.loadVideo = function(){
		$(document).ready(function() {			
			jwplayer('trailor').setup({
                  "flashplayer": "http://player.longtailvideo.com/player.swf",
                  "playlist": [
                    {
                      "file": video
                    }
                  ],
                  "width": 638,
                  "height": 330,
                  stretching: "exactfit",
                  skin: "http://content.longtailvideo.com/skins/glow/glow.zip",
                  autostart: true,
                  "controlbar": {
                    "position": "bottom"
                  },
                  "plugins": {
                  	 "autoPlay": true,
                    "ova-jw": {
                      "ads": {                        
                        "schedule": [
                          {
                            "position": "pre-roll",
                            // "tag": updateURL(vastURI)
                            "tag": "http://ad4.liverail.com/?LR_PUBLISHER_ID=44293&LR_SCHEMA=vast2-vpaid"
                          }
                        ]
                      },
                      "debug": {
                        "levels": "none"
                      }
                    }
                  }
                });
		})
	
	};
});