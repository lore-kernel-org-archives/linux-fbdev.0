Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460A257422
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203985; cv=none; b=eHF8x/ICanZ7ugiDi9tjY7+iRpW/02sHTtQSv2KUQz/rUQYxXjYkxNMVmHCuVDZE6okpwH4zQtbTJQVrrSZFP/8gSYXrfK2z8RzdXt2HiOJRGsfJH0M7fALEmrgoo6vjMN8f8ng8JdPNhRJGaTncl8z/foRSo0Nb0g+EV3k43Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203985; c=relaxed/simple;
	bh=oXABJ0HRSJUsqBxjQdzjmuSA2Zskw28HlIrTxxdX42Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhaqtyLscQFb7U3VAwffoFF8MlGDG1MylNK71Sk6OqzxIBHxw2Yv3Ch4JIq2dT5NbiR0mEJq3jD9jTIQl38QQdleYz/NMjRi3ke+skbekuoeSsTm5cZsWXow1qJaO4NTPVr3EwarvvDJfWuU21g/1F/LUIGnFXxc0TGrzmnyTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tik90vAc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tik90vAc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso45662565e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203980; x=1739808780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyom0qjvxfr0PUA0BRn3wccZvWvBCP/teSac2W2vzoA=;
        b=tik90vAcy+RxqL5CV/R71IdcYZdoghkq6KHkA0ol1xpFDU+yc5Xms/E1J30sGUPQX6
         S5UPbiNNjY/idtUNiokvcy7qCBSeNCUDVbaQby2S1cbgsNQhSMPUL3Q60Lkd9U8X2KNm
         N9HAsPgClRGZ4c3O9ekS4A0u1Bco651eTuEpK+58cj0k6fHUuXsYzAkWSWTD1pEbrBq6
         iocfkHFktzlvkebERSz1Kd62GVM9XmPlzkEnFx4YDfzakwFta9BIPDqYOARQ4ogBqeYq
         j+0Ae/N8zJK2QbNxWudiITcvLEdbFdv6zNFdmTUIW/yK3Hgfi4RfD83O7noQ+iVR2W08
         8ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203980; x=1739808780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyom0qjvxfr0PUA0BRn3wccZvWvBCP/teSac2W2vzoA=;
        b=k2xvt+XuctB6vA80kJQKHKToQKIPZ+fOdAR+fIMDAFfssBtpAF4qn0ySaw7Ibj9zi7
         Cnt8XRDfH4qk3RodOv5uG078Ifw48bpz7VOQsd/9lcgXNR+otF8jaHgmtYJr2hC2S/Pi
         Zn6WhGdd5j6dG9HkKPo3ODEwKxVIMhBcpKL0YRRFu71a+lKQGYMqiBod7G2v6iwJLuK2
         YNx0WXKDuyZoJRtjeRVf1ANJ5j2XQ3Za/ziJnvV4sSo8nKxe9ubIYwoLKuhxiqLY5PAY
         BOx29L6NlFq00E3JmO3n4gvX9XXOu3hO57wrfwTicXloMWHoPXcRTbgXoIyZkuCa9rlr
         1xAw==
X-Forwarded-Encrypted: i=1; AJvYcCVVoD5wgpwGEzQCoghQiChMjvQUgtwEG1lQk4O7ADoHKpg3JoKnT/NfUyzB0NcakYRhwxBgAf8jzzhpIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QhWEeDPklGCnJVATlIht3/oDJAvDFA4idnQXQqZsM+vj5FIO
	cORmV6LmJ73be4Z/QoLn7cMybxrnoOuF/N6I5kpqrHWnaJ2zPKUxAzo4WCGFFm8=
X-Gm-Gg: ASbGncu7RhI/fJD9vZe+PTpmIWXfGewaxUQPu0+epvQpJ6/+sh25v/LSQUejqPhGs5B
	Jxm8jKvoKD8vvnWmQ6rVb2odP5++LB2D0Ptr7/vSdZNJ6Irh6piZx7dvXis/X1UvQWa2CT5fpz4
	yVruMtZRoAYqrPl94k1FKkYLhssSD7Gxb1Iq/gTrvWop9n6GsV6z8AMWzLEmr1xeTO42f94CkSf
	NLn+AX4e5HqT7ych7A6t5VSbWvzoBtOM4xzR9dw+PnlHp4w46cpHIqs9QBQtbfVxuXyY05X70o1
	EY1FMNwkuLX4cAuo90nRNE7VTnty7gKmzn2E3qXsUEZvimo61HJxbZY8RU9R034=
X-Google-Smtp-Source: AGHT+IFHtByCSdx1O2bm7wTfO3oeSSWSD9kC3YKcmPVh+qEYF/LbA5lZmoVVo4nuzwDXSawJXU4XQw==
X-Received: by 2002:a05:600c:3c84:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-43924991e0cmr117634675e9.14.1739203979907;
        Mon, 10 Feb 2025 08:12:59 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:59 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:59 +0100
Subject: [PATCH v4 9/9] iio: adc: ad7606: add support for writing registers
 when using backend
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-9-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
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
 drivers/iio/adc/ad7606.h     | 15 +++++++++++++
 drivers/iio/adc/ad7606_par.c | 52 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index a35b526f3915..71a30525eaab 100644
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
index 64733b607aa8..335fb481bfde 100644
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
@@ -86,9 +100,39 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
 	return 0;
 }
 
+static int ad7606_par_bus_reg_read(struct ad7606_state *st, unsigned int addr)
+{
+	struct ad7606_platform_data *pdata = st->dev->platform_data;
+	int val, ret;
+
+	ret = pdata->bus_reg_read(st->back, addr, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
+static int ad7606_par_bus_reg_write(struct ad7606_state *st, unsigned int addr,
+				    unsigned int val)
+{
+	struct ad7606_platform_data *pdata = st->dev->platform_data;
+
+	return pdata->bus_reg_write(st->back, addr, val);
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

