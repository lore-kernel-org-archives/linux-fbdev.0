Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A419049B
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Oct 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465593; cv=none; b=fxUneQ+biaUehOKnseEDahlIHMdAZgFmru2fzIYw3qNvwlzXuy1zrdVJ/oC7UaBgPAWHYLbjBrnr/obC/mkXTDbrQlmPi/Am0qA4Rl4CDPq6/lJdWEaeMIyW9Nt+q2nvFefCOYQ9kZG7Xi/rrdDDxfEEeXg9WzrqVerk21p8PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465593; c=relaxed/simple;
	bh=LedlEdJCC/LMY2h2d3ZMK/XTHFaSBO06zmv+zukeWhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olOlWCBQQonT8A4OaNV3po24ZMFuJ+DoXEY4J0CgWADZIQIrU8TeFCS2Mva+7WXZczhQxoVNlbIzyu/u+6L1o8/5xixQ8AojGpRt2Q5SMjMyP1yO3Eh/KSp9mO8ulAwfHkCFb4DGRE7ii8xU73yPSbLm740rX9d28TMinrMXHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2dT7ax7R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2dT7ax7R"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398df2c871so7201336e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Oct 2024 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728465588; x=1729070388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sxBsvfyhV52GErg93d3TwpYRkYKpCLqLg+LjkHg/oE=;
        b=2dT7ax7REX8q7RSdAJNI/Ca3KxbopmB68elYRlv9A8ZCMTglcjPonJSPuGTWlqtIT6
         Dzus5GDU0Jj82orq1qQ+EQ80rYCASZwh9AaJNPmEYI6g3OrUlG8XmjysfrI3nc9meMld
         I7akCOliqDCyjC1ri3qOyvL8ysgsRDtpfzmaoVWXG8Wza71y25YAJYZ33/h+ZYKrnx0x
         dmLGC1eJz2OSZoQk7QP16/BrZa3pexzfWR+TMOgzjxvYGPzsybDYkwEIbeeqaDcOT6ba
         4aN8Dd68MVhyDlIe/tw4OVUFtf8x4tSLS31lvjJMnz53kQI1Tf9fFifjftJUb19LMJhI
         20ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465588; x=1729070388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sxBsvfyhV52GErg93d3TwpYRkYKpCLqLg+LjkHg/oE=;
        b=l+dOAT8X2/WglNFGHg4PdpT2+jl/aypONfBnZo3VuroTODYsTBXmqPJwAlKau38ST2
         JPqpAa9CSOZQYf6sYV3PZW48f6+5NtxQPGgvUB38KGQt/CEOPE00iVB/w5LkYPyclLy6
         fI81DE3QnUYxtWZo9BN4euxKUIgRxCFtLoBM2M/1T24UPHv5KGlhebkEzrYKMTaHx0Li
         1RzIJfI79h0SJmhd1+g02mGY9ywp3EhK3a24v7GAEeomG86nd19po7FKFhBli5DDxr4Q
         vHyevZxNO7+uH0KZh7d7/jZrbl3266wMT9XmkCWxmJ3QK62bn0XApSAksKJ3t//R6VWq
         iu/A==
X-Forwarded-Encrypted: i=1; AJvYcCWFZx2wIucIe8qUCaaPF83zzWP86KWOhsKdEWKsJOYaFqK5nXKkkOVw1CbCYBll6QthprCNMkutWZIRRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRQdo8pVfWs/P7RK5qOFmjcTtDGizf3giJeXVAGAv7lfPk56/
	igr60Zqw5BlgfW+B8n202Nh7dk3xOl/5PzKZXSrJEUZtxBaJ2/S/R+bEFHBLwQs=
X-Google-Smtp-Source: AGHT+IHYQG7GKXk+n7qR/3btWFErN/3GY0AZY2wR/wdZlZGQszvZ7tzxAcVmDX3/PqsYl/RTyG0tUA==
X-Received: by 2002:a05:6512:3c98:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-539c4896e53mr1055046e87.15.1728465587930;
        Wed, 09 Oct 2024 02:19:47 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm13892765e9.31.2024.10.09.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:19:46 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Wed, 09 Oct 2024 09:19:37 +0000
Subject: [PATCH v4 6/8] iio: adc: ad7606: Introduce num_adc_channels
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-ad7606_add_iio_backend_support-v4-6-6971a8c0f1d5@baylibre.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728465581; l=4625;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=LedlEdJCC/LMY2h2d3ZMK/XTHFaSBO06zmv+zukeWhM=;
 b=AaS7KusQPatp8MX1pH5ToR+la3iwSdh6zB9K40z6KABcG3HpnptxYWGhiGu6BPFHN699K94Ky
 VYbdSYgtQV1CniJYGqxgNmLQyY9MBriUVtggF+Z40PZd+VxxD2jQDhZ
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This variable determines how many hardware channels has the chip,
oppositely to the num_channels that can contain more channels, e.g a
timestamp channel in our case. Introducing this variable avoids
decreasing the former num_channels variable when reading the ADC's
channels, and clarifies a bit the code.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 +++++++++-
 drivers/iio/adc/ad7606.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dfbdea8c28ba..ec902b268388 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -150,6 +150,7 @@ static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
 const struct ad7606_chip_info ad7605_4_info = {
 	.channels = ad7605_channels,
 	.name = "ad7605-4",
+	.num_adc_channels = 4,
 	.num_channels = 5,
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 };
@@ -158,6 +159,7 @@ EXPORT_SYMBOL_NS_GPL(ad7605_4_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606_8_info = {
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-8",
+	.num_adc_channels = 8,
 	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -168,6 +170,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_8_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606_6_info = {
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-6",
+	.num_adc_channels = 6,
 	.num_channels = 7,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -178,6 +181,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_6_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606_4_info = {
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-4",
+	.num_adc_channels = 4,
 	.num_channels = 5,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -188,6 +192,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606b_info = {
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606b",
+	.num_adc_channels = 8,
 	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -198,6 +203,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606b_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606c_16_info = {
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606c16",
+	.num_adc_channels = 8,
 	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -208,6 +214,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, IIO_AD7606);
 const struct ad7606_chip_info ad7606c_18_info = {
 	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
+	.num_adc_channels = 8,
 	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
@@ -219,6 +226,7 @@ const struct ad7606_chip_info ad7616_info = {
 	.channels = ad7616_channels,
 	.init_delay_ms = 15,
 	.name = "ad7616",
+	.num_adc_channels = 16,
 	.num_channels = 17,
 	.oversampling_avail = ad7616_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
@@ -528,7 +536,7 @@ static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
 
 static int ad7606_read_samples(struct ad7606_state *st)
 {
-	unsigned int num = st->chip_info->num_channels - 1;
+	unsigned int num = st->chip_info->num_adc_channels;
 
 	return st->bops->read_block(st->dev, num, &st->data);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index d401d3ab37e0..b26a11b2eba1 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -71,6 +71,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
  * @channels:		channel specification
  * @name		device name
  * @num_channels:	number of channels
+ * @num_adc_channels	the number of channels the ADC actually inputs.
  * @scale_setup_cb:	callback to setup the scales for each channel
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
@@ -82,6 +83,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	const char			*name;
+	unsigned int			num_adc_channels;
 	unsigned int			num_channels;
 	ad7606_scale_setup_cb_t		scale_setup_cb;
 	const unsigned int		*oversampling_avail;

-- 
2.34.1

