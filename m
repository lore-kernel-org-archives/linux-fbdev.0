Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E215C7EE22
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjD1MZJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346089AbjD1MY7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 08:24:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA946B8
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:24:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA6F20088;
        Fri, 28 Apr 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682684697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpA2p4vI9cmE2mMfYH5/kG+61RwNVyMNoCdW3g7PwOg=;
        b=zibRM2ep8ZObqcDjs5bAQlvCfOncjeO3lb3Zi6KlgJOEBXzSDYkW2zOsLfDcvGzdPMUbWd
        R31rkjsIlr8F/hAGMFPF9hxFFpnhogWp9X8l9o5yhBpGrrpsdIxRnJR2B7t53NYiWaAIsi
        aRKmrGHnAAOa0EDdiRfKekHVq9Jnz1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682684697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpA2p4vI9cmE2mMfYH5/kG+61RwNVyMNoCdW3g7PwOg=;
        b=JvO/b3qvpYa7utxYeGWGbTLicCfG/Uvzvnv+tB370qF6426n96DwFKTjW9lsm0JsNVI6U/
        KZDEAyinZGfwN1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292541390E;
        Fri, 28 Apr 2023 12:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mOXsCBm7S2RgeAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 12:24:57 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 06/19] fbdev/broadsheetfb: Use struct fb_info.screen_buffer
Date:   Fri, 28 Apr 2023 14:24:39 +0200
Message-Id: <20230428122452.4856-7-tzimmermann@suse.de>
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

As the driver operates on the latter address space, it is wrong to use
.screen_base and .screen_buffer must be used instead. This also gets
rid of casting needed due to not using the correct data type.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/broadsheetfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 55e62dd96f9b..65dc86b7081e 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -824,7 +824,7 @@ static void broadsheet_init_display(struct broadsheetfb_par *par)
 
 	broadsheet_burst_write(par, (panel_table[par->panel_index].w *
 					panel_table[par->panel_index].h)/2,
-					(u16 *) par->info->screen_base);
+					(u16 *)par->info->screen_buffer);
 
 	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
 
@@ -865,7 +865,7 @@ static void broadsheetfb_dpy_update_pages(struct broadsheetfb_par *par,
 						u16 y1, u16 y2)
 {
 	u16 args[5];
-	unsigned char *buf = (unsigned char *)par->info->screen_base;
+	unsigned char *buf = par->info->screen_buffer;
 
 	mutex_lock(&(par->io_lock));
 	/* y1 must be a multiple of 4 so drop the lower bits */
@@ -913,7 +913,7 @@ static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
 	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
 	broadsheet_burst_write(par, (panel_table[par->panel_index].w *
 					panel_table[par->panel_index].h)/2,
-					(u16 *) par->info->screen_base);
+					(u16 *)par->info->screen_buffer);
 
 	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
 
@@ -1033,7 +1033,7 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
 		count = total_size - p;
 	}
 
-	dst = (void *)(info->screen_base + p);
+	dst = info->screen_buffer + p;
 
 	if (copy_from_user(dst, buf, count))
 		err = -EFAULT;
@@ -1109,7 +1109,7 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	if (!videomemory)
 		goto err_fb_rel;
 
-	info->screen_base = (char *)videomemory;
+	info->screen_buffer = videomemory;
 	info->fbops = &broadsheetfb_ops;
 
 	broadsheetfb_var.xres = dpyw;
@@ -1205,7 +1205,7 @@ static int broadsheetfb_remove(struct platform_device *dev)
 		fb_deferred_io_cleanup(info);
 		par->board->cleanup(par);
 		fb_dealloc_cmap(&info->cmap);
-		vfree((void *)info->screen_base);
+		vfree(info->screen_buffer);
 		module_put(par->board->owner);
 		framebuffer_release(info);
 	}
-- 
2.40.0

