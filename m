Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D4256C6D
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767761000; cv=none; b=RlxrMDikEc/3yeFAdMunVBdZi/2Fh+ObHk5gldHS2rFGQufCFwUSMFd/vZsNbByNPilEG3/edGbc7BybLN0E4/uIdy9u6FX/X3Axmn9R6dEiQtBlN0zl1q0qNr4Rm9MMAC8HAwWiNZG+Nemg9/Xr2J+c6s63xY3GbRgUUoqaUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767761000; c=relaxed/simple;
	bh=FnV0IJmLlwk0Yk8Amd2W/sf6pDwZoG+c8cE9oXjsy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bpn8jn5/AcXcsv+DkE8loHLw+zL/xG9bhSyrfH+JWvbX01s87jLiywC4HOR0EKtBzFMeyvdgWupPdR7tPQBT7frC20fhMZNx6Lyuap3rA35pl0Z54rHqfPwulYqVHMIAriYrtanzancCFckb/CpZl3d8eKZIb4qsjf5CXImcUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsRk2Atz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsRk2Atz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c3e921afad1so810025a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Jan 2026 20:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767760997; x=1768365797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLWOELcEjrI2iHJxLfRXTvBZahch6VAgebKRz7irVnw=;
        b=OsRk2AtzqxcSndp5aSNLRXCQSAd33VenZRHISibKT3i2mt1kRTM6JYnUq2/X0zamm+
         SpCL5X5koCLvjjK9WFwvWxmqVJQ9Ct26MLdS1A+OYWm3gT1bECSAflMZjhhIkRvKQ0fx
         q1r6DSkPyY6/c0xflLi2chwaIwJzxnDwo+v3WyIZ1oc/E77Tp1vY9zEbXoEfbQ1SEX49
         i27/VdIfdSD0j1ohtrQN9UhcuSWTW0HS0qKXjc8VBM7KLOLYV1uHoxzGYs8Dm3dsGXDW
         6Jmeppl6rQT+veyHQvH76rLXmZCNfXA16KwpnmPkcwItFyjsVW7J9UOC9CDm8aixNuN9
         mEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767760997; x=1768365797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLWOELcEjrI2iHJxLfRXTvBZahch6VAgebKRz7irVnw=;
        b=vKfMejLey1UsAaIr+/ifLF4HswpjAqpo3YTWREONs7nx6ZR8/RJzDnMIDvF3NynvMb
         K5wCJPCYYL9bEyTjQF6WYIgbnVbXnyVGNuJ8rs4DU9E51JK7aYb4xrHqFeP3g4+/9zG3
         KhaM72O+AKQaZvvWop9XV2xAQDBtIjHZa0gfs4T3kNJiwW6kkmSfKzBSJRdhvxPlyEf4
         Z24JeWdNsrQypCqL3/lDeXq/4CZYGPrC1VxVAMp6Q3YGfeBbw4qMCeEFpOjxONjjdvkY
         wJgEq67ss7H4dvBVSrvPww18Xwmbyd3VhyOgeMo5CXqo4jLBTGDFzPYJocxsdpXqLrTl
         VjIg==
X-Gm-Message-State: AOJu0Yy0dZ/4dC4UsG7Jj4XH0d9VWCgGcOlCq3tt2Y4WPa9uZvkf7mLw
	reRLEDZMwtRIjvJC6gxTZ5O6sH/e17X0QotGUkcGlSl5YqSg2XRxQpd4Wu7MOKbU
X-Gm-Gg: AY/fxX5CL6+TvqlVK5JQQJoVNdE5sJn/TGYgDu9X/YMREGwnMijUGDA3wNDQKNYzUS3
	OXqOo5iUnfCVMG48tioPQen1ABjaBU4lEjAXpt3tcSgETsmg4qzZqxYxWq3rF1Alh/QQ29ONxwi
	lJaxFsgrz3w1lBgl14Yv8M4kQFlJIOp5HwEHLAauiUyKy4/jCl2p6VkGdjw5gWZvPA4ZFkDPulF
	AizC6/Swl47U4WRcCnQAED9046FNlXEHXjicnUdIt6c8YOqLEpDXkjjOgaYb1y7TYKQi61TXpdC
	Tg7PVXdBC42MgT7mJN29fwYq/m9pxl0ykcx8l08QHyZSslKSQQLoEkKdhQJChciMPGyMtywILlR
	yMIvU82Ozq+SBkJzxEe88baZfsKyv6XpORj6BNEKnSouV+WRWs1cYAR0FXzUGSInmKMm/uApNei
	LbaRRI3OQqWQ4/W+2Q696n/FxKYMeXS5r3y3+UotlFRRjrbujyGVVxxA==
X-Google-Smtp-Source: AGHT+IEF2tiwIdEjUKJoleA4BSAnBVhOgZtlhWyisn+mWM00+oMK/a966pLLKiRVpDOA/U4Wkrlj0A==
X-Received: by 2002:a05:6a21:32a0:b0:366:2677:4b38 with SMTP id adf61e73a8af0-3898f8f5458mr1134448637.8.1767760997324;
        Tue, 06 Jan 2026 20:43:17 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:d1c8:9d76:637a:6957])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c39ef2sm36866225ad.14.2026.01.06.20.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:43:17 -0800 (PST)
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
Subject: [PATCH v4 2/4] staging: fbtft: Make FB_DEVICE dependency optional
Date: Tue,  6 Jan 2026 20:42:55 -0800
Message-ID: <20260107044258.528624-3-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107044258.528624-1-chintanlike@gmail.com>
References: <20260107044258.528624-1-chintanlike@gmail.com>
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
Reviewed-by: Helge Deller <deller@gmx.de>
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

