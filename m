Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1D311597
	for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789208531; cv=none; b=hCS39HOLeM5HfDHqfNud8fH3GDKCfGJDgf1EJLpJb9oVfj9SUajEjU9V56jbeTZRQ87wiNM1don4SN+eoqsMil7/J9XHtnY/rdGoGbSwQur38xly/sAUAEu5JyquK4FFI6DY511SEcTRBm+cQsPyL5oQelbszcOLVGe61AwzTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789208531; c=relaxed/simple;
	bh=ClEMQIr0Ji7CgfidML8AvsymaEBCbYsibVVf67Z5sSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrqBdvA0K08bsJJlS+/GKREjN9wsiMI+fmCd1WnIAZrFqqYHL7mwnrcioljSbrCxfgjQ8uOf4f7hl+cUMrklfMOXMPNgPwPSJCKzoLbKFu4TgHD3HmW/grPyPKUy1vR+zzrYcvT/M1yC7WRFMcr7tuT5lEAuB/5WrycRWuDytU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPS1Bv6g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPS1Bv6g"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso12994765e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789208518; x=1789813318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VW8CDL+OlGvA4xfcKvR9tcTjyC7BYLpejsNtiZcjZVQ=;
        b=KPS1Bv6gReuF1Ti8Xqx5MNqeeZLKX43sA4079pGmF8rA5xAB0lD6gNj2mgk6VAktxn
         9LNeM441Jk3hGLAykAbXQjzozd5qwVEOEv9FOUdv/sw9Sn4Swe7sjucSAWB0bMFhP6kc
         bxcoCVBkLWOQhKkHDMB9H6TQy2Ztw4a6cTrwnmbrsc1JI6n16bHhk68zRWpboV8L1WAP
         oZ5AF+XdLwNQ4TGynX2QyRXCD0XqEOIopHAZsogBbCbLciGLQU7z0ImUqcKAKQJcvIWv
         7Z4I23YlQeL1mXT5aneMDbTB9P9DKbcebJMxDMfXWmEkrpeF9FKYwNHZHjEItcbdPos1
         ZxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789208518; x=1789813318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW8CDL+OlGvA4xfcKvR9tcTjyC7BYLpejsNtiZcjZVQ=;
        b=IsTFmp8dg7EmGn1wGbYqxAQFqc1LfQRalnU4ZdDXgbgHLbpeZl0+eiibrjBK0q0q5J
         oLxzZ4PsLcb/TWrNxi7xj42pDmgCH/KactskMrmSYZFUZN5O6YBdANVnHujf/KB6IY/p
         3NM9tupEXpQqfSjXN6rOpgKbXWDi/LzWQyDa/x0XMomvssYx7uMmKk7YKuzJkVvSoWP4
         FtoCD6bixNAAgD4i3B9axt6EXZuCiIRsijypx8H7G1TVBpFHgV8WH+K69bg3GIK8ZDjn
         oTFPdjVd8ZoPz+ITXk2etPvyNyxyNFLGHXxbcdUhb7dSqAcMzXiGC3V8aijekmmdc5wM
         lIIA==
X-Forwarded-Encrypted: i=1; AKwUvByQxxicLi2IKbGYbqCDocza0sRE8LObJgFarwHuzQItjoa7DqT75O7bHYSbH0M+xJKSN8aTcTaQH5mElg==@vger.kernel.org
X-Gm-Message-State: AFuF++khVQt9ENFTK3psOEtKTJGVKAcu5xq1aFqNeHiMoUnXmZynwzOs
	O9xbYWPHsZRJgeL5soOfWEdU2AMkPtnkxPdrmDWZXzb+XXiulDdsOZTa
X-Gm-Gg: AYBFou1ZYa8o1s95cVZ4FNhOcOVRtdGFmGVCQkpwjmYZSPIDMuIbpV4QwdUcG+Nmaf8
	ERVPEuMso7IbtCEzBrKNPxqkctn3vSsk9+e1YnwHc/GWWxEcLzdnjL2O0k+A88DYURyMZy9ZmCQ
	FI4cA47OFci5I1vKEloN/R4qq+ek+QUvzmecvfjDdBF9wTh3onPvR89B6Ho0aIueY6HjTurVzRP
	xPmGGoiMz9JnFiB9uImi4s68JPW2h1cxI9jaedHW0iSskYilMAUucpsifXIq7eRze4wWDjcy/+T
	8E9rLPylBkEHfYUu+/mD1vw9oolornON15z/FD5O9PSajFYc8dRiHYvDgcO7zVd9l9lHlhOkRhN
	vl9ZBHigtYcxbuurR2MNDKhI/ljR92Qto3VabuRmGFqAWIu12bjqPd2WbVR/08FUYEEDGoKdDQK
	uGE+J7xSvtX33YF6R9gg08j+c26EyrPFPYp5YtOSGBx2odsj+fKl7KC5BKX47/NEBUhdGUxamL9
	UY0GRIjZQROUUlZxSKpgUo7SpRWPcWUN2ZlhTrr0/nmQIcEprU3b0uZoWoJhFHRxeiDf8fECywV
	tHMm4EGHcPNc+kMeh1VXCleXrhxdYh/w8uRC/EDvZv7CY5Ynl77/2qKg74n1Gfxl6aMyaHpBKpq
	blg==
X-Received: by 2002:a05:600c:4e88:b0:49e:6a2e:d2c5 with SMTP id 5b1f17b1804b1-49e6a2ed2ffmr41782035e9.18.1789208517912;
        Sat, 12 Sep 2026 03:21:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49db038401fsm239346045e9.13.2026.09.12.03.21.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 03:21:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Chintan Patel <chintanlike@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes
Date: Sat, 12 Sep 2026 12:21:52 +0200
Message-Id: <20260912102152.86744-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovl_* files documented in
Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
longer exist.

Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver
core") moved the attributes from each overlay's framebuffer device to
the platform driver's dev_groups and renamed them overlay_*. There is
now only one set of attributes for the whole LCDC. The callbacks still
expect dev_get_drvdata() to return a struct fb_info, but the platform
device holds struct sh_mobile_lcdc_priv, so they access the wrong
structure.

Restore the documented names and register the group on each overlay's
framebuffer device with device_add_groups(). Remove it with
device_remove_groups() before unregistering the framebuffer. Skip
creation when dev_of_fbinfo(info) is NULL, as the old device_create_file()
calls did.

Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.

Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver core")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Use dev_of_fbinfo() for overlay sysfs registration and removal (Helge).

v1: https://lore.kernel.org/r/20260907021844.25497-1-kmehltretter@gmail.com/

Found while reviewing the sysfs ABI documentation. Shixiong confirmed
that using the platform driver's dev_groups is wrong here.

Compile-tested with Clang 22.1.8, ARCH=arm and W=1, using multi_v7_defconfig
with COMPILE_TEST=y, FB_DEVICE=y and FB_SH_MOBILE_LCDC=m.

Also checked FB_DEVICE=n: olddefconfig disables FB_SH_MOBILE_LCDC because
of its existing Kconfig dependency, and the framebuffer core compiles.
This does not test the driver with FB_DEVICE=n; removing that dependency
requires additional changes outside the overlay sysfs paths.

No runtime test; I have no SH-Mobile hardware.

 drivers/video/fbdev/sh_mobile_lcdcfb.c | 39 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f..5743c96d5481 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR_RW(overlay_alpha);
-static DEVICE_ATTR_RW(overlay_mode);
-static DEVICE_ATTR_RW(overlay_position);
-static DEVICE_ATTR_RW(overlay_rop3);
-
-static struct attribute *overlay_sysfs_attrs[] __maybe_unused = {
-	&dev_attr_overlay_alpha.attr,
-	&dev_attr_overlay_mode.attr,
-	&dev_attr_overlay_position.attr,
-	&dev_attr_overlay_rop3.attr,
+static struct device_attribute dev_attr_ovl_alpha =
+	__ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);
+static struct device_attribute dev_attr_ovl_mode =
+	__ATTR(ovl_mode, 0644, overlay_mode_show, overlay_mode_store);
+static struct device_attribute dev_attr_ovl_position =
+	__ATTR(ovl_position, 0644, overlay_position_show, overlay_position_store);
+static struct device_attribute dev_attr_ovl_rop3 =
+	__ATTR(ovl_rop3, 0644, overlay_rop3_show, overlay_rop3_store);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&dev_attr_ovl_alpha.attr,
+	&dev_attr_ovl_mode.attr,
+	&dev_attr_ovl_position.attr,
+	&dev_attr_ovl_rop3.attr,
 	NULL,
 };
 
-#ifdef CONFIG_FB_DEVICE
 ATTRIBUTE_GROUPS(overlay_sysfs);
-#endif
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
@@ -1510,9 +1512,10 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
 
-	if (info == NULL || info->dev == NULL)
+	if (!info || !dev_of_fbinfo(info))
 		return;
 
+	device_remove_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 	if (ret < 0)
 		return ret;
 
+	/* The framebuffer device is optional, see fb_device_create(). */
+	if (dev_of_fbinfo(info)) {
+		ret = device_add_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
+		if (ret < 0) {
+			unregister_framebuffer(info);
+			return ret;
+		}
+	}
+
 	dev_info(lcdc->dev, "registered %s/overlay %u as %dx%d %dbpp.\n",
 		 dev_name(lcdc->dev), ovl->index, info->var.xres,
 		 info->var.yres, info->var.bits_per_pixel);
@@ -2637,7 +2649,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
-		.dev_groups	= overlay_sysfs_groups,
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.39.5 (Apple Git-154)

