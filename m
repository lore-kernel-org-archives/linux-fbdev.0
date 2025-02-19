Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7151C3BE9;
	Wed, 19 Feb 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954719; cv=none; b=mczqoHtobOBbV8hI4msBUwlDiYHzb5tmzcgnM/jsUO8YH4kcx/uLcq/dVM6WE0i+6K5cvgT1yEXL45HikW3VeblDi6J9kVXhvilzwF20H2lVg3HJDbY917xNmWkY4+CAZFT8YGv3xwsEy0aTz2dLfhPRggLz+pLDN2/mq//l9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954719; c=relaxed/simple;
	bh=uqDkMFscgjPk/BMHb/9eP3O3a+4r4MiJI9Q1LbjQu0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMQzIpFDT2t3WmFn2vvev9bzrdJGBqx+k4eRwECnaFUVs4SmJClkx4OzY7gYnp2DBsUrHL0JvEWRYb9WfH2kT40PRwZlMJkZxsMNapbdxtBFxPgjzRRwY2tvUftvbrWy/+QfcOhnLbWGWHMf6j7f/vcSTTRP5a233fKsUfcMkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wsn2lKd6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wsn2lKd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=guiet
	ZmiXVKbF39X5NOgGjs2hx7xw8u9MtGsuFXnqDs=; b=Wsn2lKd6seRXMMgXZfJp5
	VEn0CvfrvDhiNAIA0uN0NdHRncBhvUAOEmGqY1dc2N+Zw8qfgy58mIXPyDGGZ0Ek
	DRChE1y7wH3WLXXyCMq/qLXmRh8l4Jv+1AxkMOXlTmAGNxtL4Z7Od/JOksYsUI3+
	h5c1PC2bHgctiOIGFxyJh8=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXXdnwmbVnvOLDOQ--.51003S2;
	Wed, 19 Feb 2025 16:44:34 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev: lcdcfb: Register sysfs groups through driver core
Date: Wed, 19 Feb 2025 16:44:27 +0800
Message-Id: <20250219084427.244985-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXXdnwmbVnvOLDOQ--.51003S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyrAF1kXr1fGFW8AF1rXrb_yoW5Cr48pF
	4UAa4YgrW3ZwsxWrs8Aa17uFWru3WrtFyUZr10yw1rGasxAr1YqFyfJ397Jry3JFWkWr13
	trWDA345CF47uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXAf4D2e1kK-QWQAAsI

From: Shixiong Ou <oushixiong@kylinos.cn>

[WHY]
   1. The driver forgot to call device_remove_file()
   in sh_mobile_lcdc_overlay_fb_unregister(), and there was
   no error handling when calling device_create_file() failed.

   2. This should probably use device_add_group() instead of
   individual files to simplify both creation and removal. [Arnd]

   3. The driver core can register and cleanup sysfs groups already.
   as commit 95cdd538e0e5 ("fbdev: efifb: Register sysfs groups
   through driver core").

[HOW]
   Register sysfs groups through driver core.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 29 ++++++++++++--------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 4715dcb59811..dd950e4ab5ce 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1338,16 +1338,19 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static const struct device_attribute overlay_sysfs_attrs[] = {
-	__ATTR(ovl_alpha, S_IRUGO|S_IWUSR,
-	       overlay_alpha_show, overlay_alpha_store),
-	__ATTR(ovl_mode, S_IRUGO|S_IWUSR,
-	       overlay_mode_show, overlay_mode_store),
-	__ATTR(ovl_position, S_IRUGO|S_IWUSR,
-	       overlay_position_show, overlay_position_store),
-	__ATTR(ovl_rop3, S_IRUGO|S_IWUSR,
-	       overlay_rop3_show, overlay_rop3_store),
+static DEVICE_ATTR_RW(overlay_alpha);
+static DEVICE_ATTR_RW(overlay_mode);
+static DEVICE_ATTR_RW(overlay_position);
+static DEVICE_ATTR_RW(overlay_rop3);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&dev_attr_overlay_alpha.attr,
+	&dev_attr_overlay_mode.attr,
+	&dev_attr_overlay_position.attr,
+	&dev_attr_overlay_rop3.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(overlay_sysfs);
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
@@ -1516,7 +1519,6 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct sh_mobile_lcdc_priv *lcdc = ovl->channel->lcdc;
 	struct fb_info *info = ovl->info;
-	unsigned int i;
 	int ret;
 
 	if (info == NULL)
@@ -1530,12 +1532,6 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 		 dev_name(lcdc->dev), ovl->index, info->var.xres,
 		 info->var.yres, info->var.bits_per_pixel);
 
-	for (i = 0; i < ARRAY_SIZE(overlay_sysfs_attrs); ++i) {
-		ret = device_create_file(info->dev, &overlay_sysfs_attrs[i]);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -2641,6 +2637,7 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
+		.dev_groups	= overlay_sysfs_groups,
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,
-- 
2.25.1

