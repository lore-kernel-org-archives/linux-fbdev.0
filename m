Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E6C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2206056C
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhGZMgW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhGZMgV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 08:36:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7EC061757;
        Mon, 26 Jul 2021 06:16:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k4-20020a17090a5144b02901731c776526so19680592pjm.4;
        Mon, 26 Jul 2021 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1UL54kq9P3B03/zrEaHmiJVQdBboZhMIM+Kjok0NDY=;
        b=C36NpbPuZKpV5iBQACQRJs+XclqHKt1igprkGySAlIR/vKUdiam2f2wpzXiM9oAgLB
         UbSij7LBho010HkJrW0cJ20MxTwygttVWZezEC/ABMzCgiIc6FUi/cizAgMnrEVLQwAU
         uvOX/ZBn4xSC7cVFaDkfXaxGjk0qzrVrcfL6/B3xuQkhgkznMo/efyksYpCgSdolHBVa
         BN73oKkbOYezCBipnAjxbwJIFvTjPL8y7QiKMATPmFU5HE7S5gQVsJjKRdg4BcufxqOa
         T7bwhJK89qZIthhQ/iNGHxSgKK8Pgfx92k8CVFaKTsACfOZYTRv/XeADVXNbCMaIx/Hf
         4Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1UL54kq9P3B03/zrEaHmiJVQdBboZhMIM+Kjok0NDY=;
        b=V+BJdoyQA6pZH9ClcBNrLk5cwcFUGdLaGBFbf9d/9vwZwgdw4LSk72ErSwWxbWzkFU
         qV2VCSihSUqYzZEOXGvLESc05QQgUWRaNPG41iJeO2dopqpIhkmc7gJnunFYOk+Br2o3
         +RVus/6yVhNSG6yXqgzL4H8564RnaVxyFAoPz+pjGhhLdsoVrh3hW0485rSK4xFNRkbS
         eqYbuQ2WPWJXXlBzMXG/+NgpDcra8xep+YFNUQVEgEzXvEOzWQU2PcG3u2ghJTjdxwza
         buFrPz0U/vxqb5yf9sUGoS9cHS+lPQvDNMJwRLkf8iQ2tbbLv2fPYGPQhXomP8igbSkn
         Oj4w==
X-Gm-Message-State: AOAM5308+bCC159JnC2roAsgNb2Ei+AW3ZaEmYiAUrFhiUl7cLUwiU31
        HAB+TI9u5zICxU5tClpQr3A=
X-Google-Smtp-Source: ABdhPJx6eIHRutchmLGiKkUgbUcc8PSZS2vs88kH6Qdf5R8BfIa1c+bA5sI1Af5TgvyeuP1StPY3aw==
X-Received: by 2002:a17:90a:f690:: with SMTP id cl16mr13519662pjb.164.1627305409475;
        Mon, 26 Jul 2021 06:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id c12sm12070869pfl.56.2021.07.26.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:16:49 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: Rename maxH to max_h in lynx_cursor
Date:   Mon, 26 Jul 2021 18:45:01 +0530
Message-Id: <692211000786d76aa41bc24d4ee06b5868d82771.1627304144.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627304144.git.benjamin.philip495@gmail.com>
References: <cover.1627304144.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The struct lynx_cursor has a member named maxH. This name is
CamelCase and is frowned upon. This commit renames it to max_h
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECK:

CHECK: Avoid CamelCase: <maxH>
116: FILE: drivers/staging/sm750fb/sm750.c:116:
+           fbcursor->image.height > cursor->maxH ||

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c237a8f8eb59..ee9ee2857f00 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -113,7 +113,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	cursor = &crtc->cursor;
 
 	if (fbcursor->image.width > cursor->maxW ||
-	    fbcursor->image.height > cursor->maxH ||
+	    fbcursor->image.height > cursor->max_h ||
 	    fbcursor->image.depth > 1) {
 		return -ENXIO;
 	}
@@ -723,8 +723,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.maxH = crtc->cursor.maxW = 64;
-	crtc->cursor.size = crtc->cursor.maxH * crtc->cursor.maxW * 2 / 8;
+	crtc->cursor.max_h = crtc->cursor.maxW = 64;
+	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.maxW * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 23eefd019ec9..5556208f7178 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -123,7 +123,7 @@ struct lynx_cursor {
 	int size;
 	/* hardware limitation */
 	int maxW;
-	int maxH;
+	int max_h;
 	/* base virtual address and offset  of cursor image */
 	char __iomem *vstart;
 	int offset;
-- 
2.31.1

