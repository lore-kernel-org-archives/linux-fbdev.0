Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4373128DC
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Sep 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736731; cv=none; b=LqvTQFmpVRDgKc2ZQs1UUQhGULkqV3AoSHZ/HS21al8+OSKEdehznXpsyn9vlC0bmIKuc8ut6kSwefzbK9Hz0h7OCM+yTxSprW5FgylfiARKb1iPKm/8oeTsTpHehPwVqucXXQkKD7nIvEA9Qone2f2yV6aM2P+WtXhsC1kfglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736731; c=relaxed/simple;
	bh=J9zIa1+ZcwGSSn740ye9fEQihDeL8OCDBGPNvWNOnyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrYUmRG8iJjHxVyvLScIgZwOgZuCm01rw1tORGPgyhpl5g8Y4GU/hWPvxhfZQu4BTX2mXxynGT2xKvnHO+GG9PAdiP2thYles+Cmva6v3HR7SRnCNJbQbWVeJ7BchosVvvsly0NWROO3LMXRwBFHYlo5Ebd04uvP6qY7gbg832s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEQHzFzK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEQHzFzK"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso95016a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Sep 2025 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758736728; x=1759341528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKqJP+48MmB6+CsLCrP4WRsLC5jZbjywV4JQAy5jU3Y=;
        b=eEQHzFzKaL2eE1QzzJj1/KTX3vzRF3zGSKLFoWK/SkA1Vwew8GzIpvDAz4ROp8BLjw
         hgxlB88g0fJvBSXRwvqgbUD6W0V+sPPRLw+J7giq3yrDnbEOKL03CtC5zcHNAqm8BUsA
         c6bsc7W9EcYhJ/lnYvlcoovIyrgHEbe70YGH+bS++NwVxhx6mOaZsqXalK1a2muT8Oz+
         JpL3DUKMRoz9n7Cn6wOisuaatkTTmwP0lBV718N4yEeQ4Q0lJqsVODY20zktLhNUzH7a
         UelIXpUeHbyGzi6QCQSEoHkXiV5L9eVa1z/GD8mls0sdyOEmFGjegZZgdOLQfx4GSJWB
         iHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736728; x=1759341528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKqJP+48MmB6+CsLCrP4WRsLC5jZbjywV4JQAy5jU3Y=;
        b=VykyJgmfckaxdoHPNdFxkLQC/5Lrp5Z+6Dgf8YId9md9Ni5YX/OX38P+LrHtPtmmfl
         z0z+2DqSccycX6t1C+43PvHsgYD/NoTLgpBXMpkMhfIncWubnDHPqY1/ffQwhsgBdxwJ
         i+2Ium0LV6ryPsGtQzqARzpAYr3pNjcVkxTNdjScNmwgzQHxW/j8aSnsaBTdbADcb1Np
         MzwiEXBfWxjT6w2RwdFguZhkegJkJtspmOPLqhxzVdR4lyjbwiyuwm1PaX2Bjv0wLyd9
         8/FLBaBTUslHcOGfXRiRFdtRxycdUlR1h6qRWRnUw+jQ3v7vZHRF8RlRb19d5GSZmP1r
         wT8g==
X-Forwarded-Encrypted: i=1; AJvYcCX+bOTFBLvUVOvhuGxklUTWh04Mn+5dU1cEYAlGTvDBdbmv+xmcDI9K5sWo7J5y0vNj9VqAHqneHWp76g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF96qD9TwEorNiAOM4EeJ9OU9PUH23lfFLmSZEww5mIivTI2f1
	tRQzywskUlJefzRaPSclfL1zMWGU3SwLLdzeTJdaOnVJ1GENjWlxI1f+
X-Gm-Gg: ASbGncu1Cok7UgXTYYXzaMuOuWnMFdThd8cYbTg73yapb/jjmXBuLAFznGA6CkOcP+z
	R6UHL4DSGXhosgRwYuMCZx/fnqex4E/c7/JfjDeaEQCJejrUTbFGD/PGLdv9QhA8Nn5jt6frW2E
	IINlMEtRPZgU3XS1Bge64HyqbhX6xN1zHwsiKDeaSYVX95Es9q2aN+27Ay2zzxFWYhUWpgxbJej
	7oXUkHWhsJc02UjdDgUb2x7Kcvq3j9tqMgFRIJUiu/p1qMmP2UNYH8Nz8pI2E6ohiME8GqpaLWT
	rBT2xoOKKvMUQ8c54HDERFMhUfPZMrfJIo+TLl86Vhtg7D0xkR2IktETtnSgv8RV5vzV2imK0n+
	XcYJTHqbY+/pyx5o=
X-Google-Smtp-Source: AGHT+IGK48eDiJPLwUG6CwWCcjw8mwwOjz0+lrph0QUuGNIzekpn8VliJE1l3jHE+fdBUys0/PFSAA==
X-Received: by 2002:a05:6402:180d:b0:62f:9cfb:7d34 with SMTP id 4fb4d7f45d1cf-6349fa97d25mr223912a12.38.1758736726861;
        Wed, 24 Sep 2025 10:58:46 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6316acdfe14sm9080057a12.52.2025.09.24.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:58:46 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Bernie Thompson <bernie@plugable.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
Date: Wed, 24 Sep 2025 19:57:38 +0200
Message-ID: <20250924175743.6790-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The udlfb driver exposes sysfs attributes thus depends upon
CONFIG_FB_DEVICE. This patch work wraps relavent code blocks
with #ifdef CONFIG_FB_DEVICE so that the driver can still be
built even when CONFIG_FB_DEVICE is not selected.

This addresses an item in Documentation/gpu/TODO.rst.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
Note: this change has only been compile-tested.

 drivers/video/fbdev/Kconfig | 1 -
 drivers/video/fbdev/udlfb.c | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 1500dca8c416..40442b80de17 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1596,7 +1596,6 @@ config FB_SMSCUFX
 config FB_UDL
 	tristate "Displaylink USB Framebuffer support"
 	depends on FB && USB
-	depends on FB_DEVICE
 	select FB_MODE_HELPERS
 	select FB_SYSMEM_HELPERS_DEFERRED
 	help
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index ccede85df1e1..de2e310054d4 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1382,6 +1382,7 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 	return result;
 }
 
+#ifdef CONFIG_FB_DEVICE
 static ssize_t metrics_bytes_rendered_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
@@ -1413,6 +1414,7 @@ static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 	return sysfs_emit(buf, "%u\n",
 			atomic_read(&dlfb->cpu_kcycles_used));
 }
+#endif
 
 static ssize_t edid_show(
 			struct file *filp,
@@ -1486,6 +1488,7 @@ static const struct bin_attribute edid_attr = {
 	.write = edid_store
 };
 
+#ifdef CONFIG_FB_DEVICE
 static const struct device_attribute fb_device_attrs[] = {
 	__ATTR_RO(metrics_bytes_rendered),
 	__ATTR_RO(metrics_bytes_identical),
@@ -1493,6 +1496,7 @@ static const struct device_attribute fb_device_attrs[] = {
 	__ATTR_RO(metrics_cpu_kcycles_used),
 	__ATTR(metrics_reset, S_IWUSR, NULL, metrics_reset_store),
 };
+#endif
 
 /*
  * This is necessary before we can communicate with the display controller.
@@ -1702,6 +1706,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+#ifdef CONFIG_FB_DEVICE
 	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++) {
 		attr = &fb_device_attrs[i];
 		retval = device_create_file(info->dev, attr);
@@ -1710,6 +1715,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 				 "failed to create '%s' attribute: %d\n",
 				 attr->attr.name, retval);
 	}
+#endif
 
 	retval = device_create_bin_file(info->dev, &edid_attr);
 	if (retval)
@@ -1753,9 +1759,11 @@ static void dlfb_usb_disconnect(struct usb_interface *intf)
 	/* this function will wait for all in-flight urbs to complete */
 	dlfb_free_urb_list(dlfb);
 
+#ifdef CONFIG_FB_DEVICE
 	/* remove udlfb's sysfs interfaces */
 	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
 		device_remove_file(info->dev, &fb_device_attrs[i]);
+#endif
 	device_remove_bin_file(info->dev, &edid_attr);
 
 	unregister_framebuffer(info);
-- 
2.43.0

