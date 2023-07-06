Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88557EB64DD
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 15:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGFPOl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjGFPOi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 11:14:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095F1997
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 08:14:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4B1A2285D;
        Thu,  6 Jul 2023 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688656475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVf0m2es0yK7mPVaVFTp11XST+fQvUNnxDouX4Snpik=;
        b=vVKHog6M2zMVJmKreFiO2PXXnSa+MDmONM8BN8EUlqebplGdgTGUqtT8Wnxr+H+olhMCrF
        V3OpAvtP9PGtu+kRzUjLZNQidDlZ5ebQ3iRFYu859+wj1lKZTDMWpJlsxL7Bsr5xGAdvM6
        qEgTB1GPJvQ1R6Wiw3Y5znB2jgL0MOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688656475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVf0m2es0yK7mPVaVFTp11XST+fQvUNnxDouX4Snpik=;
        b=/kFIB5cjjeNXQ37FbSj8+JRIL9r+qD/dIiDNGzd7xx/IcC37Hvqxd55Cp2KztMi1jOXnCc
        CEh2OPRoIrDSsCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C37BD138FC;
        Thu,  6 Jul 2023 15:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WGyULlvapmRvDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 15:14:35 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/10] fbdev/ssd1307fb: Generate deferred I/O ops
Date:   Thu,  6 Jul 2023 17:08:51 +0200
Message-ID: <20230706151432.20674-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706151432.20674-1-tzimmermann@suse.de>
References: <20230706151432.20674-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use the existing generator macros to create deferred-I/O helpers
for ssd1307fb and set them in the fb_ops structure. Functions
for damage handling on memory ranges and areas are provided by
the driver.

Ssd1307fb's implementation of fb_write writes to system memory,
so the generated code can use the respective helper internally.
This also fixes a long-standing bug where fb_write returned an
errno code instead of the number of written bytes. See the commit
message of commit 921b7383f348 ("fbdev: Return number of bytes
read or written") for more details.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/ssd1307fb.c | 69 ++++++---------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 11c373798279..a2b939342a4f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -292,43 +292,6 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	return ssd1307fb_update_rect(par, 0, 0, par->width, par->height);
 }
 
-static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
-		size_t count, loff_t *ppos)
-{
-	struct ssd1307fb_par *par = info->par;
-	unsigned long total_size;
-	unsigned long p = *ppos;
-	void *dst;
-	int ret;
-
-	if (!info->screen_buffer)
-		return -ENODEV;
-
-	total_size = info->fix.smem_len;
-
-	if (p > total_size)
-		return -EINVAL;
-
-	if (count + p > total_size)
-		count = total_size - p;
-
-	if (!count)
-		return -EINVAL;
-
-	dst = info->screen_buffer + p;
-
-	if (copy_from_user(dst, buf, count))
-		return -EFAULT;
-
-	ret = ssd1307fb_update_display(par);
-	if (ret < 0)
-		return ret;
-
-	*ppos += count;
-
-	return count;
-}
-
 static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 {
 	struct ssd1307fb_par *par = info->par;
@@ -339,39 +302,29 @@ static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
 }
 
-static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void ssd1307fb_defio_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct ssd1307fb_par *par = info->par;
-	sys_fillrect(info, rect);
-	ssd1307fb_update_rect(par, rect->dx, rect->dy, rect->width,
-			      rect->height);
-}
 
-static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
-{
-	struct ssd1307fb_par *par = info->par;
-	sys_copyarea(info, area);
-	ssd1307fb_update_rect(par, area->dx, area->dy, area->width,
-			      area->height);
+	ssd1307fb_update_display(par);
 }
 
-static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void ssd1307fb_defio_damage_area(struct fb_info *info, u32 x, u32 y,
+					u32 width, u32 height)
 {
 	struct ssd1307fb_par *par = info->par;
-	sys_imageblit(info, image);
-	ssd1307fb_update_rect(par, image->dx, image->dy, image->width,
-			      image->height);
+
+	ssd1307fb_update_rect(par, x, y, width, height);
 }
 
+FB_GEN_DEFAULT_DEFERRED_SYS_OPS(ssd1307fb,
+				ssd1307fb_defio_damage_range,
+				ssd1307fb_defio_damage_area)
+
 static const struct fb_ops ssd1307fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_read	= fb_sys_read,
-	.fb_write	= ssd1307fb_write,
+	FB_DEFAULT_DEFERRED_OPS(ssd1307fb),
 	.fb_blank	= ssd1307fb_blank,
-	.fb_fillrect	= ssd1307fb_fillrect,
-	.fb_copyarea	= ssd1307fb_copyarea,
-	.fb_imageblit	= ssd1307fb_imageblit,
-	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
-- 
2.41.0

