Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D491B392B;
	Sat,  8 Feb 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007008; cv=none; b=KeffPab7Nu1romUzKU2PcRRKGa1tyOdraGAaZA9iE2j8T9JPfu5G//ezqTJfVjA7wgq80BSzCktfFsdTHwDbV+QbhuWsEE0Q08vFv2+BDMwjcAAabBlwyoPWHJ57qIDrYOGEEZmkOeg6I8QNPZHuVyuhFr4Gtp6eNXN4UhSPOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007008; c=relaxed/simple;
	bh=dWo/bfeju/FyepwzWaZBtQ69y0AhMrz/V6IqsmlS4ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TO4zMI5OEcqMBJJcrKlpQFOa1zLuiSnDaSxNQ0nS6J2C6MTrF0aBwbzAz+/3Scxx5eovEZKgvMMUOf6aBxUWnS2PQb19dPb0Vmuqtj/9CDnfM/smgdL72n5/j0E4fG7vpiMPEBaXKDkZTnPoa63VmeuXNpmQcqRqY67AjNbeGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ed6A45wM; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ed6A45wM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bYMGG
	j4F/JZvudIDaRtW1ZtWpqeyPToJB8Uq/ovG1Fk=; b=ed6A45wMvBi8XX+8dtWC3
	2SbnX19nikA5ExWLPV/aZbZtwAh4o+JyW2FApF/mzmcQT4cbBLCIKJsr3NsnIuqW
	yI2V/Vd/iuTxW2chXiDyQllQM7v37+Z6WGcHY7NfboUIbGD78ERbPvrHtTBKf+LM
	Y2nie+60wy87W+pNbLOFvQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB35gTwI6dnE0MiKg--.12901S2;
	Sat, 08 Feb 2025 17:29:21 +0800 (CST)
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
Subject: [PATCH v2] fbdev: lcdcfb: add missing device_remove_file()
Date: Sat,  8 Feb 2025 17:29:18 +0800
Message-Id: <20250208092918.251733-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB35gTwI6dnE0MiKg--.12901S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8WFWDWF4Dtw1fWr13XFb_yoW8Zry5pF
	4UGas0grWrZrnrWr4fAF4UuF45u3s7tas3Zr1xJ345u3s3ArsYg343Ja93XrWfJa93GF1a
	vrWrt345uF4UuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQVy3UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwXtD2enFw6wdwAAsa

From: Shixiong Ou <oushixiong@kylinos.cn>

1. The device_remove_file() need to be called when driver is removing.
2. The device_remove_file() need to be called if the call to
   device_create_file() fails.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
	add missing 'return error'.
	call device_remove_file() in sh_mobile_lcdc_overlay_fb_unregister().

 drivers/video/fbdev/sh_mobile_lcdcfb.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 4715dcb59811..c52661d5491a 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1504,10 +1504,14 @@ static void
 sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
+	unsigned int i;
 
 	if (info == NULL || info->dev == NULL)
 		return;
 
+	for (i = 0; i < ARRAY_SIZE(overlay_sysfs_attrs); ++i)
+		device_remove_file(info->dev, &overlay_sysfs_attrs[i]);
+
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1516,7 +1520,7 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct sh_mobile_lcdc_priv *lcdc = ovl->channel->lcdc;
 	struct fb_info *info = ovl->info;
-	unsigned int i;
+	unsigned int i, error = 0;
 	int ret;
 
 	if (info == NULL)
@@ -1531,9 +1535,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
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
+		return error;
 	}
 
 	return 0;
-- 
2.17.1

