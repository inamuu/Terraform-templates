resource "aws_s3_bucket" "website_hosting_inamuu_com" {
  bucket = "website-hosting.inamuu.com"
  acl    = "public-read"
  policy = "${file("files/s3/policy/website_hosting_inamuu.com.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "log_bucket"
  acl    = "log-delivery-write"
}
