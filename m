Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73224FC01
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203972; cv=none; b=SJMRAn6H3eNGzx8YbNH20bRT3NuOshVpziY38WrpkCNo040ngJCaUOvRQiF3/Tqpq6zcWgZo0Wc5M53j2MCAHoLOMlWq/5BD/RZIeiP+uELsG+Mqq0F6HGtwqjtyXUZlXMFLA15jgA64Ladg6kFpXV8xeYMICtHNWVLt6R48/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203972; c=relaxed/simple;
	bh=dioqZv2txBsr2G2NsI3KTjuvSsHBK1WMQvxJwpSgCpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwGa1TTnSxsgRjbjpwqXRDGAcbjiL8ru6ku/ZIhMq8sFj3A36gObdOYjaKFedWpxfWje+fMmgZXdCOhDZozp/FFKACuol50Ch8K7ba3tEpeUPbM2j9+Jf9Mk0ODIjYxT0YKgUTn0fSpIv6817tF2gu/zcnznKwkQYpke9J9/CNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b9y3MuMF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b9y3MuMF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436249df846so30998935e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203969; x=1739808769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlrP600R/ci5wFmyR+m1ecPzb5qUkdneDDlwcUEYxOc=;
        b=b9y3MuMFXdZk5UnwGNkzL3tGF/UoguHHXLfUTzvSVsX3Z+eXGBM6cMqME+9CxFlEzF
         fKfuWy5VdEs5/+vZXnMVsSKxzqQ1s4zbMGIZozZyfSzY/sIo+WPGsR90me2vjhRZwzmA
         otljs5BZR4bFEfYmXUh39yhIO8QwBREXOYTFF4P4kWBmXG8xU2zSGTfwlheccqBUSs81
         5LtR5Dd+BY3425MXiqANpHcBoNoHADAqfyJNYQiTc+FDQ890bIThjMxELGhLQQvf9lmq
         fJal8c3qgAeAfif2zwBvOx6OeCZvqUeZJ0pUCrGnpaSC2Zvifo858zHBUuML9MZ5pQtk
         YSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203969; x=1739808769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlrP600R/ci5wFmyR+m1ecPzb5qUkdneDDlwcUEYxOc=;
        b=UmIIffy96qZuSUvomnMRB7TbXw3rG8Hnd7w7ADP5VYUXJjT2I7/iQMXF8CkXyz5fH4
         tXvZ/YA7je0j/1ktzuvxalNNpyiydON4MDQ20a7MFOcD1H86/3jHWdCvlRZJeYKWfvWs
         G3IBiQRXXFDq6Mm++Q6bAi8+f/NnHa+q05PRwv/tBrnrlW8rFEYnyAx6uFhdD0/ttwYq
         F30KDHd40GL1J+HU1lTktHVZr6pP9zHJKDSyKvFcTtouuF2NPub/SRMJpKJZjJVuDkjy
         iZnhsSpTCViHjEVuf99KVAHNYcYBLtyLkVnAMORY5dqbq4vaznuJjCCF81SwFLsO427C
         v5fA==
X-Forwarded-Encrypted: i=1; AJvYcCVrNeOz9FxoH6XGCzSFRJYZNRlttOLZurJscdlGluI5xN/FCL5C0Mj8kkzTr0Nqhek084MNDsgO1hT0mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/0/biDVVYaCDFLLU485zMCLnk/f01NsXhIxno6aHUhEi99xq
	PNBH9aLRXulzJTfsPUeysDbBGIcDMu9D5ZT06ZjiitqFXv6hajcLqXxWG+BP6jk=
X-Gm-Gg: ASbGncuTGCj+/fXL+emzaFdkGVuiQqj7YZ2TtY3u67sm+XE/KGj0fwKyCy3fm81hvcv
	R6mkbhW3y0tFLdiKI9Gfa/UeV/DLcfUypgLBFg5AdvVsreZ2ovF+jCdnCaBOyXpuNs4zldKcjjU
	pruHd1VbvSpOYXvDTKH/iH0/iWEyCNuEaS4MT13DzMgzfSMZ6+TauXxey8Oe90AzDByeGV6OYpU
	UXnTYrvevR+53ZP7jh4LkZDHZxMCA7lADpyGxMJU3j/nwPKyvVTHDTe+H63n4Vhuq72t61okpgC
	IgHg2gozNaAORlTcmFAw1T5/XipQp+LWUW7kNcsOek3i/a5XqiFldgPKU4QQMhw=
X-Google-Smtp-Source: AGHT+IGQ20TR8IqLo3bvMy0IcaAnfycl4PjoyxaTBZPLOGAxAxi90IcCYacmnO7KRYC2/BYvJFVsqQ==
X-Received: by 2002:a05:600c:6dd7:b0:439:31e0:d9a2 with SMTP id 5b1f17b1804b1-43931e0dfeamr74180395e9.3.1739203968869;
        Mon, 10 Feb 2025 08:12:48 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:48 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:52 +0100
Subject: [PATCH v4 2/9] iio: adc: ad7606: move the software mode
 configuration
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-2-160df18b1da7@baylibre.com>
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

This is a preparation for the intoduction of the sofware functions in
the iio backend version of the driver.
The software mode configuration must be executed once the channels are
configured, and the number of channels is known. This is not the case
before iio-backend's configuration is called, and iio backend version of
the driver does not have a timestamp channel.
Also the sw_mode_config callback is configured during the iio-backend
configuration.
For clarity purpose, I moved the entire block instead of just the
concerned function calls.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d39354afd539..376c808df11c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1246,17 +1246,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return -ERESTARTSYS;
 	}
 
-	st->write_scale = ad7606_write_scale_hw;
-	st->write_os = ad7606_write_os_hw;
-
-	ret = ad7606_sw_mode_setup(indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ad7606_chan_scales_setup(indio_dev);
-	if (ret)
-		return ret;
-
 	/* If convst pin is not defined, setup PWM. */
 	if (!st->gpio_convst) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
@@ -1334,6 +1323,17 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
+	st->write_scale = ad7606_write_scale_hw;
+	st->write_os = ad7606_write_os_hw;
+
+	ret = ad7606_sw_mode_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7606_chan_scales_setup(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");

-- 
2.47.0

