Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92991D8E10
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148708; cv=none; b=rQpYzYd6Bq7uk+B/xyNjJyJgl5b9AHxZPUrJFgLw/zJjgzSyhadfRpEAT9AinYPs1wTLhBqVq91W4J9uOIZY7d6Uv8YeFoqjYY4FuSwa5jLz1vxo/oegagNhczy73+XmTd8YKU2brH9rSMboNzjgVySuSp3r4tnXSsBMUBm5Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148708; c=relaxed/simple;
	bh=eeeG742/LDeOmZMMgJC+W4hlPYKRzBPb8KIQGlxLJKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nb1yanayJNPHkulTPXSZOT54uSSCqVsHouCf5AZ26jqzc5e7lrO7MGgkHonKbHPAIlyUk5AAMp9wgxf2CEq2XRjbvEg/HEnYLHGTNKGPf53YgSpRW292dszN8LxRpsb4LVWvasjRbeef9kvClkxnyGSxvafV3ofx/WQpCLvLjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ctaK8n/c; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ctaK8n/c"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38be3bfb045so400622f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148704; x=1738753504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdc1cATkxj+NRQremP6tEug4vIFfF8rLsJGQkTSIG7w=;
        b=ctaK8n/cGXbZUQJsCsEeJAX1kstrN1ZAO4b+dRNxj9Bsm0Lt0hC9j+jlAdPbK7F99I
         JAe+aES1tFjFYG51ASECBQM+3qpKJGlbIPjyeRCYtDQ5KP5V3qhq37qKpLBJ3HQQz330
         oJ9uWH4T8nbQkEuYDsdhAtu8Blp5am4lSKl8Y3u7YMUBsExsD51duhau+RsCUb2KlgVU
         YqYAFApmgnwjlUSVJF7ZgPE6pKUBoZr0OgG5zrnMkoFyX7NYVsCBJwKB7KlKPpUZe115
         zuWoCHaDV/K+9P5EUJVQtUuKI6c8GoR5TRujlUgiUQ4yisberOTWVTxbMcT5gCmvKycm
         cJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148704; x=1738753504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cdc1cATkxj+NRQremP6tEug4vIFfF8rLsJGQkTSIG7w=;
        b=D1zzSmEC2cdB+JtWZr2TriHBT4QDa7iXXoYOxBZ8A7BCc7/y9C12EZT9qO43RIkaFC
         Uzx5Y0LDxssGNzGjLOKimjWMeCMh21E93Ayf2Qo3qUzTUqWXH/EKby19iCaO04+WBRlo
         NmjPP+W4Fnme0yFY+tCuAk69yKJQ80AKKoe4gK/KRVV7WdOsB4qX3sxf9MWJgsqSCa2W
         0kV1Y1wFKYkpk7iQz3CtttvBJTeRpKDzBS2+8mIpR+GKlZ1tr/WDm4gYt9ibHOUJ5ntN
         sm9s1f4zy6eqwq+ofxNPTQYkYF8Uz/7OS8JeQQuJ8G+CbspmzZy2Q+7HOCdG4JH9YRir
         Nbvg==
X-Forwarded-Encrypted: i=1; AJvYcCXH8Yxlh5zvk6I9BNtDT/8hEx+LWeqERgQh085iKwMJa6DRqh/jq7HecztRp4AP9NJMsWtmRCOYWdSB6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMXy1Op8vwqTuOUCxkPf4VW+ilKkWWAZ81cWzLqrzFH9UaIOY
	ylGviIR9Kh9mv2mmj+73FZ45gvuajcACN16t5gPKz1Fe6n6IgFYgGcrc+52AfP4=
X-Gm-Gg: ASbGnctfhF35krHlYfAtnZzDrybu59qgJyO+rez+vxm5VZZW8qtmql1ILV+UrOhRHDr
	N/1KNHw/ZuFoXsWkSUYdY0P3RStkbyYpHEptmcmAsKGog/pq/Zw+nFynt0ECfFfom3WIPRsnkid
	MO5YqI2y385OmPXaXvVfoZIdWa5xLrTIGq1faIsE9PvsBvehml/y+rVuV43OVGUskYarCspELjX
	Fgb2fty2ggAISCqcPql0mi0H8exNSx6vOlbZhD/2zHLiFLLQMb4VzI8jdqZZWLtVcCxwyvalXq5
	vvAKkukmauoEvltLH/j/g1cxEXG3gSRL9O8nvvPT7Lzjjbloqs1ompfwjSQQcYsMYqOwu/k=
X-Google-Smtp-Source: AGHT+IFaDLpWVjFWIu1Y+Qyim7g9TKgeSUYK0sY4eBsggvgAlH7UPWWj1NlDTMMXxX0rHSkDBiAViQ==
X-Received: by 2002:a5d:6481:0:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38c49a051c8mr5706558f8f.4.1738148703815;
        Wed, 29 Jan 2025 03:05:03 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:05:00 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:04 +0100
Subject: [PATCH v3 03/10] iio: adc: ad7606: fix wrong scale available
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-3-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix wrong scale available list since only one value is returned:

...
iio:device1: ad7606b (buffer capable)
    8 channels found:
           voltage0:  (input, index: 0, format: le:S16/16>>0)
           2 channel-specific attributes found:
                 attr  0: scale value: 0.305176
                 attr  1: scale_available value: 0.076293
Fix as:
           voltage0:  (input, index: 0, format: le:S16/16>>0)
           2 channel-specific attributes found:
                 attr  0: scale value: 0.305176
                 attr  1: scale_available value: 0.076293 0.152588 0.305176

Fixes: 97c6d857041d ("iio: adc: ad7606: rework scale-available to be static")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678..d39354afd539 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1047,7 +1047,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 
 		cs = &st->chan_scales[ch];
 		*vals = (int *)cs->scale_avail;
-		*length = cs->num_scales;
+		*length = cs->num_scales * 2;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;

-- 
2.47.0

