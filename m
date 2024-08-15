Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6117C997
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723934; cv=none; b=TieVt4G2EtV4QKlXqzX/QaIjGVhBToLMKhxvoTwpZMpvzR6ckcmkuR6AFI3u9XV52fWk0FlwsYhgeDM9dOnR/LK412zOVfYchx86jG4ZoLneS65b9JfUI/IvgEF+dCbj0MWnfqbPkUpNsCnQi3uM74pRbwWbFGUio/siX4YVDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723934; c=relaxed/simple;
	bh=NbKx0MzTSy4AkOnvlPHkNNwV65/pkwG9IF0PJXDZUNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhCOZ6aOJANZhVys2689D+nEPir7fN0MrMuKyR+1p9kWfgaG8QP4VjCgZAOntA998VzpKr3hodOfsIlXWSfuxJH/yrLS9ihEsXN5zDQZpr3aI6KQAfgALlmt37c5WZNTwI8ZeAdWADXvTdvxkSF3sYVMxf+mo70CUVtylEcpT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o/wKZo/t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o/wKZo/t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso5661855e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Aug 2024 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723928; x=1724328728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlruai3BQqsm2YC4dPuHFKVGpCYgCvlc+hshYkB6H2k=;
        b=o/wKZo/tDnKqm0doODysO8m8dYXNXqCSMbezw+IhBudRcpzNE3+m6W3OnhxG3BW9b2
         4iIZ7CjifrOGx+AWR3vXAP58Le2OAMhaEGv4tMQWJ76R++erQz1Qw6tNkxbEyZv9LWbI
         Ss0uP57a0UQwoM847ZAt3OcnrFzewDypuhEvzTKMWJZTkiXTLuVQLYV0AdQ22pYQEdOD
         Cf8Odsr/SRGlaGL/ZU5z/EAVXl/sU9bvkNPkMVmMyHulUVT8zCzKUiot2eSXXx68QTcu
         SxbJv9fXHdWjznC/h2JjdLvr55GDpC5bPw0v5LtPDX54YtogaVnA4Tu5kw2Vnvc4T+2O
         MS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723928; x=1724328728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nlruai3BQqsm2YC4dPuHFKVGpCYgCvlc+hshYkB6H2k=;
        b=U/9LHAgREPlKATUJnzayvQ6yWDPdR3skf0u95B2O9Dv/xtwkzwr/jauVSq196Xg2TW
         rde+UjCDAfgIbqWKDoEyC8oblIKUOfbjgTlDJXzFQbheBVEBiB1MkxGpWgeXE+CGATIC
         o9xeF9N15a0TF2/vH8U5HvVL5fXvAKPVOMEJBFCsSC9VbI/QIAqfkMiROEYOqkswMtgR
         6sm7GET60iFm6rUeyUOcsnAnw8AmGdB0t/s+1wKL8qslqHUIunUxiH9uFsCHTDsjcNZN
         WoVW6xIJkRzpVYJbQzK0Z579RJUFPYMNulEbZ47LXC0j5LwM/kVWT5WeAa0k0cEyCccc
         qLfw==
X-Forwarded-Encrypted: i=1; AJvYcCWnRfEtno1F2k3SzwMmfzkkAoPxXNtR/EiKZk1dCpl+KeOle/JpagS5C9ctyPcTTcXnfSYRaFJuNcBZuIc6lHQHai2lsWLIE7ARbNg=
X-Gm-Message-State: AOJu0Yz2UUuSeOa0bThppQMYGcPPRtI5kFyEP/ngp1XspO04gnibAf3t
	GNjN7AO7mIVQWMUjHblrv7+TVtP2a1a12H9DjHbM7vh2/9aI5AyY30WM0lliOt0=
X-Google-Smtp-Source: AGHT+IFqE0M2OmpEvxD4duj5kGOQWRtd+obMKR2lPW9I+CeIS+oRNhsQvPM4dCQIxcqphRcbR+qxkQ==
X-Received: by 2002:a5d:59a5:0:b0:371:728e:d000 with SMTP id ffacd0b85a97d-3717775c9b2mr4340274f8f.1.1723723927819;
        Thu, 15 Aug 2024 05:12:07 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:07 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:11:59 +0000
Subject: [PATCH 5/8] platform: add platform_get_device_match_data() helper
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-5-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
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
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=1781;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=NbKx0MzTSy4AkOnvlPHkNNwV65/pkwG9IF0PJXDZUNw=;
 b=VOYJGuD/1ccizW8foihyuYIcvcsufWDfHQhMJgly8oXiPmQELygHZcqqg/NPsa767PekcfJOM
 vx/cis54SwFDlOLGtkc07Yo/YSNxVhQeNHA7o9alToZqiRWmpOqxr9/
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Inspired from spi_get_device_match_data() helper: if OF or ACPI driver
data is available, platform_get_device_id will return NULL because
platform_match_id is not called, and pdev->id_entry is never populated.
This helper function checks if match data is available, and otherwise
returns the ID table data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/base/platform.c         | 12 ++++++++++++
 include/linux/platform_device.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4c3ee6521ba5..26e9a026eb05 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1090,6 +1090,18 @@ static const struct platform_device_id *platform_match_id(
 	return NULL;
 }
 
+const void *platform_get_device_match_data(const struct platform_device *pdev)
+{
+	const struct platform_device_id *match;
+
+	match = device_get_match_data(&pdev->dev);
+	if (match)
+		return match;
+
+	return (const void *)platform_get_device_id(pdev)->driver_data;
+}
+EXPORT_SYMBOL_GPL(platform_get_device_match_data);
+
 #ifdef CONFIG_PM_SLEEP
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index d422db6eec63..e2cc09ecc447 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -45,6 +45,7 @@ struct platform_device {
 };
 
 #define platform_get_device_id(pdev)	((pdev)->id_entry)
+extern const void *platform_get_device_match_data(const struct platform_device *pdev);
 
 #define dev_is_platform(dev) ((dev)->bus == &platform_bus_type)
 #define to_platform_device(x) container_of((x), struct platform_device, dev)

-- 
2.34.1

