Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5164C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C566139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349066AbhDGGoC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349068AbhDGGnz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C7C061761;
        Tue,  6 Apr 2021 23:43:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f29so9815911pgm.8;
        Tue, 06 Apr 2021 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ud5Lzp79k1SGUuv+EiKNbNuFA/5+lE3CGchvKku3uIE=;
        b=iJkwBi7KVbyZYS9GfX0BYQ91VreWjBOm8zpdIIlzLlF3Ry9LHDAcwS6uCbzrtlwzVO
         O6P//6QInNKwmD/t9RPVEZx9rR02xxPqpSGP5ruuQddvo5izBtQLh2FfbtHhMTXOtg4M
         92K4fjg30GwsFx+D1FiAVCCnwwfoFF+YIWFfcqjsX9/YJxuqEagqqpju5wV5CBeCtwbJ
         VyoXFnEZW5qKcrMsQkrwxYrwemMg0WPhUsef2ZCfKOhEAGaOyxWZIqBN4OTGPgNIznHi
         P0FZ+scia1jCQl9rd5JRaNv0//YaDXThk4BQuyvGMQyomtzFL1jUy62VLsTMV8qng45F
         66OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ud5Lzp79k1SGUuv+EiKNbNuFA/5+lE3CGchvKku3uIE=;
        b=LKAHiGzX91HQW4VC4zdMPxP9rOT8hcX0ByjHUzumU9c+Fv9JIjwJGIiwdzK6iLg4k5
         OpUBTbX/pD6HlKUOPOe4x66B7aYWdbM0u8iMgXqkQHg7a5iPKAXdkmg5Zt94fxm3SNLh
         k6vtsjhrMJfVoDZ4C8VlpClwRnQTaSOQykoisAsgO4hh5aV5EokJtdgfsvj0dtPERPBc
         hgOrzot9NGN4TFubtwyRtdXNlGrBRP+7qKbkhLxfI/qPV1Wrnw+Z7hIFKb2yGhZzgsBz
         yDoUrB5NpOhoMEXCLUbNHqutmP5G/BGCnPZWCSqVNreEnBIpXXy90BA4FS95ky6SuC14
         anmg==
X-Gm-Message-State: AOAM530Xit17lgf5Sqvd/WRefeVGTsd8EhHVhUDyUzkrWgLOa9WuCu6G
        tTzUslDuurr9W/bsYOa/mao=
X-Google-Smtp-Source: ABdhPJwiGXyAMRtVFst8y5vF7NeRJzg5ktr1IulCzxwSMwUNmxjCn4VFmNbLLH9kTYxuRPqh0iZbjg==
X-Received: by 2002:a63:390:: with SMTP id 138mr1978644pgd.8.1617777825923;
        Tue, 06 Apr 2021 23:43:45 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id p17sm19778622pfn.62.2021.04.06.23.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:45 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:43 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/49] staging: sm750fb: Update members of lynx_cursor to
 snake case
Message-ID: <b9f4e37adf0d973c2ce8566dd8bf48394a42a33c.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members
of lynx_cursor structure, in particular maxW and maxH.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 8 ++++----
 drivers/staging/sm750fb/sm750.h        | 4 ++--
 drivers/staging/sm750fb/sm750_cursor.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c237a8f8eb59..4f5f68e6aa60 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -112,8 +112,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	crtc = &par->crtc;
 	cursor = &crtc->cursor;
 
-	if (fbcursor->image.width > cursor->maxW ||
-	    fbcursor->image.height > cursor->maxH ||
+	if (fbcursor->image.width > cursor->max_w ||
+	    fbcursor->image.height > cursor->max_h ||
 	    fbcursor->image.depth > 1) {
 		return -ENXIO;
 	}
@@ -723,8 +723,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.maxH = crtc->cursor.maxW = 64;
-	crtc->cursor.size = crtc->cursor.maxH * crtc->cursor.maxW * 2 / 8;
+	crtc->cursor.max_h = crtc->cursor.max_w = 64;
+	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 23eefd019ec9..8271cf7c89f3 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -122,8 +122,8 @@ struct lynx_cursor {
 	int h;
 	int size;
 	/* hardware limitation */
-	int maxW;
-	int maxH;
+	int max_w;
+	int max_h;
 	/* base virtual address and offset  of cursor image */
 	char __iomem *vstart;
 	int offset;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index bbbef27cb329..43e6f52c2551 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -97,7 +97,7 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 	count = pitch * cursor->h;
 
 	/* in byte */
-	offset = cursor->maxW * 2 / 8;
+	offset = cursor->max_w * 2 / 8;
 
 	data = 0;
 	pstart = cursor->vstart;
@@ -147,7 +147,7 @@ void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
 	count = pitch * cursor->h;
 
 	/* in byte */
-	offset = cursor->maxW * 2 / 8;
+	offset = cursor->max_w * 2 / 8;
 
 	data = 0;
 	pstart = cursor->vstart;
-- 
2.30.2

