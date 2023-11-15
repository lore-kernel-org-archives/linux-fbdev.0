Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31CE57E
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1nH+kKK6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1iV3aZ1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C212E
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 02:29:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2FF222910;
	Wed, 15 Nov 2023 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700044197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAtl6LuoVlLsxiRdTjJKvaF+FwE7/mQnn+5rCX3zk1o=;
	b=1nH+kKK66U89JIjxUun+DX0MQr012dUw2vufuVaDU4+8RQW/iBicGCvI6Mn9xlbtF3hcpf
	UHmv3xoO5mOzI+Rb/hHHAd6XN4HyspD/6+sw8efWcsWatTfBT13qtnBeNEWPZK0Pa/Sntp
	F7mhABAKfogrjW0eG8TyPDY9xGay/Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700044197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAtl6LuoVlLsxiRdTjJKvaF+FwE7/mQnn+5rCX3zk1o=;
	b=S1iV3aZ1uxQMZPpip8rtHy/eyJov8P4QwZPHYf2KqN2Pfg1CGdGULN6uFKeidbSoOCwjjF
	zzRCtnC87AKADVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA87613ACD;
	Wed, 15 Nov 2023 10:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yL6rLKWdVGV+UAAAMHmgww
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Nov 2023 10:29:57 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 08/32] auxdisplay/cfag12864bfb: Initialize fb_ops with fbdev macros
Date: Wed, 15 Nov 2023 11:19:13 +0100
Message-ID: <20231115102954.7102-9-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
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
	 RCPT_COUNT_FIVE(0.00)[6];
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
2.42.0

