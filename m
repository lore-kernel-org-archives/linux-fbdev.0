Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AE3F23D1
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949382; cv=none; b=m4FNaChyrVnMFuj3NpfCU932juZa7mPtAqnM3R/TMupjlmmeIZtIr1Pq+jhnpZH9P0fAtz02TlHzlJ5uPwQbyXJCo01lpMlI2fLGsdQehm3Rimoj+Sn9UWpTt2vVMlphczzS/Z11I4SjCbh6o91EwldpadPhh5t3LHBOWVAhcg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949382; c=relaxed/simple;
	bh=NwvngB55nrQuY2zsw+u/UlQ+ziOq9i4AgvNGIC5B8qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrFRpu2Vdq2/y0Z7c4lu94Xqnrw/oOJ4sMe34/u77s+byHFH/6MDPEMOMnEWuXz0s7s1hXkJ76C4ZhBGyJ7XrxhKrdvJJ36ngE0qVRwGajB1Xa6h2/TXHV/HVugRi6SqT9TEMGuCcNf7cBAiAke0WYwmTyvyzNqdsSRpdy0MlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T68td7Dc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T68td7Dc"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so953298e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782949375; x=1783554175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=T68td7DcIeSQXbb7LNevtAYMB3InXe2EW5aCNI5m/JIAaf+B1nAdfL/rnNERZrIvXB
         aIkQoS09lnSuCUOQB2U0Tv6vb3lOG1U+h7HhKLgZTidsXh38B+RmG7JXd+xxQMh5Qoaj
         fOo69VyGYfm+VYi22t2tX/zg2ml/s3tGqq+TfKIOpq6GAXhyOkzufC6n9mKdZmT5Vowg
         dJyvSPj6nLe70KZMtK4E6qBTzCH20KfupjDYYABe6eYnLdKNQTM7Ua8aGI7iYYs+5df/
         Hys0oSTaVqZU6qs5ln+h9NLb4ANzmBa68vHA2yW5w5t1oAimTFHMK8KQzO9QzCYx4R9o
         pxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949375; x=1783554175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=Rrt1K5gfpgnmK71OfLVH20mldkJmohVp8WSCd49ceg+hfrmQhfF9jzBfB3Z9DtyTXB
         KW1L+0rx51fDD2CyqhlXOGBiiklFhARnmPKM98i4ROao5X1cqRGinQEZEsrxGl45Vp8W
         RaQs2eVE99y1fL4MQc1a08fVsYoDo/YUvGOHdrJBgW8rGDNUs1L0fpTqhS2bVuuhkRjh
         YPzMNiTVDE8NV1kT2jBy5yNUpHyHo/mSr5Uiw8TNx87aW5x5LhCitrUCBx+z+FKSd6/G
         vLCFNGNuTTeVHd2pXB9qL2SucRtEBATdHHXb3k55wZw5wEX/pD6wusTNyAKjwOREd9fg
         sLNA==
X-Gm-Message-State: AOJu0YwZwtZSC/XWGwHHU4IzVEnpCwYO95wC5iXv0BdjkUMQJqwZXZ2C
	dvRhmq9MCWwxu/jOtdpCGU86OBGlRHKiFtv1AKPU2suyh/DdTye03JAR
X-Gm-Gg: AfdE7clMxUJ1x6X3x2SArjw8NIVDRWKKU96n0/fEZoFZYSOkQLaBvMgIgBNl9Asq2q8
	nSUdBypoNL8wovl3mog+05S0XyEnT4U6aTDLOEw5qC2tiSoR7D5WcF2K7p6tfO+YeC2Mdlv6E5E
	ZIHXmYkcO6L2xnpLJ+GGXE7NBnfXsSMmvoMoRQi8qEQC03Tomdzj3W6pavLaTzVFaZBOpSIdOeA
	Woy9F770erD+csGSW5C76n/ft4p4E/lkIXMuRWfxmRHb2LWfqFOIIn0sp8QTuvv+jpB62PSbKWr
	79bYRsZb3KKK89jkmuRRCR+UrBMCWX5+Izra0D6Dhwb+C6LDFOvzox6RteN2Nsx7+xltGoPHhLl
	logP5rHPWAdXmemoSqGcmvOxqQb4339CgF/4TgJMrh3Qs9DmHl6it5P/dOVbzznUp3ZN29jbka3
	vkXUHZGtEGq6kcJe993dhSwpONuUub6yaj/QTVQ/iLJg==
X-Received: by 2002:a05:6512:4481:b0:5ae:c201:c3d7 with SMTP id 2adb3069b0e04-5aec801063cmr603820e87.8.1782949374962;
        Wed, 01 Jul 2026 16:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:42:53 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] fbdev: bound mode sysfs output to the sysfs buffer
Date: Thu,  2 Jul 2026 01:42:46 +0200
Message-Id: <20260701234248.236023-2-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mode_string() uses snprintf() which can return a value larger than the
remaining buffer space. show_modes() accumulates the return value into i
without checking whether i has reached PAGE_SIZE, causing the offset to
advance past the sysfs buffer if the modelist is long enough.

Add a size parameter to mode_string() and use scnprintf() to return
only the bytes actually written. Add an early return when offset
already exceeds the buffer. In show_modes(), stop accumulating once
the buffer is full.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..af21dc5052 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -27,12 +27,15 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	return 0;
 }
 
-static int mode_string(char *buf, unsigned int offset,
+static int mode_string(char *buf, size_t size, unsigned int offset,
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
 	char v = 'p';
 
+	if (offset >= size)
+		return 0;
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
@@ -45,7 +48,7 @@ static int mode_string(char *buf, unsigned int offset,
 	if (mode->vmode & FB_VMODE_DOUBLE)
 		v = 'd';
 
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	return scnprintf(&buf[offset], size - offset, "%c:%dx%d%c-%d\n",
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
@@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i = mode_string(mstr, 0, mode);
+		i = mode_string(mstr, sizeof(mstr), 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
 
 			var = fb_info->var;
@@ -86,7 +89,7 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 	if (!fb_info->mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -136,7 +139,9 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	i = 0;
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i += mode_string(buf, i, mode);
+		i += mode_string(buf, PAGE_SIZE, i, mode);
+		if (i >= PAGE_SIZE - 1)
+			break;
 	}
 	return i;
 }
-- 
2.39.5

