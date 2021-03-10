Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F4EC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2EC64FCE
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhCJSzm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhCJSzi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Mar 2021 13:55:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BDC061760;
        Wed, 10 Mar 2021 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xPa0e9GY36MTdUnU4Us/o0bHjoJTlPS3WAbT34ElMIs=; b=IJmYRV4hZ3EEw0NVPp8cuKjNph
        RppQyGXpVETCuFn+gF9WObaqrL0avriNNB7MqxPayCpLStu3oKdyxypqQUIYVqzuiSUzz4EepXd2V
        +nh0a+RgbHK/rQuwlYvoe++yt7qkY/kyltg9MTGpfUmBHDlN/VWPVYA532UhHeFtsncYqjO6U9V4o
        8X/uSUFjh5IHf8PcBV8ld1L7z9WswWS7jyAigLv4+z2NxZI5EExPrE1auakhoruBj/W4uibXdv9Yi
        lVuJtGPWNLHqGnhlao9L9ROybrWXETuKs6brYE9PNEQuddzZYNIaa+GanlRS6SYmD5SrVHzISv4Yt
        c8E4LuYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lK3zX-004Q1q-Qh; Wed, 10 Mar 2021 18:55:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ian Campbell <ijc@hellion.org.uk>,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v2] fb_defio: Remove custom address_space_operations
Date:   Wed, 10 Mar 2021 18:55:30 +0000
Message-Id: <20210310185530.1053320-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There's no need to give the page an address_space.  Leaving the
page->mapping as NULL will cause the VM to handle set_page_dirty()
the same way that it's handled now, and that was the only reason to
set the address_space in the first place.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
v2: Delete local variable definitions
 drivers/video/fbdev/core/fb_defio.c | 35 -----------------------------
 drivers/video/fbdev/core/fbmem.c    |  4 ----
 include/linux/fb.h                  |  3 ---
 3 files changed, 42 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..b292887a2481 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -52,13 +52,6 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	get_page(page);
-
-	if (vmf->vma->vm_file)
-		page->mapping = vmf->vma->vm_file->f_mapping;
-	else
-		printk(KERN_ERR "no mapping available\n");
-
-	BUG_ON(!page->mapping);
 	page->index = vmf->pgoff;
 
 	vmf->page = page;
@@ -151,17 +144,6 @@ static const struct vm_operations_struct fb_deferred_io_vm_ops = {
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
 
-static int fb_deferred_io_set_page_dirty(struct page *page)
-{
-	if (!PageDirty(page))
-		SetPageDirty(page);
-	return 0;
-}
-
-static const struct address_space_operations fb_deferred_io_aops = {
-	.set_page_dirty = fb_deferred_io_set_page_dirty,
-};
-
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	vma->vm_ops = &fb_deferred_io_vm_ops;
@@ -212,29 +194,12 @@ void fb_deferred_io_init(struct fb_info *info)
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
 
-void fb_deferred_io_open(struct fb_info *info,
-			 struct inode *inode,
-			 struct file *file)
-{
-	file->f_mapping->a_ops = &fb_deferred_io_aops;
-}
-EXPORT_SYMBOL_GPL(fb_deferred_io_open);
-
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
-	struct page *page;
-	int i;
 
 	BUG_ON(!fbdefio);
 	cancel_delayed_work_sync(&info->deferred_work);
-
-	/* clear out the mapping that we setup */
-	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
-		page = fb_deferred_io_page(info, i);
-		page->mapping = NULL;
-	}
-
 	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 06f5805de2de..372b52a2befa 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1415,10 +1415,6 @@ __releases(&info->lock)
 		if (res)
 			module_put(info->fbops->owner);
 	}
-#ifdef CONFIG_FB_DEFERRED_IO
-	if (info->fbdefio)
-		fb_deferred_io_open(info, inode, file);
-#endif
 out:
 	unlock_fb_info(info);
 	if (res)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ecfbcc0553a5..a8dccd23c249 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -659,9 +659,6 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 /* drivers/video/fb_defio.c */
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma);
 extern void fb_deferred_io_init(struct fb_info *info);
-extern void fb_deferred_io_open(struct fb_info *info,
-				struct inode *inode,
-				struct file *file);
 extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_fsync(struct file *file, loff_t start,
 				loff_t end, int datasync);
-- 
2.30.0

