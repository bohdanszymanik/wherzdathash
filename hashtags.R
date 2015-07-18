# get a URI redirect ie oauth callback
require(httr)
full_url <- oauth_callback()
full_url <- gsub("(.*localhost:[0-9]{1,5}/).*", x=full_url, replacement="\\1")
print(full_url)

#
app_name <- "WherzDatHash"
client_id <- "841908b2b41c493fbea7789d0135e0d9"
client_secret <- "11cabebf97194f36898e1c0544c56752"
scope = "basic"

instagram <- oauth_endpoint(
  authorize = "https://api.instagram.com/oauth/authorize",
  access = "https://api.instagram.com/oauth/access_token")
myapp <- oauth_app(app_name, client_id, client_secret)

ig_oauth <- oauth2.0_token(instagram, myapp,scope="basic", 
                           type = "application/x-www-form-urlencoded",
                           cache=FALSE)
tmp <- strsplit(toString(names(ig_oauth$credentials)), '"')
token <- tmp[[1]][4]

require(rjson)
require(RCurl)
tagged <- fromJSON(
  getURL(paste('https://api.instagram.com/v1/tags/crochet/media/recent&access_token=',token,sep="")),
  unexpected.escape = "keep")
