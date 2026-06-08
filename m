Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139671A6838;
	Mon,  8 Jun 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922608; cv=none; b=CyYtEJDYegwGhPlFx+nPDd2drQswyNwrmCdKQCigKs0uI2fjndy3VSiLtKkBLXtD/jpJ4YwRu4MpW30gvhjwIJSmGzMthEwQWbPDYrfPVqF5UHk6sBftRFkzVZzWfA4cMnF41GCEDHNSM9V/md7dAqqlg09hAqDY/TQzHKN3i90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922608; c=relaxed/simple;
	bh=db3cHg2z1TdZfuPA114ggytQeKrKK5RQE/IYT/sJ6A0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cov/uHDN3tDBR5DkJOmRkZCpZHVL/VvpJXRVE6XJGRdYGPM2RvEJetkpP7733lFw1JXHJigZQ9opVPqiHEILT0gQpBhShN48OCt4bramX9d7447FXY1gB4HLbBUQWpgJzd5v8WyfIfuEzUueFsuaV5bjqNrgyCUwjduZDmWDylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tx61RswJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tx61RswJ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWZJi-00CD0A-DO; Mon, 08 Jun 2026 14:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=i21DvDjBZEXRc7cUjpPiYapFIdF7uLqvyUopKC2I8J8=; b=tx61Rs
	wJa5u9sjJpgBK2NtYWXkY1aSJUIRK5BgeDUZH8wPlTrX5UCLRStW7eDjsb17dH3pOzoijqOpRqMe2
	YOhGUIgbfaMxrwWErkBr8BIafxfYW12eRGeILwurekspRHK02YrK5SH9Wbx+yYIkuFXu9eW4iFo28
	eSg5Bd8sLBsGZNNqp2pXXqqFiJfZK6ahTTqEvUViZglRuiXyJinECX94LEDjE6VP6YlbqOS/FPMRs
	do65i5DrXslKGLPuLEimpQu0Hj7QOZG8E5HXdDBdDOc9Aaui/hqyBo0aBc91lCVMPVRPvLgxpCjJU
	n8YtIXQEl9PXHvf1VpnheK0bF6Zg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWZJh-0004KU-FK; Mon, 08 Jun 2026 14:42:57 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWZJV-00Ayo3-20;
	Mon, 08 Jun 2026 14:42:45 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	linux-fbdev@vger.kernel.org,
	devicetree-discuss@ozlabs.org,
	Ben Dooks <ben@simtec.co.uk>,
	Vincent Sanders <vince@simtec.co.uk>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>,
	Helge Deller <deller@gmx.de>,
	Danila Chernetsov <listdansp@mail.ru>,
	Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 1/1] video, sm501: Fix buffer errors in OF binding code
Date: Mon,  8 Jun 2026 13:42:42 +0100
Message-Id: <20260608124242.13164-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code that gets the frame buffer mode from OF has 'use after free',
'buffer overrun' and memory leaks.

info->edid_data isn't free if the probe functions fail or if
pd->def_mode is set.

If both the CRT and PANEL are enabled info->edid_data is used after
being freed and is freed twice.

The string returned by of_get_property(np, "mode", &len) is just
written over either the static "640x480-16@60" or the module parameter
string without any regard for the length (which is most likely longer).

Use kstrump() for the OF mode and free everything before freeing 'info.

Fixes: 4295f9bf74a88 ("video, sm501: add OF binding to support SM501")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/video/fbdev/sm501fb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index fee4b9f84592..ea5375ed4ea6 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -96,6 +96,7 @@ struct sm501fb_info {
 	void __iomem		*fbmem;		/* remapped framebuffer */
 	size_t			 fbmem_len;	/* length of remapped region */
 	u8 *edid_data;
+	char *fb_mode;
 };
 
 /* per-framebuffer private data */
@@ -1793,12 +1794,11 @@ static int sm501fb_init_fb(struct fb_info *fb, enum sm501_controller head,
 			fb->var.yres_virtual = fb->var.yres;
 		} else {
 			if (info->edid_data) {
-				ret = fb_find_mode(&fb->var, fb, fb_mode,
+				ret = fb_find_mode(&fb->var, fb,
+					info->fb_mode ?: fb_mode,
 					fb->monspecs.modedb,
 					fb->monspecs.modedb_len,
 					&sm501_default_mode, default_bpp);
-				/* edid_data is no longer needed, free it */
-				kfree(info->edid_data);
 			} else {
 				ret = fb_find_mode(&fb->var, fb,
 					   NULL, NULL, 0, NULL, 8);
@@ -1974,7 +1974,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 			/* Get EDID */
 			cp = of_get_property(np, "mode", &len);
 			if (cp)
-				strcpy(fb_mode, cp);
+				info->fb_mode = kstrdup(cp, GFP_KERNEL);
 			prop = of_get_property(np, "edid", &len);
 			if (prop && len == EDID_LENGTH) {
 				info->edid_data = kmemdup(prop, EDID_LENGTH,
@@ -2031,6 +2031,12 @@ static int sm501fb_probe(struct platform_device *pdev)
 		goto err_started_crt;
 	}
 
+	/* These aren't needed any more */
+	kfree(info->edid_data);
+	kfree(info->fb_mode);
+	info->edid_data = NULL;
+	info->fb_mode = NULL;
+
 	/* we registered, return ok */
 	return 0;
 
@@ -2048,6 +2054,8 @@ static int sm501fb_probe(struct platform_device *pdev)
 	framebuffer_release(info->fb[HEAD_CRT]);
 
 err_alloc:
+	kfree(info->edid_data);
+	kfree(info->fb_mode);
 	kfree(info);
 
 	return ret;
-- 
2.39.5

