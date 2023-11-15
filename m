Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBBFC03
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tQeQufU8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AjIo6vjK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3413D
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 02:30:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5EC920502;
	Wed, 15 Nov 2023 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700044198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUy5lhblC+Myvg0CjSgw5eSZfGcVwPzCzryM+8UbVoo=;
	b=tQeQufU8nyjgkRvDDjH4OVKAmbpDYHUZoMaB4UlD+x/C1/xFqY/oZcrArs/rbbgEcVkAxW
	y5azBQAhWJqKPadwnWds+yJCTffzxDswZLvA94EAyTXj+n0XIbVhmpcg55MPzhb0VGRDyR
	thVN/4dpOXG8VetBkns+tNXR4ZIY+v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700044198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUy5lhblC+Myvg0CjSgw5eSZfGcVwPzCzryM+8UbVoo=;
	b=AjIo6vjKgP77yb3FhNls8QBWjooAQ0ELc9QnyABJpe/SdecY4Oc+MeHlAd7NJcxP3FrwdZ
	GlJhYTrKYE0iCFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 992B7139B7;
	Wed, 15 Nov 2023 10:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iN6SJKadVGV+UAAAMHmgww
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Nov 2023 10:29:58 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/32] fbdev/sh_mobile_lcdcfb: Initialize fb_ops with fbdev macros
Date: Wed, 15 Nov 2023 11:19:18 +0100
Message-ID: <20231115102954.7102-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115102954.7102-1-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Initialize the instance of struct fb_ops with fbdev initializer
macros for framebuffers in DMA-able virtual address space. Set the
read/write, draw and mmap callbacks to the correct implementation
and avoid implicit defaults. Also select the necessary helpers in
Kconfig.

The driver uses a mixture of DMA helpers and deferred I/O. That
probably needs fixing by a driver maintainer.

Fbdev drivers sometimes rely on the callbacks being NULL for a
default I/O-memory-based implementation to be invoked; hence
requiring the I/O helpers to be built in any case. Setting all
callbacks in all drivers explicitly will allow to make the I/O
helpers optional. This benefits systems that do not use these
functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig            |  7 ++-----
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 10 +++-------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e789e5c1973cb..409e02130be0f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1634,12 +1634,9 @@ config FB_SH_MOBILE_LCDC
 	depends on FB && HAVE_CLK && HAS_IOMEM
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	depends on FB_DEVICE
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
-	select FB_DEFERRED_IO
 	select FB_BACKLIGHT
+	select FB_DEFERRED_IO
+	select FB_DMAMEM_HELPERS
 	help
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
 
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 5c99fc8a409fd..d84628de51893 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1488,13 +1488,10 @@ sh_mobile_lcdc_overlay_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 static const struct fb_ops sh_mobile_lcdc_overlay_ops = {
 	.owner          = THIS_MODULE,
-	.fb_read        = fb_sys_read,
-	.fb_write       = fb_sys_write,
-	.fb_fillrect	= sys_fillrect,
-	.fb_copyarea	= sys_copyarea,
-	.fb_imageblit	= sys_imageblit,
+	__FB_DEFAULT_DMAMEM_OPS_RDWR,
 	.fb_blank	= sh_mobile_lcdc_overlay_blank,
 	.fb_pan_display = sh_mobile_lcdc_overlay_pan,
+	__FB_DEFAULT_DMAMEM_OPS_DRAW,
 	.fb_ioctl       = sh_mobile_lcdc_overlay_ioctl,
 	.fb_check_var	= sh_mobile_lcdc_overlay_check_var,
 	.fb_set_par	= sh_mobile_lcdc_overlay_set_par,
@@ -1966,8 +1963,7 @@ sh_mobile_lcdc_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static const struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
-	.fb_read        = fb_sys_read,
-	.fb_write       = fb_sys_write,
+	__FB_DEFAULT_DMAMEM_OPS_RDWR,
 	.fb_fillrect	= sh_mobile_lcdc_fillrect,
 	.fb_copyarea	= sh_mobile_lcdc_copyarea,
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
-- 
2.42.0

