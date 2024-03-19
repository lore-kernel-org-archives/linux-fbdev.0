Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB977D075
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841162; cv=none; b=TpUZiwBLGOd7FgJdpAFZXpmD6xiGYaZArAOslCOOfKmGadMUY8wWo+4qnpJ9c0Aiyr2A6q/+byUshLOnQ6NcAT5O81vxCiljh1EeLu7cdcdIq3A+ZzqQI9GcHnpJ0chEIR3uhNpX/yaw9O2qj9oOLzQRUPzrHc9scvcsIbYJRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841162; c=relaxed/simple;
	bh=s2rcjk2xWxLikKnKuD3iwroCkSUh5zUCDjiArzuRmyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Df/pvtd11kOe5FCSKUYKtocykTgcyBO7KmyW5zwqud2+MoPXJ/DQHgWaecdK9AXA/U3ngXHXry9UT/PHzFdGcx1m9+eOdnADxYKrnB6D4cEiN+/1JbLWFsW6bMsJTJ6D8xFxPmS/h8VDUfaI7jxtry3YH+AQKBTJO0MtG4zYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D952E37616;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FED113700;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gAX5IUZd+WU6GAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 19 Mar 2024 09:39:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	geert@linux-m68k.org,
	dan.carpenter@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/6] backlight: omap1: Replace FB_BLANK_ states with simple on/off
Date: Tue, 19 Mar 2024 10:37:22 +0100
Message-ID: <20240319093915.31778-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319093915.31778-1-tzimmermann@suse.de>
References: <20240319093915.31778-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D952E37616
X-Spam-Flag: NO

The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
any other value in fb_blank. But the field fb_blank in struct
backlight_properties is deprecated and should not be used any
longer.

Replace the test for fb_blank in omap's backlight code with a
simple boolean parameter and push the test into the update_status
helper. Instead of reading fb_blank directly, decode the backlight
device's status with backlight_is_blank().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

---

v2:
- update commit-message style according to subsystem (Lee)
- rename 'power/on' to 'enable/enabled' (Daniel)
---
 drivers/video/backlight/omap1_bl.c | 43 +++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 84d148f385951..636b390f78f04 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
 #include <linux/platform_data/omap1_bl.h>
@@ -20,7 +19,7 @@
 #define OMAPBL_MAX_INTENSITY		0xff
 
 struct omap_backlight {
-	int powermode;
+	bool enabled;
 	int current_intensity;
 
 	struct device *dev;
@@ -37,21 +36,14 @@ static inline void omapbl_send_enable(int enable)
 	omap_writeb(enable, OMAP_PWL_CLK_ENABLE);
 }
 
-static void omapbl_blank(struct omap_backlight *bl, int mode)
+static void omapbl_enable(struct omap_backlight *bl, bool enable)
 {
-	switch (mode) {
-	case FB_BLANK_NORMAL:
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	case FB_BLANK_POWERDOWN:
-		omapbl_send_intensity(0);
-		omapbl_send_enable(0);
-		break;
-
-	case FB_BLANK_UNBLANK:
+	if (enable) {
 		omapbl_send_intensity(bl->current_intensity);
 		omapbl_send_enable(1);
-		break;
+	} else {
+		omapbl_send_intensity(0);
+		omapbl_send_enable(0);
 	}
 }
 
@@ -61,7 +53,7 @@ static int omapbl_suspend(struct device *dev)
 	struct backlight_device *bl_dev = dev_get_drvdata(dev);
 	struct omap_backlight *bl = bl_get_data(bl_dev);
 
-	omapbl_blank(bl, FB_BLANK_POWERDOWN);
+	omapbl_enable(bl, false);
 	return 0;
 }
 
@@ -70,33 +62,34 @@ static int omapbl_resume(struct device *dev)
 	struct backlight_device *bl_dev = dev_get_drvdata(dev);
 	struct omap_backlight *bl = bl_get_data(bl_dev);
 
-	omapbl_blank(bl, bl->powermode);
+	omapbl_enable(bl, bl->enabled);
 	return 0;
 }
 #endif
 
-static int omapbl_set_power(struct backlight_device *dev, int state)
+static void omapbl_set_enabled(struct backlight_device *dev, bool enable)
 {
 	struct omap_backlight *bl = bl_get_data(dev);
 
-	omapbl_blank(bl, state);
-	bl->powermode = state;
-
-	return 0;
+	omapbl_enable(bl, enable);
+	bl->enabled = enable;
 }
 
 static int omapbl_update_status(struct backlight_device *dev)
 {
 	struct omap_backlight *bl = bl_get_data(dev);
+	bool enable;
 
 	if (bl->current_intensity != dev->props.brightness) {
-		if (bl->powermode == FB_BLANK_UNBLANK)
+		if (bl->enabled)
 			omapbl_send_intensity(dev->props.brightness);
 		bl->current_intensity = dev->props.brightness;
 	}
 
-	if (dev->props.fb_blank != bl->powermode)
-		omapbl_set_power(dev, dev->props.fb_blank);
+	enable = !backlight_is_blank(dev);
+
+	if (enable != bl->enabled)
+		omapbl_set_enabled(dev, enable);
 
 	return 0;
 }
@@ -136,7 +129,7 @@ static int omapbl_probe(struct platform_device *pdev)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	bl->powermode = FB_BLANK_POWERDOWN;
+	bl->enabled = false;
 	bl->current_intensity = 0;
 
 	bl->pdata = pdata;
-- 
2.44.0

