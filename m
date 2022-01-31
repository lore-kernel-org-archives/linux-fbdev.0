Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D3C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379754AbiAaVH1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379942AbiAaVGv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F96C061765
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s18so27876679wrv.7
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgnSdd2AvfoeNcByN2bDHp+PhpIRGYatmO8U9PanFuc=;
        b=S+8VBUNNneiGc1+bGPSnrLBcbuVFkgKSU1F9WHEKGEhoPtQNo9kYEWH32/VdEJ10IN
         +9JFlSujzOM4Bw11VzRyD+o6Ay/zYtaJDCVsEreNhW23/UsII4y11JSGXkMSZ5oO87vf
         awGxIE+pHd6B7RDP848NhmOIATd3HdslcGwVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgnSdd2AvfoeNcByN2bDHp+PhpIRGYatmO8U9PanFuc=;
        b=L/k4oQbrf9WgpFxe6ME74tH6LMc/xJowMVbpZIVEmmLhWRGBj1w3EI2WZ/6qqemQQF
         1sjwUPLRifyXd/3Utd7vOe/ouT7b8Oa9C7agevKsj2IJr/BrFEjaay20xx5s/ZOJBPRY
         ZqaoqwX8InVmgeRh4qAUkozIvoLsuXV6r2C5DT+hK3YubxEmwXekicVkTQEQI5SLOxs2
         ie/ehaIqjUm6kfXXAxS01VXKS6j096uuh/nB8gB94k+DEuRe6WUQrYGYcgxkt9Pf2I6R
         56HLPsIO/xZgBKcC79zk2jF1R2Ebj9uDmTyJlJ1I7oHs45Id2a9ygYP448bsum9UVJKr
         mGgw==
X-Gm-Message-State: AOAM5337r50sXOBnhbyLRfZYbH4UCCEbOTy6x8hQh+w6XlRAUHhQjtKL
        7J7uXQpAuH4qULrJqvwVlbjKLg==
X-Google-Smtp-Source: ABdhPJzMRGhgP+Wd468RY30pZW2pKS4gWFtsBggDBPv5aBnxBsUkCxh6leO3bSHMlVVRxYvL1JzDCg==
X-Received: by 2002:a5d:4b4d:: with SMTP id w13mr19360147wrs.640.1643663206862;
        Mon, 31 Jan 2022 13:06:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:46 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>
Subject: [PATCH 13/21] fbcon: move more common code into fb_open()
Date:   Mon, 31 Jan 2022 22:05:44 +0100
Message-Id: <20220131210552.482606-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

No idea why con2fb_acquire_newinfo() initializes much less than
fbcon_startup(), but so be it. From a quick look most of the
un-initialized stuff should be fairly harmless, but who knows.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 74 +++++++++++++-------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b83a5a77d8a8..5a3391ff038d 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -680,8 +680,18 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
 
 #endif /* CONFIG_MISC_TILEBLITTING */
 
+static void fbcon_release(struct fb_info *info)
+{
+	if (info->fbops->fb_release)
+		info->fbops->fb_release(info, 0);
+
+	module_put(info->fbops->owner);
+}
+
 static int fbcon_open(struct fb_info *info)
 {
+	struct fbcon_ops *ops;
+
 	if (!try_module_get(info->fbops->owner))
 		return -ENODEV;
 
@@ -691,19 +701,22 @@ static int fbcon_open(struct fb_info *info)
 		return -ENODEV;
 	}
 
-	return 0;
-}
+	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+	if (!ops) {
+		fbcon_release(info);
+		return -ENOMEM;
+	}
 
-static void fbcon_release(struct fb_info *info)
-{
-	if (info->fbops->fb_release)
-		info->fbops->fb_release(info, 0);
+	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
+	ops->info = info;
+	info->fbcon_par = ops;
+	ops->cur_blink_jiffies = HZ / 5;
 
-	module_put(info->fbops->owner);
+	return 0;
 }
 
 static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
-				  int unit, int oldidx)
+				  int unit)
 {
 	struct fbcon_ops *ops = NULL;
 	int err;
@@ -712,27 +725,10 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 	if (err)
 		return err;
 
-	if (!err) {
-		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-		if (!ops)
-			err = -ENOMEM;
-
-		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
-	}
-
-	if (!err) {
-		ops->cur_blink_jiffies = HZ / 5;
-		ops->info = info;
-		info->fbcon_par = ops;
-
-		if (vc)
-			set_blitting_type(vc, info);
-	}
+	ops = info->fbcon_par;
 
-	if (err) {
-		con2fb_map[unit] = oldidx;
-		fbcon_release(info);
-	}
+	if (vc)
+		set_blitting_type(vc, info);
 
 	return err;
 }
@@ -840,9 +836,11 @@ static int set_con2fb_map(int unit, int newidx, int user)
 
 	found = search_fb_in_map(newidx);
 
-	con2fb_map[unit] = newidx;
-	if (!err && !found)
-		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
+	if (!err && !found) {
+		err = con2fb_acquire_newinfo(vc, info, unit);
+		if (!err)
+			con2fb_map[unit] = newidx;
+	}
 
 	/*
 	 * If old fb is not mapped to any of the consoles,
@@ -939,20 +937,10 @@ static const char *fbcon_startup(void)
 	if (fbcon_open(info))
 		return NULL;
 
-	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-	if (!ops) {
-		fbcon_release(info);
-		return NULL;
-	}
-
-	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
-
+	ops = info->fbcon_par;
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
-	ops->cur_blink_jiffies = HZ / 5;
-	ops->info = info;
-	info->fbcon_par = ops;
 
 	p->con_rotate = initial_rotation;
 	if (p->con_rotate == -1)
@@ -1022,7 +1010,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
+		con2fb_acquire_newinfo(vc, info, vc->vc_num);
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.33.0

