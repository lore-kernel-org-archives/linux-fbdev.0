Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE88C64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2995720702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuXVD4U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgK1WnY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgK1WnY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:24 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8CC061A56
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:57 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id i17so10604929ljd.3
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUS2l8ow10S8HSMYNfPD1C147gZPvQOjrsInjizZFWo=;
        b=ZuXVD4U+vOHha9du/xh79eB8mXwGkHog3AcYCmOiX/kyAI0CkHLEW4enjKDEADRidd
         TEDCXyWF5O8L3obC0yEOfyv7VjYtT5EmyOXth8pyNpjR8iD+YMpeYLfMGXC2H+DIBzBf
         Z4XvUtva0NtPBnsOYAOpJ4N7uLjCl5fZItorbBSj/Qjir5m8IIKwCoEPaOX+826UL4bq
         pqXBJ/hdtIg19IZPJWrWPR7W3lQwOLMJADR5y9bMuFKcw0AwockLuPZgbW13duq6ezUN
         7kPQNGdRNwy6Pk5ZipS7fWaRqk/cctTHFv4Um1eRK1ATYLWt0wZppPuPWeprwXOhI22P
         i38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FUS2l8ow10S8HSMYNfPD1C147gZPvQOjrsInjizZFWo=;
        b=CgWgFP931cbt0HF+6ASUDmxfjrAxGY6fShSfRjskOe9wsJWgyuim4b1/m6UDsi9eVG
         oJ2JsFmg2IEFp3E2dk5IIuMe3xoXT2jUAXGqiSC6DNuDrY462P3PVtE8ft3wMxSNP2Jc
         rUHx2/WWN6ThsXOBajvYFN9yqK9iibgbC/lI6ei61IozaA2g/hKgufmoDEVtw8/6tE/P
         0F79wkuCgkjhpOaf0Usdy/3Hd5mqnJbpT+w7/pwK5XsHYZiqDfg+NMnntzHtUbOXs9fK
         cx599irq7TXlCP+TNkc+3mYTT6fB0bop+tB+7evHSFxngs4fdp705xmvMvbTATwGbctt
         9V0w==
X-Gm-Message-State: AOAM530Aekfi2mYuulG/Othw5YM6D6Ap/R+1nF1cFFbrIpus4l1UJ+KN
        /yYXT8KJIjxFLtcH9ayc94cLBCfZNnUNnA==
X-Google-Smtp-Source: ABdhPJwQp91sOBtClqT2B4BDuivw06O2VWWo97mJ17fzP30e5uvOsf2Sl/QfFQYeZZd1g8R+upOYhA==
X-Received: by 2002:a05:651c:48f:: with SMTP id s15mr6322341ljc.412.1606603316230;
        Sat, 28 Nov 2020 14:41:56 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:55 -0800 (PST)
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
Subject: [PATCH v2 18/28] video: fbdev: mx3fb: Fix kernel-doc, set but not used and string warnings
Date:   Sat, 28 Nov 2020 23:41:04 +0100
Message-Id: <20201128224114.1033617-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings:
- Fix kernel-doc
- Drop unused code/variables
- Use memcpy to copy a string without zero-termination
  strncpy() generates a warning

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
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

