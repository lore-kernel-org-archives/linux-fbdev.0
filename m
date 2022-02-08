Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA32C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386705AbiBHWXw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386724AbiBHVIu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9AC0612B8
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so2043631wml.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jcZhW240q/V+F937iAT51+jAJ4wMTWthnKOU1oFwYY=;
        b=RvN9RXsH98HQ7R4ASK94Wa721S7v3e9uYupFyjpxCVnHmyUZk9Z0e0fiSif0AsX195
         hJ8mBsbov8YE3ijlPln772kRVM7ChshKzGAhsKXYeIBbkNk0RX0OB2TONi3m39pCKQhc
         m8pJ7WEZ//h8h6RloxQYTj4Gg7Q9rT68dL5eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jcZhW240q/V+F937iAT51+jAJ4wMTWthnKOU1oFwYY=;
        b=FiFPixzJ6/b/3J92hgCzapEN9ORtmPT5wCsd+6tDCU+haZ6VuZUsPaR1InDjv488do
         I+u3DjtT5dyX1oWMsQ57lC7t8uwICYiVUHsU8fNMzj0CPtkQfXQqnLBpxlIhd9Ax+cf3
         t7i5UlCtzDhx5A2KMMEz1ZXfiIvQbzd2QgCwV+JcWIXMPzDF4lIH7Qp2mgTILf3Qcw88
         AKBvJuEAOlyIcsz5jV4rJugqWw3lZLGH5dIa1bFixxdX+psDTUIIPcizUiK9J3bhQKIS
         bDCjNA5hI2rPZSM9QNj862SxOCcK87clAvm8WFdtu2E4TX4c43gwFJBVZTosKWXVlYil
         RApQ==
X-Gm-Message-State: AOAM532wHzKTNdt4ynwaLerBkoJY3kHqjHoguTMm3Z4pq5Hvqu+GyN29
        oeaW53g/au5emkRmyMlaVIBdsXvwZLTXYQ==
X-Google-Smtp-Source: ABdhPJwMORQTpYifpLCGD22BDyRns4eEbj+NoYV/5vmbXl7M9Sj9oFb03bz6IHoMsQGBTHnNyzmopg==
X-Received: by 2002:a05:600c:3848:: with SMTP id s8mr2565869wmr.151.1644354527869;
        Tue, 08 Feb 2022 13:08:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:47 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 10/19] fbcon: Ditch error handling for con2fb_release_oldinfo
Date:   Tue,  8 Feb 2022 22:08:15 +0100
Message-Id: <20220208210824.2238981-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It doesn't ever fail anymore.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
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
index 3e1a3e7bf527..a60891005d44 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -739,9 +739,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
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
@@ -770,8 +769,6 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				"detected unhandled fb_set_par error, "
 				"error code %d\n", ret);
 	}
-
-	return 0;
 }
 
 static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
@@ -825,7 +822,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
-	int found, err = 0;
+	int found, err = 0, show_logo;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -854,18 +851,15 @@ static int set_con2fb_map(int unit, int newidx, int user)
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
@@ -2769,7 +2763,7 @@ static inline void fbcon_unbind(void) {}
 /* called with console_lock held */
 void fbcon_fb_unbind(struct fb_info *info)
 {
-	int i, new_idx = -1, ret = 0;
+	int i, new_idx = -1;
 	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -2803,13 +2797,8 @@ void fbcon_fb_unbind(struct fb_info *info)
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
2.34.1

