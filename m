Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEEFC15
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XUkVe0kC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75aImFZg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A29182
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 02:30:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 566C5204E3;
	Wed, 15 Nov 2023 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700044199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Cw71RO8yawCfFDU6u58cDixSW0G5roCUDejOnQBUes=;
	b=XUkVe0kC3rYivT+64v3RHgy0ygWiTny0buZFOj/adUIBkR0LNY821Jq+XaB3S6lREGt9GH
	CNCH/jtf8hLpIfhoOtxApppA6uHrInBqcBw3jOO9KX0xAaStmAYj+/QjxHlwwxQMEpELPI
	27ufmUSJKKiAoo+/j4BJjxfLpz9Fq6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700044199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Cw71RO8yawCfFDU6u58cDixSW0G5roCUDejOnQBUes=;
	b=75aImFZgjGQCo7te27RyAqKX1KkB3Or2K7dDYex/R5tZxPMSjq56MfwNa9AVsh1gUVWelF
	3+BLC/o/8v71ZgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A815139B7;
	Wed, 15 Nov 2023 10:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mOtQDaedVGV+UAAAMHmgww
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Nov 2023 10:29:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 17/32] fbdev/au1200fb: Initialize fb_ops with fbdev macros
Date: Wed, 15 Nov 2023 11:19:22 +0100
Message-ID: <20231115102954.7102-18-tzimmermann@suse.de>
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

Fbdev drivers sometimes rely on the callbacks being NULL for a
default I/O-memory-based implementation to be invoked; hence
requiring the I/O helpers to be built in any case. Setting all
callbacks in all drivers explicitly will allow to make the I/O
helpers optional. This benefits systems that do not use these
functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig    | 5 +----
 drivers/video/fbdev/au1200fb.c | 7 ++-----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8c38969e9468a..2445cbca85579 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1457,10 +1457,7 @@ config FB_AU1100
 config FB_AU1200
 	bool "Au1200/Au1300 LCD Driver"
 	depends on (FB = y) && MIPS_ALCHEMY
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
+	select FB_DMAMEM_HELPERS
 	help
 	  This is the framebuffer driver for the Au1200/Au1300 SOCs.
 	  It can drive various panels and CRTs by passing in kernel cmd line
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 817c1ebb625b6..16ebbab500972 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1488,15 +1488,12 @@ static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 static const struct fb_ops au1200fb_fb_ops = {
 	.owner		= THIS_MODULE,
+	__FB_DEFAULT_DMAMEM_OPS_RDWR,
 	.fb_check_var	= au1200fb_fb_check_var,
 	.fb_set_par	= au1200fb_fb_set_par,
 	.fb_setcolreg	= au1200fb_fb_setcolreg,
 	.fb_blank	= au1200fb_fb_blank,
-	.fb_fillrect	= sys_fillrect,
-	.fb_copyarea	= sys_copyarea,
-	.fb_imageblit	= sys_imageblit,
-	.fb_read	= fb_sys_read,
-	.fb_write	= fb_sys_write,
+	__FB_DEFAULT_DMAMEM_OPS_DRAW,
 	.fb_sync	= NULL,
 	.fb_ioctl	= au1200fb_ioctl,
 	.fb_mmap	= au1200fb_fb_mmap,
-- 
2.42.0

