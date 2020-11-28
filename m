Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B096C63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B58221FD
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpRWLtnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgK1WmJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgK1WmI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:08 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF5C0613D3
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:28 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so10557551ljj.10
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zz+KNh/9JyMd3kn8YmCOwv7AijkhcR05hHUDJe6/qKc=;
        b=lpRWLtnUZVJogSjTFPoLRElm3AFWwS8Z1SXL/LOx65VzchjutIU1KBAJynonSnuboN
         u1/s24DjJCkNITKEr+uaKsF62sRBiotsOhskJShgB6NXB+aixblONp2CQI6jcXJniY2L
         vII4wT8soxgCpyDAWnhL0yc1yWPa/w+VaH84kNXJJLg+OZE2c7JnVeia9fb/fgxwvS+D
         RjX85tPOCEQtqUFws97IRBx5V2gqbkIWOsMQ+7QLgCu5Qxge/TfcNSTCo5aipa3n2U3S
         LnvjUTgQ0XJISHDe6OrmqU6lJpnTsiaP8e5IL14ra71dor8RoukacGJ+QVmd/ZDv1UPy
         GiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zz+KNh/9JyMd3kn8YmCOwv7AijkhcR05hHUDJe6/qKc=;
        b=b0EnPGlWAc4AEhvQZH775LsD5mUlUIOreO9YioEglcXswZHtn7+i7eRiTKh31qZSpt
         jkFiJzPn7EAmWzpxFjzWCrD9mOeoqMfRtJ2XunyC62niMU75n6hi3E04ZT5pLwlazmnd
         p7wgP9P96w8RTiWfj89uXQaiN7QzB65tgeApQlgLB8zAAXi5YmBPrLGnDpms2O0E9eWd
         OsZuHmH9zUdFLUVI79n7T7gCAUtQCgdNcLh+Fi/+dep6pnTEZ9vywAUlmjTHS3gWiSdh
         gttsDLGL62xCSrvvpKnZAwC3jAelOgKEJealAA3Zq/iPPS1I8oztfedk4klP+4UMA4S9
         76lA==
X-Gm-Message-State: AOAM532JN75revV/5hqd7g1MTg4Ro78NKsH2zYyGe4OEzgq5PGargz/2
        Yrks3+fsAiSz/kvoDpgpAiEAWleHFDzWow==
X-Google-Smtp-Source: ABdhPJz8UR5SyutdhYJr8/GasxQH3JX/eBxv59llfsuusbiLxoWjCHxswDvuGDD4yr+pCne/+Kytkg==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr6287385lji.460.1606603286769;
        Sat, 28 Nov 2020 14:41:26 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:26 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 02/28] video: fbcon: Fix warnings by using pr_debug() in fbcon
Date:   Sat, 28 Nov 2020 23:40:48 +0100
Message-Id: <20201128224114.1033617-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replacing DPRINTK() statements with pr_debug fixes set but not used
warnings.  And moves to a more standard logging setup at the same time.

v2:
  - Fix indent (Joe)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Peilin Ye <yepeilin.cs@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: George Kennedy <george.kennedy@oracle.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbcon.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bf61598bf1c3..44a5cd2f54cc 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -56,8 +56,6 @@
  *  more details.
  */
 
-#undef FBCONDEBUG
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
@@ -82,12 +80,6 @@
 
 #include "fbcon.h"
 
-#ifdef FBCONDEBUG
-#  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __func__ , ## args)
-#else
-#  define DPRINTK(fmt, args...)
-#endif
-
 /*
  * FIXME: Locking
  *
@@ -1015,11 +1007,11 @@ static const char *fbcon_startup(void)
 	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
 
-	DPRINTK("mode:   %s\n", info->fix.id);
-	DPRINTK("visual: %d\n", info->fix.visual);
-	DPRINTK("res:    %dx%d-%d\n", info->var.xres,
-		info->var.yres,
-		info->var.bits_per_pixel);
+	pr_debug("mode:   %s\n", info->fix.id);
+	pr_debug("visual: %d\n", info->fix.visual);
+	pr_debug("res:    %dx%d-%d\n", info->var.xres,
+		 info->var.yres,
+		 info->var.bits_per_pixel);
 
 	fbcon_add_cursor_timer(info);
 	return display_desc;
@@ -2013,7 +2005,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	    y_diff < 0 || y_diff > virt_fh) {
 		const struct fb_videomode *mode;
 
-		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
+		pr_debug("attempting resize %ix%i\n", var.xres, var.yres);
 		mode = fb_find_best_mode(&var, &info->modelist);
 		if (mode == NULL)
 			return -EINVAL;
@@ -2023,7 +2015,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		if (virt_w > var.xres/virt_fw || virt_h > var.yres/virt_fh)
 			return -EINVAL;
 
-		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
+		pr_debug("resize now %ix%i\n", var.xres, var.yres);
 		if (con_is_visible(vc)) {
 			var.activate = FB_ACTIVATE_NOW |
 				FB_ACTIVATE_FORCE;
@@ -3299,8 +3291,7 @@ static void fbcon_exit(void)
 
 		if (info->queue.func)
 			pending = cancel_work_sync(&info->queue);
-		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
-			"no"));
+		pr_debug("fbcon: %s pending work\n", (pending ? "canceled" : "no"));
 
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i) {
-- 
2.27.0

