Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC49C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 12:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjD1MZL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjD1MZC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 08:25:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37906270A
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:25:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1E3B21F60;
        Fri, 28 Apr 2023 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682684699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UUISuEWNBB7Ivz59ObDk7Z8YDWtZKFLLWdx8JUBWw8=;
        b=xRrH0djXV1GdzF9P0rN+vmoxV6mpuRO1368DNSv8OKtyokoN5HpodGeRkqT5H539VVToXc
        AqGqGOs0F1HTcEz4ynEOEKUT6297CUdCMHA6XqlZxnviZaa7kNsULohbaDognhG7P1Yd+7
        CtZOtdeaeKRagclJcHdksy63vKaDTzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682684699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UUISuEWNBB7Ivz59ObDk7Z8YDWtZKFLLWdx8JUBWw8=;
        b=a3YPlTICjqfygTukMiu1KcW7y2Lj6W2eaBSGtQo3jFou3AlQoeDsX2KKf2jhRPmRVrO36f
        Io3kuFFutoqyLdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A7791390E;
        Fri, 28 Apr 2023 12:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KAq4JBu7S2RgeAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 12:24:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 15/19] fbdev: Use screen_buffer in fb_sys_{read,write}()
Date:   Fri, 28 Apr 2023 14:24:48 +0200
Message-Id: <20230428122452.4856-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428122452.4856-1-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use info->screen_buffer when reading and writing framebuffers in
system memory. It's the correct pointer for this address space.

The struct fb_info has a union to store the framebuffer memory. This can
either be info->screen_base if the framebuffer is stored in I/O memory,
or info->screen_buffer if the framebuffer is stored in system memory.

Since the fb_sys_{read,write}() functions operate on the latter address
space, it is wrong to use .screen_base and .screen_buffer must be used
instead. This also gets rid of all the casting needed due to not using
the correct data type.

v2:
	* add detailed commit message (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fb_sys_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index cefb77b9546d..6589123f4127 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -39,7 +39,7 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	if (count + p > total_size)
 		count = total_size - p;
 
-	src = (void __force *)(info->screen_base + p);
+	src = info->screen_buffer + p;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -87,7 +87,7 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 		count = total_size - p;
 	}
 
-	dst = (void __force *) (info->screen_base + p);
+	dst = info->screen_buffer + p;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-- 
2.40.0

