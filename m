Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844718592D
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Sep 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853621; cv=none; b=HtvI/zNH9B+RT+IvCcZ/kArkyFFST3lPzoev1u827HWERgIQx6kZNVG2T0tf7racFXdC5g3MS3eSq+8s2F0WCtf2nNTeaxZ2gwNiSutW16/YKMlwh+pRGtcfXppwfijg8u7eSkeU9EbMua2WAsy5jeeM4SUkI094p7zUiLFbUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853621; c=relaxed/simple;
	bh=jH5AF1NUj11MGOXs+0oMMIR7SvlyPmokhbLME9mMNMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSeeqdit80bZd85QiS1PcD7ONw5vySfrXua+2J03LG4K5K0pq8PLYJD6UCSX0WPbgJT94dV/Bd/BK65NUYZvhqQ4Qq1UjFnybuBRQaPbLRIrNXZxDf7K9C9fOhcuWrAtJKva8plHGtceZYV9RlflwvSS0U2ppSI8jSuTpe70/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BIOrXG+r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BIOrXG+r"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374bb08d011so1238521f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Sep 2024 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853616; x=1727458416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqbTxoEOJj+E0EusJXu3vOo7bySZpM0E+tGgQhd2Qeo=;
        b=BIOrXG+rj43PTDtF5s+7ZqEf+/6qZ3HmQoUZeQ0jFuq8PEtSzC8VI/ulrwfSYHDKUf
         14iFj3+RFhTNas1qHu03RpWNtGKRF9KX0aGtcDWAsfqFTezhWVriczctcCVIGCRces2J
         aGvDo5I+z/D8MBaKNeLgBB8g+2fQJbuqvOF99ary92LlyX0bKAYb/TcjJL2xUwJAh+Om
         PYNW5drVNKSSoF1riQqLDYbaByoWbVPX3hVYM5v+3HFOG8Ctcfh2p9qlhlL7CKP/Ifm0
         U6Ie8AvlJbn62W+q3AjlIswmyaPcaBTHNHf/g4HlJNHUxEsZMXk9TJ1ZBcAkb4M/dKSG
         Erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853616; x=1727458416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqbTxoEOJj+E0EusJXu3vOo7bySZpM0E+tGgQhd2Qeo=;
        b=EjD/Wx82WntGDXzESOEja/cQEvU5mvMRJsnSwMlcQaRNr7f5YoimP4hhf5eeFReM5R
         d4X+/FRnYU1V+I3J3/kZsYTS/FtiwktGBVjk6A2YatzUiDqmBca9cqCULp7Rrdrr3ro1
         lWRBST/QcHp3y07vNzMiEcME8SE5A5z2CYBebNKYcxeE5YrweqSOF+pReW+7eCFMcpBC
         VbX9xGzW4LjEYLuspdH2YMBa2MluQXBzCtgl0A3C3SK1gB1t+d9ckTFV+dDXG0eJ1VLD
         5Q3604Ia/3B1EA0wobpBktopLXUj2loGzgkoNwpUqQM+ElrCf8Ycx3NkzbbAHnl+5VgI
         C+yA==
X-Forwarded-Encrypted: i=1; AJvYcCXPE+OkO8LO+82QtPsaZxi/mTQChmz/lWHvAO/oELWk2AkDiN+UgC+XiUIJ0SLFim1y4nsYtcQ/OQ03sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLS/nklWnAY2R/zdZx40shoIzSjQvbDSGSuq97RwajWfosD77b
	eRPMOC3YZTocjcLE1pzciNvaQzk/qnWM36a6vN24nNt+48S8W3OUlH5FnidApudQwVzOEu7UFL9
	W
X-Google-Smtp-Source: AGHT+IFiSJQD4Z15/Xdx8nq9M3r3mKqhBJoDnK88r8s3gsfWDbUgSbXnNSZwYOc4QDNcmGmgZR2b6g==
X-Received: by 2002:a05:6000:88e:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37a4226bb7bmr1929359f8f.14.1726853616033;
        Fri, 20 Sep 2024 10:33:36 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:34 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:30 +0000
Subject: [PATCH v2 10/10] iio: adc: ad7606: Disable PWM usage for non
 backend version
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=1655;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=jH5AF1NUj11MGOXs+0oMMIR7SvlyPmokhbLME9mMNMs=;
 b=kSnZJIrPGfSq6YzbLJZ9p9mO7w2NOsG/iZXur554ypRAWkxnTvW2tYn3jiMYak1kdPyCLhejb
 hUajOoIJbZlAmnbA5Lm007KmnnbAvokXAsLS7hGMF50KRMfdAOuPIXg
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the pwm was introduced before backend, there was an example use
whit triggered buffers. However, using it may be dangerous, because if
the PWM goes too fast, a new conversion can be triggered before the
transmission is over, whit the associated mess in the buffers.
Until a solution is found to mitigate this risk, for instante CRC
support, the PWM will be disabled.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f710445bdc22..0c12ca237ee9 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -599,7 +599,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
-	ad7606_pwm_set_swing(st);
 
 	return 0;
 }
@@ -609,7 +608,6 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
-	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -838,6 +836,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
 	} else {
 		init_completion(&st->completion);
+
+		/* Reserve the PWM use only for backend (force gpio_convst definition) */
+		if (!st->gpio_convst)
+			return dev_err_probe(dev, -EINVAL,
+					     "No backend, connect convst to a GPIO");
+
 		ret = devm_request_threaded_irq(dev, irq,
 						NULL,
 						&ad7606_interrupt,

-- 
2.34.1

