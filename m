Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66592C77B78
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 14:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjDYO26 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjDYO2x (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 10:28:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6713C10
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 07:28:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C802D1FDAA;
        Tue, 25 Apr 2023 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682432930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2D3N2Qx5z0w9X9shC22zFTUU3BHqjb0n/0JLuz8OeV8=;
        b=PuFhazH8vLmmRt+nL8GDQd4hKJQoLw60m3KmCeizU/moWUXkrH9aZMS0Q6DAwqlYzLY+tq
        Q3Ir7bAFsFO3QMLOO7DAeczKNNRKWsKIfZ161e8i9XUFJYtNcCL3fIzBlNEVN+cLTL+/KM
        wcZ3qjhdi9iAnr+MOEf1B3nIlfC3OlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682432930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2D3N2Qx5z0w9X9shC22zFTUU3BHqjb0n/0JLuz8OeV8=;
        b=pqOhZ3FHgB4sF7uiJbrRvpi2I72Xj8e0qgeRdVCQrghVlRkmdprhxsvoOTJgmsk+CLZfnV
        ZSzXX7EMztV2QhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B07A138E3;
        Tue, 25 Apr 2023 14:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WCveIKLjR2ReOgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Apr 2023 14:28:50 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/6] drm/fb-helper: Use fb_{cfb,sys}_{read, write}()
Date:   Tue, 25 Apr 2023 16:28:46 +0200
Message-Id: <20230425142846.730-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425142846.730-1-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Implement DRM fbdev helpers for reading and writing framebuffer
memory with the respective fbdev functions. Removes duplicate
code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 174 +-------------------------------
 1 file changed, 4 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 6bb1b8b27d7a..e11858470fa7 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -714,95 +714,6 @@ void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagerefli
 }
 EXPORT_SYMBOL(drm_fb_helper_deferred_io);
 
-typedef ssize_t (*drm_fb_helper_read_screen)(struct fb_info *info, char __user *buf,
-					     size_t count, loff_t pos);
-
-static ssize_t __drm_fb_helper_read(struct fb_info *info, char __user *buf, size_t count,
-				    loff_t *ppos, drm_fb_helper_read_screen read_screen)
-{
-	loff_t pos = *ppos;
-	size_t total_size;
-	ssize_t ret;
-
-	if (info->screen_size)
-		total_size = info->screen_size;
-	else
-		total_size = info->fix.smem_len;
-
-	if (pos >= total_size)
-		return 0;
-	if (count >= total_size)
-		count = total_size;
-	if (total_size - count < pos)
-		count = total_size - pos;
-
-	if (info->fbops->fb_sync)
-		info->fbops->fb_sync(info);
-
-	ret = read_screen(info, buf, count, pos);
-	if (ret > 0)
-		*ppos += ret;
-
-	return ret;
-}
-
-typedef ssize_t (*drm_fb_helper_write_screen)(struct fb_info *info, const char __user *buf,
-					      size_t count, loff_t pos);
-
-static ssize_t __drm_fb_helper_write(struct fb_info *info, const char __user *buf, size_t count,
-				     loff_t *ppos, drm_fb_helper_write_screen write_screen)
-{
-	loff_t pos = *ppos;
-	size_t total_size;
-	ssize_t ret;
-	int err = 0;
-
-	if (info->screen_size)
-		total_size = info->screen_size;
-	else
-		total_size = info->fix.smem_len;
-
-	if (pos > total_size)
-		return -EFBIG;
-	if (count > total_size) {
-		err = -EFBIG;
-		count = total_size;
-	}
-	if (total_size - count < pos) {
-		if (!err)
-			err = -ENOSPC;
-		count = total_size - pos;
-	}
-
-	if (info->fbops->fb_sync)
-		info->fbops->fb_sync(info);
-
-	/*
-	 * Copy to framebuffer even if we already logged an error. Emulates
-	 * the behavior of the original fbdev implementation.
-	 */
-	ret = write_screen(info, buf, count, pos);
-	if (ret < 0)
-		return ret; /* return last error, if any */
-	else if (!ret)
-		return err; /* return previous error, if any */
-
-	*ppos += ret;
-
-	return ret;
-}
-
-static ssize_t drm_fb_helper_read_screen_buffer(struct fb_info *info, char __user *buf,
-						size_t count, loff_t pos)
-{
-	const char *src = info->screen_buffer + pos;
-
-	if (copy_to_user(buf, src, count))
-		return -EFAULT;
-
-	return count;
-}
-
 /**
  * drm_fb_helper_sys_read - Implements struct &fb_ops.fb_read for system memory
  * @info: fb_info struct pointer
@@ -816,21 +727,10 @@ static ssize_t drm_fb_helper_read_screen_buffer(struct fb_info *info, char __use
 ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	return __drm_fb_helper_read(info, buf, count, ppos, drm_fb_helper_read_screen_buffer);
+	return fb_sys_read(info, buf, count, ppos);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_read);
 
-static ssize_t drm_fb_helper_write_screen_buffer(struct fb_info *info, const char __user *buf,
-						 size_t count, loff_t pos)
-{
-	char *dst = info->screen_buffer + pos;
-
-	if (copy_from_user(dst, buf, count))
-		return -EFAULT;
-
-	return count;
-}
-
 /**
  * drm_fb_helper_sys_write - Implements struct &fb_ops.fb_write for system memory
  * @info: fb_info struct pointer
@@ -849,7 +749,7 @@ ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *buf,
 	ssize_t ret;
 	struct drm_rect damage_area;
 
-	ret = __drm_fb_helper_write(info, buf, count, ppos, drm_fb_helper_write_screen_buffer);
+	ret = fb_sys_write(info, buf, count, ppos);
 	if (ret <= 0)
 		return ret;
 
@@ -921,39 +821,6 @@ void drm_fb_helper_sys_imageblit(struct fb_info *info,
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_imageblit);
 
-static ssize_t fb_read_screen_base(struct fb_info *info, char __user *buf, size_t count,
-				   loff_t pos)
-{
-	const char __iomem *src = info->screen_base + pos;
-	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
-	ssize_t ret = 0;
-	int err = 0;
-	char *tmp;
-
-	tmp = kmalloc(alloc_size, GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	while (count) {
-		size_t c = min_t(size_t, count, alloc_size);
-
-		memcpy_fromio(tmp, src, c);
-		if (copy_to_user(buf, tmp, c)) {
-			err = -EFAULT;
-			break;
-		}
-
-		src += c;
-		buf += c;
-		ret += c;
-		count -= c;
-	}
-
-	kfree(tmp);
-
-	return ret ? ret : err;
-}
-
 /**
  * drm_fb_helper_cfb_read - Implements struct &fb_ops.fb_read for I/O memory
  * @info: fb_info struct pointer
@@ -967,43 +834,10 @@ static ssize_t fb_read_screen_base(struct fb_info *info, char __user *buf, size_
 ssize_t drm_fb_helper_cfb_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	return __drm_fb_helper_read(info, buf, count, ppos, fb_read_screen_base);
+	return fb_cfb_read(info, buf, count, ppos);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_read);
 
-static ssize_t fb_write_screen_base(struct fb_info *info, const char __user *buf, size_t count,
-				    loff_t pos)
-{
-	char __iomem *dst = info->screen_base + pos;
-	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
-	ssize_t ret = 0;
-	int err = 0;
-	u8 *tmp;
-
-	tmp = kmalloc(alloc_size, GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	while (count) {
-		size_t c = min_t(size_t, count, alloc_size);
-
-		if (copy_from_user(tmp, buf, c)) {
-			err = -EFAULT;
-			break;
-		}
-		memcpy_toio(dst, tmp, c);
-
-		dst += c;
-		buf += c;
-		ret += c;
-		count -= c;
-	}
-
-	kfree(tmp);
-
-	return ret ? ret : err;
-}
-
 /**
  * drm_fb_helper_cfb_write - Implements struct &fb_ops.fb_write for I/O memory
  * @info: fb_info struct pointer
@@ -1022,7 +856,7 @@ ssize_t drm_fb_helper_cfb_write(struct fb_info *info, const char __user *buf,
 	ssize_t ret;
 	struct drm_rect damage_area;
 
-	ret = __drm_fb_helper_write(info, buf, count, ppos, fb_write_screen_base);
+	ret = fb_cfb_write(info, buf, count, ppos);
 	if (ret <= 0)
 		return ret;
 
-- 
2.40.0

