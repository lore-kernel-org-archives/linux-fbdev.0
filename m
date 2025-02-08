Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A01A9B52;
	Sat,  8 Feb 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005594; cv=none; b=UBaRJmK0YEZ7aWosZcIRHh24q27qPXVhB+oYOw8mW2Hbj3lpqUspnG0dDsNHpJFX87Z3KnZPufv7XTLI/cF8UMjbp3XqQ/oKr7/BDmW2nobL+x4FFeqe2WXBLBJUbxXwZTWtReusFEcsKAiZsusyOQcWz9lI5zt3OM06GL1VPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005594; c=relaxed/simple;
	bh=vmC1up6C5LBprRwt2/fRt1z4BJSE4GhLNdei7aTu3xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ToSbPBSQm8IsVfBTLXUK+bjuQZot/d87mBXULySHeBoNo693tbud2Uhjjw4SRJY+aVpnwWMlwRmqO1RCqINGMdYOrEO5/YHVyrg2T4/f6E3owAjY6W5BY5WB3sKQZ8s+xo2Q40/4h41F1NSJuBs/UXpYKiQ2lW/UTO01oEh+SiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VZ2u7bTO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VZ2u7bTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Yr/Kz
	e1arVLKPu4HbhTCdQQlaXiSMZKNM8RjZqVS5is=; b=VZ2u7bTO/IcFA2C+g3bm0
	tnf/GLAwRJLQhnvvjV1j+6c6RzLZVDYF0xIREPAOBLivAQKdkUaFmVhWs+fauf+m
	tXuKTv//KGpTKJUVUWQjNatrSKFhby/UhEGhu+acmP5BaFmWl+OOL5b9f7ypXJwN
	898ZCZN5B/8YGfbKwZKxjY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHRQA2HqdnvFYeKg--.11819S2;
	Sat, 08 Feb 2025 17:04:55 +0800 (CST)
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
Subject: [PATCH] fbdev: lcdcfb: add missing device_remove_file()
Date: Sat,  8 Feb 2025 17:04:51 +0800
Message-Id: <20250208090451.240292-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHRQA2HqdnvFYeKg--.11819S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8WFWDWFy3XFykXw18Xwb_yoW8Cr17pF
	4UGas0grWrZrnrGr4fAF4UuF45u348tas3Zr1xt345u3s3ArsYg345Ga93Z3yxJa93GF1a
	vrW0y345GF1UWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP3kNUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXR3sD2elkFTX4gABsR

From: Shixiong Ou <oushixiong@kylinos.cn>

1. The device_remove_file() need to be called when driver is removing.
2. The device_remove_file() need to be called if the call to
   device_create_file() fails.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 4715dcb59811..b56ab1df7369 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1516,7 +1516,7 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct sh_mobile_lcdc_priv *lcdc = ovl->channel->lcdc;
 	struct fb_info *info = ovl->info;
-	unsigned int i;
+	unsigned int i, error = 0;
 	int ret;
 
 	if (info == NULL)
@@ -1531,9 +1531,14 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 		 info->var.yres, info->var.bits_per_pixel);
 
 	for (i = 0; i < ARRAY_SIZE(overlay_sysfs_attrs); ++i) {
-		ret = device_create_file(info->dev, &overlay_sysfs_attrs[i]);
-		if (ret < 0)
-			return ret;
+		error = device_create_file(info->dev, &overlay_sysfs_attrs[i]);
+		if (error)
+			break;
+	}
+
+	if (error) {
+		while (--i >= 0)
+			device_remove_file(info->dev, &overlay_sysfs_attrs[i]);
 	}
 
 	return 0;
@@ -1543,10 +1548,14 @@ static void
 sh_mobile_lcdc_overlay_fb_cleanup(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
+	unsigned int i;
 
 	if (info == NULL || info->device == NULL)
 		return;
 
+	for (i = 0; i < ARRAY_SIZE(overlay_sysfs_attrs); ++i)
+		device_remove_file(info->dev, &overlay_sysfs_attrs[i]);
+
 	framebuffer_release(info);
 }
 
-- 
2.25.1

