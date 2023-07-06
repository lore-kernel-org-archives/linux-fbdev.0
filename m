Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE5EB64DC
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGFMuK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGFMuC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 08:50:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDAA1BDC;
        Thu,  6 Jul 2023 05:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C46C2029B;
        Thu,  6 Jul 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688647750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsFhjaoPgVp2581koPGFyw3SO2K9XY/ALPWjj/vOxyo=;
        b=ohQs19c9l2Y8h8EuBwGkNfeEW3uNzTp4bTUAVgdeeeYXWoWFG2oS393iFq1Ubw5pZYIX6m
        NqDConuLvu+QPsvn4bkdAOTNPrxTeK26Qj4kVfnVxslPsVkPGISkjELxSBEFjwONs0SYZf
        I/AY49VlU7+ucXhxUKSWGEkjzAYZoQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688647750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsFhjaoPgVp2581koPGFyw3SO2K9XY/ALPWjj/vOxyo=;
        b=TRFKkZtSqMVaF/S2YPG09ZpNju/i142i056uilDX91yO6NM/QM2NYT4ApXk6d+JKV0OjEL
        XV/iDO1YinzbWhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 260B41390F;
        Thu,  6 Jul 2023 12:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +IQ+CEa4pmS7QgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 12:49:10 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 11/11] fbdev: Harmonize some comments in <linux/fb.h>
Date:   Thu,  6 Jul 2023 14:46:49 +0200
Message-ID: <20230706124905.15134-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124905.15134-1-tzimmermann@suse.de>
References: <20230706124905.15134-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Make the comments for I/O, system and DMA memory say the same.
Makes the header file's structure more obvious.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
---
 include/linux/fb.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index d370f84fbca9..c8ca9c265fda 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -529,7 +529,7 @@ extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_blank(struct fb_info *info, int blank);
 
 /*
- * Drawing operations where framebuffer is in I/O memory
+ * Helpers for framebuffers in I/O memory
  */
 
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
@@ -540,10 +540,6 @@ extern ssize_t fb_io_read(struct fb_info *info, char __user *buf,
 extern ssize_t fb_io_write(struct fb_info *info, const char __user *buf,
 			   size_t count, loff_t *ppos);
 
-/*
- * Initializes struct fb_ops for framebuffers in I/O memory.
- */
-
 #define __FB_DEFAULT_IO_OPS_RDWR \
 	.fb_read	= fb_io_read, \
 	.fb_write	= fb_io_write
@@ -562,7 +558,7 @@ extern ssize_t fb_io_write(struct fb_info *info, const char __user *buf,
 	__FB_DEFAULT_IO_OPS_MMAP
 
 /*
- * Drawing operations where framebuffer is in system RAM
+ * Helpers for framebuffers in system memory
  */
 
 extern void sys_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
@@ -573,10 +569,6 @@ extern ssize_t fb_sys_read(struct fb_info *info, char __user *buf,
 extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 			    size_t count, loff_t *ppos);
 
-/*
- * Initializes struct fb_ops for framebuffers in system memory.
- */
-
 #define __FB_DEFAULT_SYS_OPS_RDWR \
 	.fb_read	= fb_sys_read, \
 	.fb_write	= fb_sys_write
-- 
2.41.0

