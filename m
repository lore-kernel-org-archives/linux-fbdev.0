Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAD2D594F
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072549; cv=none; b=prTlpzAXEJLXbbDiTHs+HMnMh3V8Rz3A3cmlyHFyhb+8Lg5RV1CPtgZbVm9QoVwSUUCAybNvRGq/PUJ+JVcL0O+uo9edVS7q61VQnUv/mz4oAOE5EW34ud9VUuSC+1UnnKT4QAPLZ/tbyk0IW1TmArGLAXPx4KubUXywKKqNSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072549; c=relaxed/simple;
	bh=AxHW31F/u643GumGUG5OTePG8VH5O62R29ow3KWdMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPfrZlAbDObrwHWuNiVYm016ciyTeh+nVaMYQt3+3mteErD+1sPdA4v6W5/nG9ab+Xb6gVN6UUhoOiFwku1fJiNFJkMabNGuD7MRfX1Fcboa70fegtVave++g9OrL0A0X1jdgR4HYK6NLf9tNt1lwh33C5wbm8u6qc26FN5Uotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH1YdJTe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH1YdJTe"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c09bb78cso70209055ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 21:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072547; x=1767677347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2hI5Lo88RYKXzSxQDxQgMKWvWfPHcve4QtdDyVBhKg=;
        b=nH1YdJTeXfmmCOqv+vjb/dCY3zseC++FT3i9NI1635HUdptpov5RtVtA5/J7Ojckqw
         UKMAmTq88yiiwahrEAHiEzwQSko4MXRKTGd/D6N0dk7BGz2GWctLk3KU4p+K7WxmoLXe
         vs2NBcLBObQ4+RUJbrAuzKFTKq97hZIjlHnNNn3YcygEqob6TxTbCRMBFLygB/9QiPbm
         MKBsaxmCdO5MrtTxlAyKlreqWiF6DUUJ/U+y0BoC+KnJdkIC2vxABSKn50f2DaXE1Vsj
         umpLplhGuszFyonMLNwH0VFxQk0013KXuqiUsZHxXarmcDgMkKVXxNyFsoHSmRbJOS8G
         sIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072547; x=1767677347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2hI5Lo88RYKXzSxQDxQgMKWvWfPHcve4QtdDyVBhKg=;
        b=UYflcVcSdXk+ZGh8Kv9QLwjGyf9Id9zBm1TDOBc24yaDB8j+EQb+dHWw7qWvFv7wMJ
         xBy/ybIGKNtbINuG0WEPWBHIqycjWfhYPICd02wQOttV88N/1mEN4l8EDlP36n5qzu0q
         gA9QTcQ1Lr9oB3CMF+N51B8UN2inZxch0eyyPM0RISn87eE4bVrl+Atohdmkej033b0c
         VZ80DJFKKfYmlvWaVJu6owIDb+L/XYwsm1nUhGd+BZmyohP8WIILxpM0iimSi9Sg+o/D
         zDa192Zdohnqpu0Hd2TDiH/CjfcjO+ubsaG1VOcEjbQQy4wUmDJ6ZC+YWOel41ianXMf
         dy2w==
X-Gm-Message-State: AOJu0YySokKwRkZ8JN9cpyWReOzCOrY9b4mEHIUQhKPoBgeGLOrFAT1d
	HTgLMxIiOXEOMiQY6BTzzzObK9USWK0V83ymAqjxN7pto1rVy7BgC2IRUAdJgNrW
X-Gm-Gg: AY/fxX4d8+cH2RPKRrpFq4KChCCu2r/irRJ8ciNAMoa0Q2tfx/pjxNhvkoRTRSshjwP
	nlUo43kdYRFvVbRIgjlRrjCss7faJpOlrfrKyTFVkh83DJf0BWNrAMlqq2lEeHbV03j+bsikVQb
	FsYoBR94tqLgmZG80jdS2S6DajEbpJij+zVi4pRPkLsHplBBGiU0kxBLzY9JjswGB8wgH3OphhP
	uLHvV11hc69gAuQicI9DKE5/1AqO/7ixdu/kxqxZIcYjAjyH6gDW+U0znVNSNEYSa+aX0G947lY
	8wRHSRiIkn5Xue2o8Ly31dUKgmx/4fQDlrNvHMf+EWBaIROf+sOILoPlKROEPB6VtRQwQLLUGJM
	iQR2A7a1ju0833o6i8iXOnM0HAIPs/FoP9LQBFLQGeR+3qFJj6gpBs7boOa6TfMU2mEigqvLWqZ
	NAIOK8hoXTleP0lRZVkVKWbjl6r9RTzKQ1ag2wWuKKzg==
X-Google-Smtp-Source: AGHT+IEzK1mfCzTYTBVF1B1JeAS/8wWfCanHdXYXITuiOcE0jrd5VC2Uc+2+6l74lzCrDnJw2EHo+g==
X-Received: by 2002:a17:902:f68e:b0:295:55fc:67a0 with SMTP id d9443c01a7336-2a2caa9be93mr359745255ad.2.1767072546800;
        Mon, 29 Dec 2025 21:29:06 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:f7a0:c2f:d915:faf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8286esm289290375ad.33.2025.12.29.21.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:29:06 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v3 2/4] staging: fbtft: Make FB_DEVICE dependency optional
Date: Mon, 29 Dec 2025 21:28:20 -0800
Message-ID: <20251230052827.4676-3-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230052827.4676-1-chintanlike@gmail.com>
References: <20251230052827.4676-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbtft provides sysfs interfaces for debugging and gamma configuration,
but these are not required for the core driver.

Drop the hard dependency on CONFIG_FB_DEVICE and make sysfs support
optional by using dev_of_fbinfo() at runtime. When FB_DEVICE is disabled,
sysfs operations are skipped while the code remains buildable and
type-checked.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/staging/fbtft/Kconfig       |  5 ++++-
 drivers/staging/fbtft/fbtft-sysfs.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index c2655768209a..578412a2f379 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -2,11 +2,14 @@
 menuconfig FB_TFT
 	tristate "Support for small TFT LCD display modules"
 	depends on FB && SPI
-	depends on FB_DEVICE
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on GPIOLIB || COMPILE_TEST
 	select FB_BACKLIGHT
 	select FB_SYSMEM_HELPERS_DEFERRED
+	help
+	  Support for small TFT LCD display modules over SPI bus. FB_DEVICE
+	  is not required, but if enabled, provides sysfs interface for debugging
+	  and gamma curve configuration.
 
 if FB_TFT
 
diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index e45c90a03a90..d05599d80011 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -203,14 +203,26 @@ static struct device_attribute debug_device_attr =
 
 void fbtft_sysfs_init(struct fbtft_par *par)
 {
-	device_create_file(par->info->dev, &debug_device_attr);
+	struct device *dev;
+
+	dev = dev_of_fbinfo(par->info);
+	if (!dev)
+		return;
+
+	device_create_file(dev, &debug_device_attr);
 	if (par->gamma.curves && par->fbtftops.set_gamma)
-		device_create_file(par->info->dev, &gamma_device_attrs[0]);
+		device_create_file(dev, &gamma_device_attrs[0]);
 }
 
 void fbtft_sysfs_exit(struct fbtft_par *par)
 {
-	device_remove_file(par->info->dev, &debug_device_attr);
+	struct device *dev;
+
+	dev = dev_of_fbinfo(par->info);
+	if (!dev)
+		return;
+
+	device_remove_file(dev, &debug_device_attr);
 	if (par->gamma.curves && par->fbtftops.set_gamma)
-		device_remove_file(par->info->dev, &gamma_device_attrs[0]);
+		device_remove_file(dev, &gamma_device_attrs[0]);
 }
-- 
2.43.0

