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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD44C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4906761222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbhDGGou (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349237AbhDGGoa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:44:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E7EC06174A;
        Tue,  6 Apr 2021 23:44:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so769336pjb.4;
        Tue, 06 Apr 2021 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ghbx7FFI/xOaeHs+49tMcMS7V7bwU5Z4Exh4f7xVL44=;
        b=ZHdV5aLw9zBBixfk7lns3j+uLp+fE+jfpBzCQ7bZd5CYr2EuneKFIuLHqTifVnaucL
         zGdPcDW+nNelVgeqB7W8oUdMFsYRpxCrBkIOM8VgAaFX5CXzWK68BSVrTEKrts7X1Yd/
         EamanSujTxwKs4BQr5XQv69wV+v6gstaNlTCKO4E0G/a86co5dtRz0ZCS+1J0V/v6VDi
         YqQwY0uVAAbtBURfKhkp0yl0fE/7M8It5+XQi0t1fWA6q50lvULYRLfdzxIbEU/bX12V
         QyZMUMJNXFT8i5Dztf04m48S8EeXSE9mQCvAp2KUuNguhx5kjLdP0ltHdpMdn7QZSLGZ
         RqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ghbx7FFI/xOaeHs+49tMcMS7V7bwU5Z4Exh4f7xVL44=;
        b=EyOVJPJ9S6Zmpv9hLM5/3mwqgE6Tis8JatVUc85PsWlMr6XqqOmf0zuj/4slv3I7Tj
         4kK0ZYWzuszW02DvLGx5QF7hW7+jS6SivoQYIwT+ZqGrezDPtJNGt4WwKjLRnEtppVsV
         QJI2oB0gzYpWsOJdgcjLa0mCyu5Pan1YEMl5wwC9ttE6l4KIgIBjJSbcfWOkeU11nqHL
         X0NOCDQR7lB1+PJI0suXF1JhRUe0esaExNDj7tesp9AGticqevMCWx62D7/Jw9m/19ud
         LVLEEJRx1xCq/6rJzdMpcukD5pUyEhBY2ZovBBu4jZZqpHymax3ozu1oDsDa1ATUATzr
         e7Pw==
X-Gm-Message-State: AOAM533eIEFo/gBrI8nX9YZGUJjiN6ZRlWUqAHYyKLuE0to5bvn9X5MG
        PuVZ5gNGu09aU+/e2TVleRU=
X-Google-Smtp-Source: ABdhPJwMUnBvkzFOlvRo36+9JXfDTHckBHyQhlezB7Mo3oGKjr3aI+4SImJApI+xreybVO67UNt6lA==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mr1936031pjw.159.1617777861339;
        Tue, 06 Apr 2021 23:44:21 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id x18sm3809410pfi.105.2021.04.06.23.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:44:20 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:44:18 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/49] staging: sm750fb: Rename function
 sm750_hw_cursor_setColor to snake case
Message-ID: <453d3058e041eb99492ea0bc85956ecf8cc47129.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
sm750_hw_cursor_set_color.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index b76d3d40969a..d93884f9da7f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -141,7 +141,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		sm750_hw_cursor_setColor(cursor, fg, bg);
+		sm750_hw_cursor_set_color(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 0ba80e086415..ac83ead1c5bc 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -73,7 +73,7 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 	poke32(HWC_LOCATION, reg);
 }
 
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index d0ade8e366f4..edfa6a8202cd 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -7,7 +7,7 @@ void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 			     const u8 *data, const u8 *mask);
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-- 
2.30.2

