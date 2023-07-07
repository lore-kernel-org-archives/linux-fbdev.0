Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B15C0015E
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 08:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjGGIe3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGGIe3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 04:34:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D9113;
        Fri,  7 Jul 2023 01:34:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3905227BD;
        Fri,  7 Jul 2023 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688718866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKR3ZnbG7MMz5F4/vJcdpyoOxU6C2g5Dy4H9g3Ktz+0=;
        b=Nbcs7L2X8dIrZ+pjQOetdl5EkQ4rA1yUjdmIj0aEumWkNisY4c6iuwVlm4OR9RFP06ww7d
        Exd+QdNTTqYEi8x1GLb8QJblP6+pmWAHraagp5/la2v9YIVrYyL/NnwMTRM5IWl6DA+UcN
        4rgfrhQc9Fddsv5Ke4IwoY4gmCKxKjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688718866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKR3ZnbG7MMz5F4/vJcdpyoOxU6C2g5Dy4H9g3Ktz+0=;
        b=yV+s2SQuvmnMWfG30ZwHvxeNO7ITtmJ8CzxOX04kJDO0NagLNxnKxD8XCrfU+ew+AhhCs3
        9WVRmDOsaeHNnzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EC0813A18;
        Fri,  7 Jul 2023 08:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sA8OHhLOp2RdQAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 07 Jul 2023 08:34:26 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v3 01/12] fbdev: Add fb_ops init macros for framebuffers in DMA-able memory
Date:   Fri,  7 Jul 2023 10:31:52 +0200
Message-ID: <20230707083422.18691-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707083422.18691-1-tzimmermann@suse.de>
References: <20230707083422.18691-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add initializer macros for struct fb_ops for framebuffers in DMA-able
memory areas. Also add a corresponding Kconfig token. As of now, this
is equivalent to system framebuffers and mostly useful for labeling
drivers correctly.

A later patch may add a generic DMA-specific mmap operation. Linux
offers a number of dma_mmap_*() helpers for different use cases.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/Kconfig |  8 ++++++++
 include/linux/fb.h          | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index cecf15418632..f14229757311 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -168,6 +168,14 @@ config FB_DEFERRED_IO
 	bool
 	depends on FB
 
+config FB_DMA_HELPERS
+	bool
+	depends on FB
+	select FB_SYS_COPYAREA
+	select FB_SYS_FILLRECT
+	select FB_SYS_FOPS
+	select FB_SYS_IMAGEBLIT
+
 config FB_IO_HELPERS
 	bool
 	depends on FB
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1d5c13f34b09..1191a78c5289 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -594,6 +594,19 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	__FB_DEFAULT_SYS_OPS_DRAW, \
 	__FB_DEFAULT_SYS_OPS_MMAP
 
+/*
+ * Helpers for framebuffers in DMA-able memory
+ */
+
+#define __FB_DEFAULT_DMA_OPS_RDWR \
+	.fb_read	= fb_sys_read, \
+	.fb_write	= fb_sys_write
+
+#define __FB_DEFAULT_DMA_OPS_DRAW \
+	.fb_fillrect	= sys_fillrect, \
+	.fb_copyarea	= sys_copyarea, \
+	.fb_imageblit	= sys_imageblit
+
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
-- 
2.41.0

