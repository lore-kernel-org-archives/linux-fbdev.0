Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB419A
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Nov 2023 05:17:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D9D920402;
	Mon, 27 Nov 2023 13:17:06 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C991B13B3A;
	Mon, 27 Nov 2023 13:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2PwnMNGWZGUhLQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Nov 2023 13:17:05 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 26/32] staging/sm750fb: Initialize fb_ops with fbdev macros
Date: Mon, 27 Nov 2023 14:15:55 +0100
Message-ID: <20231127131655.4020-27-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127131655.4020-1-tzimmermann@suse.de>
References: <20231127131655.4020-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++
X-Spam-Score: 9.10
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of tzimmermann@suse.de) smtp.mailfrom=tzimmermann@suse.de;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 0D9D920402
X-Spamd-Result: default: False [9.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.971];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,siliconmotion.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,gmail.com,siliconmotion.com,linuxfoundation.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

Initialize all instances of struct fb_ops with fbdev initializer
macros for framebuffers in I/O address space. Set the read/write,
draw and mmap callbacks to the correct implementation and avoid
implicit defaults. Also select the necessary helpers in Kconfig.

Fbdev drivers sometimes rely on the callbacks being NULL for a
default I/O-memory-based implementation to be invoked; hence
requiring the I/O helpers to be built in any case. Setting all
callbacks in all drivers explicitly will allow to make the I/O
helpers optional. This benefits systems that do not use these
functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 35098516f53c9..04c1b32a22c5e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -665,31 +665,28 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 
 static const struct fb_ops lynxfb_ops = {
 	.owner = THIS_MODULE,
+	FB_DEFAULT_IOMEM_OPS,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
 	.fb_pan_display = lynxfb_ops_pan_display,
-	.fb_fillrect = cfb_fillrect,
-	.fb_imageblit = cfb_imageblit,
-	.fb_copyarea = cfb_copyarea,
 };
 
 static const struct fb_ops lynxfb_ops_with_cursor = {
 	.owner = THIS_MODULE,
+	FB_DEFAULT_IOMEM_OPS,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
 	.fb_pan_display = lynxfb_ops_pan_display,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea = cfb_copyarea,
-	.fb_imageblit = cfb_imageblit,
 	.fb_cursor = lynxfb_ops_cursor,
 };
 
 static const struct fb_ops lynxfb_ops_accel = {
 	.owner = THIS_MODULE,
+	__FB_DEFAULT_IOMEM_OPS_RDWR,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
@@ -698,10 +695,12 @@ static const struct fb_ops lynxfb_ops_accel = {
 	.fb_fillrect = lynxfb_ops_fillrect,
 	.fb_copyarea = lynxfb_ops_copyarea,
 	.fb_imageblit = lynxfb_ops_imageblit,
+	__FB_DEFAULT_IOMEM_OPS_MMAP,
 };
 
 static const struct fb_ops lynxfb_ops_accel_with_cursor = {
 	.owner = THIS_MODULE,
+	__FB_DEFAULT_IOMEM_OPS_RDWR,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
@@ -711,6 +710,7 @@ static const struct fb_ops lynxfb_ops_accel_with_cursor = {
 	.fb_copyarea = lynxfb_ops_copyarea,
 	.fb_imageblit = lynxfb_ops_imageblit,
 	.fb_cursor = lynxfb_ops_cursor,
+	__FB_DEFAULT_IOMEM_OPS_MMAP,
 };
 
 static int lynxfb_set_fbinfo(struct fb_info *info, int index)
-- 
2.43.0

