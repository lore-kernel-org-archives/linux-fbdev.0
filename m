Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29044C63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F0220809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abL3wWcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgK1C2q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262DBC0613D4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:23 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id z1so7131170ljn.4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekXPc5E7Fh5wD/Vc411Zf73OtfZn7TTfUSuqDZSxDOI=;
        b=abL3wWcvsvIz2CzO/LLQDCf6XcLh3onTjaMFDbGE74/YxhdMd5qgru9TxPx1XN+iwj
         uvlGQppWRm4tryk0y+YoqhT1zyKdQHFNHWdbwFnhNiLbPBWzLDb2Q4lL5/fNiKgNuGK3
         qieT5nqi1qzBx9lSmNch74YLkmKW1LSxDX3omn3t33/G7J+bEEoNXDod3xPQOoffnTlC
         UOs2GrcWE2DMYOkzM6z5qM0FmTWCvRFzHnn/yP/XWrevQjm19rxNz5m5bh3rApNBsDTS
         UFW+++W0JdwSqoLqjua+cPbmHpauD1O2T5YtvRC7PECiKQkPylu3MlvlSjPYnA+FjUq2
         qUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ekXPc5E7Fh5wD/Vc411Zf73OtfZn7TTfUSuqDZSxDOI=;
        b=B8tfqr22z07Tb9+2Q6lVJcL6thOirqLGACP9IULURp92FRy/6kDzewTjiQy7jXLikk
         CP1Fq3GR+xsg+UeyylafXySHP/WkooFSoefLAxQWaXT9uavmupAxVDCSJ9ILAHhC3cSv
         FFA9+nfRF3xR4EvKQgT8tofvFCMowbpbUaww4yl0AIz9oVYNFjKMqZqwJPiXQpaeFk5+
         ANPW99DAxPttlZ5xzNyh+2o3j6wVyhpNT5aOy3oDtYvKrH2X/RZ7bNK0myugks3LYSmE
         EJB6zY5LFk8vrZPOyZp0P/DSDCpu1MYxxuKv7f5gV8uBaRkEOLsYQy7Gbd17ILUWEDE6
         GHiw==
X-Gm-Message-State: AOAM532G+rIZatxJ4ET85gB1+1mInMk7+kNreGZ2N+irecpEgd9azcr0
        2SiDxClX14EBxrLKH1mqWi4+CuFxaNySE8rA
X-Google-Smtp-Source: ABdhPJyOyRLSvkVpVR1HEUfAKSuZ5ePdfs+N0TGYeMdvRv4fmzf7VQ4BrA1YQM7s6/4t3ORr021/gQ==
X-Received: by 2002:a2e:80c4:: with SMTP id r4mr4469451ljg.284.1606507161441;
        Fri, 27 Nov 2020 11:59:21 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:20 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
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
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
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
Subject: [PATCH v1 18/28] video: fbdev: mx3fb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:15 +0100
Message-Id: <20201127195825.858960-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings:
- Fix kernel-doc
- Drop unused code/variables

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mx3fb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 894617ddabcb..fabb271337ed 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -445,7 +445,6 @@ static void sdc_enable_channel(struct mx3fb_info *mx3_fbi)
 static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 {
 	struct mx3fb_data *mx3fb = mx3_fbi->mx3fb;
-	uint32_t enabled;
 	unsigned long flags;
 
 	if (mx3_fbi->txd == NULL)
@@ -453,7 +452,7 @@ static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 
 	spin_lock_irqsave(&mx3fb->lock, flags);
 
-	enabled = sdc_fb_uninit(mx3_fbi);
+	sdc_fb_uninit(mx3_fbi);
 
 	spin_unlock_irqrestore(&mx3fb->lock, flags);
 
@@ -732,7 +731,7 @@ static int mx3fb_unmap_video_memory(struct fb_info *fbi);
 
 /**
  * mx3fb_set_fix() - set fixed framebuffer parameters from variable settings.
- * @info:	framebuffer information pointer
+ * @fbi:	framebuffer information pointer
  * @return:	0 on success or negative error code on failure.
  */
 static int mx3fb_set_fix(struct fb_info *fbi)
@@ -740,7 +739,7 @@ static int mx3fb_set_fix(struct fb_info *fbi)
 	struct fb_fix_screeninfo *fix = &fbi->fix;
 	struct fb_var_screeninfo *var = &fbi->var;
 
-	strncpy(fix->id, "DISP3 BG", 8);
+	memcpy(fix->id, "DISP3 BG", 8);
 
 	fix->line_length = var->xres_virtual * var->bits_per_pixel / 8;
 
@@ -1105,6 +1104,8 @@ static void __blank(int blank, struct fb_info *fbi)
 
 /**
  * mx3fb_blank() - blank the display.
+ * @blank:	blank value for the panel
+ * @fbi:	framebuffer information pointer
  */
 static int mx3fb_blank(int blank, struct fb_info *fbi)
 {
@@ -1126,7 +1127,7 @@ static int mx3fb_blank(int blank, struct fb_info *fbi)
 /**
  * mx3fb_pan_display() - pan or wrap the display
  * @var:	variable screen buffer information.
- * @info:	framebuffer information pointer.
+ * @fbi:	framebuffer information pointer.
  *
  * We look only at xoffset, yoffset and the FB_VMODE_YWRAP flag
  */
@@ -1387,6 +1388,8 @@ static int mx3fb_unmap_video_memory(struct fb_info *fbi)
 
 /**
  * mx3fb_init_fbinfo() - initialize framebuffer information object.
+ * @dev: the device
+ * @ops:	framebuffer device operations
  * @return:	initialized framebuffer structure.
  */
 static struct fb_info *mx3fb_init_fbinfo(struct device *dev,
-- 
2.27.0

