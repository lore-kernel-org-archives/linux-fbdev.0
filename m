Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8898C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358666AbiAaVIy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380447AbiAaVHE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:07:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EFFC061758
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r7so11185039wmq.5
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR2Cpj9NPzd3PMXMumK8tGjLNRzMjrUh58YqCebhDEo=;
        b=ZXAAWHU3cxYjQqaynKuzlDitJZki2ld78sfGg5BvoOXCxWUICbZVwllmG72oQjrJqV
         MFAF6FjmGHluZ4RcYolzuSjzNn2P05ro9f3pwcZjHwx7b9I20PuWxiFZLgb3boxLRRsu
         DLoJLArEnqol2fPTAyDdyu3SOHyLveDYE6buc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR2Cpj9NPzd3PMXMumK8tGjLNRzMjrUh58YqCebhDEo=;
        b=IZ+WLFe46BrzG1y2zcY7nVM4sSiS6CBoe6l8reZbGLiYgTFL5/ieWmlJ3EbuPYfqvs
         hVl3D50cvQvFeLdxfu6h17+GNvSMh35Xm03YKFtHfXPlIO9+Wq7RVGMJxZdGHP/iTFIr
         uOiuCGaukKAk5GZ/ybuBvy1Nzqp81zZbQ5yxMjclpcN364nP12EGH5UM2m1CQhpSNmg2
         U5h7LzqULrCX1WDEJrmq9Do2GVuHZ+d2hfNT64T3NtsvlIweUIT0qPR/aJTKF+KsST9/
         yW5r6dSvlo1oOT8UtjiUBaK/152cSwAcZR2uHY1F7wkMkGv/elVRd7pom5uZ7IlC4ZgZ
         SuPA==
X-Gm-Message-State: AOAM530MVAW/hfd6ByhYB03vwJ1ugpzlHpQ54eVmIOADmUf1sxjjE4FF
        QMkLAB/wwyNS6+BBItuQJlCkbg==
X-Google-Smtp-Source: ABdhPJwsHKFlXJjctslIwLzw0eq71bo0GChWx/OaKsX1kI+rSPX9G1EgnGiUQOnkpJ2lxJyTJPvEfw==
X-Received: by 2002:a05:600c:38a:: with SMTP id w10mr23340953wmd.12.1643663211423;
        Mon, 31 Jan 2022 13:06:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:51 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 18/21] fbcon: untangle fbcon_exit
Date:   Mon, 31 Jan 2022 22:05:49 +0100
Message-Id: <20220131210552.482606-19-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There's a bunch of confusions going on here:
- The deferred fbcon setup notifier should only be cleaned up from
  fb_console_exit(), to be symmetric with fb_console_init()
- We also need to make sure we don't race with the work, which means
  temporarily dropping the console lock (or we can deadlock)
- That also means no point in clearing deferred_takeover, we are
  unloading everything anyway.
- Finally rename fbcon_exit to fbcon_release_all and move it, since
  that's what's it doing when being called from consw->con_deinit
  through fbcon_deinit.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/fbcon.c | 63 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5c14e24d14a1..22581952b4fd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -185,7 +185,6 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 			   int unit);
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
-static void fbcon_exit(void);
 
 static struct device *fbcon_device;
 
@@ -1149,6 +1148,27 @@ static void fbcon_free_font(struct fbcon_display *p, bool freefont)
 
 static void set_vc_hi_font(struct vc_data *vc, bool set);
 
+static void fbcon_release_all(void)
+{
+	struct fb_info *info;
+	int i, j, mapped;
+
+	for_each_registered_fb(i) {
+		mapped = 0;
+		info = registered_fb[i];
+
+		for (j = first_fb_vc; j <= last_fb_vc; j++) {
+			if (con2fb_map[j] == i) {
+				mapped = 1;
+				con2fb_map[j] = -1;
+			}
+		}
+
+		if (mapped)
+			fbcon_release(info);
+	}
+}
+
 static void fbcon_deinit(struct vc_data *vc)
 {
 	struct fbcon_display *p = &fb_display[vc->vc_num];
@@ -1188,7 +1208,7 @@ static void fbcon_deinit(struct vc_data *vc)
 		set_vc_hi_font(vc, false);
 
 	if (!con_is_bound(&fb_con))
-		fbcon_exit();
+		fbcon_release_all();
 
 	if (vc->vc_num == logo_shown)
 		logo_shown = FBCON_LOGO_CANSHOW;
@@ -3316,34 +3336,6 @@ static void fbcon_start(void)
 #endif
 }
 
-static void fbcon_exit(void)
-{
-	struct fb_info *info;
-	int i, j, mapped;
-
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
-	if (deferred_takeover) {
-		dummycon_unregister_output_notifier(&fbcon_output_nb);
-		deferred_takeover = false;
-	}
-#endif
-
-	for_each_registered_fb(i) {
-		mapped = 0;
-		info = registered_fb[i];
-
-		for (j = first_fb_vc; j <= last_fb_vc; j++) {
-			if (con2fb_map[j] == i) {
-				mapped = 1;
-				con2fb_map[j] = -1;
-			}
-		}
-
-		if (mapped)
-			fbcon_release(info);
-	}
-}
-
 void __init fb_console_init(void)
 {
 	int i;
@@ -3383,10 +3375,19 @@ static void __exit fbcon_deinit_device(void)
 
 void __exit fb_console_exit(void)
 {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+	console_lock();
+	if (deferred_takeover)
+		dummycon_unregister_output_notifier(&fbcon_output_nb);
+	console_unlock();
+
+	cancel_work_sync(&fbcon_deferred_takeover_work);
+#endif
+
 	console_lock();
 	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
-	fbcon_exit();
+
 	do_unregister_con_driver(&fb_con);
 	console_unlock();
 }	
-- 
2.33.0

