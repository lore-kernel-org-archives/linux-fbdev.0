Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BEC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355035AbiBHWXP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386748AbiBHVI5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5379C0612BA
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i15so609894wrb.3
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCYS5QyMNkkwqTDkShTEbfPtwnFmBXM7JP7Pazg2YKM=;
        b=kTDETVVLcYRtMjjA8LySpUTc6zRE3ZqOVKlYdUkFPag87WIkrPWX47b+Rb5Gehv3cR
         LO/YoTPo1B1XpGaBAzdpwQ20SF/lTTiXX0i09lBUwufoAO3uAsw/1GqRYGbBpFouLnMs
         kFt72PsgGfZ5DstDIs4E5PvzoMLE0yCbrB9+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCYS5QyMNkkwqTDkShTEbfPtwnFmBXM7JP7Pazg2YKM=;
        b=nMavJRLglSEFqyd7XI4zv1eTCoIqYoCGVXGrKODsPNaTl/sW7UD+WkU7thoj0Y5JqK
         TlbeszqdwrWtPE06JIzDCR2FdSPt2medcd+agV6tBkiNRuN4b0UrT1nD0XNhXpvaK5cR
         9LvFiDg/ahsbELS8F8lwvNfhrilUTPaDNCc4+9GE0PeepNMK/8IvwaVzF5ArXnDdH3F1
         hWnoKlJItJCrOdP7A3vnWe+Zyvhdo/BsAdw+oSL/JIfex3jutaXpt1I755l905iNi+04
         xrNOMOvgQNUQEYZIT4oO80caZBWqGyr8TTae2dDuHM1ThV+fLeMq9HZAgb9IQgJlsPUu
         YcsA==
X-Gm-Message-State: AOAM532BA4+AHhEH8zmgftGeL5IU80znC1aZV3ySewIWJ5zgaPBt0xnW
        qNPsJA+u98mzrTVOshu9d61nSA==
X-Google-Smtp-Source: ABdhPJzoozBk4sCtvPwFCt7Ns2n0EIlD3c2Oag8W2C4RKf4YDquTma29XshfY3LkS6cE7lgaMjCoTA==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr5008752wrr.141.1644354535375;
        Tue, 08 Feb 2022 13:08:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:54 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 16/19] fbcon: untangle fbcon_exit
Date:   Tue,  8 Feb 2022 22:08:21 +0100
Message-Id: <20220208210824.2238981-17-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
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

To answer a question from Sam just quoting my own reply:

> We loose the call to fbcon_release_all() here [in fb_console_exit()].
> We have part of the old fbcon_exit() above, but miss the release parts.

Ah yes that's the entire point of this change. The release_all in the
fbcon exit path was only needed when fbcon was a separate module
indepedent from core fb.ko. Which means it was possible to unload fbcon
while having fbdev drivers registered.

But since we've merged them that has become impossible, so by the time the
fb.ko module can be unloaded, there's guaranteed to be no fbdev drivers
left. And hence removing them is pointless.

v2: Explain the why better (Sam)

Acked-by: Sam Ravnborg <sam@ravnborg.org>
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
index 685b4a9e5546..944f514c77ec 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -187,7 +187,6 @@ static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 			      int line, int count, int dy);
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
-static void fbcon_exit(void);
 
 static struct device *fbcon_device;
 
@@ -1146,6 +1145,27 @@ static void fbcon_free_font(struct fbcon_display *p, bool freefont)
 
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
@@ -1185,7 +1205,7 @@ static void fbcon_deinit(struct vc_data *vc)
 		set_vc_hi_font(vc, false);
 
 	if (!con_is_bound(&fb_con))
-		fbcon_exit();
+		fbcon_release_all();
 
 	if (vc->vc_num == logo_shown)
 		logo_shown = FBCON_LOGO_CANSHOW;
@@ -3296,34 +3316,6 @@ static void fbcon_start(void)
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
@@ -3363,10 +3355,19 @@ static void __exit fbcon_deinit_device(void)
 
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
2.34.1

