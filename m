Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10453C433E0
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 22:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A0F204EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbhAZWjD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391680AbhAZSWz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611685288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJzmx/FDrJMCCLLcPZO2xno8mAW17V5sI1Mz8ht2blY=;
        b=I+EpKpG8iGnVhd7z3gyGW8tpSsUQtm+QAegZ2x/njCGxl8uC4lkC7IB0PTJ1BRs7/d9P1A
        S/Tev6POPJDR0dHw/y+r7/TQ8UYshV/CPRjoaZBgcTzd7uAD6FiiGldegPApXExD8ew6EI
        bG0tPnQLh5h26JlwuOLx1h4gYlubWDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-HIxeCZ2DNiWixeoS2pS0Ug-1; Tue, 26 Jan 2021 13:21:26 -0500
X-MC-Unique: HIxeCZ2DNiWixeoS2pS0Ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7B9801817;
        Tue, 26 Jan 2021 18:21:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FA946F80A;
        Tue, 26 Jan 2021 18:21:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 1/2] video: fbdev: acornfb: remove free_unused_pages()
Date:   Tue, 26 Jan 2021 19:21:12 +0100
Message-Id: <20210126182113.19892-2-david@redhat.com>
In-Reply-To: <20210126182113.19892-1-david@redhat.com>
References: <20210126182113.19892-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This function is never used and it is one of the last remaining user of
__free_reserved_page(). Let's just drop it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/video/fbdev/acornfb.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index bcc92aecf666..1b72edc01cfb 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -921,40 +921,6 @@ static int acornfb_detect_monitortype(void)
 	return 4;
 }
 
-/*
- * This enables the unused memory to be freed on older Acorn machines.
- * We are freeing memory on behalf of the architecture initialisation
- * code here.
- */
-static inline void
-free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
-{
-	int mb_freed = 0;
-
-	/*
-	 * Align addresses
-	 */
-	virtual_start = PAGE_ALIGN(virtual_start);
-	virtual_end = PAGE_ALIGN(virtual_end);
-
-	while (virtual_start < virtual_end) {
-		struct page *page;
-
-		/*
-		 * Clear page reserved bit,
-		 * set count to 1, and free
-		 * the page.
-		 */
-		page = virt_to_page(virtual_start);
-		__free_reserved_page(page);
-
-		virtual_start += PAGE_SIZE;
-		mb_freed += PAGE_SIZE / 1024;
-	}
-
-	printk("acornfb: freed %dK memory\n", mb_freed);
-}
-
 static int acornfb_probe(struct platform_device *dev)
 {
 	unsigned long size;
-- 
2.29.2

