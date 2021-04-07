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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02132C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AFF6139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbhDGGqQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbhDGGpl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:45:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D96C06174A;
        Tue,  6 Apr 2021 23:45:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so778565pjv.1;
        Tue, 06 Apr 2021 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cq0F0lLxX9YZN85mY7IttM5IDARZ7TDuacaMTtEqzBU=;
        b=ZqHBDt9zMmhQ2BUnkUxKq1bpZgEJsxiJL7gxitapvMauN/ZBXTgjwXa+l4BO3cOS9g
         B/o67xoi9AjNDWI/+TMzzBl1BH8N0sqrPoF97WThEaoghxSbClpNbjpBLA8L2mhFAeq7
         pLByWMgtKasK7qVRhZ4m5pO6jq1P0vqo9cVq8Ib8A32r3P/wG0tB/4M+ngjMLsI4HVXh
         sHklVjfdagHfp0a5IbtGba42yV8Hy9uf1jtki9/ybyV/AHxFYSwHUzP1Nw3gLujAtoYX
         sZ0mvpZHQRSJRJtOTPpxlfMJcBSjfBWCgGaFrzdzPrd1Hwkyct5eQa0tv3POs4DOK9x1
         LGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cq0F0lLxX9YZN85mY7IttM5IDARZ7TDuacaMTtEqzBU=;
        b=SfQGnmS199REnQy9F1FsrMSnaEvIHFsvgU9N2a5GtH4ET9/edgSXGC4WcO3Po0rNjq
         5I8U0nLJSySmUJTTeUB/Krl2bsj+9oZklyLRihEVAiQh8TmgyBsEukQIc5F475EVV1TL
         6nODE3NKJpm8O4ly8o8Vg0GYtzzE0CMm7AUskbqNqCvN+ho6mCb59/VUjusxwfEyiET6
         IG3Q6TGu5ywmR9uk0+nv+hJqg/yia0cacQI/X+HR7IHTWbQ5D4n2eWJg4xnuyAP4257G
         hgt0Q8lVaULA029yrQfKcMc9kULIMZ2id1Rqsy2a0OIgQqGCMwuLgIOjuJSKDqhdF4YH
         ju2A==
X-Gm-Message-State: AOAM533aZVSsktit9B+WnkWsePDTl1yvP5MZ60QiBQL36SNyrslBDSH7
        f8e34PpEd/N3GAKpd099BLM=
X-Google-Smtp-Source: ABdhPJweO/S/JOZZdVNrMt+N1UpFQgRrQ4bndSmGPIZkV6qvSMhqoaRRJlBgmXbWfaspqIgGX9FW+w==
X-Received: by 2002:a17:90a:1509:: with SMTP id l9mr1904415pja.163.1617777930303;
        Tue, 06 Apr 2021 23:45:30 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id w203sm19864646pfc.188.2021.04.06.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:45:29 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:45:27 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/49] staging: sm750fb: Update members of lynxfb_crtc
 struct to snake case
Message-ID: <8c28f719ba6be13c9d5cf6a72080c449ce4897ce.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members of the
struct lynxfb_crtc, in particular vCursor, vScreen, oCursor, and
oScreen.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 44 +++++++++++++++---------------
 drivers/staging/sm750fb/sm750.h    |  8 +++---
 drivers/staging/sm750fb/sm750_hw.c |  6 ++--
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 22881d35c9ad..2c944539eaf0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -175,7 +175,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -213,7 +213,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -247,7 +247,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -451,7 +451,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
+		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -463,7 +463,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
+		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -614,44 +614,44 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
-		crtc->oScreen = 0;
-		crtc->vScreen = sm750_dev->mem;
+		crtc->o_screen = 0;
+		crtc->v_screen = sm750_dev->mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
-		crtc->oScreen = 0;
-		crtc->vScreen = sm750_dev->mem;
+		crtc->o_screen = 0;
+		crtc->v_screen = sm750_dev->mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
-			crtc->oScreen = 0;
-			crtc->vScreen = sm750_dev->mem;
+			crtc->o_screen = 0;
+			crtc->v_screen = sm750_dev->mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
-			/* not consider of padding stuffs for oScreen,need fix */
-			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->mem + crtc->oScreen;
+			/* not consider of padding stuffs for o_screen,need fix */
+			crtc->o_screen = sm750_dev->vidmem_size >> 1;
+			crtc->v_screen = sm750_dev->mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
-			crtc->oScreen = 0;
-			crtc->vScreen = sm750_dev->mem;
+			crtc->o_screen = 0;
+			crtc->v_screen = sm750_dev->mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
-			/* not consider of padding stuffs for oScreen,
+			/* not consider of padding stuffs for o_screen,
 			 * need fix
 			 */
-			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->mem + crtc->oScreen;
+			crtc->o_screen = sm750_dev->vidmem_size >> 1;
+			crtc->v_screen = sm750_dev->mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -718,7 +718,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * set current cursor variable and proc pointer,
 	 * must be set after crtc member initialized
 	 */
-	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
+	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
 	crtc->cursor.mmio = sm750_dev->reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
@@ -801,7 +801,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			    crtc->line_pad);
 
 	info->pseudo_palette = &par->pseudo_palette[0];
-	info->screen_base = crtc->vScreen;
+	info->screen_base = crtc->v_screen;
 	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 	info->flags = FBINFO_FLAG_DEFAULT | 0;
@@ -816,7 +816,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	strscpy(fix->id, fixId[index], sizeof(fix->id));
 
-	fix->smem_start = crtc->oScreen + sm750_dev->vidmem_start;
+	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/*
 	 * according to mmap experiment from user space application,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 6f3af779f3b0..368e5cc19147 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -132,10 +132,10 @@ struct lynx_cursor {
 };
 
 struct lynxfb_crtc {
-	unsigned char __iomem *vCursor; /* virtual address of cursor */
-	unsigned char __iomem *vScreen; /* virtual address of on_screen */
-	int oCursor; /* cursor address offset in vidmem */
-	int oScreen; /* onscreen address offset in vidmem */
+	unsigned char __iomem *v_cursor; /* virtual address of cursor */
+	unsigned char __iomem *v_screen; /* virtual address of on_screen */
+	int o_cursor; /* cursor address offset in vidmem */
+	int o_screen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index add9daa585fd..7c852c6a153b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -314,7 +314,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset, width, start address, etc... */
 		poke32(PANEL_FB_ADDRESS,
-		       crtc->oScreen & PANEL_FB_ADDRESS_ADDRESS_MASK);
+		       crtc->o_screen & PANEL_FB_ADDRESS_ADDRESS_MASK);
 
 		reg = var->xres * (var->bits_per_pixel >> 3);
 		/*
@@ -350,7 +350,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 		poke32(PANEL_DISPLAY_CTRL, reg | (var->bits_per_pixel >> 4));
 	} else {
 		/* not implemented now */
-		poke32(CRT_FB_ADDRESS, crtc->oScreen);
+		poke32(CRT_FB_ADDRESS, crtc->o_screen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
 		/*
 		 * crtc->channel is not equal to par->index on numeric,
@@ -554,7 +554,7 @@ int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 
 	total = var->yoffset * info->fix.line_length +
 		((var->xoffset * var->bits_per_pixel) >> 3);
-	total += crtc->oScreen;
+	total += crtc->o_screen;
 	if (crtc->channel == sm750_primary) {
 		poke32(PANEL_FB_ADDRESS,
 		       peek32(PANEL_FB_ADDRESS) |
-- 
2.30.2

