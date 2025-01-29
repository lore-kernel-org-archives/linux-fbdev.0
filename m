Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F001DED73
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148724; cv=none; b=swMhI7jgkV0c5bgkc9RVkuRdUMQWTg7rMi7KAaZ15TvAEpSSCoXfg9PgzeIGhkdvKn+D6mtanDBEP2uNEmfdQzhV46kb4hbB2fD+ow5NnFa5V4WUkHmujLqtECw1RubrAtHKCq4iYhvrqfirk7/NHYgzGkU+pJXgalwa8zJbe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148724; c=relaxed/simple;
	bh=yGd3st0BkkdBB9o/zs3cfRwhrC8hQZbOG6AfbocTdgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYjExqYcgKzEH0jAHO/9oJtWqsv6w5/7b1NtsY4FxEkKAXxVyE+IgeFwu0IL6YjnWyxlwuLq/q1Lgsaa3/c5Eezatrq6JMhdn/m7ggWoTlJvbaZ04AxyciNyeVl0T0L8UhDpiMZ41p/7Xr21p3m7bJTIgQaBGvfUXXZv2GvQPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BIH8wq8l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BIH8wq8l"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3878578f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148721; x=1738753521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8oP5qhY3kGRjXifVrWrcQBHp7bMw7gjCvgp2Jodwtk=;
        b=BIH8wq8lGQoPZenuexFJMIg0K90mYzdXpYhm1eGDvNlhCOJu8MGI6B+Mlj1XYBM+wj
         UzHLg/dNKTMJpX6gQZbdiYaynB+fSSQ1OaM+9dYTFG1+Jw3/mGMi0DrU1dSgnvZ3N5XL
         Dq36VJ/XdeqFty4iGER4FIpGEYd+/1KBJcX0C8nGjClAACXcyzrfAnsmqumEefQPMtQn
         2TJrG8GaM5M7N4HFWQmX17iiFyEOH6E3ff5xHUQLORqcedqfZE+5oPLsWLbC3r0NpSka
         /HyfNDBLUYT/HNUW4cobE5LLlDEun3HmOIzllKQQK3UIDBD0Y8B12XmWOWqyRnJMRED2
         Jt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148721; x=1738753521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8oP5qhY3kGRjXifVrWrcQBHp7bMw7gjCvgp2Jodwtk=;
        b=Hj5drTEiQ0ZqWYCC3cK5f2zxww2OjE0xDNB7/J6SE2X5KoNHzeVT++afzJXQOg4ren
         37uGCCfEqLi/7OZCcXVmybQ2IU8/0DjEQy7V2UmdXhaEMwBRk0bKE5xp8XeZu7gppGZ5
         /ktXlU6QxTQ/fGPSxQ/m1fOmVV0L0Dbd6X71z2I63wFN0sxX0bD/Ob8nzpiOluzlxBuJ
         JwtXN2zhaCTsIuD9Bba8roiCSK1i70C8ScRW24KqogDwndXXlj8apyRlnBL+w1IesE8k
         jlAK3cYVEVExu6dCwTwAFlbZgjQ65aX1KIdlBDkbiTu3C5a81yuO2WHSyn4dHVhXfuls
         FtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeb9EITTJpo+/olKb9yMrYT75XiuDLTO/WQNTNx2+pCh1Qi8WAv5bxBaSdiBTHA/aC++DdlHrHCCiH0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSn/fxgqXAU/RddvN/5beAjnCk8w+lJqG+OS1O5JHg9EiqU7he
	V6x+r2W2lIpegyxoJ96MGyUWlYGTY0ig/CdqGn7s9aryHjCmpco43hoNN1myySA=
X-Gm-Gg: ASbGncvS6cLYs3zqXhXABPn+78ZRs6iK9Bi+Vu4l8UMKkyhsAnC1rjMtiiiAFjpSSbj
	u2Ur2dQdvTSDoq9QuZlTKPVqx8UJqN5JNvnVt1ARkDvvuHwhGRe/QTQ2N9hTV8cow/dq+TqmnDK
	vMTiPPGiml/6/Wp45yyu8ByxD/7k1cRA8QM0GmlYsG+WeDBWWIDVsnySEyMDGTSPpL8KMAN/mnE
	B6fwhOu9ehaBxRL6Hke5NdIK999ra3ATlZTHx7EUXQPzOGhO8higXZAf+DCdxaxZSM7mGwM/HtC
	slb3PayLR/vei0CS0mRiU5V5m02yqXX7z6waKT/XhuqgxzX2Hel5S062TtFEk7AYpG1tdic=
X-Google-Smtp-Source: AGHT+IHadqyHkH/s7Way2NtX7ywZbXEZrfjSOuv9RTHy7FYZlK0lZd7rr92W3A4jsI/0idbvpy2Bhw==
X-Received: by 2002:a05:6000:1788:b0:386:459f:67e0 with SMTP id ffacd0b85a97d-38c5194d438mr2585149f8f.21.1738148720850;
        Wed, 29 Jan 2025 03:05:20 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:05:20 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:11 +0100
Subject: [PATCH v3 10/10] iio: adc: ad7606: add support for writing
 registers when using backend
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-10-c3aec77c0ab7@baylibre.com>
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

From: Guillaume Stols <gstols@baylibre.com>

Add the logic for effectively enabling the software mode for the
iio-backend, i.e. enabling the software mode channel configuration and
implementing the register writing functions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.h     | 15 ++++++++++
 drivers/iio/adc/ad7606_par.c | 69 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index ada8065fba4e..9da39c2d5d53 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -96,6 +96,21 @@
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
 		0, 0, 16)
 
+#define AD7606_BI_SW_CHANNEL(num)			\
+	AD760X_CHANNEL(num,				\
+		/* mask separate */			\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask type */				\
+		0,					\
+		/* mask all */				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		/* mask separate available */		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask all available */		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		16)
+
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 64733b607aa8..19d93ae49e1d 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -19,6 +19,7 @@
 #include <linux/iio/iio.h>
 
 #include "ad7606.h"
+#include "ad7606_bus_iface.h"
 
 static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(0),
@@ -31,7 +32,19 @@ static const struct iio_chan_spec ad7606b_bi_channels[] = {
 	AD7606_BI_CHANNEL(7),
 };
 
-static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+static const struct iio_chan_spec ad7606b_bi_sw_channels[] = {
+	AD7606_BI_SW_CHANNEL(0),
+	AD7606_BI_SW_CHANNEL(1),
+	AD7606_BI_SW_CHANNEL(2),
+	AD7606_BI_SW_CHANNEL(3),
+	AD7606_BI_SW_CHANNEL(4),
+	AD7606_BI_SW_CHANNEL(5),
+	AD7606_BI_SW_CHANNEL(6),
+	AD7606_BI_SW_CHANNEL(7),
+};
+
+static int ad7606_par_bus_update_scan_mode(struct iio_dev *indio_dev,
+					   const unsigned long *scan_mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int c, ret;
@@ -48,7 +61,8 @@ static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned
 	return 0;
 }
 
-static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
+static int ad7606_par_bus_setup_iio_backend(struct device *dev,
+					    struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int ret, c;
@@ -86,9 +100,56 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
 	return 0;
 }
 
+static int ad7606_par_bus_reg_read(struct iio_dev *indio_dev, unsigned int addr)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int val, ret;
+	struct ad7606_platform_data *pdata =  st->dev->platform_data;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = pdata->bus_reg_read(st->back, addr, &val);
+
+	iio_device_release_direct_mode(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	return val;
+}
+
+static int ad7606_par_bus_reg_write(struct iio_dev *indio_dev,
+				    unsigned int addr, unsigned int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_platform_data *pdata =  st->dev->platform_data;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = pdata->bus_reg_write(st->back, addr, val);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad7606_par_bus_sw_mode_config(struct iio_dev *indio_dev)
+{
+	indio_dev->channels = ad7606b_bi_sw_channels;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_bi_bops = {
-	.iio_backend_config = ad7606_bi_setup_iio_backend,
-	.update_scan_mode = ad7606_bi_update_scan_mode,
+	.iio_backend_config = ad7606_par_bus_setup_iio_backend,
+	.update_scan_mode = ad7606_par_bus_update_scan_mode,
+	.reg_read = ad7606_par_bus_reg_read,
+	.reg_write = ad7606_par_bus_reg_write,
+	.sw_mode_config = ad7606_par_bus_sw_mode_config,
 };
 
 static int ad7606_par16_read_block(struct device *dev,

-- 
2.47.0

