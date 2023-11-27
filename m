Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EA19A
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Nov 2023 05:17:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0730921DC1;
	Mon, 27 Nov 2023 13:17:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA126132A6;
	Mon, 27 Nov 2023 13:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8MbcL82WZGUhLQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Nov 2023 13:17:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2 08/32] auxdisplay/cfag12864bfb: Initialize fb_ops with fbdev macros
Date: Mon, 27 Nov 2023 14:15:37 +0100
Message-ID: <20231127131655.4020-9-tzimmermann@suse.de>
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
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of tzimmermann@suse.de) smtp.mailfrom=tzimmermann@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 8.79
X-Rspamd-Queue-Id: 0730921DC1

Initialize the instance of struct fb_ops with fbdev initializer
macros for framebuffers in virtual address space. Set the read/write,
draw and mmap callbacks to the correct implementation and avoid
implicit defaults. Also select the necessary helpers in Kconfig.

Fbdev drivers sometimes rely on the callbacks being NULL for a
default I/O-memory-based implementation to be invoked; hence
requiring the I/O helpers to be built in any case. Setting all
callbacks in all drivers explicitly will allow to make the I/O
helpers optional. This benefits systems that do not use these
functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/auxdisplay/Kconfig        | 5 +----
 drivers/auxdisplay/cfag12864bfb.c | 7 ++-----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 64012cda4d126..4377e53f8f572 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -112,10 +112,7 @@ config CFAG12864B
 	depends on X86
 	depends on FB
 	depends on KS0108
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
+	select FB_SYSMEM_HELPERS
 	default n
 	help
 	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index c0ba693845aaf..ede0f9a513110 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -56,11 +56,8 @@ static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 static const struct fb_ops cfag12864bfb_ops = {
 	.owner = THIS_MODULE,
-	.fb_read = fb_sys_read,
-	.fb_write = fb_sys_write,
-	.fb_fillrect = sys_fillrect,
-	.fb_copyarea = sys_copyarea,
-	.fb_imageblit = sys_imageblit,
+	__FB_DEFAULT_SYSMEM_OPS_RDWR,
+	__FB_DEFAULT_SYSMEM_OPS_DRAW,
 	.fb_mmap = cfag12864bfb_mmap,
 };
 
-- 
2.43.0

