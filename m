Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00765C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Mar 2022 01:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiCRBHi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Mar 2022 21:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiCRBHh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Mar 2022 21:07:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501F1AFE86
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647565579; x=1679101579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VWC6HUH11zHEaXwf+ALnIMxVDNWIX7ILw0OIDe/QfRw=;
  b=CY76ZgazjiIpS+QD8Iu2pA2ufAdBC3vmwgVAqp5EeUnf/5djiWV3H3YO
   mGeAwm93MYMjPirJKLqkg/AyGLt/YEirD2zYweDbrfx6grOZrxRJcsH4L
   uJgTkrs4PnEDUj8pLyLG76JhxW1IJDQgyyCzHlL1rj2I9EKc4wiWBKfsX
   L7QrlSA2LWyWeGtq4RTBrtMwLkL+zQIjWs/wKGKsX+hfyT6jZRmWDe1yu
   hGXvXecocfw37RHG5OKauadKb863KFhHWtfMwvTXXZkqbvFCwSmaRhY5I
   ltvMMZLdKKcUyIClO1vbpo5Q9bMqR9/h/AIJ3wAUHDvZYmLuSPAyiVOiJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254575410"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254575410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 18:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647259586"
Received: from cliu38-mobl3.sh.intel.com ([10.239.147.106])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 18:06:16 -0700
From:   Chuansheng Liu <chuansheng.liu@intel.com>
To:     jayalk@intworks.biz, daniel@ffwll.ch, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        chuansheng.liu@intel.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2] fbdev: defio: fix the pagelist corruption
Date:   Fri, 18 Mar 2022 08:50:03 +0800
Message-Id: <20220318005003.51810-1-chuansheng.liu@intel.com>
X-Mailer: git-send-email 2.25.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Easily hit the below list corruption:
==
list_add corruption. prev->next should be next (ffffffffc0ceb090), but
was ffffec604507edc8. (prev=ffffec604507edc8).
WARNING: CPU: 65 PID: 3959 at lib/list_debug.c:26
__list_add_valid+0x53/0x80
CPU: 65 PID: 3959 Comm: fbdev Tainted: G     U
RIP: 0010:__list_add_valid+0x53/0x80
Call Trace:
 <TASK>
 fb_deferred_io_mkwrite+0xea/0x150
 do_page_mkwrite+0x57/0xc0
 do_wp_page+0x278/0x2f0
 __handle_mm_fault+0xdc2/0x1590
 handle_mm_fault+0xdd/0x2c0
 do_user_addr_fault+0x1d3/0x650
 exc_page_fault+0x77/0x180
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7fd98fc8fad1
==

Figure out the race happens when one process is adding &page->lru into
the pagelist tail in fb_deferred_io_mkwrite(), another process is
re-initializing the same &page->lru in fb_deferred_io_fault(), which is
not protected by the lock.

This fix is to init all the page lists one time during initialization,
it not only fixes the list corruption, but also avoids INIT_LIST_HEAD()
redundantly.

V2: change "int i" to "unsigned int i" (Geert Uytterhoeven)

Fixes: 105a940416fc ("fbdev/defio: Early-out if page is already
enlisted")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 drivers/video/fbdev/core/fb_defio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 98b0f23bf5e2..a1da54016c88 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -59,7 +59,6 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 		printk(KERN_ERR "no mapping available\n");
 
 	BUG_ON(!page->mapping);
-	INIT_LIST_HEAD(&page->lru);
 	page->index = vmf->pgoff;
 
 	vmf->page = page;
@@ -220,6 +219,8 @@ static void fb_deferred_io_work(struct work_struct *work)
 void fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct page *page;
+	unsigned int i;
 
 	BUG_ON(!fbdefio);
 	mutex_init(&fbdefio->lock);
@@ -227,6 +228,12 @@ void fb_deferred_io_init(struct fb_info *info)
 	INIT_LIST_HEAD(&fbdefio->pagelist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
+
+	/* initialize all the page lists one time */
+	for (i = 0; i < info->fix.smem_len; i += PAGE_SIZE) {
+		page = fb_deferred_io_page(info, i);
+		INIT_LIST_HEAD(&page->lru);
+	}
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
 
-- 
2.25.0.rc2

