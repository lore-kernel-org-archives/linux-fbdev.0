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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D7C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842C6613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbhDGGqZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349151AbhDGGqV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839AFC061761;
        Tue,  6 Apr 2021 23:46:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so740714pjb.2;
        Tue, 06 Apr 2021 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P81LnC6bDd+byVZVERPQ7nQWM5zWnQv6C3u8NNQHox4=;
        b=E/aKNJo54FqShHJx/iEwNgesBoUWtnV4rV5+/FCKpMJ7OJWRkUUQztYa+6lP0vM4HS
         zKerDwilw9VUXXz8iDH3TUbVw8wMRR/GK5x7FPh7LdAqqIxgtUc/KHQ/rPO9vss/t4df
         NTv70Vvw4mGdRITOu486Th0VF+NeP6o9CvTqogQDw3b6OeckKrXVSWEjX3v6JH1RBifG
         3HeXRR07Yge8lEERcWmOnxvt4+LlGoTUz+lph1VmE/s1kaTAvsAXymvk+w5s9xAJsuO8
         ZH4rZyezP+3idDHV+KfN70q3ETKGWj0X1xwAknq2tTQ38zPeeN/OzSP1oNaI3EvIwq9t
         aAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P81LnC6bDd+byVZVERPQ7nQWM5zWnQv6C3u8NNQHox4=;
        b=gHZj0rJI0izXw7UsJtTp2r4vMpldiV5MvWyVxRc1QYgbIAgPUIuYzwiIdnX1aXNQdl
         lB3d/e4UNNZSOkj7UaeLmUo3yATKgNUqcb7SEZ494rz12y7H92imI+eTnsEM1zSuliRR
         co+//SuiQILMwHGSRp8rOZ/07FYsB6482zprbe7+vinypUlg16Nz7tXQHGIu2Di0hsOo
         59KP5Ng7/SioSf2WJu2/sRCkYsaVnxPnhYweoKdhDjgRVaPJi4hqdL6YulxmAqFici6y
         2wlMFsz7h6QF9joqkcM3S/14JfZiDuuN/n44knXpj4nRYjqv/r8HeSbjVdmvs//bk9UM
         TJ6Q==
X-Gm-Message-State: AOAM533LDEHvL4zsYkLU2sPuZR4IOZ9c3j5M6zDCKUCCImOSpfAXzFEn
        qYCsh7th60Ay1bAYZcw6IRs=
X-Google-Smtp-Source: ABdhPJw0j67aR86TwFg3HC6ld3mo9/Va/7UbZQl1JhC/sMn28GhNSjjCm7Jp7wz3P5JK3mLKugWfHQ==
X-Received: by 2002:a17:902:7c88:b029:e6:f006:f8e5 with SMTP id y8-20020a1709027c88b02900e6f006f8e5mr1839101pll.1.1617777972094;
        Tue, 06 Apr 2021 23:46:12 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id t19sm21243026pfg.38.2021.04.06.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:11 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:09 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 46/49] staging: sm750fb: Rename local variable Bpp to bpp
 in sm750.c
Message-ID: <b51650f7eb9b8340b64b53f33ef1a062d5699142.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the local variable
Bpp in functions lynxfb_ops_fillrect and lynxfb_ops_copyarea.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 162eaf08db4c..937a44530fbf 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -162,7 +162,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp, rop;
+	unsigned int base, pitch, bpp, rop;
 	u32 color;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -177,9 +177,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp == 1) ? region->color :
+	color = (bpp == 1) ? region->color :
 		((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
@@ -192,7 +192,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, Bpp,
+				     base, pitch, bpp,
 				     region->dx, region->dy,
 				     region->width, region->height,
 				     color, rop);
@@ -204,7 +204,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 
 	par = info->par;
 	sm750_dev = par->dev;
@@ -215,7 +215,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/*
 	 * If not use spin_lock, system will die if user load driver
@@ -227,7 +227,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 
 	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
 				     base, pitch, region->sx, region->sy,
-				     base, pitch, Bpp, region->dx, region->dy,
+				     base, pitch, bpp, region->dx, region->dy,
 				     region->width, region->height,
 				     HW_ROP2_COPY);
 	spin_unlock(&sm750_dev->slock);
@@ -236,7 +236,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 static void lynxfb_ops_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 	unsigned int fgcol, bgcol;
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
@@ -249,7 +249,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/* TODO: Implement hardware acceleration for image->depth > 1 */
 	if (image->depth != 1) {
@@ -276,7 +276,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
 				      image->data, image->width >> 3, 0,
-				      base, pitch, Bpp,
+				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
 				      fgcol, bgcol, HW_ROP2_COPY);
-- 
2.30.2

