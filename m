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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FC3C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84F96056C
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhGZMgZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhGZMgY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 08:36:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CDC061757;
        Mon, 26 Jul 2021 06:16:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so19678627pja.5;
        Mon, 26 Jul 2021 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKvZR1AeK2etahyjDlfPtU4YJhGm6x6glPkXtI2NAaA=;
        b=U49J3pSHmtIMW1xIjiWIVxKFZVdv3/nZj+kjYNwd+XzjiEBNcgR6D9uEejSxV8dlV5
         DOYTj2IWgewXV0QfFt62n7M3NWkBlI23QkFQlUppFr1yTrPWVbYUHcYUg3To6rLWIMZD
         1bkCnE2vo5b+Gvy/kQhzFYZZ45jfxUAiNyEnQndSNL8Y97TzqaBajnuTweTmlOEoyRjn
         +OMTtlhp8sv5dzWwRpN2PVleFxFhM2g1S8OiiwweXL2N6OrWXTlpraX+wd4TZ7yxmyra
         326BsyL2OwpLximb/BPRcHi3ho39b88lnECYhbcUAqyRT84NOlRF7U+dSb1eE6BezqCz
         aZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKvZR1AeK2etahyjDlfPtU4YJhGm6x6glPkXtI2NAaA=;
        b=Opb+wfsYYM2Uz52xVdKcFPxCgJLaiRCUwzqb7CaLAA1+BXoXp111Kwqxld4GcQ8KuB
         RdPo+H5McR1kxhgZsf5PjUhQ0Du5JnFUuUoIHuSYeGfbanA2b2kdK9I27+E4Y/K6TaFQ
         5K55U5B/k+53rMr38qFols6p70wHq5rfQU1FbTKA9ZBawrCQIsohjyF3de/1FDQeneFn
         ZOraJXWWXxidFEgCfZRCLzMT5rcdr00BTuZZMoVzjIL6NO04K6G3Eb8C13O3pP+BZF8s
         pl6O/eQdVcTT7yk4yMUl5fRAqYr7XKhAvny/76Kp1MLww/D0gUfPs33mU3c7bkiIKSqq
         TPOg==
X-Gm-Message-State: AOAM532/t61VuE2rG32CV+fjP8eTe2OKdPvwKEIehezH3usi/N8iew8w
        7bc7x5sq7640F4jfr7rh0Bw=
X-Google-Smtp-Source: ABdhPJxwY1HAUM1CXV+EQT5VI+spGgh/AfS/lkrXy6Bnrcax21qBEpAuoGxI5vqoF50Zajo4xxcNEQ==
X-Received: by 2002:a05:6a00:b46:b029:334:54db:af17 with SMTP id p6-20020a056a000b46b029033454dbaf17mr18049626pfo.26.1627305412250;
        Mon, 26 Jul 2021 06:16:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id c12sm12070869pfl.56.2021.07.26.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:16:52 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: Rename maxW to max_w in lynx_cursor
Date:   Mon, 26 Jul 2021 18:45:02 +0530
Message-Id: <c0c84569b155df7b510a505a86863987836e192d.1627304144.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627304144.git.benjamin.philip495@gmail.com>
References: <cover.1627304144.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The struct lynx_cursor has a member named maxW. This name is
CamelCase and is frowned upon. This commit renames it to max_w
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECK:

CHECK: Avoid CamelCase: <maxW>
115: FILE: drivers/staging/sm750fb/sm750.c:115:
+	if (fbcursor->image.width > cursor->maxW ||

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 6 +++---
 drivers/staging/sm750fb/sm750.h        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index ee9ee2857f00..4f5f68e6aa60 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -112,7 +112,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	crtc = &par->crtc;
 	cursor = &crtc->cursor;
 
-	if (fbcursor->image.width > cursor->maxW ||
+	if (fbcursor->image.width > cursor->max_w ||
 	    fbcursor->image.height > cursor->max_h ||
 	    fbcursor->image.depth > 1) {
 		return -ENXIO;
@@ -723,8 +723,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.max_h = crtc->cursor.maxW = 64;
-	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.maxW * 2 / 8;
+	crtc->cursor.max_h = crtc->cursor.max_w = 64;
+	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 5556208f7178..8271cf7c89f3 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -122,7 +122,7 @@ struct lynx_cursor {
 	int h;
 	int size;
 	/* hardware limitation */
-	int maxW;
+	int max_w;
 	int max_h;
 	/* base virtual address and offset  of cursor image */
 	char __iomem *vstart;
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
2.31.1

