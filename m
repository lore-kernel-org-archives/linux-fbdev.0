Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC09C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiECUZM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiECUYv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 16:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A362DABC
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651609276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4u7Yt2vppAECuc7ylXyyx3S/PHhKr3Xvb+IjIhWLrAo=;
        b=JpgIMYR6bBJEIbHFv6miLD9boVAkGGbrBRQWRIZgh/J/cmkYX7iJa9sDkzo20pttxeb0ip
        rvFcY8Rq5IKInp8J3rYMh6N1WOZt3JqPQ4bNnyf6FQst16R/PiytgsjsOhiGxoDCVk8lDT
        /eGCs6EhYIDtWbBFSvaJ4rBsqYctqSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-SQ2wcZPjOHuNF4rLjDv8gA-1; Tue, 03 May 2022 16:19:48 -0400
X-MC-Unique: SQ2wcZPjOHuNF4rLjDv8gA-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso1859543wmh.2
        for <linux-fbdev@vger.kernel.org>; Tue, 03 May 2022 13:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4u7Yt2vppAECuc7ylXyyx3S/PHhKr3Xvb+IjIhWLrAo=;
        b=DYlMv+W+gWyK6bXAAr3irXyVRAVQphHKmw3MdpqkQOEbVu7XeXqbSHnftz9ICjisRN
         ORcKWJm7ckdu+aQ2fp1j4AcY6ZXvMsNFJ18EUZ2+6tpFNa8k5nmbBKmBhuu0xoNmQhh7
         AMJSa5uh9ymNoMP51LCRjM9s+torxqNZ2HHQoh5TW7eRPLU+CYOM41COp2Ug0HL0JimN
         N9ybGTP/Fpq+/63bRklRRWWjpjMIhvyF4hGgO6IzFsVprAiL+cv+vpJT6ORZhxGBBT0u
         D2yVCchEsMa6LWnvpwJF3a6jHFUE9MQksT3Czpgj6zjD+fSPBtrFwsa7+60xGdrLafSf
         H0Dw==
X-Gm-Message-State: AOAM533ls01udr3bMvt2bcmfqJMYnxbVMy6s9l/uLcKCK7yBLtv01JCm
        dDhCDQa4XrCDQlxk3EFpnb8d5b+3yLhalNdfOSGyjetH8RN8r3H3MYzsgniECTYVIc1PivPBAsp
        ZQ6bMgDj1y9mMiTJ6KmPn7pc=
X-Received: by 2002:a5d:5544:0:b0:20a:819d:5249 with SMTP id g4-20020a5d5544000000b0020a819d5249mr14052882wrw.461.1651609186779;
        Tue, 03 May 2022 13:19:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp0vPLBY+J8oEzOKXdDGOAxOZWvF7aZWpw1WW7Zeo9NRiqINypGhS10lmOL0oOQYpZY8f19A==
X-Received: by 2002:a5d:5544:0:b0:20a:819d:5249 with SMTP id g4-20020a5d5544000000b0020a819d5249mr14052865wrw.461.1651609186511;
        Tue, 03 May 2022 13:19:46 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6-20020adfc586000000b0020c5253d908sm10737994wrg.84.2022.05.03.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:19:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] fbdev: Use helper to get fb_info in all file operations
Date:   Tue,  3 May 2022 22:19:34 +0200
Message-Id: <20220503201934.681276-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A reference to the framebuffer device struct fb_info is stored in the file
private data, but this reference could no longer be valid and must not be
accessed directly. Instead, the file_fb_info() accessor function must be
used since it does sanity checking to make sure that the fb_info is valid.

This can happen for example if the registered framebuffer device is for a
driver that just uses a framebuffer provided by the system firmware. In
that case, the fbdev core would unregister the framebuffer device when a
real video driver is probed and ask to remove conflicting framebuffers.

Most fbdev file operations already use the helper to get the fb_info but
get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.

Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
exported. Rename it and add a fb_ prefix to denote that is public now.

Reported-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Fix copy & paste error passing file->private_data instead of file
  to fb_file_fb_info() function (Sam Ravnborg).

 drivers/video/fbdev/core/fb_defio.c |  5 ++++-
 drivers/video/fbdev/core/fbmem.c    | 24 +++++++++++++++---------
 include/linux/fb.h                  |  1 +
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 842c66b3e33d..ccdf903c48bd 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -68,12 +68,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fb_info *info = file->private_data;
+	struct fb_info *info = fb_file_fb_info(file);
 	struct inode *inode = file_inode(file);
 	int err = file_write_and_wait_range(file, start, end);
 	if (err)
 		return err;
 
+	if (!info)
+		return -ENODEV;
+
 	/* Skip if deferred io is compiled-in but disabled on this fbdev */
 	if (!info->fbdefio)
 		return 0;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..ba2c14a1087d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -745,7 +745,7 @@ static const struct seq_operations __maybe_unused proc_fb_seq_ops = {
  * So look up the fb_info using the inode minor number,
  * and just verify it against the reference we have.
  */
-static struct fb_info *file_fb_info(struct file *file)
+struct fb_info *fb_file_fb_info(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	int fbidx = iminor(inode);
@@ -755,12 +755,13 @@ static struct fb_info *file_fb_info(struct file *file)
 		info = NULL;
 	return info;
 }
+EXPORT_SYMBOL(fb_file_fb_info);
 
 static ssize_t
 fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	u8 *buffer, *dst;
 	u8 __iomem *src;
 	int c, cnt = 0, err = 0;
@@ -825,7 +826,7 @@ static ssize_t
 fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	u8 *buffer, *src;
 	u8 __iomem *dst;
 	int c, cnt = 0, err = 0;
@@ -1181,7 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 static long fb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 
 	if (!info)
 		return -ENODEV;
@@ -1293,7 +1294,7 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	const struct fb_ops *fb;
 	long ret = -ENOIOCTLCMD;
 
@@ -1333,7 +1334,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);
 	unsigned long mmio_pgoff;
 	unsigned long start;
@@ -1434,7 +1435,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
+	struct fb_info * const info = fb_file_fb_info(file);
 
 	if (!info)
 		return -ENODEV;
@@ -1453,8 +1454,13 @@ unsigned long get_fb_unmapped_area(struct file *filp,
 				   unsigned long addr, unsigned long len,
 				   unsigned long pgoff, unsigned long flags)
 {
-	struct fb_info * const info = filp->private_data;
-	unsigned long fb_size = PAGE_ALIGN(info->fix.smem_len);
+	struct fb_info * const info = fb_file_fb_info(filp);
+	unsigned long fb_size;
+
+	if (!info)
+		return -ENODEV;
+
+	fb_size = PAGE_ALIGN(info->fix.smem_len);
 
 	if (pgoff > fb_size || len > fb_size - pgoff)
 		return -EINVAL;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 9a77ab615c36..3004b8b8c5c2 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -624,6 +624,7 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
+extern struct fb_info *fb_file_fb_info(struct file *file);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
-- 
2.35.1

