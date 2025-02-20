Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C541F1301;
	Thu, 20 Feb 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045615; cv=none; b=SImkzICS26/IWQzOUp3GaQBnrgrYTRAHOZGsmKBhJen40P3BPNNDGc6vdVQBi5HhJRkduEJWfTjda1dNk4HeOXODAdstEktoPqBW7Mivbpc+bOUa+PIkv9onuS6hctxtwWCEfMtGxzRW3TyzrJrwy3jzQ9jmq1nhLV3QibJjH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045615; c=relaxed/simple;
	bh=Jh8ska2JiUu6hoEeigD6Clig/7y9WNDWseWg53zbtMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XqgAVhH6b3bl94y5WJy0SsP8Hy0ojLX0hKqRYUNRL9K1mbFZDiyVBK4Ja1dqN21r6VdqVQwvlMz6c+GWiAZzIoI16OSQqzRu6vDXf8yg15P5g7kirVsGZ/pm6uxQmyZKKsdl4xKf+59Vb/QD3QoifBFcJA+fsye+d5+SdV30tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BV1BLeNm; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BV1BLeNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2RoNr
	SjHOSnrbQWPVmn0LiRyjXkWM0htcxpHKmfkuqc=; b=BV1BLeNmH6YzL7rRbUtjE
	R542RFTSXbvkLXpOaNF4F3seYCVa+3SjrpKeZiZYcKGpEPsqiLKakUrKeOmcaGAO
	ZBzNLLjCNuUN63pG/vPcXOs8ouwGE3ou2uy7VImVeNI39cwS4rCCdln6rMDEWCoK
	quh8NXRgJ73gCAZ5LATcw0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn77ML_bZnugebMw--.5396S2;
	Thu, 20 Feb 2025 17:59:40 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	oushixiong <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev: Register sysfs groups through device_add_group
Date: Thu, 20 Feb 2025 17:59:35 +0800
Message-Id: <20250220095935.270797-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn77ML_bZnugebMw--.5396S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF43urWUKryfJF15Jw47Jwb_yoWrWw43pr
	n3JFyFgry5WF1UGFs3uwsrX39xWw4rury5Jr9xt3yxGF43GFZrW34xAFy5A3yrGr97Jr1S
	qFsrXw18JFZF9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOZ2-UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRb5D2e28fjYegAAsH

From: oushixiong <oushixiong@kylinos.cn>

Use device_add_group() to simplify creation.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbsysfs.c | 69 +++++++++++++++++-------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 1b3c9958ef5c..06d75c767579 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -416,55 +416,64 @@ static ssize_t show_bl_curve(struct device *device,
 /* When cmap is added back in it should be a binary attribute
  * not a text one. Consideration should also be given to converting
  * fbdev to use configfs instead of sysfs */
-static struct device_attribute device_attrs[] = {
-	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
-	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
-	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
-	__ATTR(cursor, S_IRUGO|S_IWUSR, show_cursor, store_cursor),
-	__ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode),
-	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
-	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
-	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
-	__ATTR(name, S_IRUGO, show_name, NULL),
-	__ATTR(stride, S_IRUGO, show_stride, NULL),
-	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
-	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
+static DEVICE_ATTR(bits_per_pixel, 0644, show_bpp, store_bpp);
+static DEVICE_ATTR(blank, 0644, show_blank, store_blank);
+static DEVICE_ATTR(console, 0644, show_console, store_console);
+static DEVICE_ATTR(cursor, 0644, show_cursor, store_cursor);
+static DEVICE_ATTR(mode, 0644, show_mode, store_mode);
+static DEVICE_ATTR(modes, 0644, show_modes, store_modes);
+static DEVICE_ATTR(pan, 0644, show_pan, store_pan);
+static DEVICE_ATTR(virtual_size, 0644, show_virtual, store_virtual);
+static DEVICE_ATTR(name, 0444, show_name, NULL);
+static DEVICE_ATTR(stride, 0444, show_stride, NULL);
+static DEVICE_ATTR(rotate, 0644, show_rotate, store_rotate);
+static DEVICE_ATTR(state, 0644, show_fbstate, store_fbstate);
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
-	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
+static DEVICE_ATTR(bl_curve, 0644, show_bl_curve, store_bl_curve);
 #endif
+
+static struct attribute *fb_device_attrs[] = {
+	&dev_attr_bits_per_pixel.attr,
+	&dev_attr_blank.attr,
+	&dev_attr_console.attr,
+	&dev_attr_cursor.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_modes.attr,
+	&dev_attr_pan.attr,
+	&dev_attr_virtual_size.attr,
+	&dev_attr_name.attr,
+	&dev_attr_stride.attr,
+	&dev_attr_rotate.attr,
+	&dev_attr_state.attr,
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	&dev_attr_bl_curve.attr,
+#endif
+	NULL,
+};
+
+static const struct attribute_group fb_device_attr_group = {
+	.attrs          = fb_device_attrs,
 };
 
 static int fb_init_device(struct fb_info *fb_info)
 {
-	int i, error = 0;
+	int ret;
 
 	dev_set_drvdata(fb_info->dev, fb_info);
 
 	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
-		error = device_create_file(fb_info->dev, &device_attrs[i]);
-
-		if (error)
-			break;
-	}
-
-	if (error) {
-		while (--i >= 0)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
+	ret = device_add_group(fb_info->dev, &fb_device_attr_group);
+	if (ret)
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-	}
 
 	return 0;
 }
 
 static void fb_cleanup_device(struct fb_info *fb_info)
 {
-	unsigned int i;
-
 	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
+		device_remove_group(fb_info->dev, &fb_device_attr_group);
 
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
 	}
-- 
2.17.1

