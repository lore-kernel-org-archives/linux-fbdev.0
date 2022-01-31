Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B3C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380805AbiAaVHW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379932AbiAaVGu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F5C061763
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so27877257wra.4
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUTw8V7HxKRdtSwZCGcGzWOP5vCv7juYPfGf+0JDGh8=;
        b=hBV4RcKOE2SCL7MS+ukEqNHtEjxW2tHq5evpclBGbPiMqwnLYbPCte7oygeO4v0Sef
         u/qZlYiw6W5BbTfxyFYzHB5lY1Kiyzg+KXHPHlBlJh/atUWkOMB48ijEa8gfrnz3jalr
         WWgMhmyq10rjrF9MPc/QRAsQaSVeIG46o3N9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUTw8V7HxKRdtSwZCGcGzWOP5vCv7juYPfGf+0JDGh8=;
        b=RYv6Co7QY8juGq8S8zp3OUozbo4JfVYQQL6GaSaDg2AU0R9O35egkSeTMCZYy2nnKs
         Hq2/KuRvMf8PQeEWg2CGG7GSY4i37lG92whENXCkBTPwAxOwZKWGjK7qep5N5xaicSvC
         bfrXkzoURwIe0H8Sg5pAUCe9VJb2u9Z/EFgNKGsx0Wr7+7EcbFZJ/6moVjFAreOkjMYq
         c4rOmeKfO3steby8CF9zpvfKIyvrNrnvm6etwZ99KTB+wuSFNrGvskRle0Zkh4Bmx30T
         3qURH7x+Ho/XJnVUo4u0Zvrr1UHrhFU4E9UgFoFB9YXaOBEc8QPTu16mYc08bzIiBgB7
         O9lw==
X-Gm-Message-State: AOAM532KWDvi6kWi2qlBET1pwacEquBCfu6biPjUtYnQJwcW5/fw67nb
        KxXMxjrGeWm8UqrFM3uZU+fpPg==
X-Google-Smtp-Source: ABdhPJwFf0hltBLXnhPQNqmgPHTzrw+ymImbnDYnaTA7+jqQxU3KwwG7Ys6uUsKlWnGpdjnXw4/V4Q==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr19458575wrr.618.1643663205951;
        Mon, 31 Jan 2022 13:06:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:45 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 12/21] fbcon: Ditch error handling for con2fb_release_oldinfo
Date:   Mon, 31 Jan 2022 22:05:43 +0100
Message-Id: <20220131210552.482606-13-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It doesn't ever fail anymore.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/fbcon.c | 37 +++++++++++---------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index eea2ee14b64c..b83a5a77d8a8 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -737,9 +737,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 	return err;
 }
 
-static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
-				  struct fb_info *newinfo, int unit,
-				  int oldidx, int found)
+static void con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
+				   struct fb_info *newinfo)
 {
 	struct fbcon_ops *ops = oldinfo->fbcon_par;
 	int ret;
@@ -768,8 +767,6 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				"detected unhandled fb_set_par error, "
 				"error code %d\n", ret);
 	}
-
-	return 0;
 }
 
 static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
@@ -823,7 +820,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
-	int found, err = 0;
+	int found, err = 0, show_logo;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -852,18 +849,15 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	 * fbcon should release it.
 	 */
 	if (!err && oldinfo && !search_fb_in_map(oldidx))
-		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
-					     found);
+		con2fb_release_oldinfo(vc, oldinfo, info);
 
-	if (!err) {
-		int show_logo = (fg_console == 0 && !user &&
-				 logo_shown != FBCON_LOGO_DONTSHOW);
+	show_logo = (fg_console == 0 && !user &&
+			 logo_shown != FBCON_LOGO_DONTSHOW);
 
-		if (!found)
-			fbcon_add_cursor_work(info);
-		con2fb_map_boot[unit] = newidx;
-		con2fb_init_display(vc, info, unit, show_logo);
-	}
+	if (!found)
+		fbcon_add_cursor_work(info);
+	con2fb_map_boot[unit] = newidx;
+	con2fb_init_display(vc, info, unit, show_logo);
 
 	if (!search_fb_in_map(info_idx))
 		info_idx = newidx;
@@ -2786,7 +2780,7 @@ static inline void fbcon_unbind(void) {}
 /* called with console_lock held */
 void fbcon_fb_unbind(struct fb_info *info)
 {
-	int i, new_idx = -1, ret = 0;
+	int i, new_idx = -1;
 	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -2820,13 +2814,8 @@ void fbcon_fb_unbind(struct fb_info *info)
 			if (con2fb_map[i] == idx) {
 				con2fb_map[i] = -1;
 				if (!search_fb_in_map(idx)) {
-					ret = con2fb_release_oldinfo(vc_cons[i].d,
-								     info, NULL, i,
-								     idx, 0);
-					if (ret) {
-						con2fb_map[i] = idx;
-						return;
-					}
+					con2fb_release_oldinfo(vc_cons[i].d,
+							       info, NULL);
 				}
 			}
 		}
-- 
2.33.0

