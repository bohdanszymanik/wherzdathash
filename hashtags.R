# get a URI redirect ie oauth callback
require(httr)
full_url <- oauth_callback()
full_url <- gsub("(.*localhost:[0-9]{1,5}/).*", x=full_url, replacement="\\1")
print(full_url)

#
app_name <- "WherzDatHash"
# put sensitive oauth id and secret info into idSecret.R 
# and don't put it into github
# client_id <- ...somethin secret...
# client_secret <- ...somethin secret...
source("idsecret.R")
scope = "basic"

instagram <- oauth_endpoint(
  authorize = "https://api.instagram.com/oauth/authorize",
  access = "https://api.instagram.com/oauth/access_token")
myapp <- oauth_app(app_name, client_id, client_secret)

# this line is executed on its own to pop up browser for authentication
ig_oauth <- oauth2.0_token(instagram, myapp,scope="basic", 
                           type = "application/x-www-form-urlencoded",
                           cache=FALSE)

tmp <- strsplit(toString(names(ig_oauth$credentials)), '"')
token <- tmp[[1]][4]

require(rjson)
require(RCurl)

# let's decode the jwt just to see what was in there

header <- strsplit(token, '.', fixed=T)[[1]][1]
claims <- strsplit(token, '.', fixed=T)[[1]][2]
signature <- strsplit(token, '.', fixed=T)[[1]][3]
base64Decode(header)
base64Decode(claims)
base64Decode(signature)

url <- paste('https://api.instagram.com/v1/tags/knitting/media/recent&access_token=',token,sep="")
rawJson <- getURL(paste('https://api.instagram.com/v1/tags/knitting/media/recent&access_token=',token,sep=""))
getURL('https://api.instagram.com/v1/tags/knitting/media/recent?access_token=745814254.1fb234f.95f4c42084524cdca04b949aabd7d74e')

tagged <- fromJSON(
  getURL(paste('https://api.instagram.com/v1/tags/knitting/media/recent&access_token=',token,sep="")),
  unexpected.escape = "keep")
