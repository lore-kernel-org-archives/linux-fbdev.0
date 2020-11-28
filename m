Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51155C83012
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E03720771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSratFFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgK1Wm7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgK1Wm6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878BC061A55
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:56 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so12752100lfr.7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GX2d3CpgxJM36tqAcji4TF9AW0tELXUqa0FefTGKGkc=;
        b=WSratFFtrte4qjUbFg8xQAA6BVPAs2IyKsqMRnOQIDQGIrk/QEfbf7vQoIG+F6PFaE
         bHL2xZGJ53KoPsk5eeebn/EiGEL+0sQSATGEmLvqEf+OOaTz4qIuw0uStP36H2j8vzAx
         CqyoivsQCZFEqCmF7d5P4m+nJ5NxUSid3rmiuEyyaUn4E6z0TPGzGV0AgxE9PVVRmK0S
         ePHRG/qTw3Fq5fQy98aQauwSWFh1AyaJH4gB/wdxu0iPJxcBLMywNhlr9MkTG1FXPylN
         5B4ih+9iS9tBFHM7TBLFYfQ/q0SE9yK/M6c78cAHKoX1880iGpjeWywLXJSGegnCFnDc
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GX2d3CpgxJM36tqAcji4TF9AW0tELXUqa0FefTGKGkc=;
        b=bzN0KG4QaShm8lxSJAJo7331E3TbWV/j6JtIdjpm7UR6EkjBb9JFgW7SXu6vHrGLEM
         eI1ceNqVmvfi9SQMy9QyTU7+ZXo7MsORl95BHJrsdleG3sfM1neAX+8T86DzvP+w/CrK
         rxaWuLNC9Lo/OjMuq6xjROnjjVOV5m/+h2Jre2S7tKk7hkB7muZ8kroyxMfW0gBrdKoK
         Wy/xtQ4g6xvpZFiBYagUtsKsYj7q7OUj6/mnCUZSfPQeN4z+DnvAhx2iA8yu1vCKSoyr
         Xh0xB/6BkfQibQ/cQoAMYbQ2BgLHa11Ql/WAQmD7w+XGlpbdHtYntk8Ij0GYPP31m+L7
         coOw==
X-Gm-Message-State: AOAM533RZdhjWcpwAwdrYcRAt/nrfMyWNihcYkXmw8djwxKEZPFWYKrf
        GyuPftLb0tHFogS8AcHkvj/39/uZw6Yj7w==
X-Google-Smtp-Source: ABdhPJyYzVm54GMBy2SMwgj7Vizf5O6IZYm8/ahMTwfLskutoesZO7VJzcBldtutdNQrv4hcHdOPLQ==
X-Received: by 2002:a19:c70c:: with SMTP id x12mr6709305lff.474.1606603314364;
        Sat, 28 Nov 2020 14:41:54 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:53 -0800 (PST)
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
Subject: [PATCH v2 17/28] video: fbdev: tgafb: Fix kernel-doc and set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:03 +0100
Message-Id: <20201128224114.1033617-18-sam@ravnborg.org>
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
- Drop unused code

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/tgafb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index 666fbe2f671c..ae0cf5540636 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -555,7 +555,7 @@ tgafb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
 
 /**
  *      tgafb_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int
@@ -837,7 +837,7 @@ tgafb_clut_imageblit(struct fb_info *info, const struct fb_image *image)
 	u32 *palette = ((u32 *)info->pseudo_palette);
 	unsigned long pos, line_length, i, j;
 	const unsigned char *data;
-	void __iomem *regs_base, *fb_base;
+	void __iomem *fb_base;
 
 	dx = image->dx;
 	dy = image->dy;
@@ -855,7 +855,6 @@ tgafb_clut_imageblit(struct fb_info *info, const struct fb_image *image)
 	if (dy + height > vyres)
 		height = vyres - dy;
 
-	regs_base = par->tga_regs_base;
 	fb_base = par->tga_fb_base;
 
 	pos = dy * line_length + (dx * 4);
@@ -1034,7 +1033,7 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 		     regs_base + TGA_MODE_REG);
 }
 
-/**
+/*
  *      tgafb_copyarea - REQUIRED function. Can use generic routines if
  *                       non acclerated hardware and packed pixel based.
  *                       Copies on area of the screen to another area.
-- 
2.27.0

