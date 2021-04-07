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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E08DC43462
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF816139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbhDGGot (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349149AbhDGGoP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:44:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA73EC06174A;
        Tue,  6 Apr 2021 23:44:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c204so8437642pfc.4;
        Tue, 06 Apr 2021 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pz+9qnXlLq6MG0RWGwUAYrEGLB2Ibvwg3U+XKwAVHAY=;
        b=hPz0Vr/0FNjH/shaPI4Kf6Q+NrMh3PzQxZZ4llx2LvOsULhzpXrut83oD4Dq/M+lPx
         v3/fO8S4rXvbjfzn1kq+8AACkWIncAe1YGk2p0TrB7AxSA9ejUfK1ULtU/UX8AaC4tgN
         Gpd/j5teDfVYuR8AnMBTtjGlndYTVAlVWmSBXI1E/gRQdtr1nBGx2KDn4Izgf8TrvoRi
         lIdjCEJfPSwGt0S3PZxQ0w9tGNqrnbnrVQKn7SPKPph0Q0x8FS+IeRPF4OZJJm1R/a6f
         t1ZPZeMEQg2soVzCgab/IIz8TjsLKIhFOGwJ4E5g74H2oRS9bKEsdCLJZTgzCYq9aBPu
         b4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pz+9qnXlLq6MG0RWGwUAYrEGLB2Ibvwg3U+XKwAVHAY=;
        b=tY/RDW/WnjeEggALJbVqTjkOAjOjWX6IT8rAGy51CODQwg5A26EbRAii5UHhG1uUQX
         FlVrDL4oWVUQ/Ut3UmXIDAB2pJlZ2ZGEvES7XSUZRrovwoPxqQIoiJuTp9phd03C6lZR
         xm0MS8wpEOucDZMtvx5gvHRtt2tAFGsZ81JXbrOthrd/kJGMz6eYVZpcacq7uQzPRNCQ
         gUyimHsNbc+NFoZA5DWagnrU1kiPrL3Dl9PUTytEhoz05vpm0Ge7b6OHJtzJ6rGJqjY/
         cpi2wLEiuTGxYSwQG65ZVEXpPWMFV2tKCN3G9hqMAVyVv38/kwhwEjS9WZUFoK/tnjrm
         VdOg==
X-Gm-Message-State: AOAM530RJ4KgSEe6rv+VH5ZyuZQTq8GVwM36fKDZQLSqC1osZjowWTrt
        ZbWWSHZa4QTmVCcDjVrCbo8=
X-Google-Smtp-Source: ABdhPJyvKlMC+j+4Xu3mfNkUoacARCr1TNNehDyvHlblMJewcOT5lLqeYU7xYDIEb/n9xvEg5gx+pQ==
X-Received: by 2002:aa7:858e:0:b029:1f1:5df2:1f70 with SMTP id w14-20020aa7858e0000b02901f15df21f70mr1607759pfn.46.1617777845296;
        Tue, 06 Apr 2021 23:44:05 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id s76sm20749146pfc.110.2021.04.06.23.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:44:04 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:44:03 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/49] staging: sm750fb: Rename function
 sm750_hw_cursor_setSize to snake case
Message-ID: <976e2df443f81ca1433b742621651425aac43e2e.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
sm750_hw_cursor_setSize.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4f5f68e6aa60..eeba12f4b267 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -120,7 +120,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_setSize(cursor,
+		sm750_hw_cursor_set_size(cursor,
 					fbcursor->image.width,
 					fbcursor->image.height);
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 43e6f52c2551..d5ef40b8bc8e 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -58,7 +58,7 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd61ed..edeed2ea4b04 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,7 +5,7 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-- 
2.30.2

