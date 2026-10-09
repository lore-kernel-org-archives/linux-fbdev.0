Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7784E9C37;
	Fri,  9 Oct 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562700; cv=none; b=ZZFR+UOzaq98VmsZXpqM93w8lcF0ipH99tMq3neCEvoX3Y1kG8ulylJXJPrbJksAgr+OMBPyOJHT5Sw88VLU//3P9HxHzy3fnJPBj9yxAEMDjDMp5KF8D/B6kgEVBmEPP1bAKCsKPVbIRlur2bYwBsycu3MJOa+hh8Cj/kszdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562700; c=relaxed/simple;
	bh=QhVlo142lWPYxGT/gd3uHS4q6OJSgKS1aBkeTs25sIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed6dAuhVymu9g7WDYMtF8qkORgwPLWKJmHoxOTn5rUR3hxehmz0Lxej5BiNbhdNPJFLQDsM99tmekKvYNkXQtVbmOeljV0aP4CqF/yBHA1sClG+hMlJ8p49VsC4ouktvbIVKk9v6m19K22Wm3pDeZ1+KcMJoZj0LkO5tHnidBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAFD91F7E3;
	Fri,  9 Oct 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 639B313978;
	Fri,  9 Oct 2026 16:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fTjLccTyWrkFwAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Oct 2026 16:18:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	adaplas@gmail.com,
	michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/5] fbdev/au1100fb: Use FB blanking constants
Date: Fri,  9 Oct 2026 18:05:35 +0200
Message-ID: <20261009161814.120480-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161814.120480-1-tzimmermann@suse.de>
References: <20261009161814.120480-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Bar: /
X-Rspamd-Queue-Id: BAFD91F7E3
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00]

Fbdev and its drivers use FB_BLANK constants for controlling the
display's blanking state. Semantics differ to similar VESA blanking
constants.

Replace the VESA constants in au1100fb with FB_BLANK.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/au1100fb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 39f86ffb1ae3..6c375f389fbd 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -424,15 +424,15 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 
 	switch (blank_mode) {
 
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		/* Turn on panel */
 		fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 		wmb(); /* drain writebuffer */
 		break;
-
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	case VESA_POWERDOWN:
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
 		/* Turn off panel */
 		fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 		wmb(); /* drain writebuffer */
@@ -539,7 +539,7 @@ static int au1100fb_setmode(struct au1100fb_device *fbdev)
 	/* Resume controller */
 	fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 	mdelay(10);
-	au1100fb_fb_blank(VESA_NO_BLANKING, info);
+	au1100fb_fb_blank(FB_BLANK_UNBLANK, info);
 
 	return 0;
 }
@@ -856,7 +856,7 @@ static void au1100fb_drv_remove(struct platform_device *dev)
 	fbdev = platform_get_drvdata(dev);
 
 #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
-	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+	au1100fb_fb_blank(FB_BLANK_POWERDOWN, &fbdev->info);
 #endif
 	fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 
@@ -880,7 +880,7 @@ static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 		return 0;
 
 	/* Blank the LCD */
-	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+	au1100fb_fb_blank(FB_BLANK_POWERDOWN, &fbdev->info);
 
 	clk_disable(fbdev->lcdclk);
 
@@ -904,7 +904,7 @@ static int au1100fb_drv_resume(struct platform_device *dev)
 		return ret;
 
 	/* Unblank the LCD */
-	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+	au1100fb_fb_blank(FB_BLANK_UNBLANK, &fbdev->info);
 
 	return 0;
 }
-- 
2.55.0

