locals {
  s3_origin_id = "${var.site_domain}"
}

resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "${var.site_domain}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.website_hosting_inamuu_com.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["${var.alias_site_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "pre"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloud_front_destribution_domain_name" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
