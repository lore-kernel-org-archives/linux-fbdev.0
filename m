Return-Path: <SRS0=cnZs=IE=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382CC433E0
	for <linux-fbdev@archiver.kernel.org>; Sat,  6 Mar 2021 21:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B7264FCC
	for <linux-fbdev@archiver.kernel.org>; Sat,  6 Mar 2021 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCFVPy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 6 Mar 2021 16:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVPm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 6 Mar 2021 16:15:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E9C06174A;
        Sat,  6 Mar 2021 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VQ8FmP4Hiih4NweBx3Yr8lFu8i5sit0vYyEzaq8cIKI=; b=MTNLzm+TUW2tPd2YM3vEfoLXhT
        G1URl0uhROFXmJqGvDGstSL0BwFIZ0rEb5BmEn7X3cH48XFUFL8UpAXgtI55qdj7KtJdeeFaMzFoJ
        pEnIABvfHdWHingVqmIee2Gqvk4nKdPG34HJz3pRkArs4VPUDHwW2uh8vvnfy73IR01WmwIa6UQRZ
        W2pARTeo98x3sMtyiC2f9ala6Xx4vdSUZQab1ncgbAiZE9L5rOO4JhiINwVNQwfn8cflXhTlxkAMc
        T2gKpba9HnMnYkFNIxyHl7uJ5346+pWGNWB1N3k65AAD46Lr+3YH6xnW9QjwCJVrECYb2KpquL+5V
        Qiy5haFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIeGe-00DWSA-I9; Sat, 06 Mar 2021 21:15:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fbdev@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jaya Kumar <jayalk@intworks.biz>
Subject: [PATCH] fb_defio: Use __set_page_dirty_no_writeback
Date:   Sat,  6 Mar 2021 21:15:16 +0000
Message-Id: <20210306211516.3222952-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The home-grown set_page_dirty() implementation had the wrong return value.
Use __set_page_dirty_no_writeback() like other in-memory implementations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/video/fbdev/core/fb_defio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..35021265e294 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -151,15 +151,8 @@ static const struct vm_operations_struct fb_deferred_io_vm_ops = {
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
 
-static int fb_deferred_io_set_page_dirty(struct page *page)
-{
-	if (!PageDirty(page))
-		SetPageDirty(page);
-	return 0;
-}
-
 static const struct address_space_operations fb_deferred_io_aops = {
-	.set_page_dirty = fb_deferred_io_set_page_dirty,
+	.set_page_dirty = __set_page_dirty_no_writeback,
 };
 
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
-- 
2.30.0

